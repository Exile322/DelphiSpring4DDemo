unit FeatureBModule;

interface

uses
  Spring.Container,
  DIModuleBase;

type
  TFeatureBModule = class(TInterfacedObject, IDIModule)
    procedure RegisterModule(container: TContainer);
  end;

implementation

uses
  Dialogs;

procedure TFeatureBModule.RegisterModule(container: TContainer);
begin
  //ShowMessage('FeatureB');
end;

initialization
  RegisterDIModule(TFeatureBModule);

end.
