
{$apptype console}


program dtest;

uses
  SysUtils,
  forms,
  test in 'test.pas',
  dtu in 'dtu.pas';

begin
     RunTests(rxbPause);
end.

