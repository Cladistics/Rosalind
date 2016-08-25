unit uMemoWriter;

interface

uses
  uWorker.Intf, Vcl.StdCtrls;

type
  TMemoWriter = class(TInterfacedObject, IWriter)
  strict private
    FMemo: TMemo;
  public
    constructor Create(const AMemo: TMemo);
    procedure WriteAll(const AMessage: string);
  end;

implementation

uses
  uAdditionalClasses;

{ TMemoWriter }

constructor TMemoWriter.Create(const AMemo: TMemo);
begin
  if not Assigned(AMemo) then
    raise ENilObject.Create('Memo control is nil!');
  FMemo := AMemo;
end;

procedure TMemoWriter.WriteAll(const AMessage: string);
begin
  FMemo.Lines.Add(AMessage);
end;

end.
