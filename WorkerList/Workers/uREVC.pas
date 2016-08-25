unit uREVC;

interface

uses
  uWorker.Intf;

type
  TREVC_Worker = class(TInterfacedObject, IWorker)
  strict private
    function GetName: string;
  public
    procedure DoWork(Reader: IReader; Writer: IWriter);
    property Name: string read GetName;
  end;

implementation

uses
  System.SysUtils, uWorkerList;

{ TREVC_Worker }

procedure TREVC_Worker.DoWork(Reader: IReader; Writer: IWriter);
var
  Ch: Char;
  DNA_data: string;
  REVC_data: TStringBuilder;
  I: Integer;
begin
  REVC_data := TStringBuilder.Create;
  try
    DNA_data := Reader.ReadAll;
    for I := DNA_data.Length downto 1 do
    begin
      Ch := DNA_data[I];
      if Ch = 'A' then
        REVC_data.Append('T')
      else if Ch = 'T' then
        REVC_data.Append('A')
      else if Ch = 'G' then
        REVC_data.Append('C')
      else if Ch = 'C' then
        REVC_data.Append('G');
    end;
    Writer.WriteAll(REVC_data.ToString);
  finally
    FreeAndNil(REVC_data);
  end;
end;

function TREVC_Worker.GetName: string;
begin
  Result := 'REVC';
end;

initialization
  RegisterWorker(TREVC_Worker.Create);

end.
