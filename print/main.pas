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
    procedure btn3Click(Sender: TObject);
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
uses pm;
procedure TfMain.btn3Click(Sender: TObject);
var
    p :NPage;l:NLine;
begin
    //save
    p:=  NPage.Create;
    p.id := 'str';
    p.LineList := NLineList.Create(NLine);
    l :=NLine(p.LineList.Add);
    l.id := '1';
    NCell(l.CellList.add).id:='c1';
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
    assert (NLine(p.LineList.Items[1]).id = '2');
    assert (NLine(p.LineList.Items[2]).id = '3');
    p.free;
end;



end.

