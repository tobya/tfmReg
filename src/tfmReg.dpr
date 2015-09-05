{******************************************************************************}
{*  TFMREG - Programmers registry editor.                                     *}
{*  Copyright Toby Allen - Toflidium Software 2001                            *}
{*                                                                            *}
{******************************************************************************}
{*                                                                            *}
{*                                                                            *}
{******************************************************************************}

program tfmReg;

uses
  //ExceptionLog,
  Forms,
  SysUtils,
  Main in 'MAIN.PAS' {MainForm},
  About in 'about.pas' {AboutBox},
  MainChild in 'MainChild.pas' {frmRegChild},
  tfmpattclass2 in 'patttest\tfmpattclass2.pas',
  SearchingDlg in 'dialogs\SearchingDlg.pas' {frmSearching},
  UtilityFunctions in '..\Components\common\UtilityFunctions.pas',
  SearchValuesDialog in 'dialogs\SearchValuesDialog.pas' {frmSearchValuesDlg},
  RegExport in 'classes\RegExport.pas',
  SplashForm in 'SplashForm.pas' {frmSplash},
  OptionsDlg in 'dialogs\OptionsDlg.pas' {frmOptionsDlg},
  FavoritesCollection in 'templatefiles\FavoritesCollection.pas',
  FavManagerDlg in 'dialogs\FavManagerDlg.pas' {frmFavsManager},
  DEBUGDLG in 'dialogs\DEBUGDLG.pas' {DebugForm},
  tfmRegClasses in 'tfmRegClasses.pas';

{$R *.RES}
    {Support Files}
    {Packages}
    (*
    Compile in this order.
    tfmCommon.bpl
    RegComponents.bpl
    tfmRegComponents.bpl
    *)
    {c:\development\Registry Tool\todo.xls}
begin
  Application.Initialize;
  Application.Title := 'TFMReg';
  Application.HelpFile :='tfmreghelp.hlp';
  Application.CreateForm(TMainForm, MainForm);
  MainForm.CreateStartupChild ;
  {$IFDEF TRIAL}
  MainForm.ShowSplash;
  {$ENDIF}
  Application.Run;
end.
