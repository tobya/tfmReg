unit SearchingDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, tfmRegClasses;

type
  TfrmSearching = class(TForm)
    Animate1: TAnimate;
    Label1: TLabel;
    btnCancel: TButton;
    Label2: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    n: Integer; {Counter for display.}
    FSearchObject : TRegSearch;
    procedure SetSearchObject(const Value: TRegSearch);
    { Private declarations }
  public
    { Public declarations }
    Property SearchObject : TRegSearch write SetSearchObject;
    Procedure SearchKey(Sender : TObject; Path : String);
  end;

var
  frmSearching: TfrmSearching;

implementation
uses Main;
{$R *.DFM}

procedure TfrmSearching.FormActivate(Sender: TObject);
begin
    Animate1.Active := true;
    n:= 0;
end;

procedure TfrmSearching.btnCancelClick(Sender: TObject);
begin
    fSearchObject.Cancel;
end;

procedure TfrmSearching.SearchKey(Sender: TObject; Path: String);
begin
    {$IFNDEF NoSearchCaption}
    if n = 140 then
    begin
    Label2.Caption := Path;
    Application.ProcessMessages;
    n := 0;
    end
    else
        inc(n);
    {$ENDIF}
end;

procedure TfrmSearching.SetSearchObject(const Value: TRegSearch);
begin
    FSearchObject := Value;
    if MainForm.Options.ItembyName['ShowSearchKeyCaption'].AsBoolean then
        FSearchObject.OnSearchKey := SearchKey;
end;

end.
