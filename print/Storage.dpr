program Storage;

uses
  Forms,
  main in 'main.pas' {fMain},
  pm in 'pm.pas',
  PrintDO in 'PrintDO.pas',
  printGear in 'printGear.pas',
  SimpleStream in 'SimpleStream.pas',
  uReport in 'uReport.pas',
  uCellList in 'uCellList.pas',
  osservice in 'osservice.pas',
  OmniXMLXPath in 'OmniXMLXPath.pas',
  OmniXMLUtils in 'OmniXMLUtils.pas',
  OmniXMLProperties in 'OmniXMLProperties.pas',
  OmniXMLPersistent in 'OmniXMLPersistent.pas',
  OmniXMLDatabase in 'OmniXMLDatabase.pas',
  OmniXMLConf in 'OmniXMLConf.pas',
  OmniXML_Types in 'OmniXML_Types.pas',
  OmniXML_MSXML in 'OmniXML_MSXML.pas',
  OmniXML_LookupTables in 'OmniXML_LookupTables.pas',
  OmniXML_IniHash in 'OmniXML_IniHash.pas',
  OmniXML_Dictionary in 'OmniXML_Dictionary.pas',
  OmniXML in 'OmniXML.pas',
  MSXML2_TLB in 'MSXML2_TLB.pas',
  GpTextStream in 'GpTextStream.pas',
  GpStreamWrapper in 'GpStreamWrapper.pas',
  CC in 'cc.pas',
  uForm1 in 'uForm1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
