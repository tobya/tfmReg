{******************************************************************************}
{*  TFMREG - Programmers registry editor.                                     *}
{*  Copyright Toby Allen - Toflidium Software 2001                            *}
{*                                                                            *}
{******************************************************************************}
{*                                                                            *}
{* 7/02/2002 Toby                                                             *}
{* 1. Form no longer created here, must be created when called.               *}
{******************************************************************************}

unit SearchValuesDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  tfmRegClasses,
  tfmCommonReg;

type
  TfrmSearchValuesDlg = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    ckbxHKCR: TCheckBox;
    ckbxHKCU: TCheckBox;
    ckbxHKLM: TCheckBox;
    ckbxHKU: TCheckBox;
    ckbxHKCC: TCheckBox;
    ckbxSearchKeys: TCheckBox;
    ckbxSearchValueNames: TCheckBox;
    ckbxSearchValueData: TCheckBox;
    ckbxSearchCaseSensitive: TCheckBox;
    ckbxMatchWholeKey: TCheckBox;
    edSearchValue: TEdit;
    btnCancel: TButton;
    btnOK: TButton;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Function ShowAndReturn(Const Search:  TRegSearch) : Boolean;
  end;

var
  frmSearchValuesDlg: TfrmSearchValuesDlg;

implementation

{$R *.DFM}

{ TfrmSearchValuesDlg }

function TfrmSearchValuesDlg.ShowAndReturn(
  const Search: TRegSearch): Boolean;
begin
    Result := False;

    if showmodal = mrOK then
    begin
        With Search do
        begin
            SearchValue := edSearchValue.Text;
            SearchValueData  := ckbxSearchValueData.checked;
            SearchValueName  := ckbxSearchValueNames.Checked;
            SearchKeyNames   := ckbxSearchKeys.Checked;
            CaseSensitive    := ckbxSearchCaseSensitive.Checked;
            MatchWholeKey    := ckbxMatchWholeKey.Checked;

            HKEYS.ShowHive[hkey_CLasses_Root] := ckbxHKCR.Checked;
            HKEYS.ShowHive[hkey_Local_Machine] := ckbxHKLM.Checked;
            HKEYS.ShowHive[HKEY_CURRENT_USER] := ckbxHKCU.Checked;
            HKEYS.ShowHive[HKEY_CURRENT_CONFIG] :=  ckbxHKCC.Checked ;
            HKEYS.SHOWHIVE[HKEY_USERS] := ckbxHKU.Checked ;
       end;
       Result := True;
    end;



end;

procedure TfrmSearchValuesDlg.btnOKClick(Sender: TObject);
begin
    if edSearchValue.text = '' then
    begin
        Showmessage('You must specify text to be searched for.');
        ModalResult := mrNone;
    end;
end;

end.
