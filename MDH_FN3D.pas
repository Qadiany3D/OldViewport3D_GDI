{*************************}
{ Besmelaherrahmanerrahym }
{     MDH_Functions_3D    }
{    Mohammad_Ghadiyany   }
{          _1388_         }
{*************************}

unit MDH_FN3D;

interface

uses
    Windows, Messages, SysUtils, math, Graphics, Types, DateUtils;

const
    C2Pi         = 6.283185307179586476925286766559005768394338798750211641948;
    CPi          = 3.141592653589793238462643383279502884197169399375105820974;
    CPi_2        = 1.570796326794896619231321691639751442;
    CPi_3        = 1.047197551196597746154214461093167628;
    CPi_4        = 0.785398163397448309615660845819875721;
    CPi_6        = 0.523598775598298873077107230546583814;
    CDegRad      = 57.2957795130823208767981548141051703324054724;
    CRadDeg      = 0.0174532925199432957692369076848861271344287;
    C1_Pi        = 0.318309886183790671537767526745028724;
    CJazr2       = 1.4142135623730950488016887242096980785;
    C1_Jazr2     = 0.7071067811865475244008443621048490392;
    CSinPi_3     = 0.8660254037844386467637231707529361834;
    CJazr3       = 1.732050807568877293527446341505872366942805253810380628;
    C_Jazr3      = 0.577350269189625764509148780501957455647601751270126876;
    Ce           = 2.718281828459045235360287471352662497757247093699959574966;

type
    TFC = record
      const
        Pi2         = 6.283185307179586476925286766559005768394338798750211641948;
        Pi          = 3.141592653589793238462643383279502884197169399375105820974;
        Pi_2        = 1.570796326794896619231321691639751442;
        Pi_3        = 1.047197551196597746154214461093167628;
        Pi_4        = 0.785398163397448309615660845819875721;
        Pi_6        = 0.523598775598298873077107230546583814;
        DegRad      = 57.2957795130823208767981548141051703324054724;
        RadDeg      = 0.0174532925199432957692369076848861271344287;
        _Pi         = 0.318309886183790671537767526745028724;
        Jazr2       = 1.4142135623730950488016887242096980785;
        _Jazr2      = 0.7071067811865475244008443621048490392;
        SinPi_3     = 0.8660254037844386467637231707529361834;
        Sqrt3       = 1.732050807568877293527446341505872366942805253810380628;
        _Jazr3      = 0.577350269189625764509148780501957455647601751270126876;
        e           = 2.718281828459045235360287471352662497757247093699959574966;
    end;
    TVec2D = packed record
        case integer of
        0: (
            X : extended;
            Y : extended;
            );
        1: (
            _: array [1..2] of extended;
           );
    end;
    TVec3D = packed record
        case integer of
        0: (
            X : extended;
            Y : extended;
            Z : extended;
            );
        1: (
            _: array [1..3] of extended;
           );
    end;
    TVec4D = packed record
        case integer of
        0: (
            X : extended;
            Y : extended;
            Z : extended;
            W : extended;
            );
        1: (
            _: array [1..4] of extended;
           );
    end;
    TRay3D = packed record
        case integer of
        0: (
            Pos : TVec3D;
            Dir : TVec3D;
           );
        1: (
            Row: array [1..2] of TVec3D;
           );
        2: (
            _: array [1..2,1..3] of extended;
           );
        3: (
            _11 , _12 , _13 : extended;
            _21 , _22 , _23 : extended;
           );
    end;
    TMatrix3D = packed record
        case integer of
        0: (
            Row1 : TVec3D;
            Row2 : TVec3D;
            Row3 : TVec3D;
            Row4 : TVec3D;
           );
        1: (
            Row: array [1..4] of TVec3D;
           );
        2: (
            _: array [1..4,1..3] of extended;
           );
        3: (
             _11 , _12 , _13 : extended;
             _21 , _22 , _23 : extended;
             _31 , _32 , _33 : extended;
             _41 , _42 , _43 : extended;
           );
    end;
    TFNRGB = class
    public
        FC : TFC;
        function Limit(const x,a,b:extended):extended;inline;
        function ClWave1(Phase:extended = 0;Black:extended = 0;Mono:extended = 0):tcolor;overload;
        function ClWave2(Phase:extended = 0;Multi:extended = 0;White:extended = 0):tcolor;overload;
        function ClWave1(C:TColor;Black:extended = 0;Mono:extended = 0):tcolor;overload;
        function ClWave2(C:TColor;Multi:extended = 0;White:extended = 0):tcolor;overload;
        function Mono(C:TColor):TColor;
        //function BlackVal(C:TColor):extended;
        function Norm(C:TColor):TColor;
        function CToWhite(C:TColor;L:extended):TColor;
        function Convert(C1,C2:TColor;Amount:extended):TColor;
        function CAvr(C1,C2:TColor):TColor;
        function CAdd(C:TColor;L:integer):TColor;overload;
        function CSub(C:TColor;L:integer):TColor;overload;
        function CMul(C:TColor;L:integer):TColor;overload;
        function CDiv(C:TColor;L:integer):TColor;overload;
        function CAdd(C:TColor;L:extended):TColor;overload;
        function CSub(C:TColor;L:extended):TColor;overload;
        function CMul(C:TColor;L:extended):TColor;overload;
        function CDiv(C:TColor;L:extended):TColor;overload;
        function CNeg(C:TColor):TColor;
        function CToV(C:TColor):TVec3D;
        function VToC(V:TVec3D):TColor;overload;
        function VToC(V:TVec3D;Multi:extended):TColor;overload;
    end;
    TFN3D = class
        FNRGB : TFNRGB;
    private
        MaximumValue : extended;
        MinimumValue : extended;
        procedure SetMaxVal(L:extended);
        procedure SetMinVal(L:extended);
        function GetMaxVal:extended;
        function GetMinVal:extended;
    public

        FC : TFC;
        property MaxVal: extended read GetMaxVal write SetMaxVal;
        property MinVal: extended read GetMinVal write SetMinVal;
        constructor Create(MinValue: extended = 1.1e-30;MaxValue: extended = 1.1e+30);
        function TimeBet(const T1,T2:TDateTime):String;
        function StrFromFloat(const x:extended;const digit:integer):string;
        function Limit(const x,a,b:extended):extended;
        function ColorWave1(Color:extended = 0;White:extended = 0;black:extended = 0):tcolor;
        function ColorWave2(Color:extended = 0;White:extended = 0;black:extended = 0):tcolor;
        function MonoColor(c:TColor):TColor;
        function Vec2D(const X,Y:extended):TVec2D;
        function Vec3D(const X,Y,Z:extended):TVec3D;
        function Vec4D(const X,Y,Z,W:extended):TVec4D;
        function Ray3D(const XPos,YPos,ZPos ,
                       XDir,YDir,ZDir :extended):TRay3D;overload;
        function Ray3D(const Pos,Dir:TVec3D):TRay3D;overload;
        function Matrix3D(const X1,Y1,Z1 ,
                                X2,Y2,Z2 ,
                                X3,Y3,Z3 ,
                                X4,Y4,Z4 : extended;DoNormal: boolean = true):TMatrix3D;overload;
        function Matrix3D(const V1,V2,V3,V4:TVec3D;DoNormal: boolean = true):TMatrix3D;overload;
        function Matrix3D(const L:extended):TMatrix3D;overload;
        function AsStr(const V:TVec2D;const Digit:integer=17):string;overload;
        function AsStr(const V:TVec3D;const Digit:integer=17):string;overload;
        function AsStr(const V:TVec4D;const Digit:integer=17):string;overload;
        function AsStr(const R:TRay3D;const Digit:integer=17):string;overload;
        function AsStr(const M:TMatrix3D;const Digit:integer=17):string;overload;
        function Equal(const X,Y:extended;const Limit:extended=0.000001):boolean;overload;
        function Equal(const V1,V2:TVec2D;const Limit:extended=0.000001):boolean;overload;
        function Equal(const V1,V2:TVec3D;const Limit:extended=0.000001):boolean;overload;
        function Equal(const V1,V2:TVec4D;const Limit:extended=0.000001):boolean;overload;
        function Equal(const R1,R2:TRay3D;const Limit:extended=0.000001):boolean;overload;
        function Equal(const M1,M2:TMatrix3D;const Limit:extended=0.000001):boolean;overload;
        function GetRow(const V:TVec2D;const i:byte):extended;overload;
        function GetRow(const V:TVec3D;const i:byte):extended;overload;
        function GetRow(const V:TVec4D;const i:byte):extended;overload;
        function GetRow(const R:TRay3D;const i:byte):TVec3D;overload;
        function GetRow(const R:TRay3D;const i,j:byte):extended;overload;
        function GetRow(const M:TMatrix3D;const i:byte):TVec3D;overload;
        function GetRow(const M:TMatrix3D;const i,j:byte):extended;overload;
        procedure SetRow(var V:TVec2D;const i:byte; L:extended);overload;
        procedure SetRow(var V:TVec3D;const i:byte; L:extended);overload;
        procedure SetRow(var V:TVec4D;const i:byte; L:extended);overload;
        procedure SetRow(var R:TRay3D;const i:byte; V:TVec3D);overload;
        procedure SetRow(var R:TRay3D;const i,j:byte; L:extended);overload;
        procedure SetRow(var M:TMatrix3D;const i:byte; V:TVec3D);overload;
        procedure SetRow(var M:TMatrix3D;const i,j:byte; L:extended);overload;
        procedure SetRow(var M:TMatrix3D;const i:byte; X,Y,Z:extended);overload;
        function VConvert(const V1,V2:TVec2D;L: extended):TVec2D;overload;
        function VConvert(const V1,V2:TVec3D;L: extended):TVec3D;overload;
        function VConvert(const V1,V2:TVec4D;L: extended):TVec4D;overload;
        function VAdd(const V1,V2:TVec2D):TVec2D;overload;
        function VAdd(const V1,V2:TVec3D):TVec3D;overload;
        function VAdd(const V1,V2:TVec4D):TVec4D;overload;
        function VSum(const AV:array of TVec2D):TVec2D;overload;
        function VSum(const AV:array of TVec3D):TVec3D;overload;
        function VSum(const AV:array of TVec4D):TVec4D;overload;
        function VSub(const V1,V2:TVec2D):TVec2D;overload;
        function VSub(const V1,V2:TVec3D):TVec3D;overload;
        function VSub(const V1,V2:TVec4D):TVec4D;overload;
        function VMul(const V1,V2:TVec2D):TVec2D;overload;
        function VMul(const V1,V2:TVec3D):TVec3D;overload;
        function VMul(const V1,V2:TVec4D):TVec4D;overload;
        function VMul(const L:extended;const V:TVec2D):TVec2D;overload;
        function VMul(const L:extended;const V:TVec3D):TVec3D;overload;
        function VMul(const L:extended;const V:TVec4D):TVec4D;overload;
        function VMul(const V:TVec2D;const L:extended):TVec2D;overload;
        function VMul(const V:TVec3D;const L:extended):TVec3D;overload;
        function VMul(const V:TVec4D;const L:extended):TVec4D;overload;
        function VMul(const V:TVec3D;const M:TMatrix3D):TVec3D;overload;
        function VDiv(const V1,V2:TVec2D):TVec2D;overload;
        function VDiv(const V1,V2:TVec3D):TVec3D;overload;
        function VDiv(const V1,V2:TVec4D):TVec4D;overload;
        function VDiv(const V:TVec2D;L:extended):TVec2D;overload;
        function VDiv(const V:TVec3D;L:extended):TVec3D;overload;
        function VDiv(const V:TVec4D;L:extended):TVec4D;overload;
        function VNeg(const V:TVec2D):TVec2D;overload;
        function VNeg(const V:TVec3D):TVec3D;overload;
        function VNeg(const V:TVec4D):TVec4D;overload;
        function VRev(const V:TVec2D):TVec2D;overload;
        function VRev(const V:TVec3D):TVec3D;overload;
        function VRev(const V:TVec4D):TVec4D;overload;
        function VAbs(const V:TVec2D):TVec2D;overload;
        function VAbs(const V:TVec3D):TVec3D;overload;
        function VAbs(const V:TVec4D):TVec4D;overload;
        function Leng(const V:TVec2D):extended;overload;
        function Leng(const V:TVec3D):extended;overload;
        function Leng(const V:TVec4D):extended;overload;
        function Leng(const x,y:extended):extended;overload;
        function Leng(const x,y,z:extended):extended;overload;
        function Leng(const x,y,z,w:extended):extended;overload;
        function Dist(const V1,V2:TVec2D):extended;overload;
        function Dist(const V1,V2:TVec3D):extended;overload;
        function Dist(const V1,V2:TVec4D):extended;overload;
        function Dist(const M1,M2:TMatrix3D):extended;overload;
        function Norm(const V:TVec2D):TVec2D;overload;
        function Norm(const V:TVec3D):TVec3D;overload;
        function Norm(const V:TVec4D):TVec4D;overload;
        function Norm(const x,y:extended):TVec2D;overload;
        function Norm(const x,y,z:extended):TVec3D;overload;
        function Norm(const x,y,z,w:extended):TVec4D;overload;
        function Norm(const R:TRay3D):TRay3D;overload;
        function Norm(const M:TMatrix3D):TMatrix3D;overload;
        procedure SetLeng(var V:TVec2d;L:extended);overload;
        procedure SetLeng(var V:TVec3d;L:extended);overload;
        procedure SetLeng(var V:TVec4d;L:extended);overload;
        function Dot(const V1,V2:TVec2D):extended;overload;
        function Dot(const V1,V2:TVec3D):extended;overload;
        function Dot(const V1,V2:TVec4D):extended;overload;
        function Cross(const V1,V2:TVec3D):TVec3D;
        function RotX(const M:TMatrix3D;const Angle:extended;const ApplyToRow4:boolean):TMatrix3D;
        function RotY(const M:TMatrix3D;const Angle:extended;const ApplyToRow4:boolean):TMatrix3D;
        function RotZ(const M:TMatrix3D;const Angle:extended;const ApplyToRow4:boolean):TMatrix3D;
        function Rot(const M:TMatrix3D;const X_Angle,Y_Angle,Z_Angle:extended;const ApplyToRow4:boolean = true;const XYZ_Not_ZYX:boolean = true):TMatrix3D;
        function PreRotX(M:TMatrix3D;const Angle:extended;const ApplyToRow4:boolean):TMatrix3D;
        function PreRotY(M:TMatrix3D;const Angle:extended;const ApplyToRow4:boolean):TMatrix3D;
        function PreRotZ(M:TMatrix3D;const Angle:extended;const ApplyToRow4:boolean):TMatrix3D;
        function MAdd(const M1,M2:TMatrix3D):TMatrix3D;
        function MSub(const M1,M2:TMatrix3D):TMatrix3D;
        function MMul(const M1,M2:TMatrix3D):TMatrix3D;overload;
        function MMul(const M1,M2:TMatrix3D;const Row4FromM2:boolean):TMatrix3D;overload;
        function Inverse(const M:TMatrix3D):TMatrix3D;
        function MovD(const M:TMatrix3D;const Dir:TVec3D;const L:extended):TMatrix3D;
        function MovX(const M:TMatrix3D;const L:extended):TMatrix3D;
        function MovY(const M:TMatrix3D;const L:extended):TMatrix3D;
        function MovZ(const M:TMatrix3D;const L:extended):TMatrix3D;
        function TransWith(const M,TransferM:TMatrix3D):TMatrix3D;overload;
        function TransWith(const V:TVec3D;const TransferM:TMatrix3D):TVec3D;overload;
        function V3DToScreen(const V:TVec3D;const M:TMatrix3D;const FOV:extended;const Radius,CenterX,CenterY:integer):tpoint;
        function V3DToScreen2(const V:TVec3D;const M:TMatrix3D;const FOV:extended;const Radius,CenterX,CenterY:integer):tpoint;
    end;


implementation

{_______________________}
{                       }
{   TFNRGB Functions    }
{_______________________}

procedure TFN3D.SetMaxVal(L:extended);
begin
    l := abs(l);
   if (l > 1.1e+4900) then
        l := 1.1e+4900
    else
        if l < 1000 then l := 1000;
    self.MaximumValue := l;
end;

procedure TFN3D.SetMinVal(L:extended);
begin
    l := abs(l);
    if l < 3.4e-4900 then
        l := 3.4e-4900
    else
        if l > 0.01 then l := 0.01;
    self.MinimumValue := l;
end;

function TFN3D.GetMaxVal:extended;
begin
    result := self.maximumvalue;
end;

function TFN3D.GetMinVal:extended;
begin
    result := self.minimumvalue;
end;

constructor TFN3D.Create(MinValue: extended = 1.1e-30;MaxValue: extended = 1.1e+30);
begin
    self.MaxVal := MaxValue;
    self.MinVal := MinValue;
end;

function TFN3D.TimeBet(const T1,T2:TDateTime):String;
var
    x,y,z,w : integer;
begin
    x := HoursBetween(t1,t2);
    y := MinutesBetween(t1,t2) mod 60;
    z := SecondsBetween(t1,t2) mod 60;
    w := MilliSecondsBetween(t1,t2) mod 1000;
    result := inttostr(x) + ' : ' +
              inttostr(y) + ' : ' +
              inttostr(z) + ' : ' +
              inttostr(w);
end;

function TFNRGB.Limit(const x,a,b:extended):extended;
begin
    if a < b then
    begin
         if x < a then result := a
         else
            if x > b then result := b
            else result := x;
    end
    else
    begin
         if x < b then result := b
         else
            if x > a then result := a
            else result := x;
    end;
end;

function TFNRGB.ClWave1(Phase:extended = 0;Black:extended = 0;Mono:extended = 0):tcolor;
{const
    p_6 = 0.523598775598298873077107230546583814;
    p2 = 6.2831853071795864769252867665590057682;
    p_3 = 1.047197551196597746154214461093167628;}
var
    r_,g_,b_,l : extended;
    procedure Limiter(var x:extended);
    begin
        if x > 1 then x := 1;
        if x < 0 then x := 0;
    end;
begin
    Black := 1 - Black;
    l := FC.Pi2 * (1 - phase) - FC.Pi_6;                                      {  2 * pi * (1 - color) - pi/6  }
    r_ := sin(l + 2.094395102393195492308);                           {  sin(l + pi / 1.5)  }
    g_ := sin(l + 4.188790204786390984616);                                    {   sin(2 * pi * (1 - color) - pi/6 + pi / 0.75);   }
    b_ := sin(l);                                                     {   sin(2 * pi * (1 - color) - pi/6 + 0);   }
    r_ := 0.5 + arcsin(r_) / FC.Pi_3;                                                             {3 * arcsin(rr) / pi + 0.5;}
    g_ := 0.5 + arcsin(g_) / FC.Pi_3;
    b_ := 0.5 + arcsin(b_) / FC.Pi_3;
    Limiter(R_);
    Limiter(G_);
    Limiter(B_);
    Limiter(Black);
    Limiter(Mono);
    Black := 255 * Black;
    l := 1 - Mono;

    r_ := Black * (l * r_ + Mono);
    g_ := Black * (l * g_ + Mono);
    b_ := Black * (l * b_ + Mono);
    {
    r_ := (Black * l * r_ + White) * 255;
    g_ := (Black * l * g_ + White) * 255;
    b_ := (Black * l * b_ + White) * 255;
    }
    result := rgb(trunc(r_),trunc(g_),trunc(b_));
end;

function TFNRGB.ClWave2(Phase:extended = 0;Multi:extended = 0;White:extended = 0):tcolor;
var
    r_,g_,b_,l : extended;
    procedure Limiter(var x:extended);
    begin
        if x > 1 then x := 1;
        if x < 0 then x := 0;
    end;
begin
    l := FC.Pi2 * (1 - phase) - FC.Pi_6;                                      {  2 * pi * (1 - color) - pi/6  }
    r_ := sin(l + 2.094395102393195492308);                           {  sin(l + pi / 1.5)  }
    g_ := sin(l + 4.188790204786390984616);                                    {   sin(2 * pi * (1 - color) - pi/6 + pi / 0.75);   }
    b_ := sin(l);                                                     {   sin(2 * pi * (1 - color) - pi/6 + 0);   }
    r_ := 0.5 + arcsin(r_) / FC.Pi_3;                                                             {3 * arcsin(rr) / pi + 0.5;}
    g_ := 0.5 + arcsin(g_) / FC.Pi_3;
    b_ := 0.5 + arcsin(b_) / FC.Pi_3;
    Limiter(R_);
    Limiter(G_);
    Limiter(B_);
    Limiter(Multi);
    Limiter(White);
    l := 1 - White;
    r_ := (Multi * l * r_ + White) * 255;
    g_ := (Multi * l * g_ + White) * 255;
    b_ := (Multi * l * b_ + White) * 255;
    result := rgb(trunc(r_),trunc(g_),trunc(b_));
end;

function TFNRGB.ClWave1(C : TColor;Black:extended = 0;Mono:extended = 0):tcolor;
{const
    p_6 = 0.523598775598298873077107230546583814;
    p2 = 6.2831853071795864769252867665590057682;
    p_3 = 1.047197551196597746154214461093167628;}
var
    r_,g_,b_,l : extended;
    procedure Limiter(var x:extended);
    begin
        if x > 1 then x := 1;
        if x < 0 then x := 0;
    end;
begin
    Black := 1 - Black;
    c := self.Norm(c);
    r_ := getrvalue(c);
    g_ := getgvalue(c);
    b_ := getbvalue(c);
    Limiter(Black);
    Limiter(Mono);
    Black := Black;
    l := 255 * (1 - Mono);
    r_ := Black * (l * r_ + Mono);
    g_ := Black * (l * g_ + Mono);
    b_ := Black * (l * b_ + Mono);
    result := rgb(trunc(r_),trunc(g_),trunc(b_));
end;

function TFNRGB.ClWave2(C : TColor;Multi:extended = 0;White:extended = 0):tcolor;
var
    r_,g_,b_,l : extended;
    procedure Limiter(var x:extended);
    begin
        if x > 1 then x := 1;
        if x < 0 then x := 0;
    end;
begin
    c := self.Norm(c);
    r_ := getrvalue(c);
    g_ := getgvalue(c);
    b_ := getbvalue(c);
    Limiter(Multi);
    Limiter(White);
    white := white * 255;
    l := 1 - White;
    r_ := (Multi * l * r_ + White);
    g_ := (Multi * l * g_ + White);
    b_ := (Multi * l * b_ + White);
    result := rgb(trunc(r_),trunc(g_),trunc(b_));
end;

function TFNRGB.Mono(C:TColor):TColor;
var
    x:integer;
begin
    x := (getrvalue(c) + getgvalue(c) + getbvalue(c)) div 3;
    result := rgb(x,x,x);
end;

function TFNRGB.Norm(C:TColor):TColor;
var
    x:integer;
    maxi,mini,r_,g_,b_:integer;
begin
    r_ := getrvalue(c);
    g_ := getgvalue(c);
    b_ := getbvalue(c);
    if r_ > g_ then
    begin
        if r_ > b_ then
        begin
            maxi := r_;
            if g_ < b_ then mini := g_ else mini := b_;
        end
        else
        begin
            maxi := b_;
            mini := g_;
        end;
    end
    else
    begin
        if r_ < b_ then
        begin
            mini := r_;
            if b_ > g_ then maxi := b_ else maxi := g_;
        end
        else
        begin
            maxi := g_;
            mini := b_;
        end;
    end;
    maxi := maxi - mini;
    if maxi <> 0 then
        result := rgb((255 * (r_ - mini)) div maxi ,
                      (255 * (g_ - mini)) div maxi ,
                      (255 * (b_ - mini)) div maxi)
    else
        result := clRed;
end;

function TFNRGB.CToWhite(C:TColor;L:extended):TColor;
var
    r_,g_,b_ : integer;
begin
    l := self.Limit(l,0,1);
    r_ := getrvalue(c);
    g_ := getgvalue(c);
    b_ := getbvalue(c);
    result := rgb(r_ - trunc((r_ - 255) * l) ,
                  g_ - trunc((g_ - 255) * l) ,
                  b_ - trunc((b_ - 255) * l));
end;

function TFNRGB.Convert(C1,C2:TColor;Amount:extended):TColor;
var
    r_,g_,b_ : integer;
begin
    amount := self.Limit(amount,0,1);
    r_ := getrvalue(c1);
    g_ := getgvalue(c1);
    b_ := getbvalue(c1);
    result := rgb(r_ - trunc((r_ - getrvalue(c2)) * amount) ,
                  g_ - trunc((g_ - getgvalue(c2)) * amount) ,
                  b_ - trunc((b_ - getbvalue(c2)) * amount));
end;

function TFNRGB.CAvr(C1,C2:TColor):TColor;
begin
    result := rgb((getrvalue(c1) + getrvalue(c2)) div 2 ,
                  (getgvalue(c1) + getgvalue(c2)) div 2 ,
                  (getbvalue(c1) + getbvalue(c2)) div 2);
end;

function TFNRGB.CAdd(C:TColor;L:integer):TColor;
begin
    result := rgb(getrvalue(c) + l ,
                  getgvalue(c) + l ,
                  getbvalue(c) + l);
end;

function TFNRGB.CSub(C:TColor;L:integer):TColor;
begin
    result := rgb(getrvalue(c) - l ,
                  getgvalue(c) - l ,
                  getbvalue(c) - l);
end;

function TFNRGB.CMul(C:TColor;L:integer):TColor;
begin
    result := rgb(getrvalue(c) * l ,
                  getgvalue(c) * l ,
                  getbvalue(c) * l);
end;

function TFNRGB.CDiv(C:TColor;L:integer):TColor;
begin
    if l <> 0 then
        result := rgb(getrvalue(c) + l ,
                      getgvalue(c) + l ,
                      getbvalue(c) + l)
    else
        result := clWhite;
end;

function TFNRGB.CAdd(C:TColor;L:extended):TColor;
var
    l_ : integer;
begin
    l_ := trunc(l);
    result := rgb(getrvalue(c) + l_ ,
                  getgvalue(c) + l_ ,
                  getbvalue(c) + l_);
end;

function TFNRGB.CSub(C:TColor;L:extended):TColor;
var
    l_ : integer;
begin
    l_ := trunc(l);
    result := rgb(getrvalue(c) - l_ ,
                  getgvalue(c) - l_ ,
                  getbvalue(c) - l_);
end;

function TFNRGB.CMul(C:TColor;L:extended):TColor;
begin
    result := rgb(trunc(getrvalue(c) * l) ,
                  trunc(getgvalue(c) * l) ,
                  trunc(getbvalue(c) * l));
end;

function TFNRGB.CDiv(C:TColor;L:extended):TColor;
begin
    if l <> 0 then
        result := rgb(trunc(getrvalue(c) / l) ,
                      trunc(getgvalue(c) / l) ,
                      trunc(getbvalue(c) / l))
    else
        result := clWhite;
end;

function TFNRGB.CNeg(C:TColor):TColor;
begin
    result := rgb(-getrvalue(c) ,
                  -getgvalue(c) ,
                  -getbvalue(c));
end;

function TFNRGB.CToV(C:TColor):TVec3D;
begin
    result.X := getrvalue(c);
    result.Y := getgvalue(c);
    result.Z := getbvalue(c);
end;

function TFNRGB.VToC(V:TVec3D):TColor;
begin
    result := rgb(trunc(v.X),trunc(v.Y),trunc(v.Z));
end;

function TFNRGB.VToC(V:TVec3D;Multi:extended):TColor;
begin
    result := rgb(trunc(v.X * multi),trunc(v.Y * multi),trunc(v.Z * multi));
end;

{_______________________}
{                       }
{    TFN3D Functions    }
{_______________________}

function TFN3D.StrFromFloat(const x:extended;const digit:integer):string;
var
    i:integer;
    s:string;
begin
    str(X:0:Digit,s);
    i := length(s) - 1;
    while (s[i+1] = '0') and (s[i] <> '.') do
    begin
        i := i - 1;
    end;
    setlength(s,i + 1);
    result := s;
end;

function TFN3D.Limit(const x,a,b:extended):extended;
begin
    if a < b then
    begin
         if x < a then result := a
         else
            if x > b then result := b
            else result := x;
    end
    else
    begin
         if x < b then result := b
         else
            if x > a then result := a
            else result := x;
    end;
end;

function TFN3D.ColorWave1(Color:extended = 0;White:extended = 0;black:extended = 0):tcolor;
const
    p_6 = 0.523598775598298873077107230546583814;
    p2 = 6.2831853071795864769252867665590057682;
    p_3 = 1.047197551196597746154214461093167628;
var
    r_,g_,b_,l : extended;
    function Limiter(out x:extended):boolean;
    begin
        if x > 1 then x := 1;
        if x < 0 then x := 0;
    end;
begin
    Black := 1 - Black;
    l := p2 * (1 - color) - p_6;                                      {  2 * pi * (1 - color) - pi/6  }
    r_ := sin(l + 2.094395102393195492308);                           {  sin(l + pi / 1.5)  }
    g_ := sin(l + 4.188790204786390984616);                                    {   sin(2 * pi * (1 - color) - pi/6 + pi / 0.75);   }
    b_ := sin(l);                                                     {   sin(2 * pi * (1 - color) - pi/6 + 0);   }
    r_ := 0.5 + arcsin(r_) / p_3;                                                             {3 * arcsin(rr) / pi + 0.5;}
    g_ := 0.5 + arcsin(g_) / p_3;
    b_ := 0.5 + arcsin(b_) / p_3;
    Limiter(R_);
    Limiter(G_);
    Limiter(B_);
    Limiter(Black);
    Limiter(White);
    Black := 255 * Black;
    l := 1 - White;

    r_ := Black * (l * r_ + White);
    g_ := Black * (l * g_ + White);
    b_ := Black * (l * b_ + White);
    {
    r_ := (Black * l * r_ + White) * 255;
    g_ := (Black * l * g_ + White) * 255;
    b_ := (Black * l * b_ + White) * 255;
    }
    colorwave1 := rgb(trunc(r_),trunc(g_),trunc(b_));
end;

function TFN3D.ColorWave2(Color:extended = 0;White:extended = 0;black:extended = 0):tcolor;
const
    p_6 = 0.523598775598298873077107230546583814;
    p2 = 6.2831853071795864769252867665590057682;
    p_3 = 1.047197551196597746154214461093167628;
var
    r_,g_,b_,l : extended;
    function Limiter(out x:extended):boolean;
    begin
        if x > 1 then x := 1;
        if x < 0 then x := 0;
    end;
begin
    //Black := 1 - Black;
    l := p2 * (1 - color) - p_6;                                      {  2 * pi * (1 - color) - pi/6  }
    r_ := sin(l + 2.094395102393195492308);                           {  sin(l + pi / 1.5)  }
    g_ := sin(l + 4.188790204786390984616);                                    {   sin(2 * pi * (1 - color) - pi/6 + pi / 0.75);   }
    b_ := sin(l);                                                     {   sin(2 * pi * (1 - color) - pi/6 + 0);   }
    r_ := 0.5 + arcsin(r_) / p_3;                                                             {3 * arcsin(rr) / pi + 0.5;}
    g_ := 0.5 + arcsin(g_) / p_3;
    b_ := 0.5 + arcsin(b_) / p_3;
    Limiter(R_);
    Limiter(G_);
    Limiter(B_);
    Limiter(Black);
    Limiter(White);
    //Black := 255 * Black;
    l := 1 - White;
    {
    r_ := Black * (l * r_ + White);
    g_ := Black * (l * g_ + White);
    b_ := Black * (l * b_ + White);
    }
    r_ := (Black * l * r_ + White) * 255;
    g_ := (Black * l * g_ + White) * 255;
    b_ := (Black * l * b_ + White) * 255;
    colorwave2 := rgb(trunc(r_),trunc(g_),trunc(b_));
end;

function TFN3D.MonoColor(c:TColor):TColor;
var
    x:integer;
begin
    x := (getrvalue(c) + getgvalue(c) + getbvalue(c)) div 3;
    result := rgb(x,x,x);
end;

function TFN3D.Vec2D(const X,Y:extended):TVec2D;
begin
    result.X := x;
    result.Y := y;
end;

function TFN3D.Vec3D(const X,Y,Z:extended):TVec3D;
begin
    result.X := x;
    result.Y := y;
    result.Z := z;
end;

function TFN3D.Vec4D(const X,Y,Z,w:extended):TVec4D;
begin
    result.X := x;
    result.Y := y;
    result.Z := z;
    result.W := w;
end;

function TFN3D.Ray3D(const XPos,YPos,ZPos ,
                    XDir,YDir,ZDir :extended):TRay3D;
begin
    result.Pos := self.Vec3D(XPos,YPos,ZPos);
    result.Dir := self.Norm(XDir,YDir,ZDir);
end;

function TFN3D.Ray3D(const Pos,Dir:TVec3D):TRay3D;
begin
    result.Pos := pos;
    result.Dir := self.Norm(dir);
end;

function TFN3D.Matrix3D(const X1,Y1,Z1 ,
                              X2,Y2,Z2 ,
                              X3,Y3,Z3 ,
                              X4,Y4,Z4 : extended;DoNormal: boolean = true):TMatrix3D;
begin
    with result do
    begin
        if DoNormal then
        begin
            Row1 :=  self.Norm(X1,Y1,Z1);
            Row2 :=  self.Norm(X2,Y2,Z2);
            Row3 :=  self.Norm(X3,Y3,Z3);
        end
        else
        begin
            _11 := X1; _12 := Y1; _13 := Z1;
            _21 := X2; _22 := Y2; _23 := Z2;
            _31 := X3; _32 := Y3; _33 := Z3;
        end;
        _41 := X4; _42 := Y4; _43 := Z4;
    end;
end;

function TFN3D.Matrix3D(const V1,V2,V3,V4:TVec3D;DoNormal: boolean = true):TMatrix3D;
begin
    if DoNormal then
    begin
        result.Row1 := self.Norm(v1);
        result.Row2 := self.Norm(v2);
        result.Row3 := self.Norm(v3);
    end
    else
    begin
        result.Row1 := v1;
        result.Row2 := v2;
        result.Row3 := v3;
    end;
        result.Row4 := v4;
end;

function TFN3D.Matrix3D(const L:extended):TMatrix3D;
begin
    with result do
    begin
        _11 := 1; _12 := 0; _13 := 0;
        _21 := 0; _22 := 1; _23 := 0;
        _31 := 0; _32 := 0; _33 := 1;
        _41 := 0; _42 := 0; _43 := 0;
    end;
end;

function TFN3D.AsStr(const V:TVec2D;const Digit:integer=17):string;
begin
    result := '[' +
          self.StrFromFloat(v.X,digit) +
          ', ' +
          self.StrFromFloat(v.y,digit) +
          ']';
end;

function TFN3D.AsStr(const V:TVec3D;const Digit:integer=17):string;
begin
    result := '[' +
          self.StrFromFloat(v.X,digit) +
          ', ' +
          self.StrFromFloat(v.y,digit) +
          ', ' +
          self.StrFromFloat(v.z,digit) +
          ']';
end;

function TFN3D.AsStr(const V:TVec4D;const Digit:integer=17):string;
begin
    result := '[' +
          self.StrFromFloat(v.X,digit) +
          ', ' +
          self.StrFromFloat(v.y,digit) +
          ', ' +
          self.StrFromFloat(v.z,digit) +
          ', ' +
          self.StrFromFloat(v.w,digit) +
          ']';
end;

function TFN3D.AsStr(const R:TRay3D;const Digit:integer=17):string;
begin
    result := '(Ray3D ' +
        self.AsStr(r.Pos,digit) +
        ' ' +
        self.AsStr(r.Dir,digit) +
        ')';
end;

function TFN3D.AsStr(const M:TMatrix3D;const Digit:integer=17):string;
begin
    result := '(Matrix3D ' +
        self.AsStr(m.Row1,digit) +
        ' ' +
        self.AsStr(m.Row2,digit) +
        ' ' +
        self.AsStr(m.Row3,digit) +
        ' ' +
        self.AsStr(m.Row4,digit) +
        ')';
end;

function TFN3D.Equal(const X,Y:extended;const Limit:extended=0.000001):boolean;
begin
    result := abs(x-y) < Limit;
end;

function TFN3D.Equal(const V1,V2:TVec2D;const Limit:extended=0.000001):boolean;
begin
    result := (abs(v1.X - v2.x) < Limit) and (abs(v1.y - v2.Y) < Limit);
end;

function TFN3D.Equal(const V1,V2:TVec3D;const Limit:extended=0.000001):boolean;
begin
    result := (abs(v1.X - v2.X) < Limit) and (abs(v1.y - v2.Y) < Limit) and (abs(v1.z - v2.z) < Limit);
end;

function TFN3D.Equal(const V1,V2:TVec4D;const Limit:extended=0.000001):boolean;
begin
    result := (abs(v1.X - v2.X) < Limit) and (abs(v1.y - v2.Y) < Limit) and (abs(v1.z - v2.z) < Limit) and (abs(v1.w - v2.w) < Limit);
end;

function TFN3D.Equal(const R1,R2:TRay3D;const Limit:extended=0.000001):boolean;
begin
    result := self.Equal(r1.Pos,r2.Pos,limit) and self.Equal(r1.Dir,r2.Dir,limit);
end;

function TFN3D.Equal(const M1,M2:TMatrix3D;const Limit:extended=0.000001):boolean;
begin
    result := self.Equal(m1.Row1,m2.Row1,limit) and self.Equal(m1.Row2,m2.Row2,limit) and self.Equal(m1.Row3,m2.Row3,limit) and self.Equal(m1.Row4,m2.Row4,limit);
end;

function TFN3D.GetRow(const V:TVec2D;const i:byte):extended;
begin
    result := v._[i];
end;

function TFN3D.GetRow(const V:TVec3D;const i:byte):extended;
begin
    result := v._[i];
end;

function TFN3D.GetRow(const V:TVec4D;const i:byte):extended;
begin
    result := v._[i];
end;

function TFN3D.GetRow(const R:TRay3D;const i:byte):TVec3D;
begin
    if (i = 2) then result := self.Norm(r.Dir)
    else result := r.Pos;
end;

function TFN3D.GetRow(const R:TRay3D;const i,j:byte):extended;
begin
    if (i = 2) then result := (r.Dir._[j] / self.Leng(r.Dir))
    else
        result := r.Pos._[i];
end;

function TFN3D.GetRow(const M:TMatrix3D;const i:byte):TVec3D;
begin
    if (i = 4) then result := m.Row4
    else
        result := self.Norm(m.Row[i]);
end;

function TFN3D.GetRow(const M:TMatrix3D;const i,j:byte):extended;
begin
    if (i = 4) then result := m.Row4._[j]
    else
        result := m._[i,j] / self.Leng(m.Row[i]);
end;

procedure TFN3D.SetRow(var V:TVec2D;const i:byte; L:extended);
begin
    if (l < 0) then
    begin
        if (-l > self.MaximumValue) then v._[i] := -self.MaximumValue
        else
            if (-l < self.MinimumValue) then v._[i] := -self.MinimumValue
            else v._[i] := l;
    end
    else
    begin
        if (l > self.MaximumValue) then v._[i] := self.MaximumValue
        else
            if (l < self.MinimumValue) then v._[i] := self.MinimumValue
            else v._[i] := l;
    end;
end;

procedure TFN3D.SetRow(var V:TVec3D;const i:byte; L:extended);
begin
    if (l < 0) then
    begin
        if (-l > self.MaximumValue) then v._[i] := -self.MaximumValue
        else
            if (-l < self.MinimumValue) then v._[i] := -self.MinimumValue
            else v._[i] := l;
    end
    else
    begin
        if (l > self.MaximumValue) then v._[i] := self.MaximumValue
        else
            if (l < self.MinimumValue) then v._[i] := self.MinimumValue
            else v._[i] := l;
    end;
end;

procedure TFN3D.SetRow(var V:TVec4D;const i:byte; L:extended);
begin
    if (l < 0) then
    begin
        if (-l > self.MaximumValue) then v._[i] := -self.MaximumValue
        else
            if (-l < self.MinimumValue) then v._[i] := -self.MinimumValue
            else v._[i] := l;
    end
    else
    begin
        if (l > self.MaximumValue) then v._[i] := self.MaximumValue
        else
            if (l < self.MinimumValue) then v._[i] := self.MinimumValue
            else v._[i] := l;
    end;
end;

procedure TFN3D.SetRow(var R:TRay3D;const i:byte; V:TVec3D);
var
  k: Integer;
begin
    for k := 1 to 3 do
    begin
        if (v._[k] < 0) then
        begin
            if (-v._[k] > self.MaximumValue) then r._[i,k] := -self.MaximumValue
            else
                if (-v._[k] < self.MinimumValue) then r._[i,k] := -self.MinimumValue
                else r._[i,k] := v._[k];
        end
        else
        begin
            if (v._[k] > self.MaximumValue) then r._[i,k] := self.MaximumValue
            else
                if (v._[k] < self.MinimumValue) then r._[i,k] := self.MinimumValue
                else r._[i,k] := v._[k];
        end;
    end;
    if (i = 2) then
        r.Dir := self.Norm(r.Dir);
end;

procedure TFN3D.SetRow(var R:TRay3D;const i,j:byte; L:extended);
begin
    if (l < 0) then
    begin
        if (-l > self.MaximumValue) then r._[i,j] := -self.MaximumValue
        else
            if (-l < self.MinimumValue) then r._[i,j] := -self.MinimumValue
            else r._[i,j] := l;
    end
    else
    begin
        if (l > self.MaximumValue) then r._[i,j] := self.MaximumValue
        else
            if (l < self.MinimumValue) then r._[i,j] := self.MinimumValue
            else r._[i,j] := l;
    end;
end;

procedure TFN3D.SetRow(var M:TMatrix3D;const i:byte; V:TVec3D);
var
    k: byte;
begin
    for k := 1 to 3 do
    begin
        if (v._[k] < 0) then
        begin
            if (-v._[k] > self.MaximumValue) then m._[i,k] := -self.MaximumValue
            else
                if (-v._[k] < self.MinimumValue) then m._[i,k] := -self.MinimumValue
                else m._[i,k] := v._[k];
        end
        else
        begin
            if (v._[k] > self.MaximumValue) then m._[i,k] := self.MaximumValue
            else
                if (v._[k] < self.MinimumValue) then m._[i,k] := self.MinimumValue
                else m._[i,k] := v._[k];
        end;
    end;
    if (i <> 4) then m.Row[i] := self.Norm(m.Row[i]);
end;

procedure TFN3D.SetRow(var M:TMatrix3D;const i,j:byte; L:extended);
begin
    if (l < 0) then
    begin
        if (-l > self.MaximumValue) then m._[i,j] := -self.MaximumValue
        else
            if (-l < self.MinimumValue) then m._[i,j] := -self.MinimumValue
            else m._[i,j] := l;
    end
    else
    begin
        if (l > self.MaximumValue) then m._[i,j] := self.MaximumValue
        else
            if (l < self.MinimumValue) then m._[i,j] := self.MinimumValue
            else m._[i,j] := l;
    end;
end;

procedure TFN3D.SetRow(var M:TMatrix3D;const i:byte; X,Y,Z:extended);
begin
    if (x < 0) then
    begin
        if (-x > self.MaximumValue) then m._[i,1] := -self.MaximumValue
        else
            if (-x < self.MinimumValue) then m._[i,1] := -self.MinimumValue
            else m._[i,1] := x;
    end
    else
    begin
        if (x > self.MaximumValue) then m._[i,1] := self.MaximumValue
        else
            if (x < self.MinimumValue) then m._[i,1] := self.MinimumValue
            else m._[i,1] := x;
    end;
    if (y < 0) then
    begin
        if (-y > self.MaximumValue) then m._[i,2] := -self.MaximumValue
        else
            if (-y < self.MinimumValue) then m._[i,2] := -self.MinimumValue
            else m._[i,2] := y;
    end
    else
    begin
        if (y > self.MaximumValue) then m._[i,2] := self.MaximumValue
        else
            if (y < self.MinimumValue) then m._[i,2] := self.MinimumValue
            else m._[i,2] := y;
    end;
    if (z < 0) then
    begin
        if (-z > self.MaximumValue) then m._[i,3] := -self.MaximumValue
        else
            if (-z < self.MinimumValue) then m._[i,3] := -self.MinimumValue
            else m._[i,3] := z;
    end
    else
    begin
        if (z > self.MaximumValue) then m._[i,3] := self.MaximumValue
        else
            if (z < self.MinimumValue) then m._[i,3] := self.MinimumValue
            else m._[i,3] := z;
    end;
    if i <> 4 then m.Row[i] := self.Norm(m.Row[i]);
end;

function TFN3D.VConvert(const V1,V2:TVec2D;L: extended):TVec2D;
begin
    l := self.Limit(l,-1,1);
    result.X := (v2.X - v1.X) * l + v1.X;
    result.Y := (v2.Y - v1.Y) * l + v1.y;
end;

function TFN3D.VConvert(const V1,V2:TVec3D;L: extended):TVec3D;
begin
    l := self.Limit(l,-1,1);
    result.X := (v2.X - v1.X) * l + v1.X;
    result.Y := (v2.Y - v1.Y) * l + v1.y;
    result.z := (v2.z - v1.z) * l + v1.z;
end;

function TFN3D.VConvert(const V1,V2:TVec4D;L: extended):TVec4D;
begin
    l := self.Limit(l,-1,1);
    result.X := (v2.X - v1.X) * l + v1.X;
    result.Y := (v2.Y - v1.Y) * l + v1.y;
    result.z := (v2.z - v1.z) * l + v1.z;
    result.w := (v2.w - v1.w) * l + v1.w;
end;

function TFN3D.VAdd(const V1,V2:TVec2D):TVec2D;
begin
    result.X := v1.X + v2.X;
    result.Y := v1.Y + v2.Y;
end;
{asm
    fld    v1.x
    fld    v2.x
    fadd
    fstp   tbyte ptr [@RESULT.X]
    fld    v1.y
    fld    v2.y
    fadd
    fstp   tbyte ptr [@RESULT]
    fwait
end;}

function TFN3D.VAdd(const V1,V2:TVec3D):TVec3D;
begin
    result.X := v1.X + v2.X;
    result.Y := v1.Y + v2.Y;
    result.Z := v1.Z + v2.Z;
end;
//begin
//asm
//    fld     v1.x
//    fld     v2.x
//    fadd
//    fstp    tbyte ptr [EaX]
    {fld     v1.y
    fld     v2.y
    fadd
    fstp    [@result]
    fld     v1.z
    fld     v2.z
    fadd
    fstp    st(0)}
//    fwait
//end;
    //result.X := 1;
//    result.Y := v1.Y + v2.Y;
//    result.Z := v1.Z + v2.Z;
//end;

function TFN3D.VAdd(const V1,V2:TVec4D):TVec4D;
begin
    result.X := v1.X + v2.X;
    result.Y := v1.Y + v2.Y;
    result.Z := v1.Z + v2.Z;
    result.W := v1.W + v2.W;
end;

function TFN3D.VSum(const AV:array of TVec2D):TVec2D;
var
  I: Integer;
begin
    result.X := av[0].X;
    result.Y := av[0].Y;
    for I := 1 to high(av) do
    begin
        result.X := result.X + av[i].X;
        result.Y := result.Y + av[i].Y;
    end;
end;

function TFN3D.VSum(const AV:array of TVec3D):TVec3D;
var
  I: Integer;
begin
    result.X := av[0].X;
    result.Y := av[0].Y;
    result.Z := av[0].Z;
    for I := 1 to high(av) do
    begin
        result.X := result.X + av[i].X;
        result.Y := result.Y + av[i].Y;
        result.Z := result.Z + av[i].Z;
    end;
end;

function TFN3D.VSum(const AV:array of TVec4D):TVec4D;
var
  I: Integer;
begin
    result.X := av[0].X;
    result.Y := av[0].Y;
    result.Z := av[0].Z;
    result.Y := av[0].W;
    for I := 1 to high(av) do
    begin
        result.X := result.X + av[i].X;
        result.Y := result.Y + av[i].Y;
        result.Z := result.Z + av[i].Z;
        result.W := result.W + av[i].W;
    end;
end;

function TFN3D.VSub(const V1,V2:TVec2D):TVec2D;
begin
    result.X := v1.X - v2.X;
    result.Y := v1.Y - v2.Y;
end;

function TFN3D.VSub(const V1,V2:TVec3D):TVec3D;
begin
    result.X := v1.X - v2.X;
    result.Y := v1.Y - v2.Y;
    result.Z := v1.Z - v2.Z;
end;

function TFN3D.VSub(const V1,V2:TVec4D):TVec4D;
begin
    result.X := v1.X - v2.X;
    result.Y := v1.Y - v2.Y;
    result.Z := v1.Z - v2.Z;
    result.W := v1.W - v2.W;
end;

function TFN3D.VMul(const V1,V2:TVec2D):TVec2D;
begin
    result.X := v1.X * v2.X;
    result.Y := v1.Y * v2.Y;
end;

function TFN3D.VMul(const V1,V2:TVec3D):TVec3D;
begin
    result.X := v1.X * v2.X;
    result.Y := v1.Y * v2.Y;
    result.Z := v1.Z * v2.Z;
end;

function TFN3D.VMul(const V1,V2:TVec4D):TVec4D;
begin
    result.X := v1.X * v2.X;
    result.Y := v1.Y * v2.Y;
    result.Z := v1.Z * v2.Z;
    result.W := v1.W * v2.W;
end;

function TFN3D.VMul(const L:extended;const V:TVec2D):TVec2D;
begin
    result.X := v.X * l;
    result.Y := v.Y * l;
end;

function TFN3D.VMul(const L:extended;const V:TVec3D):TVec3D;
begin
    result.X := v.X * l;
    result.Y := v.Y * l;
    result.Z := v.Z * l;
end;

function TFN3D.VMul(const L:extended;const V:TVec4D):TVec4D;
begin
    result.X := v.X * l;
    result.Y := v.Y * l;
    result.Z := v.Z * l;
    result.W := v.W * l;
end;

function TFN3D.VMul(const V:TVec2D;const L:extended):TVec2D;
begin
    result.X := v.X * l;
    result.Y := v.Y * l;
end;

function TFN3D.VMul(const V:TVec3D;const L:extended):TVec3D;
begin
    result.X := v.X * l;
    result.Y := v.Y * l;
    result.Z := v.Z * l;
end;

function TFN3D.VMul(const V:TVec4D;const L:extended):TVec4D;
begin
    result.X := v.X * l;
    result.Y := v.Y * l;
    result.Z := v.Z * l;
    result.W := v.W * l;
end;

function TFN3D.VMul(const V:TVec3D;const M:TMatrix3D):TVec3D;
begin
     result.X := v.X * m.Row1.X + v.Y * m.Row2.X + v.Z * m.Row3.X + m.Row4.X;
     result.Y := v.X * m.Row1.Y + v.Y * m.Row2.Y + v.Z * m.Row3.Y + m.Row4.Y;
     result.Z := v.X * m.Row1.Z + v.Y * m.Row2.Z + v.Z * m.Row3.Z + m.Row4.Z;
     {self.VSum([self.VMul(v.X,M.Row1) ,
                         self.VMul(v.Y,M.Row2) ,
                         self.VMul(v.Z,M.Row3) ,
                         M.Row4}
end;

function TFN3D.VDiv(const V1,V2:TVec2D):TVec2D;
{const
    inf_ = 0.00000000000000000001;}
begin
    if v2.X <> 0 then result.X := v1.X / v2.X else result.X := v1.X / self.MinVal;
    if v2.y <> 0 then result.y := v1.y / v2.y else result.Y := v1.Y / self.MinVal;
end;

function TFN3D.VDiv(const V1,V2:TVec3D):TVec3D;
{const
    inf_ = 0.00000000000000000001;}
begin
    if v2.X <> 0 then result.X := v1.X / v2.X else result.X := v1.X / self.MinVal;
    if v2.y <> 0 then result.y := v1.y / v2.y else result.y := v1.y / self.MinVal;
    if v2.z <> 0 then result.z := v1.z / v2.z else result.z := v1.z / self.MinVal;
end;

function TFN3D.VDiv(const V1,V2:TVec4D):TVec4D;
{const
    inf_ = 0.00000000000000000001;}
begin
    if v2.X <> 0 then result.X := v1.X / v2.X else result.X := v1.X / self.MinVal;
    if v2.y <> 0 then result.y := v1.y / v2.y else result.y := v1.y / self.MinVal;
    if v2.z <> 0 then result.z := v1.z / v2.z else result.z := v1.z / self.MinVal;
    if v2.w <> 0 then result.w := v1.w / v2.w else result.w := v1.w / self.MinVal;
end;

function TFN3D.VDiv(const V:TVec2D;L:extended):TVec2D;
begin
    if l = 0 then l := self.MinVal;//0.00000000000000000001;
    result.X := v.X / l;
    result.y := v.y / l;
end;

function TFN3D.VDiv(const V:TVec3D;L:extended):TVec3D;
begin
    if l = 0 then l := self.MinVal;//0.00000000000000000001;
    result.X := v.X / l;
    result.y := v.y / l;
    result.z := v.z / l;
end;

function TFN3D.VDiv(const V:TVec4D;L:extended):TVec4D;
begin
    if l = 0 then l := self.MinVal;//0.00000000000000000001;
    result.X := v.X / l;
    result.y := v.y / l;
    result.z := v.z / l;
    result.w := v.w / l;
end;

function TFN3D.VNeg(const V:TVec2D):TVec2D;
begin
    result.X := -v.X;
    result.Y := -v.Y;
end;

function TFN3D.VNeg(const V:TVec3D):TVec3D;
begin
    result.X := -v.X;
    result.Y := -v.Y;
    result.z := -v.z;
end;

function TFN3D.VNeg(const V:TVec4D):TVec4D;
begin
    result.X := -v.X;
    result.Y := -v.Y;
    result.z := -v.z;
    result.w := -v.w;
end;

function TFN3D.VRev(const V:TVec2D):TVec2D;
{const
    inf_ = 10000000000000000000.0;}
begin
    if v.X <> 0 then result.X := 1 / v.X else result.X := self.MaxVal;
    if v.y <> 0 then result.y := 1 / v.y else result.y := self.MaxVal;
end;

function TFN3D.VRev(const V:TVec3D):TVec3D;
{const
    inf_ = 10000000000000000000.0;}
begin
    if v.X <> 0 then result.X := 1 / v.X else result.X := self.MaxVal;
    if v.y <> 0 then result.y := 1 / v.y else result.y := self.MaxVal;
    if v.z <> 0 then result.z := 1 / v.z else result.z := self.MaxVal;
end;

function TFN3D.VRev(const V:TVec4D):TVec4D;
{const
    inf_ = 10000000000000000000.0;}
begin
    if v.X <> 0 then result.X := 1 / v.X else result.X := self.MaxVal;
    if v.y <> 0 then result.y := 1 / v.y else result.y := self.MaxVal;
    if v.z <> 0 then result.z := 1 / v.z else result.z := self.MaxVal;
    if v.w <> 0 then result.w := 1 / v.w else result.w := self.MaxVal;
end;

function TFN3D.VAbs(const V:TVec2D):TVec2D;
begin
    result.X := abs(v.X);
    result.y := abs(v.y);
end;

function TFN3D.VAbs(const V:TVec3D):TVec3D;
begin
    result.X := abs(v.X);
    result.y := abs(v.y);
    result.z := abs(v.z);
end;

function TFN3D.VAbs(const V:TVec4D):TVec4D;
begin
    result.X := abs(v.X);
    result.y := abs(v.y);
    result.z := abs(v.z);
    result.w := abs(v.w);
end;

function TFN3D.Leng(const V:TVec2D):extended;
{begin
    result := sqrt(sqr(v.X) +
                   sqr(v.Y));
end;}
asm
    fld     v.x
    fmul    st,st
    fld     v.y
    fmul    st,st
    fadd
    fsqrt
    fwait
end;

function TFN3D.Leng(const V:TVec3D):extended;
{begin
    result := sqrt(sqr(v.X) +
                   sqr(v.Y) +
                   sqr(v.Z));
end;}
asm
    fld     v.x
    fmul    st,st
    fld     v.y
    fmul    st,st
    fadd
    fld     v.z
    fmul    st,st
    fadd
    fsqrt
    fwait
end;

function TFN3D.Leng(const V:TVec4D):extended;
{begin
    result := sqrt(sqr(v.X) +
                   sqr(v.Y) +
                   sqr(v.Z) +
                   sqr(v.W));
end;}
asm
    fld     v.x
    fmul    st,st
    fld     v.y
    fmul    st,st
    fadd
    fld     v.z
    fmul    st,st
    fadd
    fld     v.w
    fmul    st,st
    fadd
    fsqrt
    fwait
end;

function TFN3D.Leng(const x,y:extended):extended;
asm
    fld   x
    fmul st,st
    fld   y
    fmul st,st
    fadd
    fsqrt
    fwait
end;

function TFN3D.Leng(const x,y,z:extended):extended;
{begin
    result := sqrt(sqr(X) +
                   sqr(Y) +
                   sqr(Z));
end;}
asm
    fld   x
    fmul st,st
    fld   y
    fmul st,st
    fadd
    fld  z
    fmul st,st
    fadd
    fsqrt
    fwait
end;

function TFN3D.Leng(const x,y,z,w:extended):extended;
{begin
    result := sqrt(sqr(X) +
                   sqr(Y) +
                   sqr(Z) +
                   sqr(W));
end;}
asm
    fld     x
    fmul    st,st
    fld     y
    fmul    st,st
    fadd
    fld     z
    fmul    st,st
    fadd
    fld     w
    fmul    st,st
    fadd
    fsqrt
    fwait
end;

function TFN3D.Dist(const V1,V2:TVec2D):extended;
{begin
    result := sqrt(sqr(v1.X - v2.X) +
                   sqr(v1.Y - v2.Y));
end;}
asm
    fld     v1.x
    fld     v2.x
    fsub
    fmul    st,st
    fstp    tbyte ptr [@result]
    fld     v1.y
    fld     v2.y
    fsub
    fmul    st,st
    fld     [@result]
    FADD
    fsqrt
    fstp    tbyte ptr [@result]
    fwait
end;

function TFN3D.Dist(const V1,V2:TVec3D):extended;
{begin
    result := sqrt(sqr(v1.X - v2.X) +
                   sqr(v1.Y - v2.Y) +
                   sqr(v1.z - v2.Z));
end;}
asm
    fld     v1.x
    fld     v2.x
    fsub
    fmul    st,st
    fstp    tbyte ptr [@result]
    fld     v1.y
    fld     v2.y
    fsub
    fmul    st,st
    fld     [@result]
    FADD
    fstp    tbyte ptr [@result]
    fld     v1.z
    fld     v2.z
    fsub
    fmul    st,st
    fld     [@result]
    FADD
    fsqrt
    fstp    tbyte ptr [@result]
    fwait
end;

function TFN3D.Dist(const V1,V2:TVec4D):extended;
{begin
    result := sqrt(sqr(v1.X - v2.X) +
                   sqr(v1.Y - v2.Y) +
                   sqr(v1.z - v2.Z) +
                   sqr(v1.W - v2.W));
end;}
asm
    fld     v1.x
    fld     v2.x
    fsub
    fmul    st,st
    fstp    tbyte ptr [@result]
    fld     v1.y
    fld     v2.y
    fsub
    fmul    st,st
    fld     [@result]
    FADD
    fstp    tbyte ptr [@result]
    fld     v1.z
    fld     v2.z
    fsub
    fmul    st,st
    fld     [@result]
    FADD
    fstp    tbyte ptr [@result]
    fld     v1.w
    fld     v2.w
    fsub
    fmul    st,st
    fld     [@result]
    FADD
    fsqrt
    fstp    tbyte ptr [@result]
    fwait
end;

function TFN3D.Dist(const M1,M2:TMatrix3D):extended;
begin
    result := sqrt(sqr(m1.Row4.X - m2.Row4.X) +
                   sqr(m1.Row4.Y - m2.Row4.Y) +
                   sqr(m1.Row4.z - m2.Row4.Z));
end;

function TFN3D.Norm(const V:TVec2D):TVec2D;
var
    l:extended;
begin
    l := sqrt(sqr(v.X) +
              sqr(v.Y));
    if l = 0 then l := self.MinVal;//0.00000000000000000001;
    result.x := v.X / l;
    result.Y := v.Y / l;
end;

function TFN3D.Norm(const V:TVec3D):TVec3D;
var
    l:extended;
begin
    l := sqrt(sqr(v.X) +
              sqr(v.Y) +
              sqr(v.Z));
    if l = 0 then l := self.MinVal;//0.00000000000000000001;
    result.x := v.X / l;
    result.Y := v.Y / l;
    result.Z := v.Z / l;
end;

function TFN3D.Norm(const V:TVec4D):TVec4D;
var
    l:extended;
begin
    l := sqrt(sqr(v.X) +
              sqr(v.Y) +
              sqr(v.Z) +
              sqr(v.W));
    if l = 0 then l := self.MinVal;//0.00000000000000000001;
    result.x := v.X / l;
    result.Y := v.Y / l;
    result.Z := v.Z / l;
    result.W := v.W / l;
end;

function TFN3D.Norm(const x,y:extended):TVec2D;
var
    l:extended;
begin
    l := sqrt(sqr(X) +
              sqr(Y));
    if l = 0 then l := self.MinVal;//0.00000000000000000001;
    result.x := X / l;
    result.Y := Y / l;
end;

function TFN3D.Norm(const x,y,z:extended):TVec3D;
var
    l:extended;
begin
    l := sqrt(sqr(X) +
              sqr(Y) +
              sqr(Z));
    if l = 0 then l := self.MinVal;//0.00000000000000000001;
    result.x := X / l;
    result.Y := Y / l;
    result.Z := Z / l;
end;

function TFN3D.Norm(const x,y,z,w:extended):TVec4D;
var
    l:extended;
begin
    l := sqrt(sqr(X) +
              sqr(Y) +
              sqr(Z) +
              sqr(W));
    if l = 0 then l := self.MinVal;//0.00000000000000000001;
    result.x := X / l;
    result.Y := Y / l;
    result.Z := Z / l;
    result.W := W / l;
end;

function TFN3D.Norm(const R:TRay3D):TRay3D;
begin
    result.Pos := r.Pos;
    result.Dir := self.Norm(r.Dir);
end;

function TFN3D.Norm(const M:TMatrix3D):TMatrix3D;
begin
    result.Row1 := self.Norm(m.Row1);
    result.Row2 := self.Norm(m.Row2);
    result.Row3 := self.Norm(m.Row3);
    result.Row4 := m.Row4;
end;

procedure TFN3D.SetLeng(var V:TVec2d;L:extended);
var
    l_:extended;
begin
    if l = 0 then l := self.MinVal;//0.0000000000000000000001;
    l_ := sqrt(sqr(v.X) +
               sqr(v.Y));
    if l_ = 0 then
    begin
        v.X := FC._Jazr2;
        v.Y := fc._Jazr2;
    end
    else
    begin
        l := l / l_;
        v.x := v.X * l;
        v.Y := v.Y * l;
    end;
end;

procedure TFN3D.SetLeng(var V:TVec3d;L:extended);
var
    l_:extended;
begin
    if l = 0 then l := self.MinVal;//0.0000000000000000000001;
    l_ := sqrt(sqr(v.X) +
               sqr(v.Y) +
               sqr(v.Z));
    if l_ = 0 then
    begin
        v.X := FC._Jazr3;
        v.Y := fc._Jazr3;
        v.Z := fc._Jazr3;
    end
    else
    begin
        l := l / l_;
        v.x := v.X * l;
        v.Y := v.Y * l;
        v.Z := v.Z * l;
    end;
end;

procedure TFN3D.SetLeng(var V:TVec4d;L:extended);
var
    l_:extended;
begin
    if l = 0 then l := self.MinVal;//0.0000000000000000000001;
    l_ := sqrt(sqr(v.X) +
               sqr(v.Y) +
               sqr(v.Z) +
               sqr(v.W));
    if l_ = 0 then
    begin
        v.X := 0.5;
        v.Y := 0.5;
        v.Z := 0.5;
        v.W := 0.5;
    end
    else
    begin
        l := l / l_;
        v.x := v.X * l;
        v.Y := v.Y * l;
        v.Z := v.Z * l;
        v.W := v.W * l;
    end;
end;

function TFN3D.Dot(const V1,V2:TVec2D):extended;
{begin
    result := v1.X * v2.X +
              v1.Y * v2.Y;
end;}
asm
    fld     v1.x
    fld     v2.x
    fmul
    fstp    tbyte ptr [@result]
    fld     v1.y
    fld     v2.y
    fmul
    fld     [@result]
    FADD
    fstp    tbyte ptr [@result]
    fwait
end;

function TFN3D.Dot(const V1,V2:TVec3D):extended;
asm
    fld     v1.x
    fld     v2.x
    fmul
    fstp    tbyte ptr [@result]
    fld     v1.y
    fld     v2.y
    fmul
    fld     [@result]
    fADD
    fstp    tbyte ptr [@result]
    fld     v1.z
    fld     v2.z
    fmul
    fld     [@result]
    fADD
    fstp    tbyte ptr [@result]
    fwait
end;
{begin
    result := v1.X * v2.X +
              v1.Y * v2.Y +
              v1.Z * v2.Z;
end;}

function TFN3D.Dot(const V1,V2:TVec4D):extended;
{begin
    result := v1.X * v2.X +
              v1.Y * v2.Y +
              v1.Z * v2.Z +
              v1.W * v2.W;
end;}
asm
    fld     v1.x
    fld     v2.x
    fmul
    fstp    tbyte ptr [@result]
    fld     v1.y
    fld     v2.y
    fmul
    fld     [@result]
    FADD
    fstp    tbyte ptr [@result]
    fld     v1.z
    fld     v2.z
    fmul
    fld     [@result]
    FADD
    fstp    tbyte ptr [@result]
    fld     v1.w
    fld     v2.w
    fmul
    fld     [@result]
    FADD
    fstp    tbyte ptr [@result]
    fwait
end;

function TFN3D.Cross(const V1,V2:TVec3D):TVec3D;
begin
    result.X := v1.Y * v2.Z - v1.Z * v2.Y;
    result.Y := v1.z * v2.x - v1.x * v2.z;
    result.Z := v1.x * v2.y - v1.y * v2.X;
end;
{    function lf_(v1y,v2z,v1z,v2y:extended):extended;
    asm
        fld     v1z
        fld     v2y
        fmul
        fstp    tbyte ptr [@result]
        fld     v1y
        fld     v2z
        fmul
        fld     [@result]
        fsub
        fstp    tbyte ptr [@result]
        fwait
    end;
begin
    result.X := lf_(v1.Y,v2.Z,v1.Z,v2.Y);
    result.Y := lf_(v1.z,v2.x,v1.x,v2.z);
    result.Z := lf_(v1.x,v2.y,v1.y,v2.X);
end;}

function TFN3D.RotX(const M:TMatrix3D;const Angle:extended;const ApplyToRow4:boolean):TMatrix3D;
var
    Sin_,Cos_:extended;
begin
    sincos(angle,sin_,cos_);
    with M do
    begin
        result._12 := _12 * cos_ - _13 * sin_;
        result._13 := _12 * sin_ + _13 * cos_;
        result._22 := _22 * cos_ - _23 * sin_;
        result._23 := _22 * sin_ + _23 * cos_;
        result._32 := _32 * cos_ - _33 * sin_;
        result._33 := _32 * sin_ + _33 * cos_;
        if ApplyToRow4 then
        begin
            result._42 := _42 * cos_ - _43 * sin_;
            result._43 := _42 * sin_ + _43 * cos_;
        end
        else
        begin
            result._42 := _42;
            result._43 := _43;
        end;

        result._11 := _11;
        result._21 := _21;
        result._31 := _31;
        result._41 := _41;
    end;
end;

function TFN3D.RotY(const M:TMatrix3D;const Angle:extended;const ApplyToRow4:boolean):TMatrix3D;
var
    Sin_,Cos_:extended;
begin
    sincos(angle,sin_,cos_);
    with M do
    begin
        result._13 := _13 * cos_ - _11 * sin_;
        result._11 := _13 * sin_ + _11 * cos_;
        result._23 := _23 * cos_ - _21 * sin_;
        result._21 := _23 * sin_ + _21 * cos_;
        result._33 := _33 * cos_ - _31 * sin_;
        result._31 := _33 * sin_ + _31 * cos_;
        if ApplyToRow4 then
        begin
            result._43 := _43 * cos_ - _41 * sin_;
            result._41 := _43 * sin_ + _41 * cos_;
        end
        else
        begin
            result._41 := _41;
            result._43 := _43;
        end;

        result._12 := _12;
        result._22 := _22;
        result._32 := _32;
        result._42 := _42;
    end;
end;

function TFN3D.RotZ(const M:TMatrix3D;const Angle:extended;const ApplyToRow4:boolean):TMatrix3D;
var
    Sin_,Cos_:extended;
begin
    sincos(angle,sin_,cos_);
    with M do
    begin
        result._11 := _11 * cos_ - _12 * sin_;
        result._12 := _11 * sin_ + _12 * cos_;
        result._21 := _21 * cos_ - _22 * sin_;
        result._22 := _21 * sin_ + _22 * cos_;
        result._31 := _31 * cos_ - _32 * sin_;
        result._32 := _31 * sin_ + _32 * cos_;
        if ApplyToRow4 then
        begin
            result._41 := _41 * cos_ - _42 * sin_;
            result._42 := _41 * sin_ + _42 * cos_;
        end
        else
        begin
            result._42 := _42;
            result._41 := _41;
        end;

        result._13 := _13;
        result._23 := _23;
        result._33 := _33;
        result._43 := _43;
    end;
end;

function TFN3D.Rot(const M:TMatrix3D;const X_Angle,Y_Angle,Z_Angle:extended;const ApplyToRow4:boolean = true;const XYZ_Not_ZYX:boolean = true):TMatrix3D;
{
___________________________________________________________

 Z >< Y >< X =
 __                                                     __
|                                                         |
| c3*c2        c1*s3 + s1*s2*c3         s1*s3 - c1*s2*c3  |
|-s3*c2        c1*c3 - s1*s2*s3         s1*c3 + c1*s2*s3  |
|  s2              -s1*c2                   c1*c2         |
|__                                                     __|
___________________________________________________________

 X >< Y >< Z =
 __                                                     __
|                                                         |
| c2*c3                      c2*s3                   -s2  |
| s1*s2*c3 - c1*s3        s1*s2*s3 + c1*c3          s1*c2 |
| c1*s2*c3 + s1*s3        c1*s2*s3 - s1*c3          c1*c2 |
|__                                                     __|
___________________________________________________________
}
var
    S1,S2,S3,C1,C2,C3: extended;
begin
    SinCos(X_Angle,S1,C1);
    SinCos(Y_Angle,S2,C2);
    SinCos(Z_Angle,S3,C3);
    if XYZ_Not_ZYX then
    begin
        result._11 := c2*c3;
        result._12 := c2*s3;
        result._13 := -s2;
        result._21 := s1*s2*c3 - c1*s3;
        result._22 := s1*s2*s3 + c1*c3;
        result._23 := s1*c2;
        result._31 := c1*s2*c3 + s1*s3;
        result._32 := c1*s2*s3 - s1*c3;
        result._33 := c1*c2;
        result._41 := 0;
        result._42 := 0;
        result._43 := 0;
    end
    else
    begin
        result._11 := c3*c2;
        result._12 := c1*s3 + s1*s2*c3;
        result._13 := s1*s3 - c1*s2*c3;
        result._21 := -s3*c2;
        result._22 := c1*c3 - s1*s2*s3;
        result._23 := s1*c3 + c1*s2*s3;
        result._31 := s2;
        result._32 := -s1*c2 ;
        result._33 := c1*c2;
        result._41 := 0;
        result._42 := 0;
        result._43 := 0;
    end;
    if ApplyToRow4 then
        result := self.MMul(result,m)
    else
        result := self.MMul(result,m,true);
    {result := self.RotX(M     ,X_Angle,ApplyToRow4);
    result := self.RotY(result,Y_Angle,ApplyToRow4);
    result := self.RotZ(result,Z_Angle,ApplyToRow4);}
end;

function TFN3D.PreRotX(M:TMatrix3D;const Angle:extended;const ApplyToRow4:boolean):TMatrix3D;
var
    Sin_,Cos_:extended;
    xx,yy,zz,Lengs_ :TVec3D;
begin    {

         1   0   0
         0  cos sin
         0 -sin cos
         0  cos sin

         }
    lengs_.X := self.Leng(m.Row1);
    lengs_.Y := self.Leng(m.Row2);
    lengs_.Z := self.Leng(m.Row3);
    m.Row1 := self.VDiv(m.Row1,lengs_.X);
    m.Row2 := self.VDiv(m.Row2,lengs_.y);
    m.Row3 := self.VDiv(m.Row3,lengs_.z);

    sincos(angle,sin_,cos_);
    result.Row1 := m.Row1;
    result.Row2 := self.VAdd(self.VMul(cos_,m.row2) ,
                             self.VMul(sin_,m.Row3));
    result.Row3 := self.VAdd(self.VMul(-sin_,m.row2) ,
                             self.VMul( cos_,m.Row3));
    if ApplyToRow4 then
    begin
        xx := self.VMul((1 - cos_) * self.dot(m.row1,m.row4) ,m.row1);
        yy := self.VMul(sin_,self.Cross(m.Row1,m.Row4));
	    zz := self.VMul(cos_,m.Row4);
        result.Row4 := self.Vec3D(xx.X + yy.X + zz.X ,
                                  xx.Y + yy.y + zz.y ,
                                  xx.Z + yy.Z + zz.Z);
    end
    else
    begin
        result.Row4 := m.Row4;
    end;
    
    m.Row1 := self.VMul(m.Row1,lengs_.x);
    m.Row2 := self.VMul(m.Row2,lengs_.y);
    m.Row3 := self.VMul(m.Row3,lengs_.z);
end;

function TFN3D.PreRotY(M:TMatrix3D;const Angle:extended;const ApplyToRow4:boolean):TMatrix3D;
var
    Sin_,Cos_:extended;
    xx,yy,zz,Lengs_ :TVec3D;
begin    {

        cos  0 -sin
         0   0   0
        sin  0  cos

         }
    lengs_.X := self.Leng(m.Row1);
    lengs_.Y := self.Leng(m.Row2);
    lengs_.Z := self.Leng(m.Row3);
    m.Row1 := self.VDiv(m.Row1,lengs_.X);
    m.Row2 := self.VDiv(m.Row2,lengs_.y);
    m.Row3 := self.VDiv(m.Row3,lengs_.z);

    sincos(angle,sin_,cos_);
    result.Row2 := m.Row2;
    result.Row1 := self.VAdd(self.VMul(cos_,m.row1) ,
                             self.VMul(sin_,m.Row3));
    result.Row3 := self.VAdd(self.VMul(-sin_,m.row1) ,
                             self.VMul( cos_,m.Row3));
    if ApplyToRow4 then
    begin
        xx := self.VMul((cos_ - 1) * self.dot(self.Norm(m.row2),m.row4) ,m.row2);
        yy := self.VMul(-sin_,self.Cross(m.Row2,m.Row4));
	    zz := self.VMul(cos_,m.Row4);
        result.Row4 := self.Vec3D(xx.X + yy.X + zz.X ,
                                  xx.Y + yy.y + zz.y ,
                                  xx.Z + yy.Z + zz.Z);
    end
    else
    begin
        result.Row4 := m.Row4;
    end;

    m.Row1 := self.VMul(m.Row1,lengs_.x);
    m.Row2 := self.VMul(m.Row2,lengs_.y);
    m.Row3 := self.VMul(m.Row3,lengs_.z);
end;

function TFN3D.PreRotZ(M:TMatrix3D;const Angle:extended;const ApplyToRow4:boolean):TMatrix3D;
var
    Sin_,Cos_:extended;
    xx,yy,zz,Lengs_ :TVec3D;
begin    {

        cos  0  sin
       -sin  0  cos
         0   0   0

         }
    lengs_.X := self.Leng(m.Row1);
    lengs_.Y := self.Leng(m.Row2);
    lengs_.Z := self.Leng(m.Row3);
    m.Row1 := self.VDiv(m.Row1,lengs_.X);
    m.Row2 := self.VDiv(m.Row2,lengs_.y);
    m.Row3 := self.VDiv(m.Row3,lengs_.z);

    sincos(angle,sin_,cos_);
    result.Row3 := m.Row3;
    result.Row1 := self.VAdd(self.VMul( cos_,m.row1) ,
                             self.VMul(-sin_,m.Row2));
    result.Row2 := self.VAdd(self.VMul( sin_,m.row1) ,
                             self.VMul( cos_,m.Row2));
    if ApplyToRow4 then
    begin
        xx := self.VMul((1 - cos_) * self.dot(self.Norm(m.row3),m.row4) ,m.row3);
        yy := self.VMul(-sin_,self.Cross(m.Row3,m.Row4));
        zz := self.VMul(cos_,m.Row4);
        result.Row4 := self.Vec3D(xx.X + yy.X + zz.X ,
                                  xx.Y + yy.y + zz.y ,
                                  xx.Z + yy.Z + zz.Z);
    end
    else
    begin
        result.Row4 := m.Row4;
    end;

    m.Row1 := self.VMul(m.Row1,lengs_.x);
    m.Row2 := self.VMul(m.Row2,lengs_.y);
    m.Row3 := self.VMul(m.Row3,lengs_.z);
end;

function TFN3D.MAdd(const M1,M2:TMatrix3D):TMatrix3D;
begin
    result._11 := m1._11 + m2._11;
    result._12 := m1._12 + m2._12;
    result._13 := m1._13 + m2._13;
    result._21 := m1._21 + m2._21;
    result._22 := m1._22 + m2._22;
    result._23 := m1._23 + m2._23;
    result._31 := m1._31 + m2._31;
    result._32 := m1._32 + m2._32;
    result._33 := m1._33 + m2._33;
    result._41 := m1._41 + m2._41;
    result._42 := m1._42 + m2._42;
    result._43 := m1._43 + m2._43;
end;

function TFN3D.MSub(const M1,M2:TMatrix3D):TMatrix3D;
begin
    result._11 := m1._11 - m2._11;
    result._12 := m1._12 - m2._12;
    result._13 := m1._13 - m2._13;
    result._21 := m1._21 - m2._21;
    result._22 := m1._22 - m2._22;
    result._23 := m1._23 - m2._23;
    result._31 := m1._31 - m2._31;
    result._32 := m1._32 - m2._32;
    result._33 := m1._33 - m2._33;
    result._41 := m1._41 - m2._41;
    result._42 := m1._42 - m2._42;
    result._43 := m1._43 - m2._43;
end;

function TFN3D.MMul(const M1,M2:TMatrix3D):TMatrix3D;
var
    i,j: integer;
begin
    result._11 := m1._11 * m2._11 + m1._12 * m2._21 + m1._13 * m2._31;
    result._12 := m1._11 * m2._12 + m1._12 * m2._22 + m1._13 * m2._32;
    result._13 := m1._11 * m2._13 + m1._12 * m2._23 + m1._13 * m2._33;
    result._21 := m1._21 * m2._11 + m1._22 * m2._21 + m1._23 * m2._31;
    result._22 := m1._21 * m2._12 + m1._22 * m2._22 + m1._23 * m2._32;
    result._23 := m1._21 * m2._13 + m1._22 * m2._23 + m1._23 * m2._33;
    result._31 := m1._31 * m2._11 + m1._32 * m2._21 + m1._33 * m2._31;
    result._32 := m1._31 * m2._12 + m1._32 * m2._22 + m1._33 * m2._32;
    result._33 := m1._31 * m2._13 + m1._32 * m2._23 + m1._33 * m2._33;
    result._41 := m1._41 * m2._11 + m1._42 * m2._21 + m1._43 * m2._31 + m2._41;
    result._42 := m1._41 * m2._12 + m1._42 * m2._22 + m1._43 * m2._32 + m2._42;
    result._43 := m1._41 * m2._13 + m1._42 * m2._23 + m1._43 * m2._33 + m2._43;
end;

function TFN3D.MMul(const M1,M2:TMatrix3D;const Row4FromM2:boolean):TMatrix3D;
var
  I,J: Integer;
begin
    result._11 := m1._11 * m2._11 + m1._12 * m2._21 + m1._13 * m2._31;
    result._12 := m1._11 * m2._12 + m1._12 * m2._22 + m1._13 * m2._32;
    result._13 := m1._11 * m2._13 + m1._12 * m2._23 + m1._13 * m2._33;
    result._21 := m1._21 * m2._11 + m1._22 * m2._21 + m1._23 * m2._31;
    result._22 := m1._21 * m2._12 + m1._22 * m2._22 + m1._23 * m2._32;
    result._23 := m1._21 * m2._13 + m1._22 * m2._23 + m1._23 * m2._33;
    result._31 := m1._31 * m2._11 + m1._32 * m2._21 + m1._33 * m2._31;
    result._32 := m1._31 * m2._12 + m1._32 * m2._22 + m1._33 * m2._32;
    result._33 := m1._31 * m2._13 + m1._32 * m2._23 + m1._33 * m2._33;
    if Row4FromM2 then
        result.Row4 := m2.Row4
    else
        result.Row4 := m1.Row4;
end;

function TFN3D.Inverse(const M:TMatrix3D):TMatrix3D;
var
    det_: extended;
begin
    with m do
    begin
        det_ := 1.0 / (
            _11 * _22 * _33 +
            _12 * _23 * _31 +
            _13 * _21 * _32 -
            _13 * _22 * _31 -
            _12 * _21 * _33 -
            _11 * _23 * _32 );
        result._[1,1] := det_ * (_22 * _33 - _23 * _32);
        result._[1,2] := det_ * (_13 * _32 - _12 * _33);
        result._[1,3] := det_ * (_12 * _23 - _22 * _13);
        result._[2,1] := det_ * (_23 * _31 - _21 * _33);
        result._[2,2] := det_ * (_11 * _33 - _13 * _31);
        result._[2,3] := det_ * (_13 * _21 - _23 * _11);
        result._[3,1] := det_ * (_21 * _32 - _22 * _31);
        result._[3,2] := det_ * (_12 * _31 - _11 * _32);
        result._[3,3] := det_ * (_11 * _22 - _12 * _21);
        result._[4,1] := -(_11 * _41 + _12 * _42 + _13 * _43);
        result._[4,2] := -(_21 * _41 + _22 * _42 + _23 * _43);
        result._[4,3] := -(_31 * _41 + _32 * _42 + _33 * _43);
    end;
end;

function TFN3D.MovD(const M:TMatrix3d;const Dir:TVec3D;const L:extended):TMatrix3D;
begin
    result := m;
    result.Row4 := self.VAdd(m.Row4,self.VMul(l,self.Norm(Dir)));
end;

function TFN3D.MovX(const M:TMatrix3d;const L:extended):TMatrix3D;
begin
    result := m;
    result.Row4 := self.VAdd(m.Row4,self.VMul(l,self.Norm(m.Row1)));
end;

function TFN3D.MovY(const M:TMatrix3d;const L:extended):TMatrix3D;
begin
    result := m;
    result.Row4 := self.VAdd(m.Row4,self.VMul(l,self.Norm(m.Row2)));
end;

function TFN3D.MovZ(const M:TMatrix3d;const L:extended):TMatrix3D;
begin
    result := m;
    result.Row4 := self.VAdd(m.Row4,self.VMul(l,self.Norm(m.Row3)));
end;

function TFN3D.TransWith(const M,TransferM:TMatrix3D):TMatrix3D;
begin
    Self.Matrix3D(1);
end;

function TFN3D.TransWith(const V:TVec3D;const TransferM:TMatrix3D):TVec3D;
begin
    result := self.VSum([self.VMul(v.X,TransferM.Row1) ,
                         self.VMul(v.Y,TransferM.Row2) ,
                         self.VMul(v.Z,TransferM.Row3) ,
                         TransferM.Row4                ]);
end;

function TFN3D.V3DToScreen2(const V:TVec3D;const M:TMatrix3D;const FOV:extended;const Radius,CenterX,CenterY:integer):tpoint;
var
    dist_pl,x,y:extended;
    cent_pl,lv3_00,lv3_01:tvec3d;
begin
    dist_pl := self.Dot(self.VSub(v,m.Row4),m.Row3);
    dist_pl := 2 * tan(FOV / 2) * dist_pl;
    if (dist_pl = 0) then dist_pl := self.MinVal;//0.0000000000000000001;
    cent_pl := self.VSub(v,self.VAdd(m.row4,self.VMul(dist_pl,m.row3)));
    x := self.Dot(cent_pl,(m.row1)) / dist_pl;
    y := self.Dot(cent_pl,(m.row2)) / dist_pl;
    result.X := trunc(-x * radius + centerx);
    result.Y := trunc( y * radius + centery);
end;

function TFN3D.V3DToScreen(const V:TVec3D;const M:TMatrix3D;const FOV:extended;const Radius,CenterX,CenterY:integer):tpoint;
var
    v_ : tvec3d;
    //m_ : TMatrix3D;
begin
    //m_ := inverse(m);
    v_ := self.VMul(v,m);
    if (v_.Z = 0) then v_.Z := self.MinVal;//0.0000000000001;
    v_.Z := v_.Z * tan(FOV / 2.0) * 2.0;
    result.X := trunc(-v_.X / v_.Z * radius + centerx);
    result.Y := trunc( v_.Y / v_.Z * radius + centery);
end;

end.

{
*************************************************
-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
 \     _ _     _ _    _ __     _  _   _  _     \
 \     \\\_   _\\\    \\  \_    \\     \\      \
 \     \\ \_ _\ \\    \\    \   \\_____\\      \
 \     \\  \_\  \\    \\   _\   \\     \\      \
 \    _\\_  \  _\\_  _\\__\    _\\_   _\\_     \
 \                                        1388 \
-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
*************************************************
}


