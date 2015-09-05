{******************************************************************************}
{*  TFMREG - Programmers registry editor.                                     *}
{*  Copyright Toby Allen - Toflidium Software 2001                            *}
{*                                                                            *}
{******************************************************************************}
{*                                                                            *}
{* 26/02/02 Toby                                                              *}
{* 1. Added code to check and uncheck Add Exepath to Path when dlg shown.     *}
{*                                                                            *}
{******************************************************************************}
unit OptionsDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Registry, tfmOptionCntrls;

 // HH_funcs, hh;

type
  TfrmOptionsDlg = class(TForm)
    PageControl1:   TPageControl;
    TabSheet1:      TTabSheet;
    GroupBox1:      TGroupBox;
    btnOK:          TButton;
    TabSheet2:      TTabSheet;
    Label1:         TLabel;
    Button1:        TButton;
    ckbxGlobalPath: TCheckBox;
    gbStartup:          TGroupBox;
    TabSheet3: TTabSheet;
    tfmOptionCheckBox1: TtfmOptionCheckBox;
    tfmOptionCheckBox2: TtfmOptionCheckBox;
    ckbxStartwithHives: TtfmOptionCheckBox;
    tfmOptionCheckBox3: TtfmOptionCheckBox;
    tfmOptionCheckBox4: TtfmOptionCheckBox;
    btnApply:   TButton;
    btnCancel:  TButton;
    TabSheet4: TTabSheet;
    GroupBox2: TGroupBox;
    tfmOptionCheckBox5: TtfmOptionCheckBox;
    procedure PageControl1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    procedure   BroadcastChange;
    function    GetPathValue: String;
    procedure   SetPathValue(Path: String);
    function    ExeOnPath: Integer;
    { Private declarations }
  public
    { Public declarations }
    chmfile : String;
  end;

var
  frmOptionsDlg: TfrmOptionsDlg;
//     mHHelp: THookHelpSystem;
const
    ENVIRONMENT_RegSection = '\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\';
    PATH_ValueName  = 'Path';
    GLOBAL_ENVIRONMENT_STRING = 'Environment';
implementation
uses Main;
{$R *.DFM}

procedure TfrmOptionsDlg.PageControl1Change(Sender: TObject);
begin
    if PageControl1.ActivePage = PageControl1.Pages[0] then
            mainform.Options.PublishtoComponents;
end;

function TfrmOptionsDlg.GetPathValue: String;
var
    Reg : TRegistry;
    NotFound : Boolean;
begin

    NotFound := True;
    {Open registry key and return ValueData}
    Reg := TRegistry.Create;
    try
        Reg.rootkey :=  HKEY_LOCAL_MACHINE ;
        if Reg.OpenKey(ENVIRONMENT_RegSection ,False) then
        begin
            if Reg.ValueExists(PATH_ValueName) then
            begin
                Result :=  Reg.ReadString(PATH_ValueName);
                NotFound := False;
            end;
            Reg.CloseKey;
        end;
        if NotFound then
        begin
           { ShowMessage('The Key'
                        +  ENVIRONMENT_RegSection + ' - '
                        + PATH_ValueName
                        + ', Could not be found in the registry.'); }

            Result := '';
            exit;
        end;


    finally
        Reg.CloseKey;
        Reg.Free;
    end;

end;

procedure TfrmOptionsDlg.SetPathValue(Path: String);
var
    Reg     : TRegistry;
    NotFound: Boolean;
begin
    if Path = '' then Raise Exception.Create('Cannot set Path to a blank String');
    NotFound := True;
    Reg := TRegistry.Create;
    try
        Reg.rootkey :=  HKEY_LOCAL_MACHINE ;
        if Reg.OpenKey(ENVIRONMENT_RegSection ,False) then
        begin
            if Reg.ValueExists(PATH_ValueName) then
            begin
                Reg.WriteString(PATH_ValueName ,Path);
                NotFound := False;
            end;

            Reg.CloseKey;
        end;

        if NotFound then
        begin
            ShowMessage('The Key'
                        +  ENVIRONMENT_RegSection + ' - '
                        + PATH_ValueName
                        + ', Could not be found in the registry.');
            exit;
        end;

    finally

        Reg.CloseKey;
        Reg.Free;
    end;
    {Broadcast the necessary message.}
    BroadcastChange;

end;


procedure TfrmOptionsDlg.BroadcastChange;
var
    lParam, wParam : Integer;   {Integers that indicate pointers to parameters}
    Buf     : Array[0..10] of Char; {Buffer used to indicate what setting we have changed.}
    aResult : Cardinal;         {Error Number returned from API Call}
begin
    {Now comes the interesting part.}
    {Environment is the section of global settings we want the system to update}
     Buf := GLOBAL_ENVIRONMENT_STRING;
     wParam := 0;
     {This gives us a pointer to the Buffer for Windows to read.}
     lParam := Integer(@Buf[0]);

     {Here we make a call to SendMessageTimeout to Broadcast a message to the
     entire system telling every application (including explorer) to update
     its settings.
     See associated article for explanation of parameters.}
     SendMessageTimeout(HWND_BROADCAST ,
                        WM_SETTINGCHANGE ,
                        wParam,
                        lParam,
                        SMTO_NORMAL	,
                        4000,
                        aResult);

     {Display windows lasterror if the result is an error.}
     if aResult <> 0 then
     begin
         SysErrorMessage(aResult);
     end;
end;

procedure TfrmOptionsDlg.Button1Click(Sender: TObject);
var
    Path, AppPath : String;
    sPos : Integer;
begin
    Path := GetPathValue;
    AppPath := ExtractFilePath(Application.ExeName);
    if ckbxGlobalPath.Checked then
    begin
        Path := Path + ';' + AppPath;

    end
    else
    begin
        sPos := ExeOnPath;
        if spos > 0 then
        begin
            delete(Path,spos,length(AppPath));

        end;
    end;
    SetPathValue(Path);
end;

procedure TfrmOptionsDlg.FormCreate(Sender: TObject);
begin
    if ExeOnPath > -1 then
        ckbxGlobalPath.Checked := True;

    PageControl1.ActivePageIndex := 0;
   {     chmfile := Application.CurrentHelpFile;
mHHelp := THookHelpSystem.Create(CHMfile, '', htHHAPI); }
end;

function TfrmOptionsDlg.ExeOnPath: Integer;
var
    Path, AppPath : String;
    sPos : Integer;
begin
    Result := -1;
    Path := GetPathValue;
    if Path = '' then
    begin
        ckbxGlobalPath.Enabled := False;
        Button1.Enabled := False;
        Exit;
    end;
    AppPath := ExtractFilePath(Application.ExeName);
    AppPath := IncludeTrailingBackslash( LowerCase(AppPath));
    Path := LowerCase(Path);
    sPos := AnsiPos(';' + AppPath,Path);
    if spos > 0 then
        Result := spos
    else
    begin
       AppPath := ExcludeTrailingBackslash(AppPath);
        sPos := AnsiPos(';' + AppPath,Path);
        if spos > 0 then
            Result := spos;
    end;
end;

procedure TfrmOptionsDlg.Button2Click(Sender: TObject);
var
    chmfile : String;
begin
(*// 1. Use the unit and declare a global
     USES HH, HH_FUNCS;
     var mHHelp: THookHelpSystem;

     // 2. Create the Object in main form create.
     procedure TMainForm.FormCreate(Sender: TObject);
     begin
       mHHelp := THookHelpSystem.Create(pathToCHM, '', htHHAPI);
       ...

     // 3. Free the object in main form destroy
     procedure TMainForm.FormDestroy(Sender: TObject);
     begin
       //Unhook and free
       mHHelp.Free;
       HHCloseAll;     //Close help before shutdown or big trouble
       ...  *)


end;

procedure TfrmOptionsDlg.FormDestroy(Sender: TObject);
begin
    {   mHHelp.Free;
       HHCloseAll;}
end;

procedure TfrmOptionsDlg.btnOKClick(Sender: TObject);
begin
    MainForm.Options.PullFromComponents;
end;

end.
