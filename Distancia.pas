unit Distancia;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, REST.Types,
  FMX.StdCtrls, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, System.JSON;

type
  TFrmDistancia = class(TForm)
    LayoutDistancia: TLayout;
    EditOrigem: TEdit;
    EditDestino: TEdit;
    LabelDistancia: TLabel;
    LabelTempo: TLabel;
    LabelDestino: TLabel;
    LabelOrigem: TLabel;
    btnCalcular: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure btnCalcularClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDistancia: TFrmDistancia;

implementation

{$R *.fmx}

procedure TFrmDistancia.btnCalcularClick(Sender: TObject);
var
  retorno: TJSONObject;
  prows: TJSONPair;
  arrayr: TJSONArray;
  orows: TJSONObject;
  arraye: TJSONArray;
  oelementos: TJSONObject;
  oduracao, odistancia: TJSONObject;

  distancia_str, duracao_str: string;
  distancia_int, duracao_int: integer;
begin
  RESTRequest1.Resource :=
    'json?origins={origem}&destinations={destino}&mode=driving&language=pt-BR&key=AIzaSyAwjnJzF57fQddVy_dL8yTC01Zw7ufVuY8';
  RESTRequest1.Params.AddUrlSegment('origem', EditOrigem.Text);
  RESTRequest1.Params.AddUrlSegment('destino', EditDestino.Text);
  RESTRequest1.Execute;

  retorno := RESTRequest1.Response.JSONValue as TJSONObject;

  if retorno.GetValue('status').Value <> 'OK' then
  begin
    showmessage('Ocorreu um erro ao calcular a viagem.');
    exit;
  end;

  prows := retorno.Get('rows');
  arrayr := prows.JSONValue as TJSONArray;
  orows := arrayr.Items[0] as TJSONObject;
  arraye := orows.GetValue('elements') as TJSONArray;
  oelementos := arraye.Items[0] as TJSONObject;

  odistancia := oelementos.GetValue('distance') as TJSONObject;
  oduracao := oelementos.GetValue('duration') as TJSONObject;

  distancia_str := odistancia.GetValue('text').Value;
  distancia_int := odistancia.GetValue('value').Value.ToInteger;

  duracao_str := oduracao.GetValue('text').Value;
  duracao_int := oduracao.GetValue('value').Value.ToInteger;

  LabelDistancia.Text := 'Distância: ' + distancia_str;
  LabelTempo.Text := 'Tempo: ' + duracao_str;

end;

end.
