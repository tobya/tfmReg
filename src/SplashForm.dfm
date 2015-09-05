object frmSplash: TfrmSplash
  Left = 328
  Top = 214
  BorderStyle = bsNone
  Caption = 'frmSplash'
  ClientHeight = 236
  ClientWidth = 398
  Color = 12615697
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 72
    Top = 0
    Width = 281
    Height = 41
    AutoSize = False
    Caption = 'Toflidium Software'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Times New Roman'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 152
    Top = 48
    Width = 100
    Height = 27
    Caption = 'TFMREG'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 1455520
    Font.Height = -24
    Font.Name = 'ZapfChan Bd BT'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 112
    Width = 368
    Height = 21
    Caption = 'Toflidium Software Programmers Registry Editor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 144
    Top = 176
    Width = 106
    Height = 24
    Caption = 'Trial Version'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 120
    Top = 80
    Width = 158
    Height = 24
    Caption = 'www.toflidium.com'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 96
    Top = 208
    Width = 220
    Height = 13
    Caption = 'Copyright Toby Allen - Toflidium Software 2002'
  end
  object Label7: TLabel
    Left = 88
    Top = 144
    Width = 241
    Height = 25
    AutoSize = False
    Caption = 
      'Rember editing the registry can cause system failure, so ensure ' +
      'you are sure of what you are doing.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 4000
    OnTimer = Timer1Timer
    Left = 40
    Top = 200
  end
end
