unit uHAMM;

interface

uses
  uWorker.Intf;

type
  THAMM_Worker = class(TInterfacedObject, IWorker)
  strict private
    function GetName: string;
  public
    procedure DoWork(Reader: IReader; Writer: IWriter);
    property Name: string read GetName;
  end;

implementation

uses
  System.SysUtils, uWorkerList;

{ THAMM_Worker }

procedure THAMM_Worker.DoWork(Reader: IReader; Writer: IWriter);
var
  I, HammDistance: Integer;
  DNA_data: TArray<string>;
begin
  DNA_data := Reader.ReadStrings;
  HammDistance := 0;
  for I := Low(DNA_data[0]) to High(DNA_data[0]) do
    if DNA_data[0][I] <> DNA_data[1][I] then
      Inc(HammDistance);
  Writer.WriteAll(Format('%d', [HammDistance]));
end;

function THAMM_Worker.GetName: string;
begin
  Result := 'HAMM';
end;

initialization
  RegisterWorker(THAMM_Worker.Create);

end.
