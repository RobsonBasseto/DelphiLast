unit UDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, IOUtils;

type
  Tdm = class(TDataModule)
    FDConnection: TFDConnection;
    FDQLogin: TFDQuery;
    FDQLoginidlogin: TFDAutoIncField;
    FDQLoginemail: TStringField;
    FDQLoginsenha: TStringField;
    FDQCarro: TFDQuery;
    FDQLogado: TFDQuery;
    FDQViagem: TFDQuery;
    FDQCarroidcarro: TFDAutoIncField;
    FDQCarroplaca: TStringField;
    FDQCarromarca: TStringField;
    FDQCarroano: TIntegerField;
    FDQCarromodelo: TStringField;
    FDQCarromediagasolina: TBCDField;
    FDQCarromediaetanol: TBCDField;
    FDQCarromediadiesel: TBCDField;
    FDQCarroqtdtanque: TIntegerField;
    procedure FDConnectionAfterConnect(Sender: TObject);
    procedure FDConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure Tdm.FDConnectionAfterConnect(Sender: TObject);
var
  strSQL: string;
begin

  strSQL := 'create table IF NOT EXISTS login(' +
    'idlogin integer primary key autoincrement,' +
    'email varchar(50) not null,  ' + 'senha varchar(200) not null) ';

  FDConnection.ExecSQL(strSQL);
  strSQL := EmptyStr;

  strSQL := 'create table IF NOT EXISTS carro( ' +
    'idcarro integer primary key autoincrement,' +
    'placa varchar(7), ' +
    'marca varchar(50), ' +
    'ano integer,    ' +
    'modelo varchar(50),   ' +
    'mediagasolina numeric(8,2),    ' +
    'mediaetanol numeric(8,2),    ' +
    'mediadiesel numeric(8,2),    ' +
    'combustivel char(10), ' +
    'qtdtanque integer)' ;

  FDConnection.ExecSQL(strSQL);
  strSQL := EmptyStr;


  strSQL := 'create table IF NOT EXISTS viagem('+
  'id integer not null primary key autoincrement,'+
  'origem varchar(100),'+
  'destino varchar(100),'+
  'origemlatitude numeric(10, 8),'+
  'origemlongitude numeric(10, 8),' +
  'destinolatitude numeric(10, 8),' +
  'destinolongitude numeric(10, 8),' +
  'valorgasolina numeric(10, 8),' +
  'valoretanol numeric(10, 8),' +
  'valordiesel numeric(10, 8))';
  FDConnection.ExecSQL(strSQL);
  strSQL := EmptyStr;

     FDQLogin.Active  :=true;
     FDQCarro.Active :=true;
end;

procedure Tdm.FDConnectionBeforeConnect(Sender: TObject);
var
strPath: string;
begin
    {$IF DEFINED(iOS) or DEFINED(ANDROID)}
       strPath:= System.IOUtils.Tpath.Combine(System.IOUtils.TPath.GetDocumentsPath,
       'bd.db');
  {$ENDIF}
  {$IFDEF MSWINDOWS}
      strPath := System.IOUtils.Tpath.Combine('D:\Users\rrobasseto\Desktop\APP\BD','bd.db');
  {$ENDIF}
       FDconnection.Params.Values['UseUnicode'] :='False';
       FDconnection.Params.Values['DATABASE'] :=strPath;
end;

end.
