object frmOptionsDlg: TfrmOptionsDlg
  Left = 423
  Top = 167
  Width = 445
  Height = 411
  HelpContext = 1001
  Caption = 'Options'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 16
    Top = 16
    Width = 393
    Height = 305
    ActivePage = TabSheet1
    TabIndex = 0
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Options'
      object GroupBox1: TGroupBox
        Left = 16
        Top = 96
        Width = 345
        Height = 113
        Caption = 'Favorites and Patterns'
        TabOrder = 0
        object tfmOptionCheckBox1: TtfmOptionCheckBox
          Left = 32
          Top = 32
          Width = 233
          Height = 17
          Caption = 'Always use separate windows for display'
          TabOrder = 0
          AppOptions = MainForm.Options
          OptionItem = 'AlwaysNewChildren'
          OptionUpdateType = utLive
        end
        object tfmOptionCheckBox2: TtfmOptionCheckBox
          Left = 32
          Top = 56
          Width = 193
          Height = 17
          Caption = 'Follow pattern using same window.'
          Checked = True
          State = cbChecked
          TabOrder = 1
          AppOptions = MainForm.Options
          OptionItem = 'FollowPatterns'
          OptionUpdateType = utLive
        end
        object tfmOptionCheckBox3: TtfmOptionCheckBox
          Left = 32
          Top = 80
          Width = 241
          Height = 17
          Caption = 'Follow patterns if in Favorites Window'
          Checked = True
          State = cbChecked
          TabOrder = 2
          AppOptions = MainForm.Options
          OptionItem = 'FollowPatternFavoriteChild'
          OptionUpdateType = utLive
        end
      end
      object gbStartup: TGroupBox
        Left = 16
        Top = 24
        Width = 345
        Height = 65
        Caption = 'Startup'
        TabOrder = 1
        object ckbxStartwithHives: TtfmOptionCheckBox
          Left = 32
          Top = 32
          Width = 289
          Height = 17
          Caption = 'On Startup use separate windows for hives'
          Checked = True
          State = cbChecked
          TabOrder = 0
          AppOptions = MainForm.Options
          OptionItem = 'StartupWithHives'
          OptionUpdateType = utLive
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Global Options'
      ImageIndex = 1
      object Label1: TLabel
        Left = 24
        Top = 48
        Width = 225
        Height = 41
        AutoSize = False
        Caption = 
          'This option allows you to type '#39'tfmreg'#39' in the Start|Run box and' +
          ' the application will start.'
        WordWrap = True
      end
      object Button1: TButton
        Left = 224
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Apply'
        TabOrder = 0
        OnClick = Button1Click
      end
      object ckbxGlobalPath: TCheckBox
        Left = 24
        Top = 24
        Width = 193
        Height = 17
        Caption = 'Add Application path to system path.'
        TabOrder = 1
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Search'
      ImageIndex = 2
      object tfmOptionCheckBox4: TtfmOptionCheckBox
        Left = 32
        Top = 32
        Width = 209
        Height = 17
        Caption = 'Show current key when searching'
        Checked = True
        State = cbChecked
        TabOrder = 0
        AppOptions = MainForm.Options
        OptionItem = 'ShowSearchKeyCaption'
        OptionUpdateType = utLive
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Display'
      ImageIndex = 3
      object GroupBox2: TGroupBox
        Left = 8
        Top = 16
        Width = 369
        Height = 249
        Caption = 'Display Options'
        TabOrder = 0
        object tfmOptionCheckBox5: TtfmOptionCheckBox
          Left = 16
          Top = 24
          Width = 241
          Height = 17
          Caption = 'Show Simple Data Type Names'
          TabOrder = 0
          OptionItem = 'FriendlyDataNames'
          OptionUpdateType = utLive
        end
      end
    end
  end
  object btnOK: TButton
    Left = 328
    Top = 344
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnApply: TButton
    Left = 96
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 2
    Visible = False
  end
  object btnCancel: TButton
    Left = 16
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    Visible = False
  end
end
