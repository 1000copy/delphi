unit uCellList;

interface
uses classes,printDO ,windows,osservice;
type
  TCellList = class(TList)
  private
    FPage:PPage ;
    FOs : WindowsOS;
  public
    constructor Create(page:PPage);
    destructor destroy;override ;
    procedure MakeInteractWith(R: TRect);
  end;
implementation

 

constructor TCellList.Create(page: PPage);
begin
   self.FPage := page ;
   FOs := WindowsOS.Create;
end;

destructor TCellList.destroy;
begin
  FPage.Free;
  FOs.Free ;
  inherited;
end;

procedure TCellList.MakeInteractWith(R: TRect);
var i,j :Integer;
Var
  ThisCell: PCell;
  ThisLine: PLine;
begin
  For I := 0 To self.FPage.LineList.Count - 1 Do
  Begin
    ThisLine := PLine(FPage.LineList.Items[I]);
    If FOS.IsIntersect(R, ThisLine.LineRect.ToRect()) Then
      For J := 0 To ThisLine.CellList.Count - 1 Do
      Begin
        ThisCell := PCell(ThisLine.CellList.Items[J]);
        if Fos.IsIntersect(ThisCell.CellRect.ToRect(), R) Then
        Begin
          If ThisCell.IsSlave Then
            ThisCell :=  ThisCell.OwnerCell ;
          Add(ThisCell);
        End;
      End;
  End;
end;

end.
