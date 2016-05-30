object fMain: TfMain
  Left = 268
  Top = 192
  BorderStyle = bsDialog
  Caption = 'OmniXML demo: Storage'
  ClientHeight = 355
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object btn3: TButton
    Left = 40
    Top = 88
    Width = 75
    Height = 25
    Caption = 'btn3'
    TabOrder = 0
    OnClick = btn3Click
  end
  object btn4: TButton
    Left = 160
    Top = 88
    Width = 75
    Height = 25
    Caption = 'btn4'
    Default = True
    TabOrder = 1
    OnClick = btn4Click
  end
end
