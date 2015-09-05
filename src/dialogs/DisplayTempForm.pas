unit DisplayTempForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TtmpDisplayForm = class(TForm)
    Memo12: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  tmpDisplayForm: TtmpDisplayForm;

implementation

{$R *.dfm}

procedure TtmpDisplayForm.Button1Click(Sender: TObject);
begin
    Release;
end;

end.
