unit Inicial;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.TabControl,
  System.Actions, idHashSHA, FMX.ActnList;

type
  TFrmInicial = class(TForm)
    LayoutCadastro: TLayout;
    Image1: TImage;
    Label1: TLabel;
    EditEmailCadastro: TEdit;
    Label2: TLabel;
    EditSenhaCadastro: TEdit;
    btnRegistrar: TRoundRect;
    Label3: TLabel;
    TabControl1: TTabControl;
    TabLogin: TTabItem;
    TabCadastro: TTabItem;
    Label5: TLabel;
    LayoutLogin: TLayout;
    Logo: TImage;
    Label6: TLabel;
    EditEmailLogin: TEdit;
    Label7: TLabel;
    EditSenhaLogin: TEdit;
    btnLogin: TRoundRect;
    Label8: TLabel;
    btnCadastro: TRoundRect;
    Label9: TLabel;
    Label10: TLabel;
    ActionList1: TActionList;
    ChangeLogin: TChangeTabAction;
    ChangeCadastro: TChangeTabAction;
    MostrarSenhaLogin: TImage;
    EsconderSenhaLogin: TImage;
    MostrarSenhaCadastro: TImage;
    EsconderSenhaCadastro: TImage;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    Layout7: TLayout;
    Layout8: TLayout;
    Layout9: TLayout;
    procedure btnLoginClick(Sender: TObject);
    procedure btnCadastroClick(Sender: TObject);
    procedure btnRegistrarClick(Sender: TObject);
    procedure MostrarSenhaLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EsconderSenhaLoginClick(Sender: TObject);
    procedure MostrarSenhaCadastroClick(Sender: TObject);
    procedure EsconderSenhaCadastroClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    usuariologado: integer;
    function SHA1(AString: string): string;
  end;

var
  FrmInicial: TFrmInicial;

implementation

{$R *.fmx} uses Principal, UDM, UOpenURL;

procedure TFrmInicial.btnCadastroClick(Sender: TObject);
begin
  ChangeCadastro.Execute;
end;

procedure TFrmInicial.btnLoginClick(Sender: TObject);
var
  senha: String;
begin
  senha := SHA1(EditSenhaLogin.text);
  dm.FDQLogin.Close;
  dm.FDQLogin.ParamByName('pEmail').AsString := EditEmailLogin.text;
  dm.FDQLogin.Open();

  if not(dm.FDQLogin.IsEmpty) and (dm.FDQLoginSenha.AsString = senha) then
  begin
    if not Assigned(FrmPrincipal) then
      usuariologado := dm.FDQLoginIdLogin.AsInteger;
    Application.CreateForm(TFrmPrincipal, FrmPrincipal);
    FrmPrincipal.Show()
  end
  else
  begin
    ShowMessage('Email ou senha estão incorretos');
  end;

end;

procedure TFrmInicial.btnRegistrarClick(Sender: TObject);
var
  senha: string;
begin
  dm.FDQLogin.Close;
  dm.FDQLogin.Open();

  if (EditEmailCadastro.text = EmptyStr) or (EditSenhaCadastro.text = EmptyStr)
  then
    Abort;

  dm.FDQLogin.Append;
  dm.FDQLoginEmail.AsString := EditEmailCadastro.text;
  dm.FDQLoginSenha.AsString := SHA1(EditSenhaCadastro.text);
  dm.FDQLogin.Post;
  dm.FDConnection.CommitRetaining;

  ShowMessage('Cadastro feito com sucesso!');
  ChangeLogin.Execute;
end;

procedure TFrmInicial.EsconderSenhaCadastroClick(Sender: TObject);
begin
  MostrarSenhaCadastro.Visible := true;
  EsconderSenhaCadastro.Visible := false;
  EditSenhaCadastro.Password := true;
end;

procedure TFrmInicial.EsconderSenhaLoginClick(Sender: TObject);
begin
  MostrarSenhaLogin.Visible := true;
  EsconderSenhaLogin.Visible := false;
  EditSenhaLogin.Password := true;
end;

procedure TFrmInicial.FormCreate(Sender: TObject);
begin
  MostrarSenhaLogin.Visible := true;
  EsconderSenhaLogin.Visible := false;
  EditSenhaLogin.Password := true;

  MostrarSenhaCadastro.Visible := true;
  EsconderSenhaCadastro.Visible := false;
  EditSenhaCadastro.Password := true;
end;

procedure TFrmInicial.MostrarSenhaCadastroClick(Sender: TObject);
begin
  MostrarSenhaCadastro.Visible := false;
  EsconderSenhaCadastro.Visible := true;
  EditSenhaCadastro.Password := false;
end;

procedure TFrmInicial.MostrarSenhaLoginClick(Sender: TObject);
begin
  MostrarSenhaLogin.Visible := false;
  EsconderSenhaLogin.Visible := true;
  EditSenhaLogin.Password := false;
end;

function TFrmInicial.SHA1(AString: string): string;
var
  SenhaSH1: TIDhASHsha1;
begin
  SenhaSH1 := TIDhASHsha1.Create;
  TRY
    Result := SenhaSH1.HashStringAsHex(AString);
  FINALLY
    SenhaSH1.Free;
  END;
end;

end.
