object frmSearchValuesDlg: TfrmSearchValuesDlg
  Left = 326
  Top = 227
  Width = 424
  Height = 281
  ActiveControl = edSearchValue
  Caption = 'Search Registry'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 16
    Width = 393
    Height = 185
    Caption = 'Search Values '
    TabOrder = 0
    object GroupBox2: TGroupBox
      Left = 8
      Top = 56
      Width = 377
      Height = 121
      Caption = 'Options'
      TabOrder = 0
      object ckbxHKCR: TCheckBox
        Left = 24
        Top = 16
        Width = 161
        Height = 17
        Caption = 'HKEY_CLASSES_ROOT'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object ckbxHKCU: TCheckBox
        Left = 24
        Top = 32
        Width = 161
        Height = 17
        Caption = 'HKEY_CURRENT_USER'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object ckbxHKLM: TCheckBox
        Left = 24
        Top = 48
        Width = 161
        Height = 17
        Caption = 'HKEY_LOCAL_MACHINE'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object ckbxHKU: TCheckBox
        Left = 24
        Top = 64
        Width = 161
        Height = 17
        Caption = 'HKEY_USERS'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object ckbxHKCC: TCheckBox
        Left = 24
        Top = 80
        Width = 161
        Height = 17
        Caption = 'HKEY_CURRENT_CONFIG'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object ckbxSearchKeys: TCheckBox
        Left = 192
        Top = 16
        Width = 97
        Height = 17
        Caption = 'KEYS'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object ckbxSearchValueNames: TCheckBox
        Left = 192
        Top = 32
        Width = 97
        Height = 17
        Caption = 'VALUE NAMES'
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object ckbxSearchValueData: TCheckBox
        Left = 192
        Top = 48
        Width = 97
        Height = 17
        Caption = 'VALUE DATA'
        Checked = True
        State = cbChecked
        TabOrder = 7
      end
      object ckbxSearchCaseSensitive: TCheckBox
        Left = 192
        Top = 64
        Width = 121
        Height = 17
        Caption = 'CASE SENSITIVE'
        TabOrder = 8
      end
      object ckbxMatchWholeKey: TCheckBox
        Left = 192
        Top = 80
        Width = 153
        Height = 17
        Caption = 'MATCH WHOLE KEY'
        Checked = True
        State = cbChecked
        TabOrder = 9
      end
    end
    object edSearchValue: TEdit
      Left = 8
      Top = 16
      Width = 377
      Height = 21
      TabOrder = 1
    end
  end
  object btnCancel: TButton
    Left = 208
    Top = 216
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object btnOK: TButton
    Left = 104
    Top = 216
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = btnOKClick
  end
end
