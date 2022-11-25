program AppViagem;

uses
  System.StartUpCopy,
  FMX.Forms,
  Inicial in 'Inicial.pas' {FrmInicial},
  Principal in 'Principal.pas' {FrmPrincipal},
  UDM in 'UDM.pas' {dm: TDataModule},
  Splash in 'Splash.pas' {Versao},
  UOpenURL in 'UOpenURL.pas',
  GPS in 'GPS.pas' {FrmGPS},
  Distancia in 'Distancia.pas' {FrmDistancia};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TVersao, Versao);
  Application.Run;
end.
