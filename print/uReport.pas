unit uReport;

interface
uses controls,windows,messages,printDO,Classes,osservice,cc,ucellList,
OmniXMLPersistent;
Const
  // Horz Align
  TEXT_ALIGN_LEFT = 0;
  TEXT_ALIGN_CENTER = 1;
  TEXT_ALIGN_RIGHT = 2;

  // Vert Align
  TEXT_ALIGN_TOP = 0;
  TEXT_ALIGN_VCENTER = 1;
  TEXT_ALIGN_BOTTOM = 2;

  // ????
  LINE_LEFT1 = 1;                       // left top to right bottom
  LINE_LEFT2 = 2;                       // left top to right
  LINE_LEFT3 = 4;                       // left top to bottom

  LINE_RIGHT1 = $100;                   // right top to left bottom
  LINE_RIGHT2 = $200;                   // right top to left
  LINE_RIGHT3 = $400;                   // right top to bottom
type
 PReport = Class(TWinControl)
   page : PPage;
   os : WindowsOS;
  private
    procedure DrawCornice(hPaintDC: HDC);
    procedure PaintCell(hPaintDC: HDC; cell: PCell; bPrint: Boolean);
    procedure FillBg(hPaintDC: HDC; cell: PCell; FCellRect: TRect;
      FBackGroundColor: COLORREF);
    procedure DrawAuxiliaryLine(hPaintDc: HDC; bPrint: Boolean;cell:PCell);
    procedure DrawFrameLine(hPaintDc: HDC;cell:PCell);
    procedure DrawDragon(hPaintDc: HDC;cell:PCell);
    procedure DrawContentText(hPaintDC: HDC;cell:PCell);
    procedure DrawBottom(hPaintDc: HDC; color: COLORREF; cell: PCell);
    procedure DrawLeft(hPaintDc: HDC; color: COLORREF; cell: PCell);
    procedure DrawRight(hPaintDc: HDC; color: COLORREF; cell: PCell);
    procedure DrawTop(hPaintDc: HDC; color: COLORREF; cell: PCell);
    procedure DrawLine(hPaintDc: HDC; x1, y1, x2, y2: integer;
      color: COLORREF; PenWidth: Integer);
 public
  Constructor Create(AOwner: TComponent); Override;
  destructor Destroy;override;
  procedure DoPaint(hPaintDC: HDC; Handle: HWND; ps: TPaintStruct);
  Procedure WMPaint(Var Message: TMessage); Message WM_PAINT;
 end;
implementation

{ PReport }

constructor PReport.Create(AOwner: TComponent);
var page : PPage ;
begin
  inherited;
  page := PPage.Create;
  OmniXMLPersistent.TOmniXMLReader.LoadFromFile(page,  '3.xml');
  os := WindowsOS.create;
end;

destructor PReport.Destroy;
begin
  page.Free;
  os.Free;
  inherited;
end;
procedure PReport.DrawCornice(hPaintDC:HDC);
Var
  I, J: Integer;
  TempRect: TRect;
  hGrayPen, hPrevPen: HPEN;
begin
  hGrayPen := CreatePen(PS_SOLID, 1, cc.Grey);
  try
    hPrevPen := SelectObject(hPaintDC, hGrayPen);
    // ??
    MoveToEx(hPaintDC, page.LeftMargin, page.TopMargin, Nil);
    LineTo(hPaintDC, page.LeftMargin, page.TopMargin - 25);

    MoveToEx(hPaintDC, page.LeftMargin, page.TopMargin, Nil);
    LineTo(hPaintDC, page.LeftMargin - 25, page.TopMargin);

    // ??
    MoveToEx(hPaintDC, page.PageWidth - page.RightMargin, page.TopMargin, Nil);
    LineTo(hPaintDC, page.PageWidth - page.RightMargin, page.TopMargin - 25);

    MoveToEx(hPaintDC, page.PageWidth - page.RightMargin, page.TopMargin, Nil);
    LineTo(hPaintDC, page.PageWidth - page.RightMargin + 25, page.TopMargin);

    // ??
    MoveToEx(hPaintDC, page.LeftMargin, page.PageHeight - page.BottomMargin, Nil);
    LineTo(hPaintDC, page.LeftMargin, page.PageHeight - page.BottomMargin + 25);

    MoveToEx(hPaintDC, page.LeftMargin, page.PageHeight - page.BottomMargin, Nil);
    LineTo(hPaintDC, page.LeftMargin - 25, page.PageHeight - page.BottomMargin);

    // ??
    MoveToEx(hPaintDC, page.PageWidth - page.RightMargin, page.PageHeight - page.BottomMargin,
      Nil);
    LineTo(hPaintDC, page.PageWidth - page.RightMargin, page.PageHeight - page.BottomMargin + 25);

    MoveToEx(hPaintDC, page.PageWidth - page.RightMargin, page.PageHeight - page.BottomMargin,
      Nil);
    LineTo(hPaintDC, page.PageWidth - page.RightMargin + 25, page.PageHeight - page.BottomMargin);
  finally
    SelectObject(hPaintDC, hPrevPen);
    DeleteObject(hGrayPen);
  end;
end;
procedure PReport.FillBg(hPaintDC: HDC;cell:PCell;FCellRect:TRect;FBackGroundColor:COLORREF);
var
  TempRect:TRect;
  TempLogBrush: TLOGBRUSH;
  hTempBrush: HBRUSH;
begin
  TempRect := FCellRect;
  TempRect.Top := TempRect.Top + 1;
  TempRect.Right := TempRect.Right + 1;
  If FBackGroundColor <>cc.White Then
  Begin
    TempLogBrush.lbStyle := BS_SOLID;
    TempLogBrush.lbColor := FBackGroundColor;
    hTempBrush := CreateBrushIndirect(TempLogBrush);
    FillRect(hPaintDC, TempRect, hTempBrush);
    DeleteObject(hTempBrush);
  End;
end;
Procedure PReport.PaintCell(hPaintDC: HDC;cell:PCell; bPrint: Boolean);
Var
  SaveDCIndex: Integer;
Begin
  If cell.IsSlave Then
    Exit;                          
  SaveDCIndex := SaveDC(hPaintDC);
  try
    SetBkMode(hPaintDC, TRANSPARENT);
    FillBg (hPaintDC, cell,cell.CellRect.ToRect(),page.BkColor);
    DrawFrameLine(hPaintDc,cell);
    DrawAuxiliaryLine (hPaintDc,bPrint,cell);
    DrawDragon(hPaintDC,cell);
    DrawContentText(hPaintDC,cell) ;
  finally
    RestoreDC(hPaintDC, SaveDCIndex);
  end;
End;
procedure PReport.DrawContentText(hPaintDC: HDC;cell:PCell);
var   Format: UINT;  hTextFont, hPrevFont: HFONT; TempRect: TRect;
begin
  If Length(cell.CellText) > 0 Then
  Begin
    Windows.SetTextColor(hPaintDC, cell.TextColor);
    Format := DT_EDITCONTROL Or DT_WORDBREAK;
    Case cell.HorzAlign Of
    TEXT_ALIGN_LEFT:
      Format := Format Or DT_LEFT;
    TEXT_ALIGN_CENTER:
      Format := Format Or DT_CENTER;
    TEXT_ALIGN_RIGHT:
      Format := Format Or DT_RIGHT;
    Else
      Format := Format Or DT_LEFT;
    End;
    // hTextFont := CreateFontIndirect(FLogFont);
    // hPrevFont := SelectObject(hPaintDC, hTextFont);
    TempRect := cell.TextRect.ToRect();
    DrawText(hPaintDC, PChar(cell.CellText), Length(cell.CellText), TempRect, Format);
    // SelectObject(hPaintDC, hPrevFont);
    // DeleteObject(hTextFont);
  End;
end;
procedure PReport.DrawDragon(hPaintDc:HDC;cell:PCell);
var p1,p2:TPoint ;R:TRect;
procedure DrawLine(hPaintDC:HDC;p1,p2:TPoint);
begin
      MoveToEx(hPaintDC,p1.x, p1.y, Nil);
      LineTo(hPaintDC, p2.x, p2.y);
end;

var R1:Rect;
  c : Canvas;
  function IsDragonLeft1:Boolean;
  begin
    result := (cell.Diagonal And LINE_LEFT1) > 0 ;
  end;
  function IsDragonLeft2:Boolean;
  begin
    result := (cell.Diagonal And LINE_LEFT2) > 0 ;
  end;
  function IsDragonLeft3:Boolean;
  begin
    result := (cell.Diagonal And LINE_LEFT3) > 0 ;
  end;
  function IsDragonRight1:Boolean;
  begin
    result := (cell.Diagonal And LINE_RIGHT1) > 0 ;
  end;
  function IsDragonRight2:Boolean;
  begin
    result := (cell.Diagonal And LINE_RIGHT2) > 0 ;
  end;
  function IsDragonRight3:Boolean;
  begin
    result := (cell.Diagonal And LINE_RIGHT3) > 0 ;
  end;
  function IsDragonSet:Boolean;
  begin
    result := cell.Diagonal > 0 ;
  end;
begin
  If not IsDragonSet Then exit;
  c := Canvas.Create(hPaintDC);
  c.ReadyDefaultPen;
  R1 := Rect.Create(os.Inflate(cell.CellRect.torect(),-1,-1));
  try
    If IsDragonLeft1 Then
    Begin
      p1 := R1.TopLeft ;
      p2 := R1.BottomRight;
      c.DrawLine(p1,p2);
    End;

    If IsDragonLeft2  Then
    Begin
      p1 := R1.TopLeft ;
      p2 := R1.RightMid;
      c.DrawLine(p1,p2);
    End;

    If IsDragonLeft3 Then
    Begin
      p1 := R1.TopLeft ;
      p2 := R1.BottomMid;
      c.DrawLine(p1,p2);
    End;

    If IsDragonRight1 Then
    Begin
      p1 := R1.RightTop;
      p2 := R1.LeftBottom;
      c.DrawLine(p1,p2);
    End;

    If IsDragonRight2 Then
    Begin
      p1 := R1.RightTop;
      p2 := R1.LeftMid;
      c.DrawLine(p1,p2);
    End;

    If IsDragonRight3 Then
    Begin
      p1 := R1.RightTop;
      p2 := R1.BottomMid;
      c.DrawLine(p1,p2);
    End;                
  finally
    c.KillPen;
    c.free;
    R1.Free;
  end;
end;
procedure PReport.DrawLine(hPaintDc:HDC;x1,y1,x2,y2:integer;color:COLORREF;PenWidth:Integer);
VAR     hPrevPen, hTempPen: HPEN;
begin
  hTempPen := CreatePen(BS_SOLID, PenWidth, color);
  hPrevPen := SelectObject(hPaintDc, hTempPen);
  MoveToEx(hPaintDc, x1, y1, Nil);
  LineTo(hPaintDC, x2, y2);
  SelectObject(hPaintDc, hPrevPen);
  DeleteObject(hTempPen);
end;
procedure PReport.DrawLeft(hPaintDc:HDC;color:COLORREF;cell:PCell);
var FCellRect:TRect ;
begin
  FCellRect := cell.CellRect.ToRect();
  DrawLine(hPaintDc,FCellRect.left, FCellRect.top,FCellRect.left, FCellRect.bottom,color,cell.LeftLineWidth);
end;
procedure PReport.DrawTop(hPaintDc:HDC;color:COLORREF;cell:PCell);
var FCellRect:TRect ;
begin
  FCellRect := cell.CellRect.ToRect();
  DrawLine( hPaintDc,FCellRect.left, FCellRect.top,FCellRect.right, FCellRect.top,color,cell.TopLineWidth);
end;
procedure PReport.DrawRight(hPaintDc:HDC;color:COLORREF;cell:PCell);
var FCellRect:TRect ;
begin
  FCellRect := cell.CellRect.ToRect();
  DrawLine( hPaintDc,FCellRect.right, FCellRect.top,FCellRect.right, FCellRect.bottom,color,cell.RightLineWidth);
end;
procedure PReport.DrawBottom(hPaintDc:HDC;color:COLORREF;cell:PCell);
var FCellRect:TRect ;
begin
  FCellRect := cell.CellRect.ToRect();
  DrawLine( hPaintDc,FCellRect.left, FCellRect.bottom,FCellRect.right, FCellRect.bottom,color,cell.BottomLineWidth);
end;
procedure PReport.DrawFrameLine(hPaintDc:HDC;cell:PCell);
begin
  If cell.LeftLine Then
    DrawLeft(hPaintDc,cc.Black,cell);
  If cell.TopLine Then
    DrawTop(hPaintDc,cc.Black,cell);
  If cell.RightLine Then
    DrawRight(hPaintDc,cc.Black,cell);
  If cell.BottomLine Then
    DrawBottom(hPaintDc,cc.Black,cell);
end;
procedure  PReport.DrawAuxiliaryLine(hPaintDc:HDC;bPrint:Boolean;cell:PCell) ;
begin
  if (not cell.LeftLine) and (not bPrint) and (cell.CellIndex = 0) then
    DrawLeft(hPaintDc,cc.Grey,cell);
  if (not cell.TopLine) and (not bPrint) and (cell.OwnerLine.Index = 0) then
    DrawTop(hPaintDc,cc.Grey);
  if (not FRightLine) and (not bPrint)  then
    DrawRight(hPaintDc,cc.Grey);
  if (not FBottomLine )and (not bPrint)  then
    DrawBottom(hPaintDc,cc.Grey);
end;
procedure PReport.DoPaint(hPaintDC: HDC; Handle: HWND; ps: TPaintStruct);
Var
  I: Integer;
  Rect: TRect;
  rectPaint: TRect;
  Cells : TCellList;
  c : Canvas;
  cell : PCell;
begin
  rectPaint := ps.rcPaint;
  //
  c := Canvas.Create(hPaintDC);
  c.SetMapMode();
  c.SetWindowExtent(page.PageWidth, page.PageHeight);
  c.SetViewportExtent(Width, Height);
  os.InverseScaleRect(rectPaint,page.ReportScale);
  c.Rectangle(0, 0, page.PageWidth, page.PageHeight);
  DrawCornice(hPaintDC);
  Cells := TCellList.Create(self.page);
  try
    Cells.MakeInteractWith(rectPaint);
    for i:= 0 to Cells.Count - 1 do
    begin
        //Cells[i].DrawImage ;
        cell := PCell(Cells[i]);
        If not cell.IsSlave Then
          PaintCell(hPaintDC,cell,FPreviewStatus);
    end;
  finally
    Cells.Free;
    c.Free;
  end;
  if not FPreviewStatus then
    For I := 0 To FSelectCells.Count - 1 Do
    Begin
      Rect := os.IntersectRect( ps.rcPaint,FSelectCells[I].CellRect);
      if not os.IsRectEmpty(Rect) then
        InvertRect(hPaintDC, Rect);
    End;     
end;

procedure PReport.WMPaint(var Message: TMessage);
Var
  hPaintDC: HDC;
  ps: TPaintStruct;
Begin
  hPaintDC := BeginPaint(Handle, ps);
  DoPaint(hPaintDc,Handle,ps);
  EndPaint(Handle, ps);
End;

end.
 