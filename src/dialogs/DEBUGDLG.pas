unit DEBUGDLG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TDebugForm = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Log(Msg : String);
  end;

var
  DebugForm: TDebugForm;

implementation

{$R *.dfm}

{ TDebugForm }

procedure TDebugForm.Log(Msg: String);
begin
    Memo1.Lines.Add(msg);
end;

end.
