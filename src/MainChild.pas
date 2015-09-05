{******************************************************************************}
{*  TFMREG - Programmers registry editor.                                     *}
{*  Copyright Toby Allen - Toflidium Software 2001                            *}
{*                                                                            *}
{******************************************************************************}
{*                                                                            *}
{* 15/07/2001 Toby                                                            *}
{* 1. Added TRegChild type and ChildType property to Form.                    *}
{* 7/02/2002 Toby                                                             *}
{* 1. Changed Declaration of TRegChild to TRegChildType.                      *}
{* 2. Tidied Up.                                                              *}
{*                                                                            *}
{* 21/02/02 Toby                                                              *}
{* 1. Added code to display an extracted icon from a file.                    *}
{******************************************************************************}

unit MainChild;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, ImgList, Menus,StdCtrls, ComObj,ShellApi,
  {Toflidium}
  ExtendedRegTreeView,
  RegTreeView,
  RegFavorites,
  tfmBaseComponents,
  tfmCommonReg;

type

  TRegChildType = (rcFull, rcFavorite, rcPattern, rcSearch);



  
  TfrmRegChild = class(TForm)
    Panel1:             TPanel;
    Panel3:             TPanel;
    Splitter1:          TSplitter;
    Panel2:             TPanel;
    RegTreeView1:       TTfmRegTreeView;
    RegListView1:       TRegListView;
    ImageListTreeview:  TImageList;
    ImageListListView:  TImageList;
    StatusBar1:         TStatusBar;
    ImageListStates:    TImageList;
    pnlShowInfo:        TPanel;
    Memo1:              TMemo;
    IconImagevw:        TImage;
    procedure FormCreate( Sender: TObject);
    procedure RegListView1DblClick( Sender: TObject);
    procedure FormCloseQuery(       Sender:     TObject;
                                var CanClose:   Boolean);
    procedure RegTreeView1Compare(  Sender: TObject;
                                    Node1, Node2: TTreeNode;
                                    Data: Integer; var Compare: Integer);
    procedure RegTreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure RegTreeView1GetSelectedIndex(Sender: TObject;
      Node: TTreeNode);
    procedure RegTreeView1Changing(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure RegListView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    fChildType :    TRegChildType;
    FFavFile :      TRegFavoritesFile;
    FFavorites:     TRegFavoritesFile;
    procedure SetChildType(const Value: TRegChildType);
    procedure SetFavorites(const Value: TRegFavoritesFile);
    function GetData: TObject;
    function rcFavorite: Boolean;
  public
    { Public declarations }
    Procedure LoadPattern(  Pattern: TRegFavoritesFile );
    property ChildType :    TRegChildType       read FChildType
                                                write SetChildType Stored rcFavorite;
    Property Favorites:     TRegFavoritesFile   read FFavorites
                                                write SetFavorites;
    
    Property Data :         TObject read GetData;
  Published

  end;
type
  TtfmInternalPatternDisplay = Procedure(Regchild : TfrmRegchild; Value : String);


  Procedure DisplayIcon(RegChild : TfrmRegchild ; IconString: String);
{There is no default Variable Declaration, as all instances
are created as MDI children of MainForm.}

implementation
uses  Main;
{$R *.DFM}

procedure TfrmRegChild.FormCreate(Sender: TObject);
begin
        RegTreeView1.Active := true;
end;

procedure TfrmRegChild.RegListView1DblClick(Sender: TObject);
begin
    if RegListView1.EditValue then
    begin
        RegListView1.Refresh;
    end;
end;

procedure TfrmRegChild.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    {Release is called here, to ensure form is destroyed and not
    just minimised, something to do with MDI Applications.}
    Canclose := True;
    release;
end;

procedure TfrmRegChild.LoadPattern(Pattern: TRegFavoritesFile);
begin
    FFavFile := pattern;
    RegTreeView1.LoadPattern(Pattern);
    //ChildType := rcFavorite;
end;

procedure TfrmRegChild.SetChildType(const Value: TRegChildType);
begin
  FChildType := Value;
end;

procedure TfrmRegChild.SetFavorites(const Value: TRegFavoritesFile);
begin
  FFavorites := Value;
end;

procedure TfrmRegChild.RegTreeView1Compare( Sender: TObject;
                                            Node1, Node2: TTreeNode;
                                            Data: Integer;
                                            var Compare: Integer);
var
    aHKEY: HKEY;
    bHKEY: HKEY;
begin
    if (pos('HKEY',Node1.Text) > 0) and (pos('HKEY', Node2.text) > 0) then
    begin
        aHKEY := HKeyFromString(Node1.text);
        bHKEY := HKeyFromString(Node2.text);
        Compare := aHKEY - bHKEY;
    end
    else
        Compare := AnsiCompareText(node1.text, node2.Text );
end;

procedure TfrmRegChild.RegTreeView1GetImageIndex(Sender: TObject;
  Node: TTreeNode);
  var
  i : integer;
begin
    IF Node = RegTreeView1.RootNode  then
    begin
        Node.ImageIndex := 0;
        exit;
    end;

    i := RegTreeView1.NodeImageIndex(Node);
    Case i of
        0: Node.ImageIndex := 0;
        1: Node.ImageIndex := 4;
        2: Node.Imageindex := 5;
        3: Node.ImageIndex := 6;
        4: Node.ImageIndex := 7;
    end; {case}
    node.StateIndex := 0;
end;

procedure TfrmRegChild.RegTreeView1GetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
  var i : Integer;
begin
    (*IF Node = RegTreeView1.RootNode  then
    begin
        Node.StateIndex := 0;
        exit;
    end;

    i := RegTreeView1.NodeImageIndex(Node);
    Case i of
        0: Node.SelectedIndex := 0;
        1: Node.SelectedIndex := 4;
        2: Node.SelectedIndex := 5;
        3: Node.SelectedIndex := 6;
    end; {case}  *)
    Node.SelectedIndex := node.ImageIndex;
end;


function TfrmRegChild.GetData: TObject;
begin
    { TODO -oToby -cSearch :
    Insert code to return an object with important
    information about the search or favorites etc }
    (*Case ChildType of
       ;

    end; {case}*)
end;





procedure DisplayIcon(RegChild : TfrmRegChild  ; IconString: String);
var
    fn : TFilename;
    H: THandle;
    DelimPos, Iconindex : integer;
begin
    {Put code in to display Icon and show panel.}
    delimpos := LastDelimiter(',',IconString);
    IconIndex := strtoint(copy(iconstring,delimpos +1 , maxint));
    fn := copy(IconString,1,delimpos -1);
    h := extracticon(hinstance,pchar(fn),IconIndex);
    //icon.Handle := h;

   with regchild do
   begin
        pnlShowInfo.visible := true;
        iconimagevw.visible := true;
        if IconImagevw.Picture.Icon.Handle <> 0 then
            IconImagevw.Picture.Icon.ReleaseHandle;
        Iconimagevw.Picture.Icon.Handle := h;

   end;


end;

function TfrmRegChild.rcFavorite: Boolean;
begin

end;

procedure TfrmRegChild.RegTreeView1Changing(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
    pnlShowInfo.Visible := False;
    IconImagevw.Visible := False;
end;

procedure TfrmRegChild.RegListView1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
    Listitem : TListItem;
begin
    if (Key = VK_DELETE	) or (Key = VK_BACK) then
    begin
        Listitem := RegListView1.Selected;
        if assigned(listitem ) then
        begin
           RegListView1.DeleteValue(listitem.caption);
        end;
    end;
end;



end.
