unit ProviderModule;

interface

{$M+}

uses
  Spring.Container,
  DIModuleBase;

type
  TProviderModule = class(TInterfacedObject, IDIModule)
    procedure RegisterModule(container: TContainer);
  end;

  TFeatureCModule = class(TInterfacedObject, IDIModule)
    procedure RegisterModule(container: TContainer);
  end;

implementation

uses
  Dialogs,
  intfEmployeeProvider,
  EmployeeProvider;

procedure TProviderModule.RegisterModule(container: TContainer);
begin
  container.RegisterType<IEmployeeProvider, TEmployeeProvider>();
end;

procedure TFeatureCModule.RegisterModule(container: TContainer);
begin
  //ShowMessage('FeatureB');
end;

initialization
// https://stackoverflow.com/questions/1606105/how-do-i-force-the-linker-to-include-a-function-i-need-during-debugging
  //TProviderModule(nil).RegisterModule(nil);

  RegisterDIModule(TProviderModule);
  RegisterDIModule(TFeatureCModule);

end.
