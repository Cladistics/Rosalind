unit uRNA;

interface

uses
  uWorker.Intf;

type
  TRNA_Worker = class(TInterfacedObject, IWorker)
  strict private
    function GetName: string;
  public
    procedure DoWork(Reader: IReader; Writer: IWriter);
    property Name: string read GetName;
  end;

implementation

uses
  System.SysUtils, uWorkerList;

{ TRNA_Worker }

procedure TRNA_Worker.DoWork(Reader: IReader; Writer: IWriter);
var
  Ch: Char;
  DNA_data: string;
  RNA_data: TStringBuilder;
begin
  RNA_data := TStringBuilder.Create;
  try
    DNA_data := Reader.ReadAll;
    for Ch in DNA_data do
      if Ch = 'T' then
        RNA_data.Append('U')
      else
        RNA_data.Append(Ch);
    Writer.WriteAll(RNA_data.ToString);
  finally
    FreeAndNil(RNA_data);
  end;
end;

function TRNA_Worker.GetName: string;
begin
  Result := 'RNA';
end;

initialization
  RegisterWorker(TRNA_Worker.Create);

end.
