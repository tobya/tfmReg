unit FavManagerDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,RegFavorites, utilityfunctions;

type
  TfrmFavsManager = class(TForm)
    ComboFavs: TComboBox;
    lboxPaths: TListBox;
    btnRemoveEntry: TButton;
    btnDeleteFile: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure ComboFavsChange(Sender: TObject);
    procedure btnRemoveEntryClick(Sender: TObject);
    procedure btnDeleteFileClick(Sender: TObject);
  private
    { Private declarations }
    CurrentFav : TRegFavoritesFile;
    fRegPattern : TRegPatterns;
  public
    { Public declarations }
    function ShowandReturn(RegPattern :TRegPatterns) : boolean; 
  end;

var
  frmFavsManager: TfrmFavsManager;

implementation

{$R *.dfm}

procedure TfrmFavsManager.Button3Click(Sender: TObject);
begin
    Close;
end;

function TfrmFavsManager.ShowandReturn(RegPattern: TRegPatterns): boolean;
var
    Index : Integer;
begin
    fregPattern := RegPattern;
    for index := 0 to RegPattern.Favorites.Count -1 do
    begin
        ComboFavs.Items.AddObject(regpattern.Favorites[index].DisplayName , RegPattern.Favorites[index])
    end;
    ShowModal;
    Result := True;
end;

procedure TfrmFavsManager.ComboFavsChange(Sender: TObject);

begin
    CurrentFav := (combofavs.items.objects[combofavs.itemindex] as TRegFavoritesFile);
    lboxpaths.items.assign(currentfav.regpaths);
end;

procedure TfrmFavsManager.btnRemoveEntryClick(Sender: TObject);
var
    iIndex : Integer;
begin
    iIndex := lboxPaths.ItemIndex;
    if iIndex > -1 then
    begin
        lboxPaths.DeleteSelected;
        CurrentFav.RegPaths.Delete(iindex);
    end;
end;

procedure TfrmFavsManager.btnDeleteFileClick(Sender: TObject);
var
    fn :String;
    itemindex : Integer;
begin
    if combofavs.itemindex = -1 then exit;
    itemindex := ComboFavs.ItemIndex;
    if MessageDlg('Are you sure you wish to delete this favorite file?',mtConfirmation ,mbOKCancel ,0) = mrOK then
    begin
        fn :=  fRegPattern.Favorites.Items[itemindex].FileName;
        fRegPattern.Favorites.Delete(itemindex);
        deletefileifexists(fn);
        ComboFavs.DeleteSelected;
        lboxPaths.Clear;
    end;
    if itemindex = 0 then
        inc(itemindex );
    if itemindex > combofavs.items.count -1 then
        dec(itemindex);

    try
        ComboFavs.ItemIndex := itemindex;
        combofavs.OnChange(combofavs);
    except
        on E: EListError do
            //ignore;
        else
            Raise;
    end;

end;

end.
