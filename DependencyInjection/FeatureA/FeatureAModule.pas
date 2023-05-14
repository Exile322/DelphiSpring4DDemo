unit FeatureAModule;

interface

uses
  Spring,
  Spring.Container,
  Spring.Container.Common,
  DIModuleBase;

type
  TFeatureAModule = class(TInterfacedObject, IDIModule)
    procedure RegisterModule(container: TContainer);
  end;

implementation

uses
  System.Classes,
  Dialogs,
  fMyPopupForm,
  intfMyPopupForm,
  intfEmployeeProvider;

procedure TFeatureAModule.RegisterModule(container: TContainer);
begin
  container.RegisterType<TMyPopupForm>();
  container.RegisterFactory<Func<TComponent, TMyPopupForm>>();
end;

initialization
  RegisterDIModule(TFeatureAModule);

end.
