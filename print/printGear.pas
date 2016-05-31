unit printGear;

interface
Uses
  PrintDO,
  Windows, Messages, SysUtils,Math,cc,
  {$WARNINGS OFF}FileCtrl,{$WARNINGS ON}
   Classes, Graphics, Controls,
  Forms, Dialogs, Printers, Menus, Db,
  DesignEditors, ExtCtrls,SimpleStream;
type

  GearPage = class(PPage)
  private
    procedure InternalLoadFromFile(FileName: string; FLineList: PLineList);
  public
    procedure LoadFrom(f:string);
  end;
implementation

{ GearPage }

procedure GearPage.LoadFrom(f: string);
begin
   InternalLoadFromFile(f,FLineList);
end;
Procedure GearPage.InternalLoadFromFile(FileName:string;FLineList:PLineList);
Var
  TargetFile: SS;
  FileFlag: WORD;
  Count1, Count2, Count3: Integer;
  ThisLine: PLine;
  ThisCell: PCell;
  I, J, K: Integer;
  TempPChar: Array[0..3000] Of Char;
  bHasDataSet: Boolean;
  procedure Before ;
  var
    I : Integer;
  begin
      For I := 0 To FLineList.Count - 1 Do
      Begin
        ThisLine := PLine(FLineList.Items[I]);
        ThisLine.Free;
      End;
      FLineList.Clear;
  end;
  procedure After;
  begin
//      Width := FPageWidth;
//      Height := FPageHeight;
  end;
Begin
  TargetFile := SS.Create(FileName, fmOpenRead);
  Try
    With TargetFile Do
    Begin
      ReadWord(FileFlag);
      If (FileFlag <> $AA55) And (FileFlag <> $AA56) And (FileFlag <> $AA57) Then
        raise Exception.create('打开文件错误');

      Before ;      

      ReadInteger(FReportScale);
      ReadInteger(FPageWidth);
      ReadInteger(FPageHeight);

      ReadInteger(FLeftMargin);
      ReadInteger(FTopMargin);
      ReadInteger(FRightMargin);
      ReadInteger(FBottomMargin);

      ReadInteger(FLeftMargin1);
      ReadInteger(FTopMargin1);
      ReadInteger(FRightMargin1);
      ReadInteger(FBottomMargin1);

      ReadBoolean(FNewTable);
      ReadInteger(FDataLine);
      ReadInteger(FTablePerPage);
      // 多少行
      ReadInteger(Count1);
      For I := 0 To Count1 - 1 Do
      Begin
        ThisLine :=PLine(self.LineList.add );
//  		  if (self is TReportControl) then
//        	ThisLine.FReportControl := Self;
        ReadInteger(Count2);
        ThisLine.CreateLine(0, Count2, FRightMargin - FLeftMargin);
      End;
      // 每行的属性
      For I := 0 To FLineList.Count - 1 Do
      Begin
        ThisLine := PLine(FLineList.Items[I]);
        ThisLine.Load(TargetFile);
        // 每个CELL的属性
        For J := 0 To ThisLine.CellList.Count - 1 Do
        Begin
          ThisCell := PCell(ThisLine.CellList.Items[J]);
          ThisCell.Load(TargetFile,FileFlag);
        End;
      End;
      ReadIntegerSkip();//(FprPageNo);
      ReadIntegerSkip();//(FprPageXy);
      ReadIntegerSkip();//(fpaperLength);
      ReadIntegerSkip();//(fpaperWidth);
      ReadIntegerSkip();//FHootNo
    End;
  Finally
    TargetFile.Free;
    After;
  End;
End;

end.
