unit MemTestForm;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.SyncObjs,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    RunTest: TButton;
    NumThreads: TEdit;
    ResultsMemo: TMemo;
    Label1: TLabel;
    UseLocks: TCheckBox;
    procedure RunTestClick(Sender: TObject);
  private
    FLock: TCriticalSection;
  end;

  TWorkThread = class(TThread)
  public
    CommonLock: TCriticalSection;
    WorkTime: TDateTime;
    OuterLoopRunCount: Integer;
    procedure Execute; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.RunTestClick(Sender: TObject);
var Threads: array of TWorkThread;
    a,RCount,ThCount: Integer;
    WorkTime: TDateTime;
    Msg: String;
begin
  for a:=0 to ControlCount-1 do
    Controls[a].Enabled:=False;
  try
    ThCount:=StrToIntDef(NumThreads.Text,1);
    if UseLocks.Checked then FLock:=TCriticalSection.Create;

    Msg:=Format('Running with %d threads',[ThCount]);
    if UseLocks.Checked then Msg:=Msg+' '+'with locks';
    ResultsMemo.Lines.Add(Msg);

    //Create and start threads
    SetLength(Threads,ThCount);
    for a:=0 to High(Threads) do begin
      Threads[a]:=TWorkThread.Create(True);
      Threads[a].OuterLoopRunCount:=3000 div ThCount;
      Threads[a].CommonLock:=FLock;
      Threads[a].Start;
    end;

    //Wait for all the threads to finish
    repeat
      RCount:=0; WorkTime:=0;
      for a:=0 to High(Threads) do begin
        WorkTime:=WorkTime+Threads[a].WorkTime;
        if not Threads[a].Terminated then inc(RCount);
      end;
      Application.ProcessMessages;
    until RCount=0;

    for a:=0 to High(Threads) do
      Threads[a].Free;

    ResultsMemo.Lines.Add('Mean time per thread: '+FormatDateTime('nn.ss.zzz',WorkTime/Length(Threads)));
  finally
    FreeAndNil(FLock);
    for a:=0 to ControlCount-1 do
      Controls[a].Enabled:=True;
  end;
end;

{ TWorkThread }

procedure TWorkThread.Execute;
//  The test thread is just supposed to do a lot of work that stresses the memory manager.
var a,b: Integer;
    c: String;
    s: TStringList;
    o: TPersistent;
    t: TDateTime;

begin
  inherited;
  t:=Now;
  for a:=1 to OuterLoopRunCount do begin
    s:=TStringList.Create;
    c:=StringOfChar(#0,a*20);
    for b:=1 to 10000 do begin
      if CommonLock<>nil then CommonLock.Acquire;
      try
        o:=TPersistent.Create;
        s.Add(IntToStr(a)+'.'+IntToStr(b)+' - '+IntToStr(Length(c)));
        o.Free;
      finally
        if CommonLock<>nil then CommonLock.Release;
      end;
    end;
    s.Free;
  end;
  WorkTime:=Now-t;
  Terminate;
end;

end.
