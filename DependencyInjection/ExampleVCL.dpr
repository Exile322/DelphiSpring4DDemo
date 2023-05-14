program ExampleVCL;

uses
  Winapi.Windows,
  System.TypInfo,
  System.Rtti,
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Dialogs,
  Spring.Container,
  Spring.Collections,
//  Spring.Container.ActivatorExtension,
  fMain in 'fMain.pas' {Form1},
  FeatureAModule in 'FeatureA\FeatureAModule.pas',
  FeatureBModule in 'FeatureB\FeatureBModule.pas',
  ProviderModule in 'Providers\ProviderModule.pas',
  DIModuleBase in 'DIModuleBase.pas',
  fMyPopupForm in 'FeatureA\fMyPopupForm.pas' {MyPopupForm},
  intfMyPopupForm in 'FeatureA\intfMyPopupForm.pas',
  EmployeeProvider in 'Providers\EmployeeProvider.pas',
  intfEmployeeProvider in 'Providers\intfEmployeeProvider.pas',
  Models in 'Models.pas';

{$R *.res}

// Notes:
// How to handle Application.CreateFrom() for the Mainfrom - https://stackoverflow.com/questions/34164648/delphi-how-to-avoid-application-createform

procedure DebugMsg(const Msg: String);
begin
    OutputDebugString(PChar(Msg))
end;

procedure RegisterModules(container: TContainer; useRTTI: boolean);
begin
  //container.AddExtension<TActivatorContainerExtension>();

  // https://stackoverflow.com/questions/34164648/delphi-how-to-avoid-application-createform
  container.RegisterType<TForm1,TForm1>(
    function: TForm1
    begin
        Application.CreateForm(TForm1, Result);
    end);

  if not useRTTI then
  begin
    // Notes:
    // https://stackoverflow.com/questions/57480607/trtticontext-gettypes-not-finding-my-types
    // https://stackoverflow.com/questions/1606105/how-do-i-force-the-linker-to-include-a-function-i-need-during-debugging

    // Direct Manual Registration
//    var featureAModule := TFeatureAModule.Create();
//    featureAModule.RegisterModule(container);
//    var featureBModule := TFeatureBModule.Create();
//    featureBModule.RegisterModule(container);
//    var providerModule := TProviderModule.Create();
//    providerModule.RegisterModule(container);

    // Indirect Manual Registration
    var modules: IList<TInterfacedClass> := GetRegisteredDIModules();
    for var moduleClass in modules do
    begin
      var module := moduleClass.Create() as IDIModule;
      module.RegisterModule(container);
    end;
  end
  else
  begin
    // RTTI Auto Registration
    var ctx := TRttiContext.Create();
    var allTypes := ctx.GetTypes();
    for var t: TRttiType in allTypes do
    begin
      if t.Handle.Kind <> tkClass then
        continue;

      if Supports(t.Handle.TypeData.ClassType, IDIModule) then
      begin
        // Found, now create an execute
        var tInstance := t.AsInstance;
        if Assigned(tInstance) then
        begin
          DebugMsg(t.Handle.Name);
          var intf := t.GetMethod('Create').Invoke(tInstance.MetaclassType, []).AsInterface As IDIModule;
          intf.RegisterModule(container);
        end;
      end;
    end;
  end;

  container.Build();
end;

begin
  RegisterModules(GlobalContainer, false);

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  GlobalContainer.Resolve<TForm1>();
  Application.Run;
end.
