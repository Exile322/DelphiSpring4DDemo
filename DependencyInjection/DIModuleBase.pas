unit DIModuleBase;

interface

uses
  Spring.Collections,
  Spring.Container;

type
  IDIModule = interface
    ['{03302505-A5DD-41CE-B1E5-4FD08FC5DB69}']

    procedure RegisterModule(container: TContainer);
  end;

// Use the in initialization section of your Module unit so that the linker
// keeps the Module class available for Rtti to find
// This can be an empty method, but I've also chosen to track a list of the
// registered modules, which could be used to register into the container
// instead of replying on Rtti
procedure RegisterDIModule(AClass: TInterfacedClass);

function GetRegisteredDIModules(): IList<TInterfacedClass>;

implementation

uses
  System.SysUtils;

var RegisteredModules: IList<TInterfacedClass>;

function GetRegisteredDIModules(): IList<TInterfacedClass>;
begin
  if not Assigned(RegisteredModules) then
    RegisteredModules := TCollections.CreateList<TInterfacedClass>();

  Result := RegisteredModules;
end;

procedure RegisterDIModule(AClass: TInterfacedClass);
begin
  if Supports(AClass, IDIModule) then
    GetRegisteredDIModules().Add(AClass);
end;

end.
