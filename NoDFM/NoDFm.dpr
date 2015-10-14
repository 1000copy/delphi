program NoDFm;

uses
  Forms,
  MainForm in 'MainForm.pas';

{$R *.res}

begin
  Application.Initialize;
//  Application.CreateForm(TForm,Form1);
  Application.CreateForm(TAppForm,MainForm_);
  Application.Run;
end.
