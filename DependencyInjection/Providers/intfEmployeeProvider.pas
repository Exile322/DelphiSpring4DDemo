unit intfEmployeeProvider;

interface

uses
  Models;

type
  IEmployeeProvider = interface
    ['{52385DFE-258C-48BB-8021-7BF57B7304AA}']

    function Find(id: TGuid): TEmployee;
  end;

implementation

end.
