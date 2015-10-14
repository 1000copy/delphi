

unit test;

interface

uses
 Windows,SysUtils, dtu;

type

  TTestTest = class(TTestCase)
  private
    fTestCount: integer;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published

    procedure TestCheck;

  end;

 

implementation

procedure TTestTest.SetUp;
begin
  inherited;
//  Writeln('setup');
end;

procedure TTestTest.TearDown;
begin
  inherited;
//   Writeln('teardown');
end;

procedure TTestTest.TestCheck;
var
  s1, s2, s3 :WideString;
begin
  Check(false, 'Check');
  
end;

initialization
  RegisterTests('Framework Suites',[TTestTest.Suite]);
end.
