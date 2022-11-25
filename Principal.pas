unit Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox, FMX.Layouts,
  FMX.Objects, IOUtils, System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope, System.Actions,
  FMX.ActnList;

type
  TFrmPrincipal = class(TForm)
    TabControl1: TTabControl;
    TabVeiculo: TTabItem;
    TabViajem: TTabItem;
    Image1: TImage;
    LayoutTop: TLayout;
    LayoutGeral: TLayout;
    btnSalvar: TRoundRect;
    Salvar: TLabel;
    Image2: TImage;
    LayoutPrincipal: TLayout;
    Layout1: TLayout;
    BtnGps: TButton;
    ActionList1: TActionList;
    ChangeCarro: TChangeTabAction;
    ChangeMenu: TChangeTabAction;
    Layout7: TLayout;
    BtnCarro: TButton;
    Layout2: TLayout;
    EditPlaca: TEdit;
    Placa: TLabel;
    Layout3: TLayout;
    EditAno: TEdit;
    Ano: TLabel;
    Layout4: TLayout;
    EditGasolina: TEdit;
    MediaGasolina: TLabel;
    Layout5: TLayout;
    EditMarca: TEdit;
    Marca: TLabel;
    Layout6: TLayout;
    EditModelo: TEdit;
    Modelo: TLabel;
    Layout9: TLayout;
    EditEtanol: TEdit;
    MediaEtanol: TLabel;
    Layout10: TLayout;
    EditDiesel: TEdit;
    MediaDiesel: TLabel;
    Layout11: TLayout;
    EditTanque: TEdit;
    Tanque: TLabel;
    Layout8: TLayout;
    btnVoltar: TButton;
    btnDistancia: TButton;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1ItemClick(const Sender: TCustomListBox;
    const Item: TListBoxItem);
    procedure BtnGpsClick(Sender: TObject);
    procedure BtnCarroClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnDistanciaClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx} uses UDM, Inicial, GPS, Distancia;

procedure TFrmPrincipal.BtnCarroClick(Sender: TObject);
begin
  ChangeCarro.Execute;
end;

procedure TFrmPrincipal.btnDistanciaClick(Sender: TObject);
begin
FrmDistancia:=TFrmDistancia.Create(Application);
FrmDistancia.Show();
end;

procedure TFrmPrincipal.BtnGpsClick(Sender: TObject);
begin
  FrmGps:=TFrmGps.Create(Application);
  FrmGps.Show();
end;

procedure TFrmPrincipal.btnSalvarClick(Sender: TObject);
begin
  dm.FDQCarro.Close;
  dm.FDQCarro.Open();

  dm.FDQCarro.Append;
  dm.FDQCarroplaca.AsString := EditPlaca.text;
  dm.FDQCarromarca.AsString := EditMarca.text;
  dm.FDQCarroano.AsInteger := EditAno.text.ToInteger();
  dm.FDQCarromodelo.AsString := EditModelo.text;
  dm.FDQCarromediagasolina.AsFloat := EditGasolina.text.ToDouble();
  dm.FDQCarromediaetanol.AsFloat := EditEtanol.text.ToDouble();
  dm.FDQCarromediadiesel.AsFloat := EditDiesel.text.ToDouble();
  dm.FDQCarroqtdtanque.AsInteger := EditTanque.text.ToInteger();
  ShowMessage('Cadastro feito com sucesso!');
  dm.FDQCarro.Post;
end;

procedure TFrmPrincipal.btnVoltarClick(Sender: TObject);
begin
  ChangeMenu.Execute;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  dm.FDQCarro.Close;
  dm.FDQCarro.Open();
end;

procedure TFrmPrincipal.ListBox1ItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin

  EditPlaca.text := dm.FDQCarroplaca.AsString;
  EditMarca.text := dm.FDQCarromarca.AsString;
  EditAno.text := dm.FDQCarroano.AsInteger.ToString();
  EditModelo.text := dm.FDQCarromodelo.AsString;
  EditGasolina.text := dm.FDQCarromediagasolina.AsFloat.ToString();
  EditEtanol.text := dm.FDQCarromediaetanol.AsFloat.ToString();
  EditDiesel.text := dm.FDQCarromediadiesel.AsFloat.ToString();
  EditTanque.text := dm.FDQCarroqtdtanque.AsFloat.ToString();
end;



end.
