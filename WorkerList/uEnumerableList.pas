unit uEnumerableList;

interface

uses
  System.Generics.Collections, System.SysUtils;

type
  TItemEnumerator<T> = class(TInterfacedObject, IEnumerator<T>)
  strict private
    FIndex: Integer;
    FList: TList<T>;
    function GetCurrentItem: T;
  public
    constructor Create(const AList: TList<T>);
    destructor  Destroy; override;
    function GetCurrent: TObject;
    function IEnumerator<T>.GetCurrent = GetCurrentItem;
    function MoveNext: Boolean;
    procedure Reset;
  end;

  TEnumerableList<T> = class(TInterfacedObject, IEnumerable<T>)
  strict private
    FList: TList<T>;
    function GetItemEnumerator: IEnumerator<T>;
  public
    constructor Create(const AList: TList<T>);
    destructor Destroy; override;
    function GetEnumerator: IEnumerator;
    function IEnumerable<T>.GetEnumerator = GetItemEnumerator;
  end;

implementation

{ TItemEnumerator<T> }

constructor TItemEnumerator<T>.Create(const AList: TList<T>);
begin
  inherited Create;
  FIndex := -1;
  FList := AList;
end;

destructor TItemEnumerator<T>.Destroy;
begin
  FList := nil;
  inherited;
end;

function TItemEnumerator<T>.GetCurrent: TObject;
begin
  Result := nil;
end;

function TItemEnumerator<T>.GetCurrentItem: T;
begin
  Result := FList[FIndex];
end;

function TItemEnumerator<T>.MoveNext: Boolean;
begin
  Result := (FList.Count > FIndex + 1);
  if Result then
    Inc(FIndex);
end;

procedure TItemEnumerator<T>.Reset;
begin
  FIndex := -1;
end;

{ TEnumerableList<T> }

constructor TEnumerableList<T>.Create(const AList: TList<T>);
begin
  inherited Create;
  FList := AList;
end;

destructor TEnumerableList<T>.Destroy;
begin
  FList := nil;
  inherited;
end;

function TEnumerableList<T>.GetEnumerator: IEnumerator;
begin
  Result := nil;
end;

function TEnumerableList<T>.GetItemEnumerator: IEnumerator<T>;
begin
  Result := TItemEnumerator<T>.Create(FList);
end;

end.
