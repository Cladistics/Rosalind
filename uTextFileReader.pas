unit uTextFileReader;

interface

uses
  uWorker.Intf, System.Classes;

type
  TTextFileReader = class(TInterfacedObject, IReader)
  public
    function ReadAll: string;
    function ReadStrings: TArray<string>;
    function Lines: ILineFeeder;
  end;

implementation

uses
  System.IOUtils, System.SysUtils, Vcl.Dialogs, System.Types;

type
  TTextFileLineFeeder = class(TInterfacedObject, ILineFeeder)
  strict private
    FReader: TStreamReader;
  public
    constructor Create(const AFileName: TFileName);
    destructor Destroy; override;
    function Eof: Boolean;
    function ReadString: string;
  end;


{ TTextFileReader }

function TTextFileReader.Lines: ILineFeeder;
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(nil);
  try
    if OpenDialog.Execute(0) then
      Result := TTextFileLineFeeder.Create(OpenDialog.FileName);
  finally
    FreeAndNil(OpenDialog);
  end;
end;

function TTextFileReader.ReadAll: string;
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(nil);
  try
    if OpenDialog.Execute(0) then
      Result := TFile.ReadAllText(OpenDialog.FileName);
  finally
    FreeAndNil(OpenDialog);
  end;
end;

function TTextFileReader.ReadStrings: TArray<string>;
var
  OpenDialog: TOpenDialog;
  Lines: TStringDynArray;
  Line: string;
  I: Integer;
begin
  OpenDialog := TOpenDialog.Create(nil);
  try
    if OpenDialog.Execute(0) then
      Lines := TFile.ReadAllLines(OpenDialog.FileName);
    SetLength(Result, High(Lines)+1);
    I := Low(Lines);
    for Line in Lines do
    begin
      Result[I] := Line;
      Inc(I);
    end;
  finally
    FreeAndNil(OpenDialog);
  end;
end;

{ TTextFileLineFeeder }

constructor TTextFileLineFeeder.Create(const AFileName: TFileName);
begin
  inherited Create;
  FReader := TFile.OpenText(AFileName);
end;

destructor TTextFileLineFeeder.Destroy;
begin
  FreeAndNil(FReader);
  inherited;
end;

function TTextFileLineFeeder.Eof: Boolean;
begin
  Result := FReader.EndOfStream;
end;

function TTextFileLineFeeder.ReadString: string;
begin
  if not FReader.EndOfStream then
    Result := FReader.ReadLine;
end;

end.
