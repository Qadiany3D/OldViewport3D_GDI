unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MHD3D_Objects, MHD3D_FNMath3D, Form_About, EditFloat_Unit, StdCtrls,
  math, Menus, ExtCtrls, Buttons, ExtDlgs, jpeg, DateUtils, ComCtrls;

function FileNameType(s_:string):integer;

type
    tmaps = class
         Displacement:Tbitmap;
         constructor create;
    end;
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    ViewPort1: TMenuItem;
    ResetTM1: TMenuItem;
    ViewPortRedraw1: TMenuItem;
    WireFrame1: TMenuItem;
    N1: TMenuItem;
    Flat1: TMenuItem;
    Polygon1: TMenuItem;
    Anomation1: TMenuItem;
    Play1: TMenuItem;
    Stop1: TMenuItem;
    Pause1: TMenuItem;
    Timer1: TTimer;
    N2: TMenuItem;
    ResetPlaySpeed1: TMenuItem;
    ImageViewPort: TImage;
    PanelViewPort: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    N3: TMenuItem;
    UseGlobalLighttoshading1: TMenuItem;
    NotColor: TMenuItem;
    DrawGrid1: TMenuItem;
    Memo1: TMemo;
    Button1: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    FastDrawonChange1: TMenuItem;
    UpDown1: TUpDown;
    Edit1: TEdit;
    UpDown_Width: TUpDown;
    Edit_Width: TEdit;
    UpDown_Length: TUpDown;
    Edit_Length: TEdit;
    UpDown_Height: TUpDown;
    Edit_Height: TEdit;
    PanelBackColor: TPanel;
    ColorDialog1: TColorDialog;
    UpDown_RotX: TUpDown;
    Edit_RotX: TEdit;
    UpDown_RotY: TUpDown;
    Edit_RotY: TEdit;
    UpDown_RotZ: TUpDown;
    Edit_RotZ: TEdit;
    UpDown_PosX: TUpDown;
    Edit_PosX: TEdit;
    UpDown_PosY: TUpDown;
    Edit_PosY: TEdit;
    UpDown_PosZ: TUpDown;
    Edit_PosZ: TEdit;
    Help1: TMenuItem;
    About1: TMenuItem;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    DrawObjectTransform1: TMenuItem;
    TrackBar1: TTrackBar;
    N4: TMenuItem;
    Show1: TMenuItem;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
    ScrollBox1: TScrollBox;
    procedure FormCreate(Sender: TObject);

    procedure ResetTM;

    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormConstrainedResize(Sender: TObject; var MinWidth,
      MinHeight, MaxWidth, MaxHeight: Integer);
    procedure ResetTM1Click(Sender: TObject);
    procedure ViewPortRedraw1Click(Sender: TObject);
    procedure WireFrame1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Polygon1Click(Sender: TObject);
    procedure Flat1Click(Sender: TObject);
    procedure Play1Click(Sender: TObject);
    procedure Pause1Click(Sender: TObject);
    procedure Stop1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ResetPlaySpeed1Click(Sender: TObject);
    procedure PanelViewPortResize(Sender: TObject);
    procedure UseGlobalLighttoshading1Click(Sender: TObject);
    procedure NotColorClick(Sender: TObject);
    procedure DrawGrid1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure PanelBackColorClick(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure Splitter2Moved(Sender: TObject);
    procedure UpDown_RotXClick(Sender: TObject; Button: TUDBtnType);
    procedure About1Click(Sender: TObject);
    procedure DrawObjectTransform1Click(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure Show1Click(Sender: TObject);
    procedure UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure RadioGroup1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    sw_FPU : Word;
    EditFloat_PosX : TEditFloat;
    EditFloat_PosY : TEditFloat;
    EditFloat_PosZ : TEditFloat;
    EditFloat_RotX : TEditFloat;
    EditFloat_RotY : TEditFloat;
    EditFloat_RotZ : TEditFloat;
    EditFloat_ScaleX : TEditFloat;
    EditFloat_ScaleY : TEditFloat;
    EditFloat_ScaleZ : TEditFloat;
    f3d:tfnMath3d;
    ViewPortDrawType : array of boolean;
    ViewChange : boolean;
    ViewMDownpos : array[1..3] of tpoint;
    ViewTM : tmatrix3d;
    InvViewTM : tmatrix3d;
    ViewPortDib:TBitmap;
    ViewPortDibHis:TBitmap;
    ViewTMHis:tmatrix3d;
    OBJ1Trans:tmatrix3d;
    ViewTMCenter:TVec3D;
    FieldOfView:extended;
    ZoomVector:TVec3D;
    BackgroundColor : tcolor;
    MouseDown:array[1..3] of boolean;
    ctrldown,altdown,shiftdown : boolean;
    PlayStartTime : extended;
    AnimationTime : extended;
    AnimationPlaySpeed:extended;
    GlobalLightPos:TVec3D;
    LightFromViewPos:boolean;
    Maps:tmaps;
    Form_About_3D_Viewport : TForm_About_3D_Viewport;
    FormViewport : tform;
    //procedure PlayAnimation;
    procedure DrawFOV(B:tbitmap;M:TMatrix3D;FOV:extended;Clr:TColor);
    procedure DrawGridOnBitmap(B:tBitmap;M,InvM:TMatrix3D;Clr:TColor;Count:integer;Distance:extended);
    procedure DrawSpheresOnBitmap(B:tBitmap;M:TMatrix3D;Offset:TVec3D;ObjCount:integer;Segs:Integer;Radius:extended);
    procedure DrawPlaneOnBitmap(B:tBitmap;const M,InvM:TMatrix3D;Offset:TVec3D;Width,Length,height:extended;WidthSegs,LengthSegs:Integer);
    procedure DrawSphereOnBitmap(B:tBitmap;const M,InvM:TMatrix3D;Offset:TVec3D;Width,Length,height:extended;WidthSegs,LengthSegs:Integer);
    procedure DrawDisplacementOnBitmap(B:tBitmap;const M,InvM:TMatrix3D;Offset:TVec3D;Width,Length,height:extended;WidthSegs,LengthSegs:Integer);
    procedure DrawViewport(m:TMatrix3D);
    procedure DrawIfNotPlaying;
    procedure NewOnChangeFloat(Sender : TObject;NewVal:extended);
    function TimeToExtended(t:tdate):extended;
    procedure DrawOBJ1Trans(M:TMatrix3D;b:tbitmap;L: extended;clrx,clry,clrz:tcolor);
    procedure DrawFace(v1,v2,v3 : TVec3D;B:TBitmap;const M,InvM : TMatrix3D;Color_ : TColor);
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function tform1.TimeToExtended(t:tdate):extended;
begin
    result := (Minuteof(t) * 60 + SecondOf(t) + MilliSecondOf(t)/1000);
end;

constructor tmaps.create;
begin
    self.Displacement := tbitmap.Create;
end;

procedure tform1.DrawFOV(B:tbitmap;M:TMatrix3D;FOV:extended;Clr:TColor);
var
    clrhis : tcolor;
    penw : integer;
    ar : array of tpoint;
    offset:tpoint;
    radius : extended;
begin
    if b.Width < b.Height then
        radius := (b.Width - 90) / 2
    else
        radius := (b.Height - 90) / 2;
    offset := point(trunc(25 + radius),b.Height - 90);
    penw := b.Canvas.Pen.Width;
    b.Canvas.Pen.Width := 1;
    clrhis := b.Canvas.Pen.Color;
    b.Canvas.Pen.Color := clr;
    setlength(ar,3);
    ar[1] := point(trunc(0) + offset.X,trunc(0) + offset.Y);
    ar[0] := point(trunc(radius *  sin(fov/2)) + offset.X,trunc(radius * -cos(fov/2)) + offset.Y);
    ar[2] := point(trunc(radius * -sin(fov/2)) + offset.X,trunc(radius * -cos(fov/2)) + offset.Y);
    //ar[3] := ar[0];
    b.Canvas.Polyline(ar);
    if ar[0].X <> ar[2].X then
        b.Canvas.Arc(offset.X - trunc(radius / 3) ,
                     offset.Y - trunc(radius / 3) ,
                     offset.X + trunc(radius / 3) ,
                     offset.Y + trunc(radius / 3) ,
                     ar[0].X ,
                     ar[0].Y ,
                     ar[2].X ,
                     ar[2].y);
    ar[1] := ar[2];
    setlength(ar,2);
    b.Canvas.Pen.Width := 5;
    b.Canvas.Polyline(ar);
    b.Canvas.Pen.Color := clrhis;
    b.Canvas.Pen.Width := penw;
end;

procedure TForm1.DrawGridOnBitmap(B:tBitmap;M,InvM:TMatrix3D;Clr:TColor;Count:integer;Distance:extended);
var
    i,j,k,k_,centx,centy:integer;
    lclr:tcolor;
    lv2_00:TVec2D;
    lv3_00 : tvec3d;
    ar : array of tpoint;
    ar_ : tpoint;
    ll : extended;
    ift,ift_ : boolean;
    penwid:integer;
begin
    penwid := b.Canvas.Pen.Width;
    b.Canvas.Pen.Width := 1;
    count := abs(count);
    lclr := b.Canvas.Pen.Color;
    ll := count * Distance;
    j := 3;
    setlength(ar,2);
    centx := b.Width div 2;
    centy := b.Height div 2;
    ar[0] := point(0,0);
    ar[1] := point(0,0);
    if (f3d.Dist(m.Row3,m.Row4) > 0) then
    begin
        while (j > -1) do
        begin
            b.Canvas.Pen.Color := rgb(150,150,150);
            j := j - 2;
            for i := 1 to count do
            begin
                k := -count - 1;
                ift_ := true;
                while ift_ and (k < count) do
                begin
                    k := k + 1;
                    lv3_00 := f3d.Vec3D(k * Distance,j*Distance*i,0.00000000001);
                    if f3d.Dot(f3d.VSub(lv3_00,Invm.Row4),Invm.Row3) < 0 then
                    begin
                        ar[0] := f3d.V3DToScreen(lv3_00,m,self.FieldOfView,b.Height,centx,centy);
                        if (ar[0].X < trunc(b.Width * 1.5))  and
                           (ar[0].X > -b.Width div 2)        and
                           (ar[0].Y < trunc(b.Height * 1.5)) and
                           (ar[0].Y > -b.Height div 2)       then
                        begin
                            ift := false;
                        end;
                    end;
                end;
                k := count + 1;
                ift_ := true;
                while ift_ and (k > -count) do
                begin
                    k := k - 1;
                    lv3_00 := f3d.Vec3D(k * Distance,j*Distance*i,0.00000000001);
                    if f3d.Dot(f3d.VSub(lv3_00,Invm.Row4),Invm.Row3) < 0 then
                    begin
                        ar[1] := f3d.V3DToScreen(lv3_00,m,self.FieldOfView,b.Height,centx,centy);
                        if (ar[1].X < trunc(b.Width * 1.5))  and
                            (ar[1].X > -b.Width div 2)        and
                            (ar[1].Y < trunc(b.Height * 1.5)) and
                            (ar[1].Y > -b.Height div 2)       then
                        begin
                            ift := false;
                        end;
                    end;
                end;
                b.Canvas.Polyline(ar);
            end;
            //____________________
            for i := 1 to count do
            begin
                k := -count - 1;
                ift_ := true;
                while ift_ and (k < count) do
                begin
                    k := k + 1;
                    lv3_00 := f3d.Vec3D(j*Distance*i,k * Distance,0.00000000001);
                    if f3d.Dot(f3d.VSub(lv3_00,Invm.Row4),Invm.Row3) < 0 then
                    begin
                        ar[0] := f3d.V3DToScreen(lv3_00,m,self.FieldOfView,b.Height,centx,centy);
                        if (ar[0].X < trunc(b.Width * 1.5))  and
                           (ar[0].X > -b.Width div 2)        and
                           (ar[0].Y < trunc(b.Height * 1.5)) and
                           (ar[0].Y > -b.Height div 2)       then
                        begin
                            ift := false;
                        end;
                    end;
                end;
                k := count + 1;
                ift_ := true;
                while ift_ and (k > -count) do
                begin
                    k := k - 1;
                    lv3_00 := f3d.Vec3D(j*Distance*i,k * Distance,0.00000000001);
                    if f3d.Dot(f3d.VSub(lv3_00,Invm.Row4),Invm.Row3) < 0 then
                    begin
                        ar[1] := f3d.V3DToScreen(lv3_00,m,self.FieldOfView,b.Height,centx,centy);
                        if (ar[1].X < trunc(b.Width * 1.5))  and
                           (ar[1].X > -b.Width div 2)        and
                           (ar[1].Y < trunc(b.Height * 1.5)) and
                           (ar[1].Y > -b.Height div 2)       then
                        begin
                            ift := false;
                        end;
                    end;
                end;
                b.Canvas.Polyline(ar);
            end;
            b.Canvas.Pen.Color := rgb(0,0,0);
            //____________________
            k := -count;
                ift_ := true;
                while ift_ and (k < count) do
                begin
                    k := k + 1;
                    lv3_00 := f3d.Vec3D(0,k * Distance,0.00000000001);
                    if f3d.Dot(f3d.VSub(lv3_00,Invm.Row4),Invm.Row3) < 0 then
                    begin
                        ar[0] := f3d.V3DToScreen(lv3_00,m,self.FieldOfView,b.Height,centx,centy);
                        if (ar[0].X < trunc(b.Width * 1.5))  and
                           (ar[0].X > -b.Width div 2)        and
                           (ar[0].Y < trunc(b.Height * 1.5)) and
                           (ar[0].Y > -b.Height div 2)       then
                        begin
                            ift := false;
                        end;
                    end;
                end;
                k := count;
                ift_ := true;
                while ift_ and (k > -count) do
                begin
                    k := k - 1;
                    lv3_00 := f3d.Vec3D(0,k * Distance,0.00000000001);
                    if f3d.Dot(f3d.VSub(lv3_00,Invm.Row4),Invm.Row3) < 0 then
                    begin
                        ar[1] := f3d.V3DToScreen(lv3_00,m,self.FieldOfView,b.Height,centx,centy);
                        if (ar[1].X < trunc(b.Width * 1.5))  and
                           (ar[1].X > -b.Width div 2)        and
                           (ar[1].Y < trunc(b.Height * 1.5)) and
                           (ar[1].Y > -b.Height div 2)       then
                        begin
                            ift := false;
                        end;
                    end;
                end;
                b.Canvas.Polyline(ar);
            //____________________
            k := -count;
                ift_ := true;
                while ift_ and (k < count) do
                begin
                    k := k + 1;
                    lv3_00 := f3d.Vec3D(k * Distance,0.000000000001,0.00000000001);
                    if f3d.Dot(f3d.VSub(lv3_00,Invm.Row4),Invm.Row3) < 0 then
                    begin
                        ar[0] := f3d.V3DToScreen(lv3_00,m,self.FieldOfView,b.Height,centx,centy);
                        if (ar[0].X < trunc(b.Width * 1.5))  and
                           (ar[0].X > -b.Width div 2)        and
                           (ar[0].Y < trunc(b.Height * 1.5)) and
                           (ar[0].Y > -b.Height div 2)       then
                        begin
                            ift := false;
                        end;
                    end;
                end;
                k := count;
                ift_ := true;
                while ift_ and (k > -count) do
                begin
                    k := k - 1;
                    lv3_00 := f3d.Vec3D(k * Distance,0.0000000000001,0.00000000001);
                    if f3d.Dot(f3d.VSub(lv3_00,Invm.Row4),Invm.Row3) < 0 then
                    begin
                        ar[1] := f3d.V3DToScreen(lv3_00,m,self.FieldOfView,b.Height,centx,centy);
                        if (ar[1].X < trunc(b.Width * 1.5))  and
                           (ar[1].X > -b.Width div 2)        and
                           (ar[1].Y < trunc(b.Height * 1.5)) and
                           (ar[1].Y > -b.Height div 2)       then
                        begin
                            ift := false;
                        end;
                    end;
                end;
                b.Canvas.Polyline(ar);
        end;
    end;
    b.Canvas.Pen.Color := lclr;
    b.Canvas.Pen.Width := penwid;
end;
{var
    i,j,centx,centy:integer;
    lclr:tcolor;
    lv2_00:TVec2D;
    ar : array of tpoint;
    ll : extended;
    ift : boolean;
begin
    lclr := b.Canvas.Pen.Color;
    setlength(ar,2);
    ll := count * dist;
    j := 3;
    centx := b.Width div 2;
    centy := b.Height div 2;
    if (f3d.Dist(m.Row3,m.Row4) > 0) then
    begin
    while (j > -1) do
    begin
        b.Canvas.Pen.Color := rgb(150,150,150);
        j := j - 2;
        for i := 1 to count do
        begin
            ar[0] := f3d.V3DToScreen(f3d.Vec3D( ll,j*dist*i,0),m,self.FieldOfView,b.Height,centx,centy);
            ar[1] := f3d.V3DToScreen(f3d.Vec3D(-ll,j*dist*i,0),m,self.FieldOfView,b.Height,centx,centy);
            if (abs(b.Width  - 2 * ar[0].X) < 1.5 * b.Width)  and
               (abs(b.Height - 2 * ar[0].Y) < 1.5 * b.Height) and
               (abs(b.Width  - 2 * ar[1].X) < 1.5 * b.Width)  and
               (abs(b.Height - 2 * ar[1].Y) < 1.5 * b.Height) then
                    b.Canvas.Polyline(ar);
        end;
        //___________________
        for i := 1 to count do
        begin
            ar[0] := f3d.V3DToScreen(f3d.Vec3D(j*dist*i,ll,0),m,self.FieldOfView,b.Height,centx,centy);
            ar[1] := f3d.V3DToScreen(f3d.Vec3D(j*dist*i,-ll,0),m,self.FieldOfView,b.Height,centx,centy);
            if (abs(b.Width  - 2 * ar[0].X) < 1.5 * b.Width)  and
               (abs(b.Height - 2 * ar[0].Y) < 1.5 * b.Height) and
               (abs(b.Width  - 2 * ar[1].X) < 1.5 * b.Width)  and
               (abs(b.Height - 2 * ar[1].Y) < 1.5 * b.Height) then
                    b.Canvas.Polyline(ar);
        end;
        b.Canvas.Pen.Color := rgb(0,0,0);
        //___________________
        ar[0] := f3d.V3DToScreen(f3d.Vec3D( ll,0,0),m,self.FieldOfView,b.Height,centx,centy);
        ar[1] := f3d.V3DToScreen(f3d.Vec3D(-ll,0,0),m,self.FieldOfView,b.Height,centx,centy);
        b.Canvas.Polyline(ar);
        //____________________
        ar[0] := f3d.V3DToScreen(f3d.Vec3D(0, ll,0),m,self.FieldOfView,b.Height,centx,centy);
        ar[1] := f3d.V3DToScreen(f3d.Vec3D(0,-ll,0),m,self.FieldOfView,b.Height,centx,centy);
        b.Canvas.Polyline(ar);
    end;
    end;
    b.Canvas.Pen.Color := lclr;
end; }

procedure TForm1.DrawSpheresOnBitmap(B:tBitmap;M:TMatrix3D;Offset:TVec3D;ObjCount:integer;Segs:Integer;Radius:extended);
var
    ift:boolean;
    ar:array of tpoint;
    i,j,k,l,ll,obji,centx,centy : integer;
    bcenter:tpoint;
    Pos,p1,p2,p3,p4,lv3_00,lv3_01,cross_:TVec3D;
    sin_1,sin_2,cos_1,cos_2,multicolor_,radiu:extended;
begin
    bcenter := point(b.Width div 2,b.Height div 2);
    setlength(ar,4);
    radiu := radius;
    centx := b.Width div 2;
    centy := b.Height div 2;
    for obji := 2 to objcount +1 do
    begin
        radius := (0.5 + 0.5 * sin(pi * (obji + 1) / (objcount + 1) + 2 * pi * self.AnimationTime)) * radiu;
        k := (segs * obji) div (2*objcount);// 2*(obji+1) div 4 + 2;
        if k < 4 then k := 4;
        ll := (segs * obji) div (2*objcount);//2*(obji+1) div 4 + 2;
        if l < 4 then l := 4;
        pos.Y := offset.Y + (3*radius * (sin(2*pi * self.AnimationTime) + cos(2*pi*obji/(objcount + 1))));
        pos.X := offset.X + (3*radius * (cos(2*pi * self.AnimationTime) - sin(2*pi*obji/(objcount + 1))));
        pos.Z := offset.Z + (3*radius);// * -sin(2*pi*obji/(objcount + 1) + 5 * self.AnimationTime));

        b.Canvas.Brush.Color := f3d.colorwave1(0.5 + obji / (objcount + 1),0,0);
        b.Canvas.Pen.Color := f3d.colorwave1(0.5 + obji / (objcount + 1),0.25,0.5);

        for i := 0 to 2*k do    {Canvase Sphere}
        begin
            for l := 1 to ll do
            begin
                sincos(l*pi/ll,sin_1,cos_1);
                sincos(i*pi/k,sin_2,cos_2);
                p1 := f3d.Vec3D(sin_1 * cos_2 * radius + pos.X ,
                                sin_1 * sin_2 * radius + pos.Y ,
                                cos_1         * radius + pos.Z);
                sincos((i+1)*pi/k,sin_2,cos_2);
                p2 := f3d.Vec3D(sin_1 * cos_2 * radius + pos.X ,
                                sin_1 * sin_2 * radius + pos.Y ,
                                cos_1         * radius + pos.Z);
                sincos((l-1)*pi/ll,sin_1,cos_1);
                p3 := f3d.Vec3D(sin_1 * cos_2 * radius + pos.X ,
                                sin_1 * sin_2 * radius + pos.Y ,
                                cos_1         * radius + pos.Z);
                sincos(i*pi/k,sin_2,cos_2);
                p4 := f3d.Vec3D(sin_1 * cos_2 * radius + pos.X ,
                                sin_1 * sin_2 * radius + pos.Y ,
                                cos_1         * radius + pos.Z);
                {______________}      {Shader}

                lv3_00 := f3d.VSub(p2,p1);
                lv3_01 := f3d.VSub(p2,p3);
                cross_ := f3d.Cross(lv3_00,lv3_01);

                if f3d.Leng(cross_) < 0.0000000001 then
                begin
                    lv3_00 := f3d.VSub(p2,p4);
                    cross_ := f3d.Cross(lv3_00,lv3_01);
                end;

                lv3_00 := f3d.Norm(f3d.VSub(m.Row4,p2));
                ift := f3d.Dot(cross_,lv3_00) < 0;
                if ift then
                begin
                    cross_ := f3d.Norm(cross_);
                    if self.LightFromViewPos then
                        lv3_00 := f3d.Norm(f3d.VSub(m.Row4,p2))
                    else
                        lv3_00 := f3d.Norm(f3d.VSub(self.GlobalLightPos,p2));
                    multicolor_ := -f3d.Dot(cross_,lv3_00);
                    cross_ := f3d.VSub(p2,m.Row4);
                    {if (f3d.dot(m.Row[3],cross_) < 0) and (multicolor_ > 0) then}
                    begin
                        multicolor_ := multicolor_ * (0.25 + 0.5 * power(sin(multicolor_* pi / 2),100));
                        if self.ViewPortDrawType[1] then
                        begin
                            if not self.ViewPortDrawType[2] then
                                b.Canvas.Brush.Color := f3d.colorwave1(0.5 + obji / (objcount + 1),power(multicolor_,3),power(1-multicolor_,2.25));//rgb(0,trunc(multicolor_ * 128),trunc(multicolor_ * 200));
                            if not self.ViewPortDrawType[0] then
                                b.Canvas.Pen.Color := b.Canvas.Brush.Color;
                        end
                        else
                        begin
                            if self.ViewPortDrawType[0] then
                                b.Canvas.Pen.Color := f3d.colorwave1(0.5 + obji / (objcount + 1),power(multicolor_,3),power(1-multicolor_,2.25));//rgb(0,trunc(multicolor_ * 128),trunc(multicolor_ * 200));
                        end;
                        ar[0] := f3d.V3DToScreen(p1,m,self.FieldOfView,b.Height,centX,centY);
                        ar[1] := f3d.V3DToScreen(p2,m,self.FieldOfView,b.Height,centX,centY);
                        ar[2] := f3d.V3DToScreen(p3,m,self.FieldOfView,b.Height,centX,centY);
                        ar[3] := f3d.V3DToScreen(p4,m,self.FieldOfView,b.Height,centX,centY);
                        if (abs(b.Width  - 2 * ar[0].X) < 1.5 * b.Width)  and
                           (abs(b.Height - 2 * ar[0].Y) < 1.5 * b.Height) and
                           (abs(b.Width  - 2 * ar[1].X) < 1.5 * b.Width)  and
                           (abs(b.Height - 2 * ar[1].Y) < 1.5 * b.Height) and
                           (abs(b.Width  - 2 * ar[2].X) < 1.5 * b.Width)  and
                           (abs(b.Height - 2 * ar[2].Y) < 1.5 * b.Height) and
                           (abs(b.Width  - 2 * ar[3].X) < 1.5 * b.Width)  and
                           (abs(b.Height - 2 * ar[3].Y) < 1.5 * b.Height) then
                        begin
                            if self.ViewPortDrawType[1] then
                            begin
                                b.Canvas.Polygon(ar);
                            end
                            else
                            begin
                                b.Canvas.Polyline(ar);
                            end;
                        end;
                    end;
                end;
                {______________}
            end;
        end;
    end;
end;

procedure TForm1.DrawPlaneOnBitmap(B:tBitmap;const M,InvM:TMatrix3D;Offset:TVec3D;Width,Length,height:extended;WidthSegs,LengthSegs:Integer);
var
    ift:boolean;
    ar:array of tpoint;
    i,j,k,l,ll,k_1,ll_1,obji : integer;
    bcenter:tpoint;
    Pos,p1,p2,p3,p4,lv3_00,lv3_01,cross_:TVec3D;
    sin_1,sin_2,cos_1,cos_2,multicolor_,multicolor_0,radiu,ltime_:extended;
    clr_:tcolor;
    matr_: TMatrix3D;
    xRot,yRot,zRot: extended;
begin
    xrot := DegToRad(EditFloat_RotX.Value);//self.UpDown_Rotx.Position);
    yrot := DegToRad(EditFloat_RotY.Value);//self.UpDown_Roty.Position);
    zrot := DegToRad(EditFloat_RotZ.Value);//self.UpDown_Rotz.Position);
    //matr_ := f3d.Rot(f3d.Matrix3D(1,0,0,0,1,0,0,0,1,0,0,0),0*xrot,0*yrot,0*zrot,false);
    matr_ := self.OBJ1Trans;//f3d.Matrix3D(1,0,0,0,1,0,0,0,1,0,0,0);
    //matr_ := f3d.Rot(matr_,xrot,yrot,zrot,false,true);
    bcenter := point(b.Width div 2,b.Height div 2);
    setlength(ar,4);
    height := height * cos(0.2*self.AnimationTime);
    //for obji := 2 to objcount +1 do
    begin
        b.Canvas.Brush.Color := f3d.colorwave1(0,1,0.5);
        b.Canvas.Pen.Color := rgb(0,0,0);//f3d.colorwave(0.5 + obji / (objcount + 1),0.25,0.5);

        pos := f3d.Vec3D(offset.X-width/2,offset.Y - length/2 ,offset.Z);
        ltime_ := 1.5 * 0.6*pi*self.AnimationTime;

        k := widthsegs;
        if k < 1 then k := 1;
        ll := Lengthsegs;
        if ll < 1 then ll := 1;
        k_1 := k + 1;
        ll_1 := ll + 1;
        for i := 0 to k do    {Canvase Sphere}
        begin
            for l := 0 to ll do
            begin
                //sincos(i*pi/k,sin_1,cos_1);
                //sincos((i+1)*pi/k,sin_2,cos_2);
                sin_1 := ltime_ + 3*-pi*i/k_1;
                sin_2 := ltime_ + 3*pi*l/ll_1;
                cos_1 := ltime_ + 3*-pi*(i+1)/k_1;
                cos_2 := ltime_ + 3*pi*(l+1)/ll_1;
                p1 := f3d.Vec3D(i/k_1 * width  + pos.X ,
                                l/ll_1 * Length + pos.Y ,
                                sin(sin_1) * cos(sin_2) * Height + pos.Z);
                //sincos((i+1)*pi/k,sin_2,cos_2);
                p2 := f3d.Vec3D((i+1)/k_1  * width  + pos.X ,
                                l/ll_1 * Length + pos.Y ,
                                sin(cos_1) * cos(sin_2) * Height + pos.Z);
                //sincos((l-1)*pi/ll,sin_1,cos_1);
                p3 := f3d.Vec3D((i+1)/k_1  * width  + pos.X ,
                                (l+1)/ll_1 * Length + pos.Y ,
                                sin(cos_1) * cos(cos_2) * Height + pos.Z);
                //sincos(i*pi/k,sin_2,cos_2);
                p4 := f3d.Vec3D(i/k_1  * width  + pos.X ,
                                (l+1)/ll_1 * Length + pos.Y ,
                                sin(sin_1) * cos(cos_2) * Height + pos.Z);
                {______________}      {Shader}
                p1 := f3d.VConvert(p1,f3d.TransWith(p1,matr_),p1.X/width + 0.5 + 5);
                p2 := f3d.VConvert(p2,f3d.TransWith(p2,matr_),p2.X/width + 0.5 + 5);
                p3 := f3d.VConvert(p3,f3d.TransWith(p3,matr_),p3.X/width + 0.5 + 5);
                p4 := f3d.VConvert(p4,f3d.TransWith(p4,matr_),p4.X/width + 0.5 + 5);
                {______________}

                lv3_00 := f3d.VSub(p2,p1);
                lv3_01 := f3d.VSub(p2,p3);
                cross_ := f3d.Cross(lv3_00,lv3_01);

                if f3d.Leng(cross_) < 0.0000000001 then
                begin
                    lv3_00 := f3d.VSub(p2,p4);
                    cross_ := f3d.Cross(lv3_00,lv3_01);
                end;

                lv3_00 := f3d.Norm(f3d.VSub(invm.Row4,p2));
                ift := ((f3d.Dot(cross_,lv3_00) < 0)                    and
                        (f3d.Dot(f3d.VSub(p1,invm.Row4),invm.Row3) < 0) and
                        (f3d.Dot(f3d.VSub(p2,invm.Row4),invm.Row3) < 0) and
                        (f3d.Dot(f3d.VSub(p3,invm.Row4),invm.Row3) < 0) and
                        (f3d.Dot(f3d.VSub(p4,invm.Row4),invm.Row3) < 0)) ;
                if ift then
                begin
                    cross_ := f3d.Norm(cross_);
                    if self.LightFromViewPos then
                        lv3_00 := f3d.Norm(f3d.VSub(invm.Row4,p2))
                    else
                        lv3_00 := f3d.Norm(f3d.VSub(self.GlobalLightPos,p2));
                    multicolor_0 := -f3d.Dot(cross_,lv3_00);
                    cross_ := f3d.VSub(p2,m.Row4);
                    if {(f3d.dot(invm.Row[3],cross_) < 0) and} (multicolor_0 > 0) then
                    begin
                        multicolor_ := 0.5 + 0.5 * sin(multicolor_0 * pi / 2);
                        if self.ViewPortDrawType[2] then
                            multicolor_0 := 1
                        else
                        begin
                            multicolor_0 := 0.5 + 0.5 * -cos(multicolor_0 * pi);//0.5 + 0.5 * sin(multicolor_* pi / 2);
                            multicolor_0 := (1 - 0.8) + 0.8 * sqrt(sqrt(multicolor_0));
                        end;
                        {Color_______________}
                        if self.Maps.Displacement.Width > 1 then
                        begin
                            clr_ := self.Maps.Displacement.Canvas.Pixels[trunc(self.Maps.Displacement.Width * ((k_1 - i) / k_1)) - 1,trunc(self.Maps.Displacement.Height * l / ll_1)];
                            if self.ViewPortDrawType[1] then
                            begin
                                if not self.ViewPortDrawType[2] then
                                    b.Canvas.Brush.Color := f3d.FNRGB.CToWhite(clr_ ,
                                                                               0.75 * power(multicolor_,25))
                                else
                                    b.Canvas.Brush.Color := clr_;
                                if not self.ViewPortDrawType[0] then
                                    b.Canvas.Pen.Color := b.Canvas.Brush.Color
                                else
                                    if not self.ViewPortDrawType[2] then
                                        b.Canvas.Pen.Color := f3d.FNRGB.CToWhite(clr_ ,
                                                                                0.75 * (power(multicolor_,25))* 0.5)
                                    else
                                        b.Canvas.Pen.Color := rgb(0,0,0);//clr_;
                            end
                            else
                            begin
                                if self.ViewPortDrawType[0] then
                                begin
                                    if not self.ViewPortDrawType[2] then
                                        b.Canvas.Pen.Color := f3d.FNRGB.CToWhite(clr_ ,
                                                                                0.75 * power(multicolor_,25) * 0.75)
                                    else
                                        b.Canvas.Pen.Color := clr_;
                                end
                                else
                                begin
                                    b.Canvas.Pen.Color := f3d.FNRGB.CToWhite(clr_,0.75);
                                end;
                            end;
                        end
                        else
                        begin
                            clr_ := f3d.FNRGB.ClWave2(i/k ,
                                                      (f3d.FNRGB.Limit(2-2*l/ll,0,1) * (power(multicolor_,0.125))) ,
                                                      (f3d.FNRGB.Limit(1-2*l/ll,0,1) + 0.75 * power(multicolor_,50)));
                            //clr_ := f3d.FNRGB.CMul(clr_,multicolor_0);
                            if self.ViewPortDrawType[1] then
                            begin
                                if not self.ViewPortDrawType[2] then
                                    b.Canvas.Brush.Color := clr_
                                else
                                    b.Canvas.Brush.Color := f3d.FNRGB.ClWave2(i/k ,
                                                                              2-2*l/ll ,
                                                                              1-2*l/ll);
                                if not self.ViewPortDrawType[0] then
                                    b.Canvas.Pen.Color := b.Canvas.Brush.Color
                                else
                                    if not self.ViewPortDrawType[2] then
                                        b.Canvas.Pen.Color := f3d.FNRGB.Convert(b.Canvas.Brush.Color,rgb(64,64,64),0.60)
                                                              {f3d.FNRGB.CMul(f3d.FNRGB.ClWave2(i/k ,
                                                               (f3d.FNRGB.Limit(2-2*l/ll,0,1) * (power(multicolor_,0.125))) * 0.5 ,
                                                               (f3d.FNRGB.Limit(1-2*l/ll,0,1) + 0.6 * power(multicolor_,50))* 0.5) , multicolor_)}
                                    else
                                        b.Canvas.Pen.Color := rgb(0,0,0);{f3d.FNRGB.ClWave2(i/k ,
                                                                             f3d.FNRGB.Limit(2-2*l/ll,0,1)*0.5 ,
                                                                             f3d.FNRGB.Limit(1-2*l/ll,0,1)*0.5);}
                            end
                            else
                            begin
                                if self.ViewPortDrawType[0] then
                                begin
                                    if not self.ViewPortDrawType[2] then
                                        b.Canvas.Pen.Color := f3d.FNRGB.ClWave2(i/k ,
                                                               (f3d.FNRGB.Limit(2-2*l/ll,0,1) * (power(multicolor_,0.125)))* 0.75 ,
                                                               (f3d.FNRGB.Limit(1-2*l/ll,0,1) + 0.6 * power(multicolor_,50))*0.75)
                                    else
                                        b.Canvas.Pen.Color := f3d.FNRGB.ClWave2(i/k ,
                                                                f3d.FNRGB.Limit(2-2*l/ll,0,1)*0.75 ,
                                                                f3d.FNRGB.Limit(1-2*l/ll,0,1)*0.75);
                                end
                                else
                                begin
                                    b.Canvas.Pen.Color := f3d.FNRGB.ClWave2(i/k,0.5,0.5);
                                end;
                            end;
                        end;
                        if not self.ViewPortDrawType[2] then
                        begin
                            b.Canvas.Brush.Color := f3d.FNRGB.CMul(b.Canvas.Brush.Color,multicolor_0);
                            b.Canvas.Pen.Color := f3d.FNRGB.CMul(b.Canvas.Pen.Color,multicolor_0);
                        end;
                        ar[0] := f3d.V3DToScreen(p1,m,self.FieldOfView,b.Height,bcenter.X,bcenter.Y);
                        ar[1] := f3d.V3DToScreen(p2,m,self.FieldOfView,b.Height,bcenter.X,bcenter.Y);
                        ar[2] := f3d.V3DToScreen(p3,m,self.FieldOfView,b.Height,bcenter.X,bcenter.Y);
                        ar[3] := f3d.V3DToScreen(p4,m,self.FieldOfView,b.Height,bcenter.X,bcenter.Y);
                        if (abs(b.Width  - 2 * ar[0].X) < 1.5 * b.Width)  and
                           (abs(b.Height - 2 * ar[0].Y) < 1.5 * b.Height) and
                           (abs(b.Width  - 2 * ar[1].X) < 1.5 * b.Width)  and
                           (abs(b.Height - 2 * ar[1].Y) < 1.5 * b.Height) and
                           (abs(b.Width  - 2 * ar[2].X) < 1.5 * b.Width)  and
                           (abs(b.Height - 2 * ar[2].Y) < 1.5 * b.Height) and
                           (abs(b.Width  - 2 * ar[3].X) < 1.5 * b.Width)  and
                           (abs(b.Height - 2 * ar[3].Y) < 1.5 * b.Height) then
                        begin
                            if self.ViewPortDrawType[3] then
                            begin
                                b.Canvas.Brush.Color := f3d.FNRGB.Mono(b.Canvas.Brush.Color);
                                b.Canvas.Pen.Color := f3d.FNRGB.Mono(b.Canvas.Pen.Color);
                            end;
                            if self.ViewPortDrawType[1] then
                            begin
                                b.Canvas.Polygon(ar);
                            end
                            else
                            begin
                                b.Canvas.Polyline(ar);
                            end;
                        end;
                    end;
                end;
                {______________}
            end;
        end;
    end;
end;

procedure TForm1.DrawSphereOnBitmap(B:tBitmap;const M,InvM:TMatrix3D;Offset:TVec3D;Width,Length,height:extended;WidthSegs,LengthSegs:Integer);
var
    ift:boolean;
    ar:array of tpoint;
    i,j,k,l,ll,k_1,ll_1,obji : integer;
    bcenter:tpoint;
    Pos,p1,p2,p3,p4,lv3_00,lv3_01,cross_:TVec3D;
    ex1,ex2,sin_1,sin_2,sin_3,sin_4,cos_1,cos_2,cos_3,cos_4,multicolor_,multicolor_0,radiu,ltime_:extended;
    clr_:tcolor;
    matr_: TMatrix3D;
    xRot,yRot,zRot: extended;
begin
    xrot := DegToRad(EditFloat_RotX.Value);//self.UpDown_Rotx.Position);
    yrot := DegToRad(EditFloat_RotY.Value);//self.UpDown_Roty.Position);
    zrot := DegToRad(EditFloat_RotZ.Value);//self.UpDown_Rotz.Position);
    //matr_ := f3d.Rot(f3d.Matrix3D(1,0,0,0,1,0,0,0,1,0,0,0),0*xrot,0*yrot,0*zrot,false);
    matr_ := self.OBJ1Trans;//f3d.Matrix3D(1,0,0,0,1,0,0,0,1,0,0,0);
    //matr_ := f3d.Rot(matr_,xrot,yrot,zrot,false,true);
    bcenter := point(b.Width div 2,b.Height div 2);
    setlength(ar,4);
    height := height * (0.75 + 0.25 * cos(2 * self.AnimationTime));
    //for obji := 2 to objcount +1 do
    begin
        b.Canvas.Brush.Color := f3d.colorwave1(0,1,0.5);
        b.Canvas.Pen.Color := rgb(0,0,0);//f3d.colorwave(0.5 + obji / (objcount + 1),0.25,0.5);

        pos := f3d.Vec3D(offset.X-width/2,offset.Y - length/2 ,offset.Z);
        ltime_ := 1.5 * 0.6*pi*self.AnimationTime;

        k := widthsegs;
        if k < 1 then k := 1;
        ll := Lengthsegs;
        if ll < 1 then ll := 1;
        k_1 := k + 1;
        ll_1 := ll + 1;
        for i := 0 to k do    {Canvase Sphere}
        begin
            for l := 0 to ll do
            begin
                sincos(ltime_ + l * pi/ll_1,sin_1,cos_1);
                sincos(ltime_ + i * 2 * pi / k_1,sin_2,cos_2);
                sincos(ltime_ + (l + 1) * pi/ll_1,sin_3,cos_3);
                sincos(ltime_ + (i + 1) * 2 * pi / k_1,sin_4,cos_4);
                //sin_1 := abs(sin_1);
                //sin_3 := abs(sin_3);
                ex1 := sin(l * pi / ll_1);
                ex2 := sin((l + 1) * pi / ll_1);
                {sin_1 := ltime_ + 3*-pi*i/k;
                sin_2 := ltime_ + 3*pi*l/ll;
                cos_1 := ltime_ + 3*-pi*(i+1)/k;
                cos_2 := ltime_ + 3*pi*(l+1)/ll;}
                p1 := f3d.Vec3D(({i/k  * }width) * cos_2 * ex2,
                                ({l/ll * }Length) * sin_2 * ex2,
                                ({sin(sin_1) * cos(sin_2) * Height + pos.Z +} Height) * cos_3);
                p2 := f3d.Vec3D(({(i+1)/k  * }width) * cos_4 * ex2,
                                ({l/ll * }Length) * sin_4 * ex2,
                                ({sin(cos_1) * cos(sin_2) * Height + pos.Z +} Height) * cos_3);
                p3 := f3d.Vec3D(({(i+1)/k  * }width) * cos_4 * ex1,
                                ({(l+1)/ll * }Length) * sin_4 * ex1,
                                ({sin(cos_1) * cos(cos_2) * Height + pos.Z +} Height) * cos_1);
                p4 := f3d.Vec3D(({i/k  * }width) * cos_2 * ex1,
                                ({(l+1)/ll * }Length) * sin_2 * ex1,
                                ({sin(sin_1) * cos(cos_2) * Height + pos.Z +}Height) * cos_1);
                {______________}      {Shader}
                p1 := {f3d.VConvert(p1,}f3d.TransWith(p1,matr_);//,p1.X/width + 0.5 + 5);
                p2 := {f3d.VConvert(p2,}f3d.TransWith(p2,matr_);//,p2.X/width + 0.5 + 5);
                p3 := {f3d.VConvert(p3,}f3d.TransWith(p3,matr_);//,p3.X/width + 0.5 + 5);
                p4 := {f3d.VConvert(p4,}f3d.TransWith(p4,matr_);//,p4.X/width + 0.5 + 5);
                {______________}

                lv3_00 := f3d.VSub(p2,p1);
                lv3_01 := f3d.VSub(p2,p3);
                cross_ := f3d.Cross(lv3_00,lv3_01);

                if f3d.Leng(cross_) < 0.0000000001 then
                begin
                    lv3_00 := f3d.VSub(p2,p4);
                    cross_ := f3d.Cross(lv3_00,lv3_01);
                end;

                lv3_00 := f3d.Norm(f3d.VSub(invm.Row4,p2));
                ift := ((f3d.Dot(cross_,lv3_00) < 0)                    and
                        (f3d.Dot(f3d.VSub(p1,invm.Row4),invm.Row3) < 0) and
                        (f3d.Dot(f3d.VSub(p2,invm.Row4),invm.Row3) < 0) and
                        (f3d.Dot(f3d.VSub(p3,invm.Row4),invm.Row3) < 0) and
                        (f3d.Dot(f3d.VSub(p4,invm.Row4),invm.Row3) < 0)) ;
                if ift then
                begin
                    cross_ := f3d.Norm(cross_);
                    if self.LightFromViewPos then
                        lv3_00 := f3d.Norm(f3d.VSub(invm.Row4,p2))
                    else
                        lv3_00 := f3d.Norm(f3d.VSub(self.GlobalLightPos,p2));
                    multicolor_0 := -f3d.Dot(cross_,lv3_00);
                    cross_ := f3d.VSub(p2,m.Row4);
                    if {(f3d.dot(invm.Row[3],cross_) < 0) and} (multicolor_0 > 0) then
                    begin
                        multicolor_ := 0.5 + 0.5 * sin(multicolor_0 * pi / 2);
                        if self.ViewPortDrawType[2] then
                            multicolor_0 := 1
                        else
                        begin
                            multicolor_0 := 0.5 + 0.5 * -cos(multicolor_0 * pi);//0.5 + 0.5 * sin(multicolor_* pi / 2);
                            multicolor_0 := (1 - 0.8) + 0.8 * sqrt(sqrt(multicolor_0));
                        end;
                        {Color_______________}
                        if self.Maps.Displacement.Width > 1 then
                        begin
                            clr_ := self.Maps.Displacement.Canvas.Pixels[trunc(self.Maps.Displacement.Width * i / k_1),trunc(self.Maps.Displacement.Height * l / ll_1)];
                            if self.ViewPortDrawType[1] then
                            begin
                                if not self.ViewPortDrawType[2] then
                                    b.Canvas.Brush.Color := f3d.FNRGB.CToWhite(clr_ ,
                                                                               0.75 * power(multicolor_,25))
                                else
                                    b.Canvas.Brush.Color := clr_;
                                if not self.ViewPortDrawType[0] then
                                    b.Canvas.Pen.Color := b.Canvas.Brush.Color
                                else
                                    if not self.ViewPortDrawType[2] then
                                        b.Canvas.Pen.Color := f3d.FNRGB.CToWhite(clr_ ,
                                                                                0.75 * (power(multicolor_,25))* 0.5)
                                    else
                                        b.Canvas.Pen.Color := rgb(0,0,0);//clr_;
                            end
                            else
                            begin
                                if self.ViewPortDrawType[0] then
                                begin
                                    if not self.ViewPortDrawType[2] then
                                        b.Canvas.Pen.Color := f3d.FNRGB.CToWhite(clr_ ,
                                                                                0.75 * power(multicolor_,25) * 0.75)
                                    else
                                        b.Canvas.Pen.Color := clr_;
                                end
                                else
                                begin
                                    b.Canvas.Pen.Color := f3d.FNRGB.CToWhite(clr_,0.75);
                                end;
                            end;
                        end
                        else
                        begin
                            clr_ := f3d.FNRGB.ClWave2(i/k ,
                                                      (f3d.FNRGB.Limit(2-2*l/ll,0,1) * (power(multicolor_,0.125))) ,
                                                      (f3d.FNRGB.Limit(1-2*l/ll,0,1) + 0.75 * power(multicolor_,50)));
                            //clr_ := f3d.FNRGB.CMul(clr_,multicolor_0);
                            if self.ViewPortDrawType[1] then
                            begin
                                if not self.ViewPortDrawType[2] then
                                    b.Canvas.Brush.Color := clr_
                                else
                                    b.Canvas.Brush.Color := f3d.FNRGB.ClWave2(i/k ,
                                                                              2-2*l/ll ,
                                                                              1-2*l/ll);
                                if not self.ViewPortDrawType[0] then
                                    b.Canvas.Pen.Color := b.Canvas.Brush.Color
                                else
                                    if not self.ViewPortDrawType[2] then
                                        b.Canvas.Pen.Color := f3d.FNRGB.Convert(b.Canvas.Brush.Color,rgb(64,64,64),0.60)
                                                              {f3d.FNRGB.CMul(f3d.FNRGB.ClWave2(i/k ,
                                                               (f3d.FNRGB.Limit(2-2*l/ll,0,1) * (power(multicolor_,0.125))) * 0.5 ,
                                                               (f3d.FNRGB.Limit(1-2*l/ll,0,1) + 0.6 * power(multicolor_,50))* 0.5) , multicolor_)}
                                    else
                                        b.Canvas.Pen.Color := rgb(0,0,0);{f3d.FNRGB.ClWave2(i/k ,
                                                                             f3d.FNRGB.Limit(2-2*l/ll,0,1)*0.5 ,
                                                                             f3d.FNRGB.Limit(1-2*l/ll,0,1)*0.5);}
                            end
                            else
                            begin
                                if self.ViewPortDrawType[0] then
                                begin
                                    if not self.ViewPortDrawType[2] then
                                        b.Canvas.Pen.Color := f3d.FNRGB.ClWave2(i/k ,
                                                               (f3d.FNRGB.Limit(2-2*l/ll,0,1) * (power(multicolor_,0.125)))* 0.75 ,
                                                               (f3d.FNRGB.Limit(1-2*l/ll,0,1) + 0.6 * power(multicolor_,50))*0.75)
                                    else
                                        b.Canvas.Pen.Color := f3d.FNRGB.ClWave2(i/k ,
                                                                f3d.FNRGB.Limit(2-2*l/ll,0,1)*0.75 ,
                                                                f3d.FNRGB.Limit(1-2*l/ll,0,1)*0.75);
                                end
                                else
                                begin
                                    b.Canvas.Pen.Color := f3d.FNRGB.ClWave2(i/k,0.5,0.5);
                                end;
                            end;
                        end;
                        if not self.ViewPortDrawType[2] then
                        begin
                            b.Canvas.Brush.Color := f3d.FNRGB.CMul(b.Canvas.Brush.Color,multicolor_0);
                            b.Canvas.Pen.Color := f3d.FNRGB.CMul(b.Canvas.Pen.Color,multicolor_0);
                        end;
                        ar[0] := f3d.V3DToScreen(p1,m,self.FieldOfView,b.Height,bcenter.X,bcenter.Y);
                        ar[1] := f3d.V3DToScreen(p2,m,self.FieldOfView,b.Height,bcenter.X,bcenter.Y);
                        ar[2] := f3d.V3DToScreen(p3,m,self.FieldOfView,b.Height,bcenter.X,bcenter.Y);
                        ar[3] := f3d.V3DToScreen(p4,m,self.FieldOfView,b.Height,bcenter.X,bcenter.Y);
                        if (abs(b.Width  - 2 * ar[0].X) < 1.5 * b.Width)  and
                           (abs(b.Height - 2 * ar[0].Y) < 1.5 * b.Height) and
                           (abs(b.Width  - 2 * ar[1].X) < 1.5 * b.Width)  and
                           (abs(b.Height - 2 * ar[1].Y) < 1.5 * b.Height) and
                           (abs(b.Width  - 2 * ar[2].X) < 1.5 * b.Width)  and
                           (abs(b.Height - 2 * ar[2].Y) < 1.5 * b.Height) and
                           (abs(b.Width  - 2 * ar[3].X) < 1.5 * b.Width)  and
                           (abs(b.Height - 2 * ar[3].Y) < 1.5 * b.Height) then
                        begin
                            if self.ViewPortDrawType[3] then
                            begin
                                b.Canvas.Brush.Color := f3d.FNRGB.Mono(b.Canvas.Brush.Color);
                                b.Canvas.Pen.Color := f3d.FNRGB.Mono(b.Canvas.Pen.Color);
                            end;
                            if self.ViewPortDrawType[1] then
                            begin
                                b.Canvas.Polygon(ar);
                            end
                            else
                            begin
                                b.Canvas.Polyline(ar);
                            end;
                        end;
                    end;
                end;
                {______________}
            end;
        end;
    end;
end;

procedure TForm1.DrawDisplacementOnBitmap(B:tBitmap;const M,InvM:TMatrix3D;Offset:TVec3D;Width,Length,height:extended;WidthSegs,LengthSegs:Integer);
var
    ift:boolean;
    ar:array of tpoint;
    i,j,k,l,ll,obji : integer;
    bcenter:tpoint;
    clr:tcolor;
    Pos,p1,p2,p3,p4,lv3_00,lv3_01,cross_:TVec3D;
    matr_ : TMatrix3D;
    sin_1,sin_2,cos_1,cos_2,multicolor_,radiu,ltime_,lheight:extended;
    k_1,ll_1 : integer;
    multicolor_0:extended;
    clr_:tcolor;
    xRot,yRot,zRot: extended;
begin
    bcenter := point(b.Width div 2,b.Height div 2);
    setlength(ar,4);
    height := height * cos(2 * self.AnimationTime);
    //for obji := 2 to objcount +1 do
    begin
        b.Canvas.Brush.Color := f3d.colorwave1(0,1,0.5);
        b.Canvas.Pen.Color := rgb(0,0,0);//f3d.colorwave(0.5 + obji / (objcount + 1),0.25,0.5);

        matr_ := self.OBJ1Trans;

        pos := f3d.Vec3D(offset.X-width/2,offset.Y - length/2 ,offset.Z);
        ltime_ := self.AnimationTime;
        lheight := height / 765;
        k := widthsegs;
        if k < 1 then k := 1;
        ll := Lengthsegs;
        if ll < 1 then ll := 1;
        k_1 := k + 1;
        ll_1 := ll + 1;

        clr := self.Maps.Displacement.Canvas.Pixels[0,0];
        sin_1 := lheight * (getrvalue(clr) + getgvalue(clr) + getbvalue(clr));
        cos_1 := sin_1;

        sin_1 := 0;
        cos_1 := 0;
        sin_2 := 0;
        cos_2 := 0;

        for i := 0 to k do    {Canvase Sphere}
        begin
            for l := 0 to ll do
            begin
                clr := self.Maps.Displacement.Canvas.Pixels[trunc(self.Maps.Displacement.Width * (1-i / k_1)),trunc(self.Maps.Displacement.Height * l / ll_1)];
                sin_1 := lheight * (getrvalue(clr) + getgvalue(clr) + getbvalue(clr));
                clr := self.Maps.Displacement.Canvas.Pixels[trunc(self.Maps.Displacement.Width * (1-(i+1) / k_1)),trunc(self.Maps.Displacement.Height * l / ll_1)];
                cos_1 := lheight * (getrvalue(clr) + getgvalue(clr) + getbvalue(clr));
                clr := self.Maps.Displacement.Canvas.Pixels[trunc(self.Maps.Displacement.Width * (1-(i+1) / k_1)),trunc(self.Maps.Displacement.Height * (l+1) / ll_1)];
                sin_2 := lheight * (getrvalue(clr) + getgvalue(clr) + getbvalue(clr));
                clr := self.Maps.Displacement.Canvas.Pixels[trunc(self.Maps.Displacement.Width * (1-i / k_1)),trunc(self.Maps.Displacement.Height * (l+1) / ll_1)];
                cos_2 := lheight * (getrvalue(clr) + getgvalue(clr) + getbvalue(clr));
                //sincos(i*pi/k,sin_1,cos_1);
                //sincos((i+1)*pi/k,sin_2,cos_2);
                {sin_1 := ltime_ + 3*-pi*i/k;
                sin_2 := ltime_ + 3*pi*l/ll;
                cos_1 := ltime_ + 3*-pi*(i+1)/k;
                cos_2 := ltime_ + 3*pi*(l+1)/ll;}

                p1 := f3d.Vec3D(i/k_1  * width  + pos.X ,
                                l/ll_1 * Length + pos.Y ,
                                sin_1 + pos.Z);
                //sincos((i+1)*pi/k,sin_2,cos_2);
                p2 := f3d.Vec3D((i+1)/k_1  * width  + pos.X ,
                                l/ll_1 * Length + pos.Y ,
                                cos_1 + pos.Z);
                //sincos((l-1)*pi/ll,sin_1,cos_1);
                p3 := f3d.Vec3D((i+1)/k_1  * width  + pos.X ,
                                (l+1)/ll_1 * Length + pos.Y ,
                                sin_2 + pos.Z);
                //sincos(i*pi/k,sin_2,cos_2);
                p4 := f3d.Vec3D(i/k_1  * width  + pos.X ,
                                (l+1)/ll_1 * Length + pos.Y ,
                                cos_2 + pos.Z);
                {______________}      {Shader}
                p1 := f3d.VConvert(p1,f3d.TransWith(p1,matr_),p1.X/width + 0.5 + 5);
                p2 := f3d.VConvert(p2,f3d.TransWith(p2,matr_),p2.X/width + 0.5 + 5);
                p3 := f3d.VConvert(p3,f3d.TransWith(p3,matr_),p3.X/width + 0.5 + 5);
                p4 := f3d.VConvert(p4,f3d.TransWith(p4,matr_),p4.X/width + 0.5 + 5);
                {______________}
                lv3_00 := f3d.VSub(p2,p1);
                lv3_01 := f3d.VSub(p2,p3);
                cross_ := f3d.Cross(lv3_00,lv3_01);

                if f3d.Leng(cross_) < 0.0000000001 then
                begin
                    lv3_00 := f3d.VSub(p2,p4);
                    cross_ := f3d.Cross(lv3_00,lv3_01);
                end;

                lv3_00 := f3d.Norm(f3d.VSub(invm.Row4,p2));
                ift := ((f3d.Dot(cross_,lv3_00) < 0)                    and
                        (f3d.Dot(f3d.VSub(p1,invm.Row4),invm.Row3) < 0) and
                        (f3d.Dot(f3d.VSub(p2,invm.Row4),invm.Row3) < 0) and
                        (f3d.Dot(f3d.VSub(p3,invm.Row4),invm.Row3) < 0) and
                        (f3d.Dot(f3d.VSub(p4,invm.Row4),invm.Row3) < 0)) ;
                if ift then
                begin
                    cross_ := f3d.Norm(cross_);
                    if self.LightFromViewPos then
                        lv3_00 := f3d.Norm(f3d.VSub(invm.Row4,p2))
                    else
                        lv3_00 := f3d.Norm(f3d.VSub(self.GlobalLightPos,p2));
                    multicolor_0 := -f3d.Dot(cross_,lv3_00);
                    cross_ := f3d.VSub(p2,m.Row4);
                    if {(f3d.dot(invm.Row[3],cross_) < 0) and} (multicolor_0 > 0) then
                    begin
                        multicolor_ := 0.5 + 0.5 * sin(multicolor_0 * pi / 2);
                        if self.ViewPortDrawType[2] then
                            multicolor_0 := 1
                        else
                        begin
                            multicolor_0 := 0.5 + 0.5 * -cos(multicolor_0 * pi);//0.5 + 0.5 * sin(multicolor_* pi / 2);
                            multicolor_0 := (1 - 0.8) + 0.8 * sqrt(sqrt(multicolor_0));
                        end;
                        {Color_______________}
                        if self.Maps.Displacement.Width > 1 then
                        begin
                            clr_ := self.Maps.Displacement.Canvas.Pixels[trunc(self.Maps.Displacement.Width * ((k_1 - i) / k_1)) - 1,trunc(self.Maps.Displacement.Height * l / ll_1)];
                            if self.ViewPortDrawType[1] then
                            begin
                                if not self.ViewPortDrawType[2] then
                                    b.Canvas.Brush.Color := f3d.FNRGB.CToWhite(clr_ ,
                                                                               0.75 * power(multicolor_,25))
                                else
                                    b.Canvas.Brush.Color := clr_;
                                if not self.ViewPortDrawType[0] then
                                    b.Canvas.Pen.Color := b.Canvas.Brush.Color
                                else
                                    if not self.ViewPortDrawType[2] then
                                        b.Canvas.Pen.Color := f3d.FNRGB.CToWhite(clr_ ,
                                                                                0.75 * (power(multicolor_,25))* 0.5)
                                    else
                                        b.Canvas.Pen.Color := rgb(0,0,0);//clr_;
                            end
                            else
                            begin
                                if self.ViewPortDrawType[0] then
                                begin
                                    if not self.ViewPortDrawType[2] then
                                        b.Canvas.Pen.Color := f3d.FNRGB.CToWhite(clr_ ,
                                                                                0.75 * power(multicolor_,25) * 0.75)
                                    else
                                        b.Canvas.Pen.Color := clr_;
                                end
                                else
                                begin
                                    b.Canvas.Pen.Color := f3d.FNRGB.CToWhite(clr_,0.75);
                                end;
                            end;
                        end
                        else
                        begin
                            clr_ := f3d.FNRGB.ClWave2(i/k ,
                                                      (f3d.FNRGB.Limit(2-2*l/ll,0,1) * (power(multicolor_,0.125))) ,
                                                      (f3d.FNRGB.Limit(1-2*l/ll,0,1) + 0.75 * power(multicolor_,50)));
                            //clr_ := f3d.FNRGB.CMul(clr_,multicolor_0);
                            if self.ViewPortDrawType[1] then
                            begin
                                if not self.ViewPortDrawType[2] then
                                    b.Canvas.Brush.Color := clr_
                                else
                                    b.Canvas.Brush.Color := f3d.FNRGB.ClWave2(i/k ,
                                                                              2-2*l/ll ,
                                                                              1-2*l/ll);
                                if not self.ViewPortDrawType[0] then
                                    b.Canvas.Pen.Color := b.Canvas.Brush.Color
                                else
                                    if not self.ViewPortDrawType[2] then
                                        b.Canvas.Pen.Color := f3d.FNRGB.Convert(b.Canvas.Brush.Color,rgb(64,64,64),0.60)
                                                              {f3d.FNRGB.CMul(f3d.FNRGB.ClWave2(i/k ,
                                                               (f3d.FNRGB.Limit(2-2*l/ll,0,1) * (power(multicolor_,0.125))) * 0.5 ,
                                                               (f3d.FNRGB.Limit(1-2*l/ll,0,1) + 0.6 * power(multicolor_,50))* 0.5) , multicolor_)}
                                    else
                                        b.Canvas.Pen.Color := rgb(0,0,0);{f3d.FNRGB.ClWave2(i/k ,
                                                                             f3d.FNRGB.Limit(2-2*l/ll,0,1)*0.5 ,
                                                                             f3d.FNRGB.Limit(1-2*l/ll,0,1)*0.5);}
                            end
                            else
                            begin
                                if self.ViewPortDrawType[0] then
                                begin
                                    if not self.ViewPortDrawType[2] then
                                        b.Canvas.Pen.Color := f3d.FNRGB.ClWave2(i/k ,
                                                               (f3d.FNRGB.Limit(2-2*l/ll,0,1) * (power(multicolor_,0.125)))* 0.75 ,
                                                               (f3d.FNRGB.Limit(1-2*l/ll,0,1) + 0.6 * power(multicolor_,50))*0.75)
                                    else
                                        b.Canvas.Pen.Color := f3d.FNRGB.ClWave2(i/k ,
                                                                f3d.FNRGB.Limit(2-2*l/ll,0,1)*0.75 ,
                                                                f3d.FNRGB.Limit(1-2*l/ll,0,1)*0.75);
                                end
                                else
                                begin
                                    b.Canvas.Pen.Color := f3d.FNRGB.ClWave2(i/k,0.5,0.5);
                                end;
                            end;
                        end;
                        if not self.ViewPortDrawType[2] then
                        begin
                            b.Canvas.Brush.Color := f3d.FNRGB.CMul(b.Canvas.Brush.Color,multicolor_0);
                            b.Canvas.Pen.Color := f3d.FNRGB.CMul(b.Canvas.Pen.Color,multicolor_0);
                        end;
                        ar[0] := f3d.V3DToScreen(p1,m,self.FieldOfView,b.Height,bcenter.X,bcenter.Y);
                        ar[1] := f3d.V3DToScreen(p2,m,self.FieldOfView,b.Height,bcenter.X,bcenter.Y);
                        ar[2] := f3d.V3DToScreen(p3,m,self.FieldOfView,b.Height,bcenter.X,bcenter.Y);
                        ar[3] := f3d.V3DToScreen(p4,m,self.FieldOfView,b.Height,bcenter.X,bcenter.Y);
                        if (abs(b.Width  - 2 * ar[0].X) < 1.5 * b.Width)  and
                           (abs(b.Height - 2 * ar[0].Y) < 1.5 * b.Height) and
                           (abs(b.Width  - 2 * ar[1].X) < 1.5 * b.Width)  and
                           (abs(b.Height - 2 * ar[1].Y) < 1.5 * b.Height) and
                           (abs(b.Width  - 2 * ar[2].X) < 1.5 * b.Width)  and
                           (abs(b.Height - 2 * ar[2].Y) < 1.5 * b.Height) and
                           (abs(b.Width  - 2 * ar[3].X) < 1.5 * b.Width)  and
                           (abs(b.Height - 2 * ar[3].Y) < 1.5 * b.Height) then
                        begin
                            if self.ViewPortDrawType[3] then
                            begin
                                b.Canvas.Brush.Color := f3d.FNRGB.Mono(b.Canvas.Brush.Color);
                                b.Canvas.Pen.Color := f3d.FNRGB.Mono(b.Canvas.Pen.Color);
                            end;
                            if self.ViewPortDrawType[1] then
                            begin
                                b.Canvas.Polygon(ar);
                            end
                            else
                            begin
                                b.Canvas.Polyline(ar);
                            end;
                        end;
                    end;
                end;
                {______________}
            end;
        end;
    end;
end;

procedure TForm1.DrawOBJ1Trans(M:TMatrix3D;b:tbitmap;L: extended;clrx,clry,clrz:tcolor);
var
    ar:array of tpoint;
    bcent,ari,arc:tpoint;//arindex,arcenter
    clr: tcolor;
    penwidth,i,Left_,Right_,Top_,Buttom_: integer;
    arv : array of tvec3d;
    radi_:extended;
    {
    function ifNegDot(ar: array of tvec3d;InvM:TMatrix3D):boolean;
    var
        lv3_00,lv3_01,cross_:tvec3d;
    begin
        lv3_00 := f3d.VSub(ar[1],ar[0]);
        lv3_01 := f3d.VSub(ar[1],ar[2]);
        cross_ := f3d.Cross(lv3_00,lv3_01);
        lv3_00 := f3d.Norm(f3d.VSub(invm.Row4,ar[1]));
        result := f3d.Dot(cross_,lv3_00) < 0;
    end;}
    function ifInView(ar:array of tpoint;Left_,Top_,Right_,Buttom_:integer):boolean;
    var
        i: integer;
    begin
        result := true;
        for I := 0 to high(ar) do
        begin
            if not ((ar[i].X <= right_) and
                    (ar[i].X >= left_ ) and
                    (ar[i].Y >= top_  ) and
                    (ar[i].Y <= buttom_)) then
            begin
                result := false;
                exit;
            end;
        end;
    end;
begin
    if self.ViewPortDrawType[3] then
    begin
        clrx := f3d.FNRGB.Mono(clrx);
        clry := f3d.FNRGB.Mono(clry);
        clrz := f3d.FNRGB.Mono(clrz);
    end;
    left_ := -b.Width div 2;
    top_ := -b.Height div 2;
    right_ := b.Width - left_;
    buttom_ := b.Height - top_;
    clr := b.Canvas.Pen.Color;
    penwidth := b.Canvas.Pen.Width;
    b.Canvas.Pen.Width := 3;
    setlength(ar,3);
    setlength(arv,6);
    radi_ := l * 0.125;
    bcent := point(b.Width div 2,b.Height div 2);
    arc := f3d.V3DToScreen(f3d.TransWith(f3d.Vec3D(0,0,0),m),self.ViewTM,self.FieldOfView,b.Height,bcent.X,bcent.y);
    //____________X_Axis
    b.Canvas.Pen.Width := 1;
    arv[0] := f3d.Vec3D(l,radi_,0);
    arv[1] := f3d.Vec3D(l, radi_ * 0.5, radi_ * f3d.FC.SinPi_3);
    arv[2] := f3d.Vec3D(l,-radi_ * 0.5, radi_ * f3d.FC.SinPi_3);
    arv[3] := f3d.Vec3D(l,-radi_,0);
    arv[4] := f3d.Vec3D(l,-radi_ * 0.5,-radi_ * f3d.FC.SinPi_3);
    arv[5] := f3d.Vec3D(l, radi_ * 0.5,-radi_ * f3d.FC.SinPi_3);

    b.Canvas.Pen.Color := clrx;
    b.Canvas.Brush.Color := clrx;
    arv[0] := f3d.TransWith(arv[0],m);
    ar[0] := f3d.V3DToScreen(arv[0],self.ViewTM,self.FieldOfView,b.Height,bcent.X,bcent.y);
    ar[2] := f3d.V3DToScreen(f3d.TransWith(f3d.Vec3D(l*1.75,0,0),m),self.ViewTM,self.FieldOfView,b.Height,bcent.X,bcent.y);
    ari := ar[0];
    for I := 1 to 5 do
    begin
        arv[i] := f3d.TransWith(arv[i],m);
        ar[1] := f3d.V3DToScreen(arv[i],self.ViewTM,self.FieldOfView,b.Height,bcent.X,bcent.y);
        if ifInView(ar,Left_,Top_,Right_,Buttom_) then b.Canvas.Polygon(ar);
        ar[0] := ar[1];
    end;
    ar[1] := ari;
    if ifInView(ar,Left_,Top_,Right_,Buttom_) then b.Canvas.Polygon(ar);
    setlength(ar,2);
    ar[0] := arc;
    ar[1] := f3d.V3DToScreen(f3d.TransWith(f3d.Vec3D(l,0,0),m),self.ViewTM,self.FieldOfView,b.Height,bcent.X,bcent.y);
    b.Canvas.Pen.Width := 3;
    b.Canvas.PolyLine(ar);
    //____________Y_Axis
    b.Canvas.Pen.Width := 1;
    setlength(ar,3);
    arv[0] := f3d.Vec3D(radi_,l,0);
    arv[1] := f3d.Vec3D( radi_ * 0.5,l, radi_ * f3d.FC.SinPi_3);
    arv[2] := f3d.Vec3D(-radi_ * 0.5,l, radi_ * f3d.FC.SinPi_3);
    arv[3] := f3d.Vec3D(-radi_,l,0);
    arv[4] := f3d.Vec3D(-radi_ * 0.5,l,-radi_ * f3d.FC.SinPi_3);
    arv[5] := f3d.Vec3D( radi_ * 0.5,l,-radi_ * f3d.FC.SinPi_3);

    b.Canvas.Pen.Color := clry;
    b.Canvas.Brush.Color := clry;
    arv[0] := f3d.TransWith(arv[0],m);
    ar[0] := f3d.V3DToScreen(arv[0],self.ViewTM,self.FieldOfView,b.Height,bcent.X,bcent.y);
    ar[2] := f3d.V3DToScreen(f3d.TransWith(f3d.Vec3D(0,l*1.75,0),m),self.ViewTM,self.FieldOfView,b.Height,bcent.X,bcent.y);
    ari := ar[0];
    for I := 1 to 5 do
    begin
        arv[i] := f3d.TransWith(arv[i],m);
        ar[1] := f3d.V3DToScreen(arv[i],self.ViewTM,self.FieldOfView,b.Height,bcent.X,bcent.y);
        if ifInView(ar,Left_,Top_,Right_,Buttom_) then b.Canvas.Polygon(ar);
        ar[0] := ar[1];
    end;
    ar[1] := ari;
    if ifInView(ar,Left_,Top_,Right_,Buttom_) then b.Canvas.Polygon(ar);
    setlength(ar,2);
    ar[0] := arc;
    ar[1] := f3d.V3DToScreen(f3d.TransWith(f3d.Vec3D(0,l,0),m),self.ViewTM,self.FieldOfView,b.Height,bcent.X,bcent.y);
    b.Canvas.Pen.Width := 3;
    b.Canvas.PolyLine(ar);
    //____________Z_Axis
    b.Canvas.Pen.Width := 1;
    setlength(ar,3);
    arv[0] := f3d.Vec3D(radi_,0,l);
    arv[1] := f3d.Vec3D( radi_ * 0.5, radi_ * f3d.FC.SinPi_3,l);
    arv[2] := f3d.Vec3D(-radi_ * 0.5, radi_ * f3d.FC.SinPi_3,l);
    arv[3] := f3d.Vec3D(-radi_,0,l);
    arv[4] := f3d.Vec3D(-radi_ * 0.5,-radi_ * f3d.FC.SinPi_3,l);
    arv[5] := f3d.Vec3D( radi_ * 0.5,-radi_ * f3d.FC.SinPi_3,l);

    b.Canvas.Pen.Color := clrz;
    b.Canvas.Brush.Color := clrz;
    arv[0] := f3d.TransWith(arv[0],m);
    ar[0] := f3d.V3DToScreen(arv[0],self.ViewTM,self.FieldOfView,b.Height,bcent.X,bcent.y);
    ar[2] := f3d.V3DToScreen(f3d.TransWith(f3d.Vec3D(0,0,l*1.75),m),self.ViewTM,self.FieldOfView,b.Height,bcent.X,bcent.y);
    ari := ar[0];
    for I := 1 to 5 do
    begin
        arv[i] := f3d.TransWith(arv[i],m);
        ar[1] := f3d.V3DToScreen(arv[i],self.ViewTM,self.FieldOfView,b.Height,bcent.X,bcent.y);
        if ifInView(ar,Left_,Top_,Right_,Buttom_) then b.Canvas.Polygon(ar);
        ar[0] := ar[1];
    end;
    ar[1] := ari;
    if ifInView(ar,Left_,Top_,Right_,Buttom_) then b.Canvas.Polygon(ar);
    setlength(ar,2);
    ar[0] := arc;
    ar[1] := f3d.V3DToScreen(f3d.TransWith(f3d.Vec3D(0,0,l),m),self.ViewTM,self.FieldOfView,b.Height,bcent.X,bcent.y);
    b.Canvas.Pen.Width := 3;
    b.Canvas.PolyLine(ar);
    //______________
    b.Canvas.Pen.Color := clr;
    b.Canvas.Pen.Width := penwidth;
end;



procedure TForm1.DrawViewport(m:TMatrix3D);
var
    b: tbitmap;
    offset:tVec3D;
    multicolor_,xx,yy,zz : extended;
  I: Integer;
begin
    //self.ViewTM.Row[3] := f3d.MultiplyVec(5,self.ViewTM.Row[3]);
    self.InvViewTM := f3d.Inverse(self.ViewTM);
    b := self.ViewPortDib;
    //b := tbitmap.Create;
    b.Width := self.ImageViewPort.ClientWidth;
    b.Height := self.ImageViewPort.ClientHeight;
    b.Canvas.Brush.Color := self.BackgroundColor;
    if (self.FastDrawonChange1.Checked) then
    begin
        if not (self.MouseDown[1] or self.MouseDown[2] or self.MouseDown[3]) then
            b.Canvas.Rectangle(0,0,b.Width,b.Height)
        else
            b.Canvas.Draw(0,0,self.ViewPortDibHis);
    end
    else
        b.Canvas.Rectangle(0,0,b.Width,b.Height);
    b.Canvas.Pen.Width := 0;
    if self.ViewPortDrawType[4] then
        self.DrawGridOnBitmap(b,M,self.InvViewTM,rgb(100,100,100),10,5);

    offset := f3d.Vec3D(0,0,0);

    //self.DrawSpheresOnBitmap(b,m,offset,7,20,50);
    self.OBJ1Trans := f3d.Rot(f3d.Matrix3D(1),DegToRad(EditFloat_RotX.Value) ,//self.UpDown_RotX.Position) ,
                                              DegToRad(EditFloat_RotY.Value) ,//self.UpDown_RotY.Position) ,
                                              DegToRad(EditFloat_RotZ.Value){self.UpDown_RotZ.Position)} ,false,true);
    f3d.SetLeng(self.OBJ1Trans.Row1,self.EditFloat_ScaleX.Value / 100);
    f3d.SetLeng(self.OBJ1Trans.Row2,self.EditFloat_ScaleY.Value / 100);
    f3d.SetLeng(self.OBJ1Trans.Row3,self.EditFloat_ScaleZ.Value / 100);
    self.OBJ1Trans.Row4 := f3d.Vec3D(self.EditFloat_PosX.Value ,
                                     self.EditFloat_PosY.Value ,
                                     self.EditFloat_PosZ.Value);

    self.ViewTMCenter := self.OBJ1Trans.Row4;


    case RadioGroup1.ItemIndex of
        0 : if (self.MouseDown[1] or self.MouseDown[2] or self.MouseDown[3]) and (self.FastDrawonChange1.Checked) then
            self.DrawPlaneOnBitmap(b,M,InvViewTM,offset,100,100,12,10,10)//self.DrawDisplacementOnBitmap(b,self.ViewTM,offset,xx,yy,zz,10,10)
        else
            self.DrawPlaneOnBitmap(b,M,InvViewTM,offset,100,100,12,self.UpDown1.Position,self.UpDown1.Position);//self.DrawDisplacementOnBitmap(b,self.ViewTM,offset,xx,yy,zz,trunc(xx / 2.5),trunc(yy / 2.5));
        1 : if (self.MouseDown[1] or self.MouseDown[2] or self.MouseDown[3]) and (self.FastDrawonChange1.Checked) then
            self.DrawSphereOnBitmap(b,M,InvViewTM,offset,50,50,50,10,10)//self.DrawDisplacementOnBitmap(b,self.ViewTM,offset,xx,yy,zz,10,10)
        else
            self.DrawSphereOnBitmap(b,M,InvViewTM,offset,50,50,50,self.UpDown1.Position,self.UpDown1.Position);//self.DrawDisplacementOnBitmap(b,self.ViewTM,offset,xx,yy,zz,trunc(xx / 2.5),trunc(yy / 2.5));
        2 : if (self.MouseDown[1] or self.MouseDown[2] or self.MouseDown[3]) and (self.FastDrawonChange1.Checked) then
                self.DrawDisplacementOnBitmap(b,M,InvViewTM,offset,100,100,5,10,10)
            else
                self.DrawDisplacementOnBitmap(b,M,InvViewTM,offset,100,100,5,self.UpDown1.Position,self.UpDown1.Position);
    end;
    //DrawFace(f3d.Vec3D(0,0,0),f3d.Vec3D(100,100,100),f3d.Vec3D(100,-100,0),b,M,InvViewTM,clred);
    //end;

    {self.OBJ1Trans := f3d.MMul(f3d.Matrix3D(-0.408111,-0.891282,-0.197641,0.665327,-0.438611,0.604119,-0.625128,0.115052,0.771996,-7.17824,-72.3777,46.9477) ,
                               f3d.Matrix3D(0.493717,0.86332,0.104509,-0.643226,0.443414,-0.624215,-0.585238,0.240963,0.774231,81.2058,44.6602,39.7702));}
    if self.ViewPortDrawType[5] then
    begin
        self.DrawOBJ1Trans(f3d.Inverse(self.OBJ1Trans),b,25 ,
            RGB(200,100,100) ,
            RGB(100,200,100) ,
            RGB(100,100,200));
        self.DrawOBJ1Trans(self.OBJ1Trans,b,25,
            RGB(255,0,0) ,
            RGB(0,255,0) ,
            RGB(0,0,255));
    end;
    //______________________________
    b.Canvas.Brush.Color := self.BackgroundColor;
    b.Canvas.Font := self.Font;
    b.Canvas.Font.Size := 8;
    b.Canvas.Brush.Style := bsClear;
    //b.Canvas.Font.Style := [fsBold];
    //b.Canvas.Font.Color := F3D.FNRGB.Norm(F3D.FNRGB.CAdd(SELF.BackgroundColor,RGB(128,128,128)));
    B.Canvas.Font.Color := $00ffffff xor self.BackgroundColor;//rgb(200,200,200);
    b.Canvas.TextOut(10,10,'Perspective');
    b.Canvas.Font.Color := f3d.FNRGB.Convert($00ffffff xor self.BackgroundColor{rgb(200,200,200)},self.BackgroundColor,1-abs(cos(self.AnimationTime*0.5)));
    b.Canvas.TextOut(b.Width - 95,trunc((0.5+0.5 * -cos(self.AnimationTime))*b.Height/3 + 10),'MHD_3D_1388');
    b.Canvas.Font.Color := $00ffffff xor self.BackgroundColor;//rgb(200,200,200);
    if self.MouseDown[3] and self.shiftdown then
    begin
        b.Canvas.Font.Color := rgb(255,255,100);
        self.DrawFOV(b,self.ViewTM,self.FieldOfView,rgb(255,255,0));
    end;
    b.Canvas.TextOut(10,b.Height - 80,'Field Of View : ' + floattostr(CDegRad * self.FieldOfView));
    b.Canvas.Font.Color := $00ffffff xor self.BackgroundColor;//rgb(200,200,200);
    b.Canvas.TextOut(10,b.Height - 60,'Play Speed : ' + floattostr(self.AnimationPlaySpeed));
    b.Canvas.TextOut(10,b.Height - 20,'Inverse_View_TM : ' + f3d.AsStr(self.InvViewTM,1));
    if self.Timer1.Enabled then
    begin
        b.Canvas.Pen.Color := rgb(0,255,0);
        b.Canvas.Font.Color := rgb(0,255,0);
    end
    else
    begin
        b.Canvas.Pen.Color := rgb(200,200,100);
    end;
    b.Canvas.TextOut(10,b.Height - 40,'Animation Time : ' + floattostr(self.AnimationTime));
    b.Canvas.Brush.Style := bsSolid;
    //b.Canvas.Brush.Color := b.Canvas.Brush.Color + $ff000000;
    //______________________________
    b.Canvas.Pen.Width := 7;
    b.Canvas.Polyline([point(0,0),point(b.Width,0),point(b.Width,b.Height),point(0,b.Height),point(0,0)]);
    self.ImageViewPort.Canvas.Draw(0,0,b,255 - self.TrackBar1.Position);
    //self.ImageViewPort.Update;
    if not (self.MouseDown[1] or self.MouseDown[2] or self.MouseDown[3]) then
    begin
        self.ViewPortDibHis.Width := self.ViewPortDib.Width;
        self.ViewPortDibHis.Height := self.ViewPortDib.Height;
        self.ViewPortDibHis.Canvas.Draw(0,0,self.ViewPortDib);
    end;
    //self.Update;
end;

procedure tform1.DrawIfNotPlaying;
begin
    if not self.Timer1.Enabled then self.DrawViewport(self.ViewTM);
end;

procedure TForm1.NewOnChangeFloat(Sender : TObject;NewVal:extended);
begin
    Self.DrawViewport(self.ViewTM);
    self.Update;
end;

procedure TForm1.Edit1Enter(Sender: TObject);
begin
    if not self.Timer1.Enabled then
        self.DrawViewport(self.ViewTM);
end;

procedure TForm1.FormCreate(Sender: TObject);
const
    xext:extended = 0.70710678118654752440;
var
   p1,p2,p3:tvec3d;
   s:string;
   m:tmatrix3d;
  I,j,k,l : Integer;
  edf_:teditfloat;
begin
    sw_FPU := System.Get8087CW;
    EditFloat_PosX := TEditFloat.Create(self);
    EditFloat_PosY := TEditFloat.Create(self);
    EditFloat_PosZ := TEditFloat.Create(self);
    EditFloat_RotX := TEditFloat.Create(self);
    EditFloat_RotY := TEditFloat.Create(self);
    EditFloat_RotZ := TEditFloat.Create(self);
    EditFloat_ScaleX := TEditFloat.Create(self);
    EditFloat_ScaleY := TEditFloat.Create(self);
    EditFloat_ScaleZ := TEditFloat.Create(self);

    EditFloat_PosX.Parent := self;
    EditFloat_PosY.Parent := self;
    EditFloat_PosZ.Parent := self;
    EditFloat_RotX.Parent := self;
    EditFloat_RotY.Parent := self;
    EditFloat_RotZ.Parent := self;
    EditFloat_ScaleX.Parent := self;
    EditFloat_ScaleY.Parent := self;
    EditFloat_ScaleZ.Parent := self;

    EditFloat_ScaleX.Value := 100.0;
    EditFloat_ScaleY.Value := 100.0;
    EditFloat_ScaleZ.Value := 100.0;

    l := GroupBox1.Height div 3 - 15;
    j := -l;
    k := 1;
    for I := self.ControlCount - 1 downto 0 do
    begin
        if Controls[i] is TEditFloat then
        begin
            if (j = l * 2) then
            begin
                j := 0;
                k := k + 1;
            end
            else
                j := j + l;
            edf_ := Controls[i] as TEditFloat;
            edf_.Color := $00ffffff;
            case k of
                1 : edf_.Parent := self.GroupBox3;
                2 : edf_.Parent := self.GroupBox2;
                3 : edf_.Parent := self.GroupBox1;
            end;
            edf_.Cursor := crVSplit;
            edf_.Font.Style := [fsBold];
            edf_.OnChangedVal := Self.NewOnChangeFloat;
            edf_.Width := (edf_.Parent as TGroupBox).Width - 10;
            edf_.Height := l;//(edf_.Parent as TGroupBox).Height div 3 - 10;
            edf_.Pos := point(2,(edf_.Parent as TGroupBox).Height - j - l - 15 - 10 * (j div l));//point(2,60 - j);
        end;
    end;

    self.Form_About_3D_Viewport := tForm_About_3D_Viewport.Create(self.Form_About_3D_Viewport);
    self.FormViewport := tform.Create(self);
    self.FormViewport.BorderStyle := bsSizeToolWin;
    self.FormViewport.Caption := 'Viewport';
    self.FormViewport.Parent := self;
    self.PanelViewPort.Parent := self.FormViewport;
    self.FormViewport.Icon := self.Icon;
    self.FormViewport.BorderIcons := [{biSystemMenu,}biMinimize,biMaximize];
    self.FormViewport.Show;
    self.FormViewport.Width := 600;
    self.FormViewport.Height := 350;
    self.FormViewport.Left := 500;
    self.FormViewport.OnConstrainedResize := self.OnConstrainedResize;
    //self.ImageViewPort.Cursor := crNone;
    AnimationTime := 0;
    AnimationPlaySpeed := 1;
    ctrldown := false;
    altdown := false;
    shiftdown := false;
    self.FieldOfView := 1;
    setlength(self.ViewPortDrawType,5);
    self.ViewPortDrawType[0] := true;
    self.ViewPortDrawType[1] := true;
    self.ViewPortDrawType[2] := false;
    self.ViewPortDrawType[3] := false;
    self.ViewPortDrawType[4] := true;
    self.ViewPortDrawType[5] := true;
    self.ViewChange := false;
    self.f3d := tfnMath3d.Create(0.1,1000);
    self.BackgroundColor := $00161616;//rgb(50,50,50);
    self.PanelBackColor.Color := self.BackgroundColor;
    self.GlobalLightPos := f3d.Vec3D(130,200,300);
    self.LightFromViewPos := true;

    self.ViewPortDib := tbitmap.Create;
    self.ViewPortDib.Width := self.ClientWidth;
    self.ViewPortDib.Height := self.ClientHeight;
    self.ViewPortDibHis := tbitmap.Create;
    self.ViewPortDibHis.Width := self.ClientWidth;
    self.ViewPortDibHis.Height := self.ClientHeight;


    self.Maps := tmaps.Create;

    self.MouseDown[1] := false;
    self.MouseDown[2] := false;
    self.MouseDown[3] := false;
    self.ViewTMCenter := f3d.Vec3D(0,0,0);
    self.viewTM := f3d.Matrix3D(1,0.00001,0.00001,0.00001,xext,xext,0.00001,-xext,xext,0.00001,-100,100);
    self.OBJ1Trans := f3d.Matrix3D(1,0,0,0,1,0,0,0,1,0,0,0);
    {
    self.ViewTM.Row[1] := p1;
    self.ViewTM.Row[2] := p2;
    self.ViewTM.Row[3] := p3;
    self.ViewTM.Row[4] := p1;
    }
    //showmessage(m.AsStr(3))
    //self.ViewTMCenter.X := -50;
    //self.ViewTMCenter.Y := -50;
    self.ResetTM;
end;

procedure TForm1.DrawFace(v1,v2,v3 : TVec3D;B:TBitmap;const M,InvM : TMatrix3D;Color_ : TColor);
var
    lv3_00,lv3_01,cross_ : TVec3D;
    ift : boolean;
    multicolor_0,multicolor_ : extended;
    clr_ : TColor;
    bcenter : TPoint;
    ar:array[0..2] of tpoint;
begin
    bcenter := point(b.Width div 2,b.Height div 2);
    lv3_00 := f3d.VSub(v2,v1);
    lv3_01 := f3d.VSub(v2,v3);
    cross_ := f3d.Cross(lv3_00,lv3_01);
    lv3_00 := f3d.Norm(f3d.VSub(invm.Row4,v2));
    ift := ((f3d.Dot(cross_,lv3_00) < 0)                    and
            (f3d.Dot(f3d.VSub(v1,invm.Row4),invm.Row3) < 0) and
            (f3d.Dot(f3d.VSub(v2,invm.Row4),invm.Row3) < 0) and
            (f3d.Dot(f3d.VSub(v3,invm.Row4),invm.Row3) < 0)) ;
    if ift then
    begin
        cross_ := f3d.Norm(cross_);
        if self.LightFromViewPos then
            lv3_00 := f3d.Norm(f3d.VSub(invm.Row4,v2))
        else
            lv3_00 := f3d.Norm(f3d.VSub(self.GlobalLightPos,v2));
        multicolor_0 := -f3d.Dot(cross_,lv3_00);
        cross_ := f3d.VSub(v2,InvM.Row4);
        if {(f3d.dot(invm.Row[3],cross_) < 0) and} (multicolor_0 > 0) then
        begin
            multicolor_ := 0.5 + 0.5 * sin(multicolor_0 * pi / 2);
            if self.ViewPortDrawType[2] then
                multicolor_0 := 1
            else
            begin
                multicolor_0 := 0.5 + 0.5 * -cos(multicolor_0 * pi);//0.5 + 0.5 * sin(multicolor_* pi / 2);
                multicolor_0 := (1 - 0.8) + 0.8 * sqrt(sqrt(multicolor_0));
            end;
            {Color_______________}
            begin
                clr_ := color_;
                if self.ViewPortDrawType[1] then
                begin
                    if not self.ViewPortDrawType[2] then
                        b.Canvas.Brush.Color := f3d.FNRGB.CToWhite(clr_ ,
                                                            0.75 * power(multicolor_,25))
                    else
                        b.Canvas.Brush.Color := clr_;
                    if not self.ViewPortDrawType[0] then
                        b.Canvas.Pen.Color := b.Canvas.Brush.Color
                    else
                        if not self.ViewPortDrawType[2] then
                            b.Canvas.Pen.Color := f3d.FNRGB.CToWhite(clr_ ,
                                                                0.75 * (power(multicolor_,25))* 0.5)
                        else
                            b.Canvas.Pen.Color := rgb(0,0,0);//clr_;
                end
                else
                begin
                    if self.ViewPortDrawType[0] then
                    begin
                        if not self.ViewPortDrawType[2] then
                            b.Canvas.Pen.Color := f3d.FNRGB.CToWhite(clr_ ,
                                                                        0.75 * power(multicolor_,25) * 0.75)
                        else
                            b.Canvas.Pen.Color := clr_;
                    end
                    else
                    begin
                        b.Canvas.Pen.Color := f3d.FNRGB.CToWhite(clr_,0.75);
                    end;
                end;
            end;
            if not self.ViewPortDrawType[2] then
            begin
                b.Canvas.Brush.Color := f3d.FNRGB.CMul(b.Canvas.Brush.Color,multicolor_0);
                b.Canvas.Pen.Color := f3d.FNRGB.CMul(b.Canvas.Pen.Color,multicolor_0);
            end;
            ar[0] := f3d.V3DToScreen(v1,M,self.FieldOfView,b.Height,bcenter.X,bcenter.Y);
            ar[1] := f3d.V3DToScreen(v2,M,self.FieldOfView,b.Height,bcenter.X,bcenter.Y);
            ar[2] := f3d.V3DToScreen(v3,M,self.FieldOfView,b.Height,bcenter.X,bcenter.Y);
            if (abs(b.Width  - 2 * ar[0].X) < 1.5 * b.Width)  and
               (abs(b.Height - 2 * ar[0].Y) < 1.5 * b.Height) and
               (abs(b.Width  - 2 * ar[1].X) < 1.5 * b.Width)  and
               (abs(b.Height - 2 * ar[1].Y) < 1.5 * b.Height) and
               (abs(b.Width  - 2 * ar[2].X) < 1.5 * b.Width)  and
               (abs(b.Height - 2 * ar[2].Y) < 1.5 * b.Height) then
            begin
                if self.ViewPortDrawType[3] then
                begin
                    b.Canvas.Brush.Color := f3d.FNRGB.Mono(b.Canvas.Brush.Color);
                    b.Canvas.Pen.Color := f3d.FNRGB.Mono(b.Canvas.Pen.Color);
                end;
                if self.ViewPortDrawType[1] then
                begin
                    b.Canvas.Polygon(ar);
                end
                else
                begin
                    b.Canvas.Polyline(ar);
                end;
            end;
        end;
    end;
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if button = mbleft then
    begin
        self.ViewMDownpos[1] := point(x,y);
        self.MouseDown[1] := true;
    end;
    if button = mbmiddle then
    begin
        self.ViewMDownpos[2] := point(x,y);
        self.MouseDown[2] := true;
    end;
    if button = mbright then
    begin
        self.ViewMDownpos[3] := point(x,y);
        self.MouseDown[3] := true;
        self.ZoomVector := f3d.Vec3D(-(X - self.ImageViewPort.ClientWidth * 0.5) / (self.ImageViewPort.ClientHeight / 2) ,
                                    (y - self.ImageViewPort.ClientHeight * 0.5) / (self.ImageViewPort.ClientHeight / 2)  ,
                                      cot(self.FieldOfView / 2));
        self.ZoomVector := f3d.Norm(self.ZoomVector);
        self.ZoomVector := f3d.VMul(self.ZoomVector,self.InvViewTM,true);
    end;
    self.ViewMDownpos[1] := point(x,y);
    self.ViewMDownpos[2] := point(x,y);
    self.ViewMDownpos[3] := point(x,y);
    self.ViewChange := true;
    self.ViewTMHis := self.ViewTM;
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    //self.ViewChange := false;
    if button = mbleft then self.MouseDown[1] := false;
    if button = mbmiddle then self.MouseDown[2] := false;
    if button = mbright then self.MouseDown[3] := false;
    self.ViewChange := self.MouseDown[1] or self.MouseDown[2] or self.MouseDown[3];
    if not self.Timer1.Enabled then self.DrawViewport(self.ViewTM);
    {
    self.ViewPortDibHis.Width := self.ViewPortDib.Width;
    self.ViewPortDibHis.Height := self.ViewPortDib.Height;
    self.ViewPortDibHis.Canvas.Draw(0,0,self.ViewPortDib);
    }
end;

procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
    self.InvViewTM := f3d.MovZ(InvViewTM,-WheelDelta / 10);
    ViewTM := f3d.Inverse(InvViewTM);
    if Self.Play1.Enabled then
        self.DrawViewport(ViewTM);
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
    p1,p2,lv3_00,lv3_01:tvec3d;
    xx,yy,zz:extended;
    m,lm : tmatrix3d;
    icin: TIconInfo;
    bitm_: tbitmap;
begin
    {
    bitm_ := tbitmap.Create;
    bitm_.Width := self.Icon.Width;
    bitm_.Height := self.Icon.Height;
    bitm_.Canvas.Draw(0,0,self.Icon);
    icin.hbmMask := bitm_.Handle;
    icin.hbmColor := bitm_.Handle;
    Screen.Cursors[100] := CreateIconIndirect(icin);
    Screen.Cursor := 100;
    }
    self.FocusControl(self.Parent);
    if self.ViewChange then
    begin
        self.ViewTM := f3d.Inverse(self.ViewTM);
        self.ViewTMHis := f3d.Inverse(self.ViewTMHis);
        m := self.ViewTMHis;
        if self.MouseDown[2] or (self.MouseDown[1] and (self.ctrldown or self.shiftdown)) then
        begin
            lv3_00 := f3d.VSub(m.Row4,self.ViewTMCenter);
            m.Row4 := lv3_00;
            xx := (self.ViewMDownpos[1].X - x) *4*pi / self.ImageViewPort.ClientHeight;
            yy := (self.ViewMDownpos[1].Y - y) *4*pi / self.ImageViewPort.ClientHeight;
            if self.shiftdown then
            begin
                {
                zz := 0;
                if (x - (self.ImageViewPort.ClientWidth div 2) > 0) then
                    zz := -yy
                else
                    zz := yy;
                if (y - (self.ImageViewPort.ClientHeight div 2) > 0) then
                    zz := zz + xx
                else
                    zz := zz - xx;
                m := f3d.PreRotZ(m,zz / 2,self.altdown);
                }
                {lv3_00 := f3d.Vec3D(x - self.ImageViewPort.ClientWidth/2.0,y - self.ImageViewPort.ClientHeight / 2.0,0.0);
                lv3_01 := f3d.Vec3D(self.ViewMDownpos[1].X - self.ImageViewPort.ClientWidth/2.0 ,
                                    self.ViewMDownpos[1].Y - self.ImageViewPort.ClientHeight / 2.0,0.0);
                zz := f3d.Dot(f3d.Norm(lv3_00),f3d.Norm(lv3_01));
                zz := arccos(zz);}

                zz := arctan2(Y - self.ImageViewPort.ClientHeight / 2.0 , X - self.ImageViewPort.ClientWidth/2.0) -
                      arctan2(self.ViewMDownpos[1].Y - self.ImageViewPort.ClientHeight / 2.0 , self.ViewMDownpos[1].X - self.ImageViewPort.ClientWidth/2.0);

                m := f3d.PreRotZ(m,zz,self.altdown);
            end
            else
            begin
                m := f3d.PreRotX(m,yy,not self.altdown);
                m := f3d.RotZ(m,xx,not self.altdown);
                {IF self.altdown THEN
                    M := F3D.PreRotY(M,XX,FALSE)
                ELSE
                    m := f3d.RotZ(m,xx,TRUE);}
            end;
            m.Row4 := f3d.VAdd(m.Row4,self.ViewTMCenter);
        end;
        p2 := f3d.VSub(self.ViewTMCenter,self.ViewTM.Row4);
        zz := -f3d.Dot(f3d.VSub(self.ViewTMCenter,self.ViewTM.Row4),self.ViewTM.Row3) * (f3d.FC.Pi) / (1.5 * self.ImageViewPort.ClientHeight);
        //if (zz < 1) then zz := 1;
        if self.MouseDown[1] and not (self.ctrldown or self.shiftdown) then//(self.MouseDown[2] or ((self.MouseDown[1] xor self.ctrldown) xor self.shiftdown)) then
        begin
            xx := (self.ViewMDownpos[1].X - x);
            yy := (y - self.ViewMDownpos[1].Y);
            p1 := f3d.VMul(tan(self.FieldOfView / 2) *xx*zz,f3d.Norm(self.ViewTM.Row1));
            p2 := f3d.VMul(tan(self.FieldOfView / 2) *yy*zz,f3d.Norm(self.ViewTM.Row2));
            m.Row4 := f3d.VAdd(m.Row4,p1);
            m.Row4 := f3d.VAdd(m.Row4,p2);
        end;
        if (self.MouseDown[3]) then
        begin
            yy := (y - self.ViewMDownpos[3].Y) / 5;
            xx := (-x + self.ViewMDownpos[3].x) / 5;
            if self.shiftdown then
            begin
                self.FieldOfView := 2 * arctan(tan(self.FieldOfView / 2) + (xx+yy) / (25 / self.FieldOfView));
                if self.FieldOfView > CPi then self.FieldOfView := CPi;
                if self.FieldOfView <= 0.01 then self.FieldOfView := 0.01;
                {
                p1 := f3d.MultiplyVec(yy*zz / 25,f3d.Normalize(self.ViewTM.ZVec));
                M.Row[4] := f3d.AddVec(M.Row[4],p1);
                p1.Free;
                }
            end
            else
            begin
                p1 := f3d.VMul(self.ZoomVector,yy*zz*20);
                {if f3d.Dist(m.Row4,self.ViewTMCenter) < 0.5 then
                    if yy < 0 then
                        p1 := f3d.VNeg(m.Row3)
                    else
                        p1 := m.Row3
                else
                begin
                    lv3_00 := f3d.Norm(f3d.VSub(m.Row4,self.ViewTMCenter));
                    p1 := f3d.VMul(}{20 / (tan(self.FieldOfView / 2) + 2) * }{20 * yy*zz,lv3_00);
                end;}
                M.Row4 := f3d.VAdd(M.Row4,p1);
            end;
        end;
        self.ViewTM := f3d.Inverse(m);
        if (self.MouseDown[1] or self.MouseDown[2] or self.MouseDown[3]) xor self.Timer1.Enabled then
        begin
            self.DrawViewport(self.ViewTM);
        end;
        self.ViewTMHis := self.ViewTM;
        self.ViewMDownpos[1] := point(x,y);
        self.ViewMDownpos[2] := point(x,y);
        self.ViewMDownpos[3] := point(x,y);
    end;
    //else
    //    self.ImageViewPort.Canvas.Draw(0,0,self.ViewPortDib);
    //self.ImageViewPort.Canvas.Draw(x - self.Icon.Width div 2,y - self.Icon.Height div 2,self.Icon);
    self.ImageViewPort.Update;
end;

procedure TForm1.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
    self.DrawViewport(self.ViewTM);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
    self.DrawViewport(self.ViewTM);
end;

procedure TForm1.FormConstrainedResize(Sender: TObject; var MinWidth,
  MinHeight, MaxWidth, MaxHeight: Integer);
begin
    if not self.Timer1.Enabled then
        self.DrawViewport(self.ViewTM);
    self.Update;
end;

procedure tform1.ResetTM;
const
    jazr1_3 = 0.5773502691896257645091487805019574556;
var
    lv3_00:tvec3d;
  I: Integer;
begin
    self.FieldOfView := CPi_4;
    lv3_00 := f3d.VMul(f3d.Vec3D(100,100,85),1.125);
    self.ViewTM.Row1 := f3d.Vec3D(-sqrt(0.5),sqrt(0.5),0);
    self.ViewTM.Row3 := f3d.Vec3D(jazr1_3,jazr1_3,jazr1_3);
    self.ViewTM.Row4 := f3d.VAdd(lv3_00,self.ViewTMCenter);
    self.ViewTM.Row2 := f3d.Cross(self.ViewTM.Row3,self.ViewTM.Row1);
    //self.ViewTM.Row3 := f3d.VMul(5,self.ViewTM.Row3);
    self.ViewTM := f3d.Inverse(self.ViewTM);
    for I := 0 to 3 do
        self.DrawViewport(self.ViewTM);
end;

procedure TForm1.ResetTM1Click(Sender: TObject);
begin
    resettm;
end;

procedure TForm1.ViewPortRedraw1Click(Sender: TObject);
begin
    self.DrawViewport(self.ViewTM);
end;

procedure TForm1.WireFrame1Click(Sender: TObject);
begin
    self.ViewPortDrawType[0] := self.WireFrame1.Checked;
    self.DrawViewport(self.ViewTM);
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    case key of
        vk_control :    self.ctrldown := true;
        vk_shift   :    self.shiftdown := true;
        vk_menu    :    self.altdown := true;
        vk_SPACE   :    begin
                            self.Play1.Enabled := self.Timer1.Enabled;
                            self.Pause1.Enabled := not self.Timer1.Enabled;
                            self.PlayStartTime := self.TimeToExtended(now);
                            self.Timer1.Enabled := not self.Timer1.Enabled;
                        end;
        vk_prior   :    if self.shiftdown then self.AnimationPlaySpeed := 2 * self.AnimationPlaySpeed else self.AnimationPlaySpeed := self.AnimationPlaySpeed + 0.05;
        vk_next    :    if self.shiftdown then self.AnimationPlaySpeed := self.AnimationPlaySpeed / 2 else self.AnimationPlaySpeed := self.AnimationPlaySpeed - 0.05;
        vk_add     :    self.InvViewTM.Row4 := f3d.VSub(self.InvViewTM.Row4,f3d.VMul( 1,self.InvViewTM.Row3));
        vk_subtract:    self.InvViewTM.Row4 := f3d.VAdd(self.InvViewTM.Row4,f3d.VMul( 1,self.InvViewTM.Row3));
        vk_up      :    self.InvViewTM.Row4 := f3d.VAdd(self.InvViewTM.Row4,f3d.VMul(-1,self.InvViewTM.Row2));
        vk_down    :    self.InvViewTM.Row4 := f3d.VSub(self.InvViewTM.Row4,f3d.VMul(-1,self.InvViewTM.Row2));
        vk_right   :    self.InvViewTM.Row4 := f3d.VAdd(self.InvViewTM.Row4,f3d.VMul(-1,self.InvViewTM.Row1));
        vk_left    :    self.InvViewTM.Row4 := f3d.VSub(self.InvViewTM.Row4,f3d.VMul(-1,self.InvViewTM.Row1));

        vk_numpad4 :    begin
                            self.ViewTMHis := self.InvViewTM;
                            self.ViewTMHis.Row4 := f3d.VSub(self.InvViewTM.Row4,self.ViewTMCenter);
                            self.InvViewTM := f3d.RotZ(self.ViewTMhis,pi/80,not self.altdown);
                            self.InvViewTM.Row4 := f3d.VAdd(self.InvViewTM.Row4,self.ViewTMCenter);
                        end;
        vk_numpad6 :    begin
                            self.ViewTMHis := self.InvViewTM;
                            self.ViewTMHis.Row4 := f3d.VSub(self.InvViewTM.Row4,self.ViewTMCenter);
                            self.InvViewTM := f3d.RotZ(self.ViewTMhis,-pi/80,not self.altdown);
                            self.InvViewTM.Row4 := f3d.VAdd(self.InvViewTM.Row4,self.ViewTMCenter);
                        end;
        vk_numpad8 :    begin
                            self.ViewTMHis := self.InvViewTM;
                            self.ViewTMHis.Row4 := f3d.VSub(self.InvViewTM.Row4,self.ViewTMCenter);
                            self.InvViewTM := f3d.PreRotX(self.ViewTMhis,pi/80,not self.altdown);
                            self.InvViewTM.Row4 := f3d.VAdd(self.InvViewTM.Row4,self.ViewTMCenter);
                        end;
        vk_numpad2 :    begin
                            self.ViewTMHis := self.InvViewTM;
                            self.ViewTMHis.Row4 := f3d.VSub(self.InvViewTM.Row4,self.ViewTMCenter);
                            self.InvViewTM := f3d.PreRotX(self.ViewTMhis,-pi/80,not self.altdown);
                            self.InvViewTM.Row4 := f3d.VAdd(self.InvViewTM.Row4,self.ViewTMCenter);
                        end;

    end;
    self.ViewTM := f3d.Inverse(self.InvViewTM);
    if (self.AnimationPlaySpeed > 10000000000000000.0) then
        self.AnimationPlaySpeed := 10000000000000000.0
    else
    begin
        if (self.AnimationPlaySpeed < -10000000000000000.0) then
            self.AnimationPlaySpeed := -10000000000000000.0;
    end;
    if not (self.Timer1.Enabled or self.MouseDown[1] or self.MouseDown[2] or self.MouseDown[3]) then self.DrawViewport(self.ViewTM);
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    case key of
        vk_control : self.ctrldown := false;
        vk_shift   : self.shiftdown := false;
        vk_menu    : self.altdown := false;
    end;
end;

procedure TForm1.Polygon1Click(Sender: TObject);
begin
    self.ViewPortDrawType[1] := self.Polygon1.Checked;
    self.DrawViewport(self.ViewTM);
    //self.Flat1.Enabled := self.Polygon1.Checked;
    //self.WireFrame1.Enabled := self.Polygon1.Checked;
end;

procedure TForm1.Flat1Click(Sender: TObject);
begin
    self.ViewPortDrawType[2] := self.Flat1.Checked;
    self.DrawViewport(self.ViewTM);
end;

procedure TForm1.Play1Click(Sender: TObject);
begin
    self.Timer1.Enabled := true;
    self.PlayStartTime := self.TimeToExtended(now);
    self.Play1.Enabled := false;
    self.pause1.Enabled := true;
end;

procedure TForm1.Pause1Click(Sender: TObject);
begin
    self.Timer1.Enabled := false;
    self.DrawViewport(self.ViewTM);
    self.Play1.Enabled := true;
    self.pause1.Enabled := false;
end;

procedure TForm1.Show1Click(Sender: TObject);
begin
    if (sender as TMenuItem).Checked then
        Self.FormViewport.Show
    else
        self.FormViewport.Close;
end;

procedure TForm1.Splitter1Moved(Sender: TObject);
begin
    self.DrawViewport(self.ViewTM);
end;

procedure TForm1.Splitter2Moved(Sender: TObject);
begin
    self.DrawViewport(self.ViewTM);
end;

procedure TForm1.Stop1Click(Sender: TObject);
begin
    self.Timer1.Enabled := false;
    self.AnimationTime := 0;
    self.DrawViewport(self.ViewTM);
    self.Play1.Enabled := true;
    self.pause1.Enabled := false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
    //self.AnimationTime := self.AnimationTime + AnimationPlaySpeed * self.Timer1.Interval / 1000;
    self.AnimationTime := self.AnimationTime + (self.TimeToExtended(now) - self.PlayStartTime) * AnimationPlaySpeed;
    self.PlayStartTime := self.TimeToExtended(now);
    self.DrawViewport(self.ViewTM);
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
    if (self.Maps.Displacement.Width = 0) and ((sender as TRadioGroup).ItemIndex = 2) then
        Button1.OnClick(Button1);
    if not self.Timer1.Enabled then self.DrawViewport(self.ViewTM);
end;

procedure TForm1.ResetPlaySpeed1Click(Sender: TObject);
begin
    self.AnimationPlaySpeed := 1;
    if not self.Enabled then self.DrawViewport(self.ViewTM);
end;

procedure TForm1.PanelBackColorClick(Sender: TObject);
begin
    self.ColorDialog1.Color := self.BackgroundColor;
    if self.ColorDialog1.Execute then
        self.BackgroundColor := self.ColorDialog1.Color;
    self.DrawViewport(self.ViewTM);
    self.PanelBackColor.Color := self.BackgroundColor;
    PanelBackColor.Font.Color := $00ffffff xor PanelBackColor.Color;
end;

procedure TForm1.PanelViewPortResize(Sender: TObject);
begin
    self.ImageViewPort.Picture.Bitmap.Width := self.PanelViewPort.ClientWidth;
    self.ImageViewPort.Picture.Bitmap.Height := self.PanelViewPort.ClientHeight;
end;

procedure TForm1.UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
begin
    if not self.Timer1.Enabled then self.DrawViewport(self.ViewTM);if not self.Timer1.Enabled then self.DrawViewport(self.ViewTM);
end;

procedure TForm1.UpDown_RotXClick(Sender: TObject; Button: TUDBtnType);
begin
    if not self.Timer1.Enabled then self.DrawViewport(self.ViewTM);
end;

procedure TForm1.UseGlobalLighttoshading1Click(Sender: TObject);
begin
    self.LightFromViewPos := not self.UseGlobalLighttoshading1.Checked;
    self.DrawViewport(self.ViewTM);
end;

procedure TForm1.NotColorClick(Sender: TObject);
begin
    self.ViewPortDrawType[3] := self.NotColor.Checked;
    self.DrawViewport(self.ViewTM);
end;

procedure TForm1.DrawGrid1Click(Sender: TObject);
begin
    self.ViewPortDrawType[4] := self.DrawGrid1.Checked;
    self.DrawViewport(self.ViewTM);
end;

procedure TForm1.DrawObjectTransform1Click(Sender: TObject);
begin
    self.ViewPortDrawType[5] := self.DrawObjectTransform1.Checked;
    self.DrawViewport(self.ViewTM);
end;

procedure TForm1.About1Click(Sender: TObject);
begin
    Form_About_3D_Viewport.ShowModal;
end;

const FNT_BMP = 0;
const FNT_JPG = 1;
const FNT_JPEG = 2;
const FNT_ICO = 3;
const FNT_UNKNOW = 4;

function FileNameType(s_:string):integer;
var
        i: integer;
begin
        i := length(s_);
        while i > 0 do
        begin
            if (s_[i] = '.') then Break;
            i := i - 1;
        end;
        Delete(s_,1,i);
        s_ := UpperCase(s_);
        if (s_ = 'BMP') then
            result := FNT_BMP
        else
            if (s_ = 'JPG') then
                result := FNT_JPG
            else
                if (s_ = 'JPEG') then
                    result := FNT_JPEG
                else
                    if (s_ = 'ICO') then
                        result := FNT_ICO
                    else
                        result := FNT_UNKNOW;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
    imjpg : TJPEGImage;
    imico: TIcon;
    //b : TBitmap;
begin
    {b := TBitmap.Create;
    b.SetSize(self.Width,self.Height);
    self.PaintTo(b.Canvas,0,0);
    b.SaveToFile('d:\test.bmp');}
    if self.OpenPictureDialog1.Execute then
    begin
        case (FileNameType(OpenPictureDialog1.FileName)) of
            FNT_BMP : begin
                            self.Maps.Displacement.LoadFromFile(OpenPictureDialog1.FileName);
                            //self.Maps.Displacement.Canvas.StretchDraw(rect(0,0,self.Maps.Displacement.Width,self.Maps.Displacement.Height),im.Picture.Bitmap);
                        end;
            FNT_JPG {or FNT_JPEG} : begin
                            imjpg := TJPEGImage.Create;
                            imjpg.LoadFromFile(OpenPictureDialog1.FileName);
                            self.Maps.Displacement.SetSize(imjpg.Width,imjpg.Height);
                            self.Maps.Displacement.Canvas.Draw(0,0,imjpg);
                            imjpg.Free;
                        end;
            FNT_ICO : begin
                            imico := TIcon.Create;
                            imico.LoadFromFile(OpenPictureDialog1.FileName);
                            self.Maps.Displacement.SetSize(imico.Width,imico.Height);
                            self.Maps.Displacement.Canvas.Draw(0,0,imico);
                            imico.Free;
                        end;
        end;
    end;
    self.DrawViewport(self.ViewTM);
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
    if ((sender as TCheckBox).Checked = true) then
        System.Set8087CW($0020)
    else
        System.Set8087CW(sw_FPU);
    if not self.Timer1.Enabled then
        self.DrawViewport(self.ViewTM);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
    self.FocusControl(self.Parent);
    self.DrawViewport(self.ViewTM);
end;

end.
