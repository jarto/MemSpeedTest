program MemSpeedTest;

uses
  //FastMM4,
  //tcmalloc,
  //BrainMM,
  //ScaleMM2,
  Vcl.Forms,
  MemTestForm in 'MemTestForm.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
