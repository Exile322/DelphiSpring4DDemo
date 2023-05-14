unit EmployeeProvider;

interface

uses
  intfEmployeeProvider,
  Models;

type
  TEmployeeProvider = class(TInterfacedObject, IEmployeeProvider)
    function Find(id: TGuid): TEmployee;
  end;

implementation

function TEmployeeProvider.Find(id: TGUID): TEmployee;
begin
  Result := nil;
end;

end.
