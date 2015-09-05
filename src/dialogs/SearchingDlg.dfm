object frmSearching: TfrmSearching
  Left = 412
  Top = 333
  BorderIcons = []
  BorderStyle = bsSingle
  ClientHeight = 108
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 88
    Top = 16
    Width = 240
    Height = 13
    Caption = 'Searching for requested keys and values in registry'
  end
  object Label2: TLabel
    Left = 8
    Top = 72
    Width = 337
    Height = 33
    AutoSize = False
    Transparent = True
    WordWrap = True
  end
  object Animate1: TAnimate
    Left = 16
    Top = 8
    Width = 57
    Height = 57
    Active = False
    AutoSize = False
    Color = clBtnFace
    CommonAVI = aviFindFile
    ParentColor = False
    StopFrame = 8
  end
  object btnCancel: TButton
    Left = 256
    Top = 40
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
end
