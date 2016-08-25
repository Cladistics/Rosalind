unit uGC;

interface

uses
  uWorker.Intf;

type
  TGC_Worker = class(TInterfacedObject, IWorker)
  strict private
    function GetName: string;
    function GetGC_content(const AGC: string): Extended;
  public
    procedure DoWork(Reader: IReader; Writer: IWriter);
    property Name: string read GetName;
  end;

implementation

uses
  System.Generics.Collections, System.SysUtils, uWorkerList;

{ TGC_Worker }

procedure TGC_Worker.DoWork(Reader: IReader; Writer: IWriter);
var
  GC_data: TArray<string>;
  I: Integer;
  Name, MaxName, Line, GCLine: string;
  CurGC_content, MaxGC_content: Extended;
begin
  GC_data := Reader.ReadStrings;
  I := Low(GC_data);
  MaxGC_content := 0;
  MaxName := '';
  while I <= High(GC_data) do
  begin
    Line := GC_data[I];
    Inc(I);
    if Line.StartsWith('>') then
      Name := Line.Substring(1);
    Line := GC_data[I];
    GCLine := '';
    while (I <= High(GC_data)) and not Line.StartsWith('>') do
    begin
      Inc(I);
      GCLine := GCLine + Trim(Line);
      if I <= High(GC_data) then
        Line := GC_data[I];
    end;
    CurGC_content := GetGC_content(GCLine);
    if CurGC_content > MaxGC_content then
    begin
      MaxName := Name;
      MaxGC_content := CurGC_content;
    end;
  end;
  Writer.WriteAll(MaxName);
  Writer.WriteAll(Format('%3.6f', [MaxGC_content]).Replace(',', '.'));
end;

function TGC_Worker.GetGC_content(const AGC: string): Extended;
var
  GC_count: Integer;
  Ch: Char;
begin
  GC_count := 0;
  for Ch in AGC do
    if CharInSet(Ch,  ['G', 'C']) then
      Inc(GC_Count);
  Result := GC_count * 100 / AGC.Length;
end;

function TGC_Worker.GetName: string;
begin
  Result := 'GC';
end;

initialization
  RegisterWorker(TGC_Worker.Create);

end.
