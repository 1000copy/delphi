program Storage;

uses
  Forms,
  main in 'main.pas' {fMain},
  pm in 'pm.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
