unit uWorkerList;

interface

uses
  uWorker.Intf;

procedure RegisterWorker(const Worker: IWorker);
function WorkerList: IEnumerable<IWorker>;

implementation

uses
  System.Generics.Collections, System.SysUtils, uEnumerableList ;

var
  _WorkerList: TList<IWorker>;

function WorkerList: IEnumerable<IWorker>;
begin
  Result := TEnumerableList<IWorker>.Create(_WorkerList);
end;

procedure RegisterWorker(const Worker: IWorker);
begin
  _WorkerList.Add(Worker);
end;

initialization
  _WorkerList := TList<IWorker>.Create;

finalization
  FreeAndNil(_WorkerList);

end.
