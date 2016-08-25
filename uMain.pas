unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uWorkersManager;

type
  TMainForm = class(TForm)
    mmOutput: TMemo;
    pnControl: TPanel;
    btnStart: TButton;
    rgWorkers: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
  strict private
    FWorkersManager: TWorkersManager;
    procedure Init;
  public

  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uMemoWriter;

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  mmOutput.Lines.Clear;
  FWorkersManager.StartWork(rgWorkers.ItemIndex, TMemoWriter.Create(mmOutput));
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Init;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FWorkersManager);
end;

procedure TMainForm.Init;
var
  WorkerName: string;
begin
  FWorkersManager := TWorkersManager.Create;
  for WorkerName in FWorkersManager.WorkersNameList do
    rgWorkers.Items.Add(WorkerName);
  rgWorkers.Height := rgWorkers.Items.Count * 16 + 25;
end;

end.
