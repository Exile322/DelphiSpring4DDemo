unit Models;

interface

type
  TEmployee = class
  private
    FId: TGuid;
    FFirstName: string;
    FLastName: string;
  public
    property Id: TGuid read FId write FId;
    property FirstName: string read FFirstName write FFirstName;
    property LastName: string read FLastName write FLastName;

  public
    constructor Create(id: TGuid; firstName, lastName: string);
  end;

implementation

constructor TEmployee.Create(id: TGUID; firstName: string; lastName: string);
begin
  FId := id;
  FFirstName := firstName;
  FLastName := lastName;
end;

end.
