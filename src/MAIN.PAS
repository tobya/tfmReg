{******************************************************************************}
{*  TFMREG - Programmers registry editor.                                     *}
{*  Copyright Toby Allen - Toflidium Software 2001                            *}
{*                                                                            *}
{******************************************************************************}
{*                                                                            *}
{* 15/07/2001 Toby                                                            *}
{* 1. Made CreateMDIChild public.                                             *}
{*                                                                            *}
{* 29/09/2001 Toby                                                            *}
{* 1. Uses TGuidInfo.                                                         *}
{* 7/02/02 Toby                                                               *}
{* 1. Removed some Menu items no longer used.  Removed commented out code     *}
{* 2. Set ChildDestroyed to be a event for the onDestroy event of each child  *}
{* 3. Provided Comments for many of the functions                             *}
{* 4. Tidied up.                                                              *}
{* 5. Refresh Display function to ensure Tabs and Child Captions match.       *}
{* 6. Added Dropdown button to allow user to Select just a particular hive.   *}
{*                                                                            *}
{* 8/02/02 Toby                                                               *}
{* 1. Added code to show OptionsDLg and use Options object to get option value*}
{*                                                                            *}
{* 18/02/2002 Toby                                                            *}
{* 1. Added code needed to implement starup option to show hives in seperate  *}
{*    windows on startup if the user wishes.                                  *}
{* 20/02/02 Toby                                                              *}
{* 1. Added Ability to change font.                                           *}
{* 2. Hid some popup menu items when mycomputer clicked.                      *}
{*                                                                            *}
{* 21/02/02 Toby                                                              *}
{* 1. Added code to deal with an 'Internal Command' Pattern.                  *}
{******************************************************************************}
unit Main;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns, ComObj,
  ActnList, ToolWin, ImgList,Registry,Clipbrd,FileCtrl,shellapi,Contnrs,
  {Toflidium}
  tfmRegAppConst,
  UtilityFunctions,
  tfmAppOptions,
  {TFMReg}
  MainChild,
  RegFavorites,
  RegTreeView,
  tfmRegClasses,
  FavoritesCollection,
  tfmpattclass2,
  tfmCommonreg,
  SearchingDlg,
  SearchValuesDialog,
  RegExport,
  OptionsDlg,
  FavManagerDlg
  {unitntsecurity}
  {$IFDEF LOGGING }
    ,DEBUGDLG
  {$ENDIF}
  , tfmMsgDialog, tfmOptionItems;

type
  TFollowPatternFlag = (fpSeperate, fpSameWindow);

  TMainForm = class(TForm)
    MainMenu1:      TMainMenu;
    File1:          TMenuItem;
    FileNewItem:    TMenuItem;
    FileCloseItem:  TMenuItem;
    Window1:        TMenuItem;
    Help1:          TMenuItem;
    N1:             TMenuItem;
    FileExitItem:   TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpAboutItem:  TMenuItem;
    OpenDialog:     TOpenDialog;
    Edit1:          TMenuItem;
    WindowMinimizeItem: TMenuItem;
    StatusBar:      TStatusBar;
    ActionList1:    TActionList;
    EditCut1:       TEditCut;
    EditCopy1:      TEditCopy;
    EditPaste1:     TEditPaste;
    FileNew1:       TAction;
    FileSave1:      TAction;
    FileExit1:      TAction;
    FileOpen1:      TAction;
    FileSaveAs1:    TAction;
    WindowCascade1:     TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowArrangeAll1:  TWindowArrange;
    WindowMinimizeAll1: TWindowMinimizeAll;
    HelpAbout1:         TAction;
    FileClose1:         TWindowClose;
    WindowTileVertical1: TWindowTileVertical;
    WindowTileItem2:    TMenuItem;
    ToolBar2:       TToolBar;
    ToolButton2:    TToolButton;
    ToolButton3:    TToolButton;
    tbtnNew: TToolButton;
    ToolButton8:    TToolButton;
    ToolButton10:   TToolButton;
    ToolButton11:   TToolButton;
    ImageListMainIcons: TImageList;
    actNewFavorites:    TAction;
    ComboFavorites1: TComboBox;
    mnuFavoritesMM: TMenuItem;
    MnuFavoritesRefresh: TMenuItem;
    pMnuTreeview:       TPopupMenu;
    ExploreTreeinnewWindow1: TMenuItem;
    mnuAddtoFavorite:   TMenuItem;
    NewFavorite1:       TMenuItem;
    pmnuListView: TPopupMenu;
    tbtnBack:       TToolButton;
    actBack:        TAction;
    FileListBox1:   TFileListBox;
    mnutvNew: TMenuItem;
    Key1:           TMenuItem;
    N2:             TMenuItem;
    Stringvalue1:   TMenuItem;
    DWordValue1:    TMenuItem;
    BinaryValue1:   TMenuItem;
    mnulvNew: TMenuItem;
    Key2:           TMenuItem;
    N3:             TMenuItem;
    Stringvalue2:   TMenuItem;
    DWordValue2:    TMenuItem;
    BinaryValue2:   TMenuItem;
    popmnuHives: TPopupMenu;
    mnutvDelete: TMenuItem;
    mnutvRename: TMenuItem;
    N5:             TMenuItem;
    tbtnRefresh:    TToolButton;
    Refresh1:       TMenuItem;
    mnuCopyKeyName: TMenuItem;
    mnuCopyKeyPath: TMenuItem;
    N6:             TMenuItem;
    N9:             TMenuItem;
    mnuLVRename:    TMenuItem;
    mnulvDelete:    TMenuItem;
    N10:            TMenuItem;
    AddNewFavorite1: TMenuItem;
    N13:            TMenuItem;
    mnuPatternSeperatorTV: TMenuItem;
    tbtnFavorites:      TToolButton;
    PopMnuFavorites:    TPopupMenu;
    mnuFind:        TMenuItem;
    N14:            TMenuItem;
    ExpandFully1:   TMenuItem;
    Tools1:         TMenuItem;
    ExportKey1:     TMenuItem;
    TabChildren:    TTabControl;
    mnuPatternSeperatorLV: TMenuItem;
    tbtnForward:    TToolButton;
    mnuOptions:     TMenuItem;
    AllHives1:      TMenuItem;
    N4:             TMenuItem;
    mnuHKEYCLASSESROOT: TMenuItem;
    mnuHKEYLOCALMACHINE: TMenuItem;
    mnuHKEYCURRENTUSER: TMenuItem;
    mnuHKEYCURRENTCONFIG: TMenuItem;
    mnuHKEYUSERS: TMenuItem;
    Help2: TMenuItem;
    SaveDialog: TSaveDialog;
    ComboChildren1: TComboBox;
    mnuShowAllChildren: TMenuItem;
    Font1: TMenuItem;
    FontDialog1: TFontDialog;
    Options:                TAppOptions;
    Refresh2: TMenuItem;
    FavoritesManager1: TMenuItem;
    mnuShowFavSep: TMenuItem;
    Security1: TMenuItem;
    MultiStringValue1: TMenuItem;
    ExpandStringValue1: TMenuItem;
    MultipleStringValue1: TMenuItem;
    ExpandStringValue2: TMenuItem;
    tfmMsgDialog1: TtfmMsgDialog;
    OptFavoritesFolderPath: TStringOption;
    AlwaysNewChildren: TIntegerOption;
    FollowPatterns: TIntegerOption;
    FollowPatternFavoriteChild: TIntegerOption;
    StartupWithHives: TIntegerOption;
    ShowSearchKeyCaption: TIntegerOption;
    mnuExpandAllinFavorite: TMenuItem;
    mnuExportKey: TMenuItem;
    Registration1: TMenuItem;

    procedure FileNew1Execute(  Sender: TObject);
    procedure FileOpen1Execute( Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FileExit1Execute( Sender: TObject);
    procedure actNewFavoritesExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboFavorites1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FileClose1Execute(Sender: TObject);
    procedure MnuFavoritesRefreshClick(Sender: TObject);
    procedure ComboChildren1Change(Sender: TObject);
    procedure Key1Click(Sender: TObject);
    procedure mnutvRenameClick(Sender: TObject);
    procedure mnutvDeleteClick(Sender: TObject);
    procedure Refresh1Click(Sender: TObject);
    procedure mnuCopyKeyNameClick(Sender: TObject);
    procedure mnuCopyKeyPathClick(Sender: TObject);
    procedure Stringvalue1Click(Sender: TObject);
    procedure DWordValue1Click(Sender: TObject);
    procedure BinaryValue2Click(Sender: TObject);
    procedure mnuLVRenameClick(Sender: TObject);
    procedure mnulvDeleteClick(Sender: TObject);
    procedure mnuFindClick(Sender: TObject);
    procedure ExpandFully1Click(Sender: TObject);
    procedure pmnuListViewPopup(Sender: TObject);
    procedure ExportKey1Click(Sender: TObject);
    procedure TabChildrenChange(Sender: TObject);
    procedure pMnuTreeviewPopup(Sender: TObject);
    procedure tbtnBackClick(Sender: TObject);
    procedure mnuHKEYCLASSESROOTClick(Sender: TObject);
    procedure mnuOptionsClick(Sender: TObject);
    procedure Help2Click(Sender: TObject);
    procedure mnuShowAllChildrenClick(Sender: TObject);
    procedure Font1Click(Sender: TObject);
    procedure ShowPanel1Click(Sender: TObject);
    procedure Refresh2Click(Sender: TObject);
    procedure FavoritesManager1Click(Sender: TObject);
    procedure Security1Click(Sender: TObject);
    procedure MultiStringValue1Click(Sender: TObject);
    procedure ExpandStringValue1Click(Sender: TObject);
    procedure mnuExpandAllinFavoriteClick(Sender: TObject);
    procedure Registration1Click(Sender: TObject);
  private
    { Private declarations }
    PatObjs:                TStringList;
    DynPatMenu:             TList;
    DynFavMenu:             TList;
    DynFavMainMenu:         TList;
    FFavList:               TStringList;
    fFavoritesChild:        TfrmRegChild;
    fSearchDisplayChild:    TFrmRegChild;
    fPatternShowChild:      TFrmRegChild;
    RExp :                  TBaseRegExport ;
    function  ActiveChild:  TfrmRegChild;
    procedure LoadFavorites;
    procedure RefreshDisplay;
    procedure GetMatchingPatternMenuItems(Menu : TPopupMenu);
    procedure AddToFavoritesClick(Sender : TObject);
    procedure AddToFavoritesSubitemClick(Sender : TObject);
    procedure OnPatternClick(Sender: TObject);
    procedure OnDisplayFavoriteClick(Sender: TObject);
    procedure SearchKeyFound(Sender : TObject; Path : String);
    Procedure ChildShown(Sender : TObject);
    procedure Loaded; override;
    function GetNewChild(ChildType: TRegChildType; ACaption : String): TFrmRegChild;
    {Cleanup Functions}
    procedure ClearDynamicMenuItems;

    {Check Functions}
    function Check_UseAddAllKeys(Child : TfrmRegChild ) : Boolean;
    procedure REGKEYChange(Sender: TObject; Node: TTreeNode);
  protected
        procedure ExportFinished(Sender: TObject);
        procedure ExportCancelled(Sender: TObject);
        {Setup Methods}
        procedure GetFileFolders;
  public
    RegPatterns : TRegPatterns;
    Procedure   ChildDestroyed(Sender : TObject);
    Procedure   ShowSplash;
    function    CreateMDIChild(const Name: string) : TfrmRegChild ;
    procedure CreateStartupChild;
  end;
Const
    MNUCAPTION_ADDKEYTOFAV = 'Add Key to Favorite';
    MNUCAPTION_ADDALLTOFAV = 'Add All Keys to Favorite';
var
  MainForm: TMainForm;

implementation

{$R *.DFM}

uses  About, SplashForm;


procedure TMainForm.FormCreate(Sender: TObject);
begin
    RegPatterns :=  TRegPatterns.Create;
    FFavList    :=  TStringList.Create;
    DynFavMainMenu := TList.Create;

    Application.HelpFile :=  extractfilepath(application.exename) + '\tfmreghelp.hlp';

    {These Lists are used for keeping track of Currently loaded patterns,
    their associated menu items, and Favorite Menu items. }
    patobjs :=      TStringList.Create;
    DynPatMenu :=   TList.Create;
    DynFavMenu :=   TList.Create;
    GetFileFolders;
    RegPatterns.FavoritesDirectory := optFavoritesFolderPath.ASString;
    RegPatterns.Load;
    LoadFavorites;    
    {$IFDEF Logging}
    DebugForm := TDebugForm.Create(self);
    debugform.Show;
    {$ENDIF}
end;


function TMainForm.CreateMDIChild(const Name: string) : TfrmRegChild ;
var
  Child: TfrmRegChild;
begin
  { create a new MDI child window }
  Child := TfrmRegChild.Create(Application);
  Child.WindowState :=  wsMaximized;
  Child.Caption :=      Name;
  Child.OnActivate :=   ChildShown;
  Child.OnDestroy :=    ChildDestroyed;
  Child.Font.assign(Self.Font);
  Child.RegTreeView1.OnChange := RegKeyChange;
  {Add to Tab control}
  TabChildren.TabIndex := TabChildren.Tabs.AddObject(Name,Child);
  //FFavList.AddObject(Name,Child);
  ComboChildren1.Items.AddObject(Name, Child);
  Result := Child;

  { TODO -cFeature :
    Insert Code here, and on refresh of options to set FriendlyDataNames
    to true for the reglistview on the children. }

end;

function TMainForm.ActiveChild: TfrmRegChild;
begin
    Result := TfrmRegChild(ActiveMDIChild);
end;


function TMainForm.GetNewChild(ChildType: TRegChildType; ACaption : String): TFrmRegChild;
begin
    //if (options.ItembyName['AlwaysNewChildren'].ASInteger > 0 ) and (not (ChildType = rcSearch)) then
if (AlwaysNewChildren.ASInteger > 0 ) and (not (ChildType = rcSearch)) then
    begin
        Result := CreateMDIChild(ACaption);
    end
    else
    begin
        Case ChildType of
        rcFavorite :
        begin
            if not assigned(fFavoritesChild) then
            begin
                fFavoritesChild  := CreateMDIChild(ACaption);
            end;

            Result := fFavoritesChild
        end;
        rcpattern:
        begin
            if not assigned(fPatternShowChild) then
            begin
                fPatternShowChild   := CreateMDIChild(ACaption);
            end;

            Result := fPatternShowChild
        end;
        rcSearch :
        begin
            if not assigned(fSearchDisplayChild) then
            begin
                fSearchDisplayChild   := CreateMDIChild(ACaption);
            end;

            Result := fSearchDisplayChild
        end;
        end;{case}
        Result.caption := ACaption;
    end;
    Result.ChildType  := childType;
    RefreshDisplay;
end;

{MDI REG CHILD EVENTS}

procedure TMainForm.ChildShown(Sender: TObject);
var
    ChildIndex : Integer;
begin
    With TfrmRegChild(Sender) do
    begin
        ChildIndex := TabChildren.Tabs.IndexOfObject(Sender);
        TabChildren.TabIndex := childindex;
        RegTreeView1.OnChange := RegKeyChange;
    end;
end;

procedure TMainForm.ChildDestroyed(Sender : TObject);

var
    Child : TfrmRegChild;
    ChildIndex: Integer;
begin
    Child := Sender as TfrmRegChild;

    //if not options.ItembyName['AlwaysNewChildren'].ASInteger > 0 then
    if not AlwaysNewChildren.ASInteger > 0 then
    begin
        if Child = fFavoritesChild  then
            fFavoritesChild := Nil;

        if child = fPatternShowChild then
            fPatternShowChild := nil;

        if Child = fSearchDisplayChild then
            fSearchDisplayChild := nil;
    end;
    ChildIndex:=  ComboChildren1.items.IndexOfObject(Child);

    combochildren1.items.Delete(ChildIndex);

    TabChildren.Tabs.Delete(ChildIndex);
end;







procedure TMainForm.LoadFavorites;
var
    index, MnuIndex, InsertIndex: Integer;
    tmpItem, tmpitemb,
    tmpItemC :  TMenuItem;
begin
    mnuAddtoFavorite.Clear;
    PopMnuFavorites.Items.Clear;
    FFavList.clear;

    for MnuIndex := 0 to DynFavMainMenu.Count -1 do
    begin
        TMenuitem(DynFavMainMenu.Items[mnuIndex]).Free;
    end;

    DynFavMainMenu.Clear;

    With RegPatterns do
    begin
        insertIndex := mnuShowFavSep.MenuIndex + 1;
        FFavList.Add(SHOWALLFAVORITE);
        for index := 0 to Favorites.Count -1 do
        begin
            FFavList.AddObject(Favorites[index].DisplayName, Favorites.Items[index]);
            tmpItem := NewItem(Favorites[Index].DisplayName ,0,false,true,AddToFavoritesSubItemClick,0,'MnuFavorites' + inttostr(Index));
            tmpItem.Tag := Index;
            mainform.mnuAddtoFavorite.Add(tmpItem);
            {Add Menu items to tool bar menu.}
            tmpItemb := NewItem(Favorites[Index].DisplayName ,0,false,true,OnDisplayFavoriteClick ,0,'MnuFavoritesB' + inttostr(Index));
            tmpItemB.Tag := Index;
            PopMnuFavorites.Items.Add(tmpItemb);
            {Add Menu items to Main Menu }
            tmpItemC := NewItem(Favorites[Index].DisplayName ,0,false,true,OnDisplayFavoriteClick,0,'MnuFavoritesC' + inttostr(Index) );
            tmpitemC.Tag := Index;
            mnuFavoritesMM.Insert(1,tmpitemc);
            inc(InsertIndex);
            tmpitemc.MenuIndex := InsertIndex;
            DynFavMainMenu.Add(tmpitemc);
        end;
    end;


end;

procedure TMainForm.ClearDynamicMenuItems;
var
    index : integer;
begin
    for index := 0 to DynPatMenu.Count -1 do
    begin
        TMenuItem(DynPatMenu.Items[index]).free;

    end;
    dynpatmenu.clear;
    for index := 0 to PatObjs.Count -1 do
    begin
        TPatternTree(Patobjs.Objects[index]).free;
    end;
    PatObjs.Clear;
end;



procedure TMainForm.GetMatchingPatternMenuItems(Menu: TPopupMenu);
var
    ptm: TPatternTree;
    tmpmenu : TMenuItem;
    sFilename : String;
    i , itemindex: integer;
    listitem : TListItem;
    tvNode : TTreeNode;
    Valuename, ValueData : String;
    isRoot : Boolean;


begin
    isRoot := False;
    ClearDynamicMenuItems;
    tvNode := ActiveChild.RegTreeView1.Selected;



    if not assigned( tvNode) then
        exit;

    if tvNode = ActiveChild.RegTreeView1.rootnode then
        IsRoot := True;

    if not(isRoot) then
    begin
        FileListBox1.Refresh;
        if DirectoryExists(GetAppPath + PATTERNS_SUBDIR) then
            FileListBox1.Directory := GetAppPath + PATTERNS_SUBDIR
        else
            exit;


        
        for i :=  0 to FileListBox1.Items.Count -1 do
        begin
            ptm :=  TPatternTree.Create;
            sfilename := filelistbox1.Directory + '\' + FileListBox1.Items[i];
            ptm.Load(sFilename );
            {if no item is selected, select default item.}
            if not assigned(    activechild.RegListView1.Selected ) then
            begin
                ActiveChild.RegListView1.Selected := activechild.RegListView1.Items[0];
            end;
            {if there arent any items exit.}
            if not assigned(ActiveChild.RegListView1.Selected) then exit;


            listitem :=     activechild.RegListView1.Selected ;

            ValueName := listitem.Caption ;
            valuedata := listitem.SubItems[1];


            if ptm.Match(    ActiveChild.RegTreeView1.GetNodePath(tvNode).FullPath ,valuename,valuedata ) then
            begin
                tmpmenu := NewItem(ptm.Description,0,false,true,OnPatternClick,0,'submenumenu' + inttostr(i) );
                tmpmenu.ImageIndex := 27;
                DynPatMenu.ADD(tmpmenu);
                PatObjs.AddObject(ptm.Description,ptm);
               // tmpmenu.OnClick := OnPatternClick;
                // TMenuItem(Sender).Add(tmpmenu);
                Menu.Items.Add(tmpmenu);
                if Menu = pMnuTreeview then
                tmpmenu.MenuIndex := mnuPatternSeperatorTV.MenuIndex + 1
                else if Menu = pmnuListView then
                tmpmenu.MenuIndex := mnuPatternSeperatorLV.MenuIndex +1
                else
                    Raise Exception.Create('Popup Menu Provided is incorrect');
            end
            else
                ptm.Free;

        end; 
    end;
end;

procedure TMainForm.RefreshDisplay;
var
    index : Integer;
    Child : TfrmRegChild ;
begin
    for index := 0 to TabChildren.Tabs.count -1 do
    begin
        Child := TfrmRegChild(tabchildren.tabs.objects[Index]);

        if not AnsiSameCaption(Child.Caption,tabchildren.tabs[index]) then
            TabChildren.Tabs.Strings[index] := Child.Caption;

    end;

end;

procedure TMainForm.ShowSplash;
begin
    {$IFNDEF DEBUG}
    Application.CreateForm(TFrmSplash, FrmSplash);
    frmSplash.show;
    frmSplash.Timer1.enabled := true;
    {$ENDIF}
  {  if FileExists(ExtractFilePath(Application.exename) + 'Readme.txt') then
    begin
        with TfrmReadmeMsg.Create(nil) do
        begin
            memoDaveStuff.Lines.LoadFromFile(ExtractFilePath(Application.exename) + 'Readme.txt');
            ShowModal;
            Free;
        end;

    end; }

end;

{Check Functions}
function TMainForm.Check_UseAddAllKeys(Child: TfrmRegChild): Boolean;
begin
    Result := False;
    if ((Child.ChildType = rcPattern )
    or (Child.ChildType = rcSearch))
    and (Child.RegTreeView1.IsRootSelected  ) then
        Result := True;
end;





{Dynamic Menu Events}

procedure TMainForm.OnDisplayFavoriteClick(Sender: TObject);
var
    cld, favIndex : Integer;
    mnuItem : TMenuItem;
    NewChild : TfrmRegChild;
begin

    mnuItem := TMenuItem(Sender);
    {Check if we just want to Show All.}
    IF mnuitem.Tag = -1 then
    begin
        for cld := 0 to mdichildcount -1 do
        begin
            if TfrmRegChild(MDIChildren[cld]).ChildType = rcFull then
            begin
                MDIChildren[cld].Show;
                break;
            end;
        end;
    end
    else
    begin
        NewChild := GetNewChild(rcFavorite,'Favorite: ' + mnuitem.caption);
        NewChild.Show;
        { TODO -oToby : Favorites control needs to be moved away from combo. }
        favindex := FFavList.IndexOf(mnuItem.Caption);
        if favindex <> -1 then
        begin
            NewChild.LoadPattern(TRegFavoritesFile(FFavList.Objects[favindex] ));
        end;
    end;


end;

procedure TMainForm.OnPatternClick(Sender: TObject);
Var
    itemindex, iPath, DelimPos : Integer;
    pm :        TPatternTree;
    REgFav :    TRegFavoritesFile;
    Child :     TfrmRegChild;
    InternalProc : Pointer;
    ip2 : TtfmInternalPatternDisplay;
    InternalProcName : String;
    retpath : String;
    retIsFile : Boolean;
begin

    With TMenuItem(Sender) do
    begin
        { TODO -oToby -c :StringReplace probably no longer needed after getting rid of
          AutoHotkey from Popup Menu.    }
        itemindex := PatObjs.IndexOf(StringReplace((TMenuItem(Sender).caption),'&','',[] ));

        pm := TPatternTree(patobjs.Objects[itemindex]);
        pm.Execute;
        if pm.LinkType = plDisplay then
        begin
            try
                REgFav :=  MainForm.RegPatterns.Favorites.Add ;
                {Ensure REg fav isnt saved to file.}
                RegFav.SavetoFile := false;
                REgfav.RegPaths.AddStrings(pm.Matches);
                {$Message Hint 'Change code to always use final \ or not.}
                REgFav.RegPaths.insert(0,activechild.RegTreeView1.selectedNodePath.FullPath);
                {$Ifdef logging}
                    DebugForm.Log(pm.Matches[0]);
                    DebugForm.Log(activechild.RegTreeView1.selectedNodePath.FullPath);

                {$ENDIF}
                if ((activechild.ChildType = rcPattern)
                and (TFollowPatternFlag (FollowPatterns.ASInteger) = fpSameWindow))
                or ((activechild.ChildType = rcFavorite)
                and  (TFollowPatternFlag (FollowPatternFavoriteChild.ASInteger) = fpSameWindow))  then
                begin
                   for iPath := 0 to Regfav.RegPaths.Count -1 do
                   begin
                    { TODO -oToby : If I add path 0 here, which already exists in the treeview,
                      I sometimes get double keys being displayed why? }
                      Child := ActiveChild;
                       child.RegTreeView1.AddPath(RegFav.Regpaths[iPath],'\',true);
                   end;
                end
                else
                begin
                    (*if Assigned(FavoritesChild) then
                    begin
                       // clsidform.caption := RegPath;

                       { TODO -oToby -c : This doenst quite work right. }
                        if FavoritesChild.ChildType = rcpattern then
                        begin
                            if assigned(Activechild.favorites) then
                            REgFav.RegPaths.AddStrings(activechild.Favorites.RegPaths);
                        end;
                        FavoritesChild.show
                    end
                    else
                    begin
                        FavoritesChild := CreateMDIChild(pm.Description + ' ' +  Activechild.RegTreeView1.SelectedNodePath.FullPath  );
                        FavoritesChild.ChildType := rcPattern;
                    end; *)

                    Child := GetNewChild(rcPattern,pm.Description + ' ' +  Activechild.RegTreeView1.SelectedNodePath.FullPath  );

                    Child.Show;
                    Child.LoadPattern(RegFav);
                    //FavoritesChild.ChildType := rcPattern;
                    if pm.FullExpand then
                    begin
                        child.RegTreeView1.BeginUpdate;
                        Child.RegTreeView1.FullExpand;
                        child.RegTreeView1.EndUpdate;
                    end;
                end;
                Child.RegListView1.Items.Clear;
                Child.RegTreeView1.AlphaSort;
            finally
                REGFav.free;
            end;
        end
        else if pm.LinkType = plcommand then
        begin
            if FileFolderFromRegCommand(pm.matches[0],retpath,retisfile) then
            ShellExecute(Application.Handle ,pchar(''),pchar(retpath),pchar(''),pchar(pm.description),1);
        end
        else if pm.linktype = plInternal then
        begin
            delimpos := LastDelimiter(';',pm.matches[0]);
            if delimpos > 0 then
            begin
                InternalProcName := copy(pm.matches[0],1,delimpos -1);
               { InternalProc := GetProcAddress(hinstance,pchar(internalprocname));
                if assigned(internalProc) then
                begin
                    @ip2 := InternalProc ;
                    ip2(activechild,copy(pm.matches[0],delimpos+1, maxint));
                end;   }
                if AnsiCompareText(internalprocname,'DisplayIcon') = 0 then
                begin
                    DisplayIcon(activechild,copy(pm.matches[0],delimpos+1, maxint));
                end;
            end;
        end;
    end;
end;

procedure TMainForm.AddToFavoritesSubitemClick(Sender: TObject);
var
    Path:   String;
begin
    {Check if we've been asked to add entire pattern.}
    if Check_UseAddAllKeys(ActiveChild) then
    begin
        With RegPatterns do
        begin
        Favorites[TMenuItem(Sender).Tag ].RegPaths.addstrings(activeChild.RegTreeView1.pathlist);
        end;
    end
    else
    begin
        With RegPatterns do
        begin
            Path :=  activechild.RegTreeView1.getNodePath( activechild.RegTreeView1.Selected).FullPath;
            Favorites[TMenuItem(Sender).Tag ].RegPaths.add(Path );

        end;
    end;
end;


{MENU EVENTS}

procedure TMainForm.FileNew1Execute(Sender: TObject);
begin
  CreateMDIChild('REGISTRY' + IntToStr(MDIChildCount + 1));
  ActiveChild.ChildType := rcFull;
end;

procedure TMainForm.mnuHKEYCLASSESROOTClick(Sender: TObject);
VAR
    Child : TfrmRegChild;
    HK    : HKEY;
    strHK : String;
begin
    strHK := TMenuItem(Sender).Caption;
    HK := HKeyFromString(strHK);
    Child := CreateMDIChild(strHK );
    {add rcpartial to list of types}
    Child.ChildType := rcfull;
    Child.RegTreeview1.Hives.ShowAll := False;
    Child.RegTreeView1.Active := false;
    child.RegTreeView1.Hives.ShowHive[HK] := True;
    child.RegTreeView1.Active := true;

end;

procedure TMainForm.FileOpen1Execute(Sender: TObject);
begin
  if OpenDialog.Execute then
    CreateMDIChild(OpenDialog.FileName);
end;

procedure TMainForm.HelpAbout1Execute(Sender: TObject);
begin

    With TAboutBox.Create(nil) do
    begin
        try
            ShowModal;
        finally
            Free;
        end;
    end;
end;

procedure TMainForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.actNewFavoritesExecute(Sender: TObject);

var
    FavFile, FavName:    String;
    Index:      Integer;
    Done:       Boolean;
const
    newList = 'New Favorites List';
begin
    Index:= 1;
    Done := False;
    Repeat
        if not FileExists(RegPatterns.FavoritesDirectory  + newlist + Inttostr(Index) + '.trf') then
            Done := True
        else
            inc(Index);

    Until Done;


    FavName := newlist + inttostr(Index);
    if InputQuery('Please type a name for your list.', newlist, FavName ) then
    begin
        RegPatterns.Favorites.Add.FileName  := RegPatterns.FavoritesDirectory  + FavName + '.trf';
        LoadFavorites;
    end;

end;
procedure TMainForm.ComboFavorites1Change(Sender: TObject);
var
    cld : Integer;
begin
//    frmRegChild.RegTreeView1.DisplayPaths(.RegPaths );
   // CreateMDIChild('Favorite: ' + ComboFavorites.text);
    Assert(False,'This method ComboFavorites1Change should not be called.');
{    IF ComboFavorites.Text = showallfavorite then
    begin
        for cld := 0 to mdichildcount -1 do
        begin
            if TfrmRegChild(MDIChildren[cld]).ChildType = rcFull then
                MDIChildren[cld].Show;
        end;
    end
    else
    begin
        if MDIChildcount = 1 then
        begin
            CreateMDIChild('New Window');
        end;
        ActiveChild.Caption := 'Favorite: ' + ComboFavorites.text;
        ActiveChild.LoadPattern(TRegFavoritesFile( ComboFavorites.items.objects[Combofavorites.itemindex]));
    end;
    ComboFavorites.ItemIndex := -1;}

end;



procedure TMainForm.FormDestroy(Sender: TObject);
begin
    regpatterns.free;
    ClearDynamicMenuItems;
    PatObjs.Free;
    DynPatMenu.Free;
    DynFavMenu.Free;
    DynFavMainMenu.Free;
    FFavList.free;
end;

procedure TMainForm.AddToFavoritesClick(Sender: TObject);

begin

end;



procedure TMainForm.FileClose1Execute(Sender: TObject);
begin
    ActiveMDIChild.free;
end;

procedure TMainForm.MnuFavoritesRefreshClick(Sender: TObject);
begin
   LoadFavorites;

end;



procedure TMainForm.ComboChildren1Change(Sender: TObject);
begin
   // TfrmRegChild(FFavList.Objects[ComboChildren.ItemIndex]).Show;

end;


procedure TMainForm.Key1Click(Sender: TObject);
var
    reginfo : tregpath;
begin
    RegInfo := activechild.RegTreeView1.SelectedNodePath;
    ActiveChild.RegTreeView1.AddKey(Reginfo);
end;

procedure TMainForm.mnutvRenameClick(Sender: TObject);
begin
    activechild.RegTreeView1.RenameKey(activechild.RegTreeView1.SelectedNodePath);
end;

procedure TMainForm.mnutvDeleteClick(Sender: TObject);
begin
    ActiveChild.RegTreeView1.DeleteKey( ActiveChild.RegTreeView1.SelectedNodePath);
end;

procedure TMainForm.Refresh1Click(Sender: TObject);
begin
    ActiveChild.RegTreeView1.Refresh;
end;

procedure TMainForm.mnuCopyKeyNameClick(Sender: TObject);
var
    clip : tclipboard;
begin
    clip := Clipboard;

    clip.SetTextBuf(Pchar(activechild.RegTreeView1.Selected.Text));
end;

procedure TMainForm.mnuCopyKeyPathClick(Sender: TObject);

var
    clip : tclipboard;
begin
    clip := Clipboard;

    clip.SetTextBuf(Pchar(activechild.RegTreeView1.SelectedNodepath.FullPath));
end;

procedure TMainForm.Stringvalue1Click(Sender: TObject);
begin
    ActiveChild.RegTreeView1.AddValue(ActiveChild.RegTreeView1.SelectedNodePath ,
                                        'NewValue','',REG_SZ);
end;

procedure TMainForm.DWordValue1Click(Sender: TObject);
begin
    ActiveChild.RegTreeView1.AddValue(ActiveChild.RegTreeView1.SelectedNodePath ,
                                        'NewValue','0',REG_DWORD );
end;

procedure TMainForm.BinaryValue2Click(Sender: TObject);
begin
    ActiveChild.RegTreeView1.AddValue(ActiveChild.RegTreeView1.SelectedNodePath ,
                                        'NewValue','0',REG_BINARY );
end;

procedure TMainForm.MultiStringValue1Click(Sender: TObject);
begin
ActiveChild.RegTreeView1.AddValue(ActiveChild.RegTreeView1.SelectedNodePath ,
                                        'NewValue','',REG_MULTI_SZ );
end;

procedure TMainForm.ExpandStringValue1Click(Sender: TObject);
begin
ActiveChild.RegTreeView1.AddValue(ActiveChild.RegTreeView1.SelectedNodePath ,
                                        'NewValue','',REG_EXPAND_SZ  );
end;

procedure TMainForm.mnuLVRenameClick(Sender: TObject);
begin
    //ActiveChild.RegListView1.RenameValue;

    ActiveChild.RegListView1.EditValue('',true);
end;

procedure TMainForm.mnulvDeleteClick(Sender: TObject);
var
    Listitem : TListItem;
begin
    Listitem := activechild.RegListView1.Selected;
    if assigned(listitem ) then
    begin
        activechild.RegListView1.DeleteValue(listitem.caption);
    end;

end;



procedure TMainForm.mnuFindClick(Sender: TObject);
var
    RegSearch : TRegSearch;
    REgFav : TRegFavoritesFile;
    Child : TfrmRegChild;
{$IFDEF TIMING}
    timeCount, fullcount : Cardinal;
{$ENDIF}
begin

    RegSearch := TRegSearch.Create(nil);
    frmSearching := TfrmSearching.Create(nil);
    try
        try
            REgFav :=  MainForm.RegPatterns.Favorites.Add ;
            {Ensure REg fav isnt saved to file.}
            RegFav.SavetoFile := false;

            {Display Search Selection Dlg}
            frmSearchValuesDlg := TfrmSearchValuesDlg.Create(nil);
            try
                if not frmSearchValuesDlg.ShowAndReturn(RegSearch) then
                    exit;
            finally
                frmSearchValuesDlg.Free;
            end;

            {Display Animated Search form to show user time passing.}
            RegSearch.OnKeyFound := SearchKeyFound;
            frmSearching.SearchObject := RegSearch;
            frmSearching.Show;

            {if Assigned(SearchDisplayform) then
            begin
               // clsidform.caption := RegPath;
                SearchDisplayform.Caption := 'Search Results - ' + rf.SearchValue;
                SearchDisplayform.show
            end
            else
            begin

                SearchDisplayform := CreateMDIChild('Search Results - ' + rf.SearchValue );
                SearchDisplayform.ChildType := rcSearch;
            end; }

            Child := GetNewChild(rcSearch,'Search Results - ' + RegSearch.SearchValue);
            Child.RegTreeView1.clear;
            {Found items will be added by use of the ONKeyFound Event.}
            {$IFDEF TIMING}
            timecount := GetTickCount;
            {$ENDIF}


            RegSearch.GetAll(RegFav.Regpaths);


            {$IFDEF TIMING}
            fullcount := GetTickCount - timecount;
            {$IFNDEF NoSearchCaption}
                ShowMessage('Time Took ' + inttostr(fullcount) + ' - No Caption');
            {$ELSE}
                ShowMessage('Time Took ' + inttostr(fullcount) + ' - With Caption');
            {$ENDIF}
            {$ENDIF}
        finally
            REGFav.free;
        end;

    finally
      RegSearch.free;
      frmSearching.Free;
    end;

end;

procedure TMainForm.SearchKeyFound(Sender: TObject; Path: String);
var
    RP : TRegPath;
begin
    rp := GetRegSections(path);

    fSearchDisplayChild.RegTreeView1.AddPath(Path,'\',False);

end;

procedure TMainForm.ExpandFully1Click(Sender: TObject);
begin

    if assigned (ActiveChild.RegTreeView1.Selected) then
    begin
        with ActiveChild.RegTreeView1 do
        begin
            beginupdate;
            Selected.Expand(true);
            endUpdate;
        end;
    end;

end;

procedure TMainForm.pmnuListViewPopup(Sender: TObject);
var
    Sel : TListItem;
    isSelected : Boolean;
    AllowRename : Boolean;
begin
    Sel := ActiveChild.RegListView1.Selected;
    {if isSelected then
        showmessage('hi');}
    if assigned(Sel) then
    begin
        isSelected := True;
        if AnsiCompareText(Sel.Caption,constDefaultValueName) = 0 then
        begin
            AllowRename := False;
        end
        else
            AllowRename := true;
    end
    else
    begin
        isSelected := False;

    end;


    mnuLVRename.Enabled := (isSelected and AllowRename);
    mnulvDelete.Enabled := isSelected;
    mnulvNew.Enabled := not(ActiveChild.RegTreeView1.NodeAccess(activechild.RegTreeView1.Selected) = nareadonly);
    if mnulvNew.enabled then
    begin
        if (activechild.RegTreeView1.IsRootSelected)
        or (not assigned(activechild.regtreeview1.Selected)) then
            mnulvnew.Enabled := False
        else
            mnulvNew.Enabled := True;
    end;
    GetMatchingPatternMenuItems(TPopupMenu(Sender));
end;

procedure TMainForm.ExportKey1Click(Sender: TObject);
var

    Index : Integer;
    MnuItem : TMenuItem;
    RExp : TbaseRegExport;
begin
{Code to create export stuff, removed until happy that export is correct.}



    if SaveDialog.Execute then
    begin
        MnuItem := (Sender as TMenuItem);

        if MnuItem.caption = '&Cancel Export' then
        begin
            RExp.Cancel;
            MnuItem.Caption := '&Export Key';
            exit;
        end
        else
            MnuItem.Caption := '&Cancel Export';


        ReXp := TBaseRegExport.Create;
        try
            sCREEN.Cursor := crHourGlass;

            RExp.OnFinished := ExportFinished;
            rexp.OnCancelled := ExportCancelled; 

            rexp.Filename := SaveDialog.FileName ;
            rexp.ExportSubKeys := true;
            if activechild.RegTreeView1.IsRootSelected then
            begin
               With RExp do
               begin
                   ExportKeys.Add('HKEY_CLASSES_ROOT');
                   ExportKeys.Add('HKEY_CURRENT_USER');
                   ExportKeys.Add('HKEY_LOCAL_MACHINE');                                      
               end;
            end
            else
            begin
                RExp.ExportKeys.add(activechild.RegTreeView1.getnodepath(activechild.RegTreeView1.selected).FullPath  );
            end;
            IF NOT rexp.ExportReg THEN
            BEGIN
                tfmMsgDialog1.Message := rexp.InvalidMessage;
                tfmMsgDialog1.Title := 'INVALID TYPES FOUND';
                tfmMsgDialog1.Execute;
//                MESSAGEdlg(rexp.InvalidMessage.Text ,mtwarning,[mbOK],0);
            END;
        finally
            MnuItem.Caption := '&Export Key';
            rexp.Free;
            SCREEN.Cursor := crDefault;
        end;
    end;
end;

procedure TMainForm.TabChildrenChange(Sender: TObject);
begin
    {Display correct child associated with tab.}
    TfrmRegChild(TabChildren.tabs.objects[TabChildren.tabindex]).Show;
end;


procedure TMainForm.pMnuTreeviewPopup(Sender: TObject);
var
    RootSelected : Boolean;
    HKEYSelected : Boolean;
    ItemSelected : Boolean;
    pMnu         : TPopupMenu;
    Index        : Integer;
    ImgTypeIndex : Integer;
begin


    ItemSelected := True ;
    HKEYSelected := False;
    ImgTypeIndex := -1;
    if not(assigned(ActiveChild.RegTreeView1.Selected)) then
        ItemSelected := False;

    pMnu := (Sender as TPopupMenu);
    if not(pmnu.PopupComponent.Owner = Activechild) then
        TForm(pmnu.PopupComponent.Owner ).BringToFront;
    for index := 0 to pmnu.Items.Count -1 do
    begin
        pmnu.Items[index].enabled := itemselected;
    end;

    RootSelected := ActiveChild.RegTreeView1.IsRootSelected;

    if not(RootSelected ) then
        if assigned(ActiveChild.RegTreeView1.Selected) then
        if ActiveChild.RegTreeView1.Selected.Parent = ActiveChild.RegTreeView1.RootNode then
            HKEYSelected := True;

    mnuAddtoFavorite.Visible := True;

    {If user is rightclicking on My Computer and it is a pattern change caption of
    addtofavorite.}
    if Check_UseAddAllKeys(ActiveChild) then
    begin
        mnuAddtoFavorite.Caption := MNUCAPTION_ADDALLTOFAV;
    end
    else
    begin
        if RootSelected then
            mnuAddtoFavorite.Visible := False;
        mnuAddtoFavorite.Caption := MNUCAPTION_ADDKEYTOFAV;
    end;

    if ItemSelected then
        ImgTypeIndex := activechild.RegTreeView1.NodeImageIndex(ActiveChild.RegTreeView1.Selected);

    mnuShowAllChildren.Visible := not RootSelected;
    mnuCopyKeyName.Visible := not RootSelected;
    mnuCopyKeyPath.Visible := not RootSelected;

    if (ActiveChild.ChildType = rcFavorite )
    or (ActiveChild.ChildType = rcPattern) then
    begin
       mnuExpandAllinFavorite.Visible := true;
    end
    else
        mnuExpandAllinFavorite.Visible := false;


    if (ActiveChild.RegTreeView1.NodeAccess(activechild.RegTreeView1.Selected) = nareadonly) then
    begin
        mnutvNew.Enabled := false;
        mnutvrename.enabled := false;
        mnutvDelete.Enabled := false;
    end
    else
    begin
        mnutvNew.Visible := not (rootselected  or (ImgTypeIndex = ICON_NOACCESS));
        mnutvRename.Visible := not (rootselected or HKEYSelected or (ImgTypeIndex = ICON_NOACCESS) );
        mnutvDelete.Visible := not (rootselected or HKEYSelected or (ImgTypeIndex = ICON_NOACCESS));
    end;

    GetMatchingPatternMenuItems(TPopupMenu(Sender));
end;





{This function is used both for the back button and the forward button.}
procedure TMainForm.tbtnBackClick(Sender: TObject);
var
    IndexOffset : Integer;
    NewIndex : Integer;
begin


    if Sender = tbtnBack then
        IndexOffset := -1
    else if Sender = tbtnForward then
        IndexOffset := 1;

    NewIndex := TabChildren.TabIndex + IndexOffset;
    if (NewIndex < 0) or (NewIndex > TabChildren.Tabs.Count -1) then
        NewIndex := TabChildren.TabIndex;
    TfrmRegChild(TabChildren.Tabs.Objects[NewIndex]).show;
end;







procedure TMainForm.mnuOptionsClick(Sender: TObject);
begin

    With TfrmOptionsDlg.Create(nil) do
    begin
        Showmodal;
        Free;
    end;
end;

procedure TMainForm.Help2Click(Sender: TObject);
begin
  // Application.CurrentHelpFile := extractfilepath(application.exename) + 'tfmreghlp.chm';
  //  ShellExecute(Application.Handle ,pchar(''),pchar(application.CurrentHelpFile  ),pchar(''),pchar(''),1);
  Application.HelpContext(10);
end;

procedure TMainForm.Loaded;
begin
    inherited;

end;

procedure TMainForm.CreateStartupChild;
var
    UseHives : Boolean;
begin
    try
        UseHives :=    StartupWithHives.asboolean;
        if UseHives then
        begin
            mnuHKEYCLASSESROOT.Click;
            mnuHKEYCURRENTUSER.Click;
            mnuHKEYLOCALMACHINE.Click;
            mnuHKEYUSERS.Click;
            mnuHKEYCURRENTCONFIG.Click;
        end
        else
          MainForm.CreateMDIChild('Registry');
    except
        On e: ENoOptionItem do
            MainForm.CreateMDIChild('Registry')
        else
            Raise;
    end;
    MDIChildren[mdichildcount-1].Show;
    TabChildren.TabIndex := 0;

end;

procedure TMainForm.mnuShowAllChildrenClick(Sender: TObject);
begin
    ActiveChild.RegTreeView1.ShowAllChildren(ActiveChild.RegTreeView1.Selected);
end;

procedure TMainForm.Font1Click(Sender: TObject);
var
    cld : Integer;
    Reg : TExtRegistry;
begin
    if FontDialog1.Execute then
    begin
        MainForm.font.Assign(fontdialog1.font);
        for cld := 0 to MDIChildCount -1 do
        begin
            MDIChildren[cld].font.assign(Mainform.font);
        end;

    end;
end;

procedure TMainForm.ShowPanel1Click(Sender: TObject);
begin
    activechild.pnlShowInfo.Visible := true;
   // DisplayIcon(activechild,'');
end;

procedure TMainForm.ExportCancelled(Sender: TObject);
begin
    {Replace with DontShowDlg}
    Showmessage('Export Cancelled by User');
end;

procedure TMainForm.ExportFinished(Sender: TObject);
begin
    { TODO : Replace with DontShowDlg }
    Showmessage('Export Finshed');
end;

procedure TMainForm.Refresh2Click(Sender: TObject);
begin
    activeChild.RegTreeView1.RefreshRegistry;
end;

procedure TMainForm.FavoritesManager1Click(Sender: TObject);
begin
    with TfrmFavsManager.Create(nil) do
    begin
        ShowandReturn(RegPatterns);
        Free;
        LoadFavorites;
    end;
end;

procedure TMainForm.Security1Click(Sender: TObject);
var
    regpath : TRegPath;
    reg : TExtRegistry;
//    ntsec :  TNTRegistryObject;
  //  acl : TAccessControlList;
begin
  {  regpath := activechild.RegTreeView1.SelectedNodePath ;
    reg := TExtRegistry.Create;
    reg.RootKey := regpath.RegHKey;
    reg.OpenKey(regpath.RegSection );

    ntsec.Create(reg.CurrentKey );

    ntsec.GetDiscretionaryAccessList(acl);

    acl.Element[i].Name; }


end;

procedure TMainForm.REGKEYChange(Sender: TObject;
  Node: TTreeNode);
begin
    if assigned(Node) then
    StatusBar.SimpleText := Activechild.RegTreeView1.GetNodePath(node).FullPath ;
end;





procedure TMainForm.GetFileFolders;
var
    tmpFolder : String;
    C: Array[0..Max_path] of Char;
begin
    if optFavoritesFolderPath.ASString = '' then
    begin
        if (Win32Platform > 1) and (Win32MajorVersion > 4) then
        begin
            {Win NT and above}
            tmpFolder := Util_ExpandEnvironmentString('%USERPROFILE%');

            if tmpFolder <> '' then
                optFavoritesFolderPath.ASString := tmpfolder + W2KSubFolders + FAVORITES_SUBDIR + '\'
            else
            begin
                tmpFolder := Util_ExpandEnvironmentString('%USERPROFILE%');
            end;

            if tmpFolder <> '' then
                optFavoritesFolderPath.ASString := tmpfolder + W2KSubFolders + FAVORITES_SUBDIR + '\' 
            else
                optFavoritesFolderPath.ASString := GetAppPath  + FAVORITES_SUBDIR + '\';

        end
        else
        begin
            {Win 9.x}
            optFavoritesFolderPath.ASString := GetAppPath  + FAVORITES_SUBDIR + '\';


        end;

    end;
    //showmessage(optFavoritesFolderPath.ASString);
end;

procedure TMainForm.mnuExpandAllinFavoriteClick(Sender: TObject);
begin
    ActiveChild.RegTreeView1.FullExpand;
end;

procedure TMainForm.Registration1Click(Sender: TObject);
begin
    Application.HelpContext(15);
end;

end.


