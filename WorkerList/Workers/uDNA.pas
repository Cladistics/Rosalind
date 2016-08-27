unit uDNA;

interface

uses
  uWorker.Intf;

type
  TDNA_Worker = class(TInterfacedObject, IWorker)
  strict private
    function GetName: string;
    function InternalCalc(const aInput: string): string;
  public
    procedure DoWork(Reader: IReader; Writer: IWriter);
    property Name: string read GetName;
  end;

implementation

uses
  System.Generics.Collections, System.SysUtils, uWorkerList;

{ TDNA_Worker }

procedure TDNA_Worker.DoWork(Reader: IReader; Writer: IWriter);
begin
  Writer.WriteAll(InternalCalc(Reader.ReadAll));
end;

function TDNA_Worker.GetName: string;
begin
  Result := 'DNA';
end;

function TDNA_Worker.InternalCalc(const aInput: string): string;
var
  CharCount: TDictionary<Char, Integer>;
  Ch: Char;
begin
  CharCount := TDictionary<Char, Integer>.Create(4);
  try
    CharCount.Add('A', 0);
    CharCount.Add('C', 0);
    CharCount.Add('G', 0);
    CharCount.Add('T', 0);
    for Ch in aInput do
    begin
      if CharCount.ContainsKey(Ch) then
        CharCount[Ch] := CharCount[Ch] + 1;
    end;
    Result := Format('%d %d %d %d', [CharCount['A'], CharCount['C'], CharCount['G'], CharCount['T']]);
  finally
    FreeAndNil(CharCount);
  end;
end;

initialization
  RegisterWorker(TDNA_Worker.Create);

end.
