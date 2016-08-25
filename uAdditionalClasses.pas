unit uAdditionalClasses;

interface

uses
  System.SysUtils;

type
  EWorkerNotExist = class(Exception)
    constructor Create;
  end;

  ENilObject = class(Exception);


implementation

{ EWorkerNotExist }

constructor EWorkerNotExist.Create;
begin
  inherited Create('Worker not exists!');
end;

end.
