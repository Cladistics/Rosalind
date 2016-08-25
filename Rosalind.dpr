program Rosalind;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {MainForm},
  uWorker.Intf in 'WorkerList\uWorker.Intf.pas',
  uWorkerList in 'WorkerList\uWorkerList.pas',
  uWorkersManager in 'uWorkersManager.pas',
  uTextFileReader in 'uTextFileReader.pas',
  uMemoWriter in 'uMemoWriter.pas',
  uAdditionalClasses in 'uAdditionalClasses.pas',
  uDNA in 'WorkerList\Workers\uDNA.pas',
  uRNA in 'WorkerList\Workers\uRNA.pas',
  uREVC in 'WorkerList\Workers\uREVC.pas',
  uFIB in 'WorkerList\Workers\uFIB.pas',
  uGC in 'WorkerList\Workers\uGC.pas',
  uHAMM in 'WorkerList\Workers\uHAMM.pas',
  uSUBS in 'WorkerList\Workers\uSUBS.pas',
  uEnumerableList in 'WorkerList\uEnumerableList.pas';

{$R *.res}

begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
