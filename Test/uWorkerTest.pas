unit uWorkerTest;

interface
uses
  DUnitX.TestFramework, uWorker.Intf;

type

  [TestFixture]
  TWorkerTest = class(TObject)
  strict private
    function TestWorker(const AWorker: IWorker; const AInput: string): string;
  public
    [Test]
    [TestCase('DNA Worker TestCase 1', 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC,20 12 17 21')]
    [TestCase('DNA Worker TestCase 2', ',0 0 0 0')]
    [TestCase('DNA Worker TestCase 3', 'ZZCT,0 1 0 1')]
    procedure TestDnaWorker(const AInput, AExpectedResult: string);
    [Test]
    [TestCase('FIBD Worker TestCase 1', '6 3,4')]
    [TestCase('FIBD Worker TestCase 2', '6 4,6')]
    [TestCase('FIBD Worker TestCase 3', '7 4,9')]
    [TestCase('FIBD Worker TestCase 4', '7 4,9')]
    [TestCase('FIBD Worker TestCase 5', '82 20,61190227951392303')]
    [TestCase('FIBD Worker TestCase 6', '88 17,1090086281966822291')]
    [TestCase('FIBD Worker TestCase 7', '100 20,2880780934725894724')]
    procedure TestFIBDWorker(const AInput, AExpectedResult: string);
  end;

implementation

uses
  System.Classes, System.SysUtils, uSimpleReaderWriter, uDNA, uFIBD;

procedure TWorkerTest.TestDnaWorker(const AInput, AExpectedResult: string);
var
  Worker: IWorker;
  ActualResult: string;
begin
  Worker := TDNA_Worker.Create;
  ActualResult := TestWorker(Worker, AInput);
  Assert.AreEqual(AExpectedResult, ActualResult);
end;

procedure TWorkerTest.TestFIBDWorker(const AInput, AExpectedResult: string);
var
  Worker: IWorker;
  ActualResult: string;
begin
  Worker := TFIBD_Worker.Create;
  ActualResult := TestWorker(Worker, AInput);
  Assert.AreEqual(AExpectedResult, ActualResult);
end;

function TWorkerTest.TestWorker(const AWorker: IWorker; const AInput: string): string;
var
  Writer: IWriter;
  StringWriter: TStringWriter;
begin
  StringWriter := TStringWriter.Create;
  try
    Writer := TSimpleWriter.Create(StringWriter);
    AWorker.DoWork(TSimpleReader.Create(AInput), Writer);
    Result := StringWriter.ToString;
  finally
    FreeAndNil(StringWriter);
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TWorkerTest);
end.
