unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Buttons;

type
  TMainForm = class(TForm)

  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  MainForm_: TMainForm;
Type
  TAppForm = class(TMainForm )   public
  constructor Create(AOwner: TComponent); override;
  end;
implementation



constructor TMainForm.Create(AOwner: TComponent);
begin
  CreateNew(AOwner);
  self.Position :=  poScreenCenter;
end;



{ TAppForm }

constructor TAppForm.Create(AOwner: TComponent);
begin
  inherited;
  self.InsertControl(TBitBtn.create(Self));
end;

end.
