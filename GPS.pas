unit GPS;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Sensors,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Maps, FMX.Layouts,
  FMX.TabControl, System.Sensors.Components, System.Permissions;

type
  TFrmGPS = class(TForm)
    LocationSensor1: TLocationSensor;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    Layout1: TLayout;
    MapView1: TMapView;
    Switch1: TSwitch;
    Label1: TLabel;
    Label2: TLabel;
    procedure Switch1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject;
      const OldLocation, NewLocation: TLocationCoord2D);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGPS: TFrmGPS;

implementation

Uses UDM
{$IFDEF ANDROID}
    , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
{$ENDIF}
    ;
{$R *.fmx}

procedure TFrmGPS.FormCreate(Sender: TObject);
begin
  MapView1.MapType := TMapType.Normal;
end;

procedure TFrmGPS.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
var
  MyMarker: TMapMarkerDescriptor;
  posicao: TMapCoordinate;
begin
  MapView1.Location := TMapCoordinate.Create(NewLocation.Latitude,
    NewLocation.Longitude);

  posicao.Latitude := NewLocation.Latitude;
  posicao.Longitude := NewLocation.Longitude;

  MyMarker := TMapMarkerDescriptor.Create(posicao, 'Estou aqui!');
  MyMarker.Draggable := true;
  MyMarker.Visible := true;
  MyMarker.Snippet := 'EU';
  MapView1.AddMarker(MyMarker);

  Label1.Text := NewLocation.Latitude.ToString().Replace(',', '.');
  Label2.Text := NewLocation.Longitude.ToString().Replace(',', '.');
end;

procedure TFrmGPS.Switch1Click(Sender: TObject);
{$IFDEF ANDROID}
var
  ApermissaoGPS: string;
{$ENDIF}
begin
{$IFDEF ANDROID}
  ApermissaoGPS := JStringToString
    (TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION);

  PermissionsService.RequestPermissions([ApermissaoGPS],
    procedure(const ApermissaoGPS: TArray<string>;
      const AGrantResults: TArray<TPermissionStatus>)
    begin
      if (Length(AGrantResults) = 1) and
        (AGrantResults[0] = TPermissionStatus.Granted) then
        LocationSensor1.Active := true
    else
      LocationSensor1.Active := false;

    end);
{$ENDIF}
end;

end.
