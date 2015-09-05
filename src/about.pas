unit About;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,  jpeg, sysutils, tfmURLLabel;

type
  TAboutBox = class(TForm)
    Panel1:         TPanel;
    OKButton:       TButton;
    ProgramIcon:    TImage;
    ProductName:    TLabel;
    lVersionLabel:  TLabel;
    Copyright:      TLabel;
    Comments:       TLabel;
    lVersion:       TLabel;
    //VersionInfo1:   TVersionInfo;
    lVerInfo:       TLabel;
    Memo3rdParty:   TMemo;
    Label1:         TLabel;
    Label2:         TLabel;
    Panel2:         TPanel;
    Label3:         TLabel;
    Memo1:          TMemo;
    tfmURLLabel1:   TtfmURLLabel;
    Label4:         TLabel;
    procedure FormCreate(   Sender: TObject);
    procedure FormKeyDown(  Sender: TObject; var Key: Word;
                            Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    EEString : String;
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.DFM}

procedure TAboutBox.FormCreate(Sender: TObject);
begin
   (* With VersionInfo1 do
    begin
        FileName := Application.ExeName;
       // lVersionLabel.Caption := FileVersion;
       // lVerInfo.Caption := FileDescription ;

    end;   *)
    {$IFNDEF TRIAL}
            Comments.Caption := 'Registered';
    {$ENDIF}
end;

procedure TAboutBox.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if ssCtrl in shift then
    begin
        if AnsiCompareText( EEString, 'p') = 0 then
        begin
            width := 571;
        end;
        if (EEString = '' ) and (Key = Ord('P')) then
            EEString := 'P';

    end;
end;

end.
 
