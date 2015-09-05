object frmFavsManager: TfrmFavsManager
  Left = 229
  Top = 171
  Width = 322
  Height = 406
  Caption = 'Favorites Manager'
  Color = clBtnFace
  Constraints.MaxHeight = 406
  Constraints.MinHeight = 406
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    314
    379)
  PixelsPerInch = 96
  TextHeight = 13
  object ComboFavs: TComboBox
    Left = 8
    Top = 8
    Width = 289
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
    OnChange = ComboFavsChange
  end
  object lboxPaths: TListBox
    Left = 8
    Top = 32
    Width = 289
    Height = 297
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 1
  end
  object btnRemoveEntry: TButton
    Left = 8
    Top = 344
    Width = 89
    Height = 25
    Caption = 'Remove Entry'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnRemoveEntryClick
  end
  object btnDeleteFile: TButton
    Left = 104
    Top = 344
    Width = 89
    Height = 25
    Caption = 'Delete Entire File'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnDeleteFileClick
  end
  object Button3: TButton
    Left = 224
    Top = 344
    Width = 75
    Height = 25
    Anchors = [akRight]
    Caption = 'Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 4
    OnClick = Button3Click
  end
end
