unit uFIB;

interface

uses
  uWorker.Intf;

type
  TFIB_Worker = class(TInterfacedObject, IWorker)
  strict private
    function GetName: string;
    function GetFibNumber(const ANumber, AK: Int64): Int64;
  public
    procedure DoWork(Reader: IReader; Writer: IWriter);
    property Name: string read GetName;
  end;

implementation

uses
  System.SysUtils, uWorkerList;

{ TFIB_Worker }

procedure TFIB_Worker.DoWork(Reader: IReader; Writer: IWriter);
var
  InitStr: string;
  InitValues: TArray<string>;
  Number, K: Int64;
begin
  InitStr := Trim(Reader.ReadAll);
  InitValues := InitStr.Split([' ']);
  Number := StrToInt(InitValues[0]);
  K := StrToInt(InitValues[1]);
  Writer.WriteAll(Format('%d', [GetFibNumber(Number, K)]));
end;

function TFIB_Worker.GetFibNumber(const ANumber, AK: Int64): Int64;
var
  F_N, F_N_1, I, Temp: Int64;
begin
  I := 2;
  F_N := 1;
  F_N_1 := 1;
  while ANumber > I do
  begin
    Temp := F_N_1;
    F_N_1 := F_N;
    F_N := F_N_1 + Temp * AK;
    Inc(I);
  end;
  Result := F_N;
end;

function TFIB_Worker.GetName: string;
begin
  Result := 'FIB';
end;

initialization
  RegisterWorker(TFIB_Worker.Create);

end.
