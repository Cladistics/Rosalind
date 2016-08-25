unit uSUBS;

interface

uses
  uWorker.Intf;

type
  TSUBS_Worker = class(TInterfacedObject, IWorker)
  strict private
    function GetName: string;
    function SubstringPositionList(const AStr, ASubStr: string): TArray<Integer>;
  public
    procedure DoWork(Reader: IReader; Writer: IWriter);
    property Name: string read GetName;
  end;

implementation

uses
  System.SysUtils, System.Generics.Collections, uWorkerList;

{ TSUBS_Worker }

procedure TSUBS_Worker.DoWork(Reader: IReader; Writer: IWriter);
var
  Pos: Integer;
  ResStr: string;
  PosList: TArray<Integer>;
  Str_data: TArray<string>;
begin
  Str_data := Reader.ReadStrings;
  ResStr := '';
  PosList := SubstringPositionList(Str_data[0], Str_data[1]);
  for Pos in PosList do
    ResStr := ResStr + ' ' + IntToStr(Pos);
  ResStr := Trim(ResStr);
  Writer.WriteAll(ResStr);
end;

function TSUBS_Worker.GetName: string;
begin
  Result := 'SUBS';
end;

function TSUBS_Worker.SubstringPositionList(const AStr, ASubStr: string): TArray<Integer>;
var
  PositionList: TArray<Integer>;
  Position, Index: Integer;
begin
  Position := 0;
  Index := 0;
  repeat
    Position := Pos(ASubStr, AStr, Position+1);
    if Position > 0 then
    begin
      SetLength(PositionList, Index+1);
      PositionList[Index] := Position;
      Inc(Index);
    end;
  until Position = 0;
  Result := PositionList;
end;

initialization
  RegisterWorker(TSUBS_Worker.Create);

end.
