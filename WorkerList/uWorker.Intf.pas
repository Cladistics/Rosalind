unit uWorker.Intf;

interface

type
  IReader = interface
    function ReadAll: string;
    function ReadStrings: TArray<string>;
  end;

  IWriter = interface
    procedure WriteAll(const AMessage: string);
  end;

  IWorker = interface
    function GetName: string;

    procedure DoWork(Reader: IReader; Writer: IWriter);
    property Name: string read GetName;
  end;

implementation

end.
