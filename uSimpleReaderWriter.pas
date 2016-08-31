unit uSimpleReaderWriter;

interface

uses
  System.Classes, uWorker.Intf;

type
  TSimpleReader = class(TInterfacedObject, IReader)
  strict private
    FStrings: TArray<string>;
  public
    constructor Create(const AString: string);
    function Lines: ILineFeeder;
    function ReadAll: string;
    function ReadStrings: TArray<string>;
  end;

  TSimpleWriter = class(TInterfacedObject, IWriter)
  strict private
    FStringWriter: TStringWriter;
    FNeedAddLine: Boolean;
  public
    constructor Create(const AString: TStringWriter);
    procedure WriteAll(const AMessage: string);
  end;

implementation

uses
  System.SysUtils;

type
  TSimpleLineFeeder = class(TInterfacedObject, ILineFeeder)
  strict private
    FStrings: TArray<string>;
    FIndex: Integer;
  public
    constructor Create(const AStrings: TArray<string>);
    function Eof: Boolean;
    function ReadString: string;
  end;

{ TSimpleReader }

constructor TSimpleReader.Create(const AString: string);
begin
  inherited Create;
  FStrings := AString.Split([sLineBreak]);
end;

function TSimpleReader.Lines: ILineFeeder;
begin
  Result := TSimpleLineFeeder.Create(FStrings);
end;

function TSimpleReader.ReadAll: string;
var
  Str: string;
  StrBuilder: TStringBuilder;
begin
  StrBuilder := TStringBuilder.Create;
  try
    for Str in FStrings do
      StrBuilder.AppendLine(Str);
    Result := StrBuilder.ToString;
  finally
    FreeAndNil(StrBuilder);
  end;
end;

function TSimpleReader.ReadStrings: TArray<string>;
begin
  Result := FStrings;
end;

{ TSimpleLineFeeder }

constructor TSimpleLineFeeder.Create(const AStrings: TArray<string>);
begin
  inherited Create;
  FStrings := AStrings;
  FIndex := -1;
end;

function TSimpleLineFeeder.Eof: Boolean;
begin
  Result := Length(FStrings) = FIndex;
end;

function TSimpleLineFeeder.ReadString: string;
begin
  if not Eof then
  begin
    Inc(FIndex);
    Result := FStrings[FIndex];
  end;
end;

{ TSimpleWriter }

constructor TSimpleWriter.Create(const AString: TStringWriter);
begin
  inherited Create;
  FStringWriter := AString;
  FNeedAddLine := False;
end;

procedure TSimpleWriter.WriteAll(const AMessage: string);
begin
  if FNeedAddLine then
    FStringWriter.WriteLine
  else
    FNeedAddLine := True;
  FStringWriter.Write(AMessage);
end;

end.
