program Storage;

uses
  Forms,
  main in 'main.pas' {fMain},
  pm in 'pm.pas',
  PrintDO in 'PrintDO.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
