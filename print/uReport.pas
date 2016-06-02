unit uReport;

interface
uses controls,windows,messages,osservice,printDO,Classes,
OmniXMLPersistent;

type
 PReport = Class(TWinControl)
   page : PPage;
 public
  Constructor Create(AOwner: TComponent); Override;
  procedure DoPaint(hPaintDC: HDC; Handle: HWND; ps: TPaintStruct);
  Procedure WMPaint(Var Message: TMessage); Message WM_PAINT;
 end;
implementation

{ PReport }

constructor PReport.Create(AOwner: TComponent);
begin
  inherited;
  page := PPage.Create;
  OmniXMLPersistent.TOmm.(g,  '3.xml',pfAttributes,    ofIndent);
end;

procedure PReport.DoPaint(hPaintDC: HDC; Handle: HWND; ps: TPaintStruct);
Var
  I: Integer;
  Rect: TRect;

  rectPaint: TRect;
  //Cells : TCellList;
  c : Canvas;
begin
  rectPaint := ps.rcPaint;
  //
  c := Canvas.Create(hPaintDC);
  c.SetMapMode();
  c.SetWindowExtent(FPageWidth, FPageHeight);
  c.SetViewportExtent(Width, Height);
  os.InverseScaleRect(rectPaint,FReportScale);
  c.Rectangle(0, 0, FPageWidth, FPageHeight);
  DrawCornice(hPaintDC);
  Cells := TCellList.Create(self);
  try
    Cells.MakeInteractWith(rectPaint);
    for i:= 0 to Cells.Count - 1 do
    begin
        Cells[i].DrawImage ;
        If not Cells[i].IsSlave Then
          Cells[i].PaintCell(hPaintDC, FPreviewStatus);
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
 