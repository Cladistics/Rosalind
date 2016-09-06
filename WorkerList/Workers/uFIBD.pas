unit uFIBD;

interface

uses
  uWorker.Intf;

type
  TFIBD_Worker = class(TInterfacedObject, IWorker)
  strict private
    function GetName: string;
    function InternalCalc(const ANumber, ALifeLength: Integer): Int64;
    function ParseAndCalc(const aInput: string): string;
  public
    procedure DoWork(Reader: IReader; Writer: IWriter);
    property Name: string read GetName;
  end;

implementation

uses
  System.Generics.Collections, System.SysUtils, System.StrUtils, System.Variants,
  uWorkerList;

{ TFIBD_Worker }

procedure TFIBD_Worker.DoWork(Reader: IReader; Writer: IWriter);
begin
  Writer.WriteAll(ParseAndCalc(Reader.ReadAll));
end;

function TFIBD_Worker.GetName: string;
begin
  Result := 'FIBD';
end;

function TFIBD_Worker.InternalCalc(const ANumber, ALifeLength: Integer): Int64;
var
  NewBorns: TQueue<Int64>;
  Index, Cycle: Integer;
  Sum, LastNumber, CurrentNumber: Int64;
begin
  // FIBD(N) = NewBorns(N) + NewBorns(N-1) + .. + NewBorns(N-P+1)
  // NewBorns(N) = NewBorns(N-2) + NewBorns(N-3) + .. + NewBorns(N-P-1)
  NewBorns := TQueue<Int64>.Create;
  try
    // Init Queue with (0, 0, 1)
    for Index := 1 to ALifeLength-1 do
      NewBorns.Enqueue(0);
    NewBorns.Enqueue(1);
    for Cycle := 1 to ANumber-1 do
    begin
      Sum := 0;
      LastNumber := 0;
      for CurrentNumber in NewBorns do
      begin
        LastNumber := CurrentNumber;
        Sum := Sum + CurrentNumber;
      end;
      Sum := Sum - LastNumber;
      NewBorns.Enqueue(Sum);
      NewBorns.Dequeue;
    end;
    Sum := 0;
    for CurrentNumber in NewBorns do
      Sum := Sum + CurrentNumber;
    Result := Sum;
  finally
    FreeAndNil(NewBorns);
  end;
end;

function TFIBD_Worker.ParseAndCalc(const aInput: string): string;
var
  Values: TArray<string>;
begin
  Values := Trim(aInput).Split([' ']);
  Result := IntToStr(InternalCalc(StrToInt(Values[0]), StrToInt(Values[1])));
end;

initialization
  RegisterWorker(TFIBD_Worker.Create);

end.
