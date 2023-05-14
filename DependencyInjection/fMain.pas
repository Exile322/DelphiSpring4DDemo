unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,

  Spring, // where the definition of Func exists
  Spring.Container.Common, // where the definition of the Inject Attribute exists
  Spring.Container, // where the definition of the container exists
  fMyPopupForm, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FMyPopupFormFunc: Func<TComponent, TMyPopupForm>;

    FMyPopupForm: TMyPopupForm;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    { Public declarations }
    procedure MainFormDI(container: TContainer);

    [Inject]
    procedure AutoDI(popupFunc: Spring.Func<TComponent, TMyPopupForm>);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (AComponent = FMyPopupForm) and (Operation = TOperation.opRemove) then
    FMyPopupForm := nil;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if not Assigned(FMyPopupForm) then
  begin
    FMyPopupForm := FMyPopupFormFunc(self);
    FMyPopupForm.FreeNotification(self);
    FMyPopupForm.Show();
    FMyPopupForm.Hydrate(TGuid.Create('{C69EEF5B-612C-4295-91AC-401D61940D14}'));
  end;
end;

procedure TForm1.MainFormDI(container: TContainer);
begin
  FMyPopupFormFunc := container.Resolve<Func<TComponent, TMyPopupForm>>();
end;

procedure TForm1.AutoDI(popupFunc: Spring.Func<TComponent, TMyPopupForm>);
begin
  FMyPopupFormFunc := popupFunc;
end;

end.
