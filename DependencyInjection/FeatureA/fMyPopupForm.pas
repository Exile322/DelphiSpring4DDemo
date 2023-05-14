unit fMyPopupForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, intfMyPopupForm, intfEmployeeProvider, Models;

type
  TMyPopupForm = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FEmployeeProvider: IEmployeeProvider;

    FEmployeeId: TGuid;
    FEmployee: TEmployee;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AEmployeeProvider: IEmployeeProvider); overload;

    procedure Hydrate(AId: TGuid);
  end;

implementation

{$R *.dfm}

constructor TMyPopupForm.Create(AOwner: TComponent; AEmployeeProvider: IEmployeeProvider);
begin
  inherited Create(AOwner);
  FEmployeeProvider := AEmployeeProvider;
end;

procedure TMyPopupForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMyPopupForm.Hydrate(AId: TGUID);
begin
  FEmployeeId := AId;
  FEmployee := FEmployeeProvider.Find(AId);
end;

end.
