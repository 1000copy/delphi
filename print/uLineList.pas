// unit uLineList;

// interface

// uses classes,printDO ,windows;

// type
//   TLineList = class(TList)
//   private                     
//     R:PPage;
//     function Get(Index: Integer): PLine;
//   public
//     constructor Create(R:PPage);
//     procedure CombineHorz;
//     property Items[Index: Integer]: PLine read Get ;default;
//     procedure MakeSelectedLines(FLineList:TLineList);
//     function CombineVert:PCell;
//     function TotalHeight:Integer;
//   published
//     {
//     G:How do I force the linker to include a function I need during debugging?
//     You can make function published.
//       TMyClass = class
//         F : integer;
//       published
//         function AsString : string;
//       end;
//       And switch on in 'Watch Properties' 'Allow function calls'
//     }
//     function ToString:String ;
//   end;
// implementation
// procedure TLineList.CombineHorz;
// Var
//   I: Integer;
// begin
//    // For I := 0 To Count - 1 Do
//    //   Items[I].CombineSelected;
// end;
// function TLineList.CombineVert:PCell;
// // Var
// //   I: Integer;
// //   Cells: TCellList;
// //   OwnerCell: TReportCell;
// begin
//   // Cells := TCellList.Create(Self.R);
//   // try
//   //   Cells.ColumnSelectedCells(Self);
//   //   OwnerCell := TReportCell(Cells[0]);
//   //   // ????????? -- ???????Cell???????cell?OwneredCell??
//   //   For I := 1 To Cells.Count - 1 Do
//   //       OwnerCell.Own(TReportCell(Cells[I]));
//   // finally
//   //   Cells.Free;
//   // end;
//   // Result := OwnerCell ;

// end;
// constructor TLineList.Create(R:PPage);
// begin
//   self.R := R; 
// end;

// function TLineList.Get(Index: Integer): PLine;
// begin
//   Result := PLine(inherited Get(Index));
// end;

// procedure TLineList.MakeSelectedLines(FLineList:TLineList);
// Var
//     I: Integer;
// begin
//     // For I := 0 To FLineList.Count - 1 Do
//     // Begin
//     //   if FLineList[I].IsSelected then
//     //     add(FLineList[I]);
//     // End;
// end;
// function TLineList.ToString: String;
// begin

// end;

// function TLineList.TotalHeight: Integer;
// begin

// end;

// end.
//  