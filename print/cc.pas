unit CC;

interface
uses windows,Math;
const
  DRAGMARGIN =10;
  RenderException = '���δ����ȫ����,�������Ԫ���Ȼ�ҳ�߾������' ;
  SumPageFormat = 'ģ���ļ���Sumpage()�����ڲ�����ӦΪ��';
  PageFormat = '��%d/%dҳ';
  PageFormat1 = '��%dҳ' ;
  PageFormat2 = '��%d-%dҳ' ;
  FormulaPrefix = '`' ;
  ErrorRendering = '�γɱ���ʱ��������������������ģ�����õ��Ƿ���ȷ';
  ErrorPrinterSetupRequired = 'δ��װ��ӡ��';
  TwoCellSelectedAtLeast = '������ѡ��������Ԫ��' ;
  IsRegularForCombine  = 'ѡ����β�������������ѡ' ;
  NewTableError = '�ر����ڱ༭���ļ��󣬲��ܽ����±��' ;
  HorzMargin_ZoomFit = 170 ;
  VertMargin_ZoomFit_ForPreview = 110 ;
  VertMargin_ZoomFit_For_Design = 160 ;
  
function Grey :COLORREF;
function White :COLORREF;
function Black :COLORREF;
function RegularPoint(V:Integer):Integer;
function calcBottom(TempString:string ;TempRect:TRect;AlighFormat :UINT;FLogFont: TLOGFONT):Integer;
function BoundValue(Value,Bigger,Smaller:Integer):Integer;
implementation
function Black :COLORREF;
begin
 result:= Windows.RGB(0,0,0);
end;
function Grey :COLORREF;
begin
 result:= Windows.RGB(192, 192, 192);
end;
function White :COLORREF;
begin
 result:= RGB(255, 255, 255)
end;
function RegularPoint(V:Integer):Integer;
begin
   result :=  trunc(V / 5 * 5 + 0.5);
end;
function BoundValue(Value,Bigger,Smaller:Integer):Integer;
begin
  Value := Max(Smaller,Value);
  Value := Min(Bigger,Value);
  Result := Value ;
end;
function IsCRTail(s : string):Boolean;
begin
  Result := (Length(s) >= 2) and (s[Length(s)] = Chr(10)) And (s[Length(s) - 1] = Chr(13));
end;
function calcBottom(TempString:string ;TempRect:TRect;AlighFormat :UINT;FLogFont: TLOGFONT):Integer;
var
  hTempFont, hPrevFont: HFONT;
  hTempDC: HDC;
  Format: UINT;
  TempSize: TSize;
begin
  // LCJ : ��С�߶���Ҫ�ܹ��������֣���������ֱ�ߵĿ�Ⱥ�2����Ŀռ������ + 4
  //       ��ˣ���Ҫʵ�ʻ���������DC 0 �ϣ��������TempRect-������ռ�Ŀռ�
  //       - FLeftMargin : Cell �����ֺͱ���֮�����µĿյĿ��
  hTempFont := CreateFontIndirect(FLogFont);
  hTempDC := GetDC(0);
  hPrevFont := SelectObject(hTempDC, hTempFont);
  try
    Format := DT_EDITCONTROL Or DT_WORDBREAK;
    Format := Format Or AlighFormat ;
    Format := Format Or DT_CALCRECT;
    // lpRect [in, out] !  TempRect.Bottom ,TempRect.Right  �ᱻ�޸� �������ֲ���û���ᵽ��
    DrawText(hTempDC, PChar(TempString), Length(TempString), TempRect, Format);
    // �����������Ļس����������
    If  IsCRTail(TempString) Then
    Begin
        GetTextExtentPoint(hTempDC, 'A', 1, TempSize);
        TempRect.Bottom := TempRect.Bottom + TempSize.cy;
    End;
    result := TempRect.Bottom ;
  finally
    SelectObject(hTempDc, hPrevFont);
    DeleteObject(hTempFont);
    ReleaseDC(0, hTempDC);
  end;
end;

end.
