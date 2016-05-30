unit main;

interface

// if you want to use MS XML parser, create a global compiler define: 'USE_MSXML'

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  OmniXML, OmniXML_Types,
  OmniXMLPersistent;



type



  TfMain = class(TForm)
    btn3: TButton;
    btn4: TButton;
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
  private
    DocPath: string;
  public
    { Public declarations }
  end;
  //2222222222222222

  



var
  fMain: TfMain;
implementation

{$R *.DFM}
uses pm,PrintDO;
procedure TfMain.btn3Click(Sender: TObject);
var
    p :NPage;
    l:NLine;
    c : NCell;
begin
    //save
    p:=  NPage.Create;
    p.id := 'str';

    p.LineList := NLineList.Create(NLine);
    l :=NLine(p.LineList.Add);
    l.id := '1';
    c :=  NCell(l.CellList.add);
    c.id:='c1';
    c.i := 1 ;
    NLine(p.LineList.Add).id := '2';
    NLine(p.LineList.Add).id := '3';
    TOmniXMLWriter.SaveToFile(p,  '1.xml',pfAttributes,    ofIndent);
    p.free;
    // load
    p:=  NPage.Create;

    TOmniXMLReader.LoadFromFile(p, '1.xml');
    assert (p.id = 'str');
    l :=     NLine(p.LineList.Items[0]);
    assert (l.id = '1');
    assert(NCell(l.CellList.items[0]).id = 'c1');
    assert(NCell(l.CellList.items[0]).i = 1);
    assert (NLine(p.LineList.Items[1]).id = '2');
    assert (NLine(p.LineList.Items[2]).id = '3');
    p.free;
end;
        {
      WriteInteger(FReportScale);
      WriteInteger(FPageWidth);
      WriteInteger(FPageHeight);
      WriteInteger(FLeftMargin);
      WriteInteger(FTopMargin);
      WriteInteger(FRightMargin);
      WriteInteger(FBottomMargin);
      WriteInteger(FLeftMargin1);
      WriteInteger(FTopMargin1);
      WriteInteger(FRightMargin1);
      WriteInteger(FBottomMargin1);
      WriteBoolean(FNewTable);
      WriteInteger(FDataLine);
      WriteInteger(FTablePerPage);
      WriteInteger(FLineList.Count);}
procedure TfMain.btn4Click(Sender: TObject);
var
    p :PPage;
    l:PLine;
    c : PCell;
    cpos :PCellPosition;
begin
    //save
    p:=  PPage.Create;
    //p.id := 'str';

    p.LineList := PLineList.Create(PLine);
    p.ReportScale := 1;
    p.PageWidth := 1024;
    p.PageHeight := 768 ;
    p.LeftMargin := 5;
    p.TopMargin := 5;
    p.RightMargin := 5;
    p.BottomMargin := 5;
    p.NewTable := true;
    p.DataLine := 2;
    p.TablePerPage := 1;
    
    l :=PLine(p.LineList.Add);
    l._Index := 1;
    l.MinHeight := 70 ;
    l.DragHeight := 70;
    l.LineRect.left := 1;

    c :=  PCell(l.CellList.add);
    c.id:='c1';
    c.i := 1 ;
    cpos :=PCellPosition(c.SlaveCells.Add);
    cpos.LineIndex := 1;
    cpos.CellIndex :=  1;
    PLine(p.LineList.Add)._Index := 2;
    PLine(p.LineList.Add)._Index := 3;
    TOmniXMLWriter.SaveToFile(p,  '2.xml',pfAttributes,    ofIndent);
    p.free;
    // load
    p:=  PPage.Create;

    TOmniXMLReader.LoadFromFile(p, '2.xml');
    //assert (p.id = 'str');
    assert (p.LineList.count = 3);
    l :=  PLine(p.LineList.Items[0]);
    assert (l._Index = 1);
     assert (l.LineRect.left = 1);
    assert(PCell(l.CellList.Items[0] ).id = 'c1' )   ;
      assert(PCell(l.CellList.Items[0] ).OwnerCellPosition.lineIndex = 0 )   ;
    p.free;
end;




end.

