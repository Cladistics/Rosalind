unit uDNA;

interface

uses
  uWorker.Intf;

type
  TDNA_Worker = class(TInterfacedObject, IWorker)
  strict private
    function GetName: string;
  public
    procedure DoWork(Reader: IReader; Writer: IWriter);
    property Name: string read GetName;
  end;

implementation

uses
  System.Generics.Collections, System.SysUtils, uWorkerList;

{ TDNA_Worker }

procedure TDNA_Worker.DoWork(Reader: IReader; Writer: IWriter);
var
  Ch: Char;
  DNA_data: string;
  CharCount: TDictionary<Char, Integer>;
begin
  CharCount := TDictionary<Char, Integer>.Create(4);
  try
    CharCount.Add('A', 0);
    CharCount.Add('C', 0);
    CharCount.Add('G', 0);
    CharCount.Add('T', 0);
    DNA_data := Reader.ReadAll;
    for Ch in DNA_data do
    begin
      if CharCount.ContainsKey(Ch) then
        CharCount[Ch] := CharCount[Ch] + 1;
    end;
    Writer.WriteAll(Format('%d %d %d %d', [CharCount['A'], CharCount['C'], CharCount['G'], CharCount['T']]));
  finally
    FreeAndNil(CharCount);
  end;
end;

function TDNA_Worker.GetName: string;
begin
  Result := 'DNA';
end;

initialization
  RegisterWorker(TDNA_Worker.Create);

end.
