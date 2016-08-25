unit uWorkersManager;

interface

uses
  System.Generics.Collections, uWorker.Intf;

type
  TWorkersManager = class
  strict private
    FWorkersList: TList<IWorker>;
    FReader: IReader;
    function GetWorkersNameList: TArray<string>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure StartWork(const AWorkerIndex: Integer; const Writer: IWriter);
    property WorkersNameList: TArray<string> read GetWorkersNameList;
  end;

implementation

uses
  System.SysUtils, uTextFileReader, uAdditionalClasses, uWorkerList;

{ TWorkersManager }

constructor TWorkersManager.Create;
var
  Worker: IWorker;
begin
  FReader := TTextFileReader.Create;
  FWorkersList := TList<IWorker>.Create;
  for Worker in WorkerList do
    FWorkersList.Add(Worker);
end;

destructor TWorkersManager.Destroy;
begin
  FreeAndNil(FWorkersList);
end;

function TWorkersManager.GetWorkersNameList: TArray<string>;
var
  Worker: IWorker;
  Lst: TArray<string>;
  Index: Integer;
begin
  SetLength(Lst, FWorkersList.Count);
  Index := 0;
  for Worker in FWorkersList do
  begin
    Lst[Index] := Worker.Name;
    Inc(Index);
  end;
  Result := Lst;
end;

procedure TWorkersManager.StartWork(const AWorkerIndex: Integer; const Writer: IWriter);
begin
  if FWorkersList.Count <= AWorkerIndex then
    raise EWorkerNotExist.Create;
  FWorkersList[AWorkerIndex].DoWork(FReader, Writer);
end;

end.
