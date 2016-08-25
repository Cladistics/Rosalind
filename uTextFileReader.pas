unit uTextFileReader;

interface

uses
  uWorker.Intf;

type
  TTextFileReader = class(TInterfacedObject, IReader)
    function ReadAll: string;
    function ReadStrings: TArray<string>;
  end;

implementation

uses
  System.IOUtils, System.SysUtils, Vcl.Dialogs, System.Types;

{ TTextFileReader }

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

end.
