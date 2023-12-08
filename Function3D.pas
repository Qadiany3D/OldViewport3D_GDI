unit Function3D;

interface

uses
    Windows, Messages, SysUtils,math,graphics,types;

const
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
    Ce           = 2.718281828459045235360287471352662497757247093699959574966;
type
     TPoint2 = class
     private
         X_:extended;
         Y_:extended;
         function GetRow(i:integer):extended;
         procedure SetRow(i:integer;Value:extended);
         function GetX:extended;
         procedure SetX(Value:extended);
         function GetY:extended;
         procedure SetY(Value:extended);
     public
         property Row[i:integer]:extended read GetRow write SetRow;
         property X:extended read GetX write SetX;
         property Y:extended read GetY write SetY;
         function AsStr(Digit:integer=17):string;
         procedure Normalize;
         function Length:extended;
         constructor Create(X,Y:extended);
         function Clone:TPoint2;
     end;

     TPoint3 = class
     private
         X_:extended;
         Y_:extended;
         Z_:extended;
         function GetRow(i:integer):extended;
         procedure SetRow(i:integer;Value:extended);
         function GetX:extended;
         procedure SetX(Value:extended);
         function GetY:extended;
         procedure SetY(Value:extended);
         function GetZ:extended;
         procedure SetZ(Value:extended);
         function GetVal:TPoint3;
         procedure SetVal(Value:TPoint3);
     public
         property Row[i:integer]:extended read GetRow write SetRow;
         property X:extended read GetX write SetX;
         property Y:extended read GetY write SetY;
         property Z:extended read GetZ write SetZ;
         property Value:TPoint3 read GetVal write SetVal;
         function AsStr(Digit:integer=17):string;
         function AsStr2(Digit:integer=17):string;
         procedure Normalize;
         function Length:extended;
         constructor Create(X,Y,Z:extended);
         function Clone:TPoint3;
     end;

     TPoint4 = class
         X:extended;
         Y:extended;
         Z:extended;
         W:extended;
     private
         function GetRow(i:integer):extended;
         procedure SetRow(i:integer;Value:extended);
     public
         property Row[i:integer]:extended read GetRow write SetRow;
         function AsStr(Digit:integer=17):string;
         procedure Normalize;
         function Length:extended;
         constructor Create(X,Y,Z,W:extended);
         function Clone:TPoint4;
     end;

     TRay = class
     private
         Position:TPoint3;
         Direction:TPoint3;
         function GetRow(i:integer):TPoint3;
         procedure SetRow(i:integer;Value:TPoint3);
         function GetPos:TPoint3;
         procedure SetPos(Value:TPoint3);
         function GetDir:TPoint3;
         procedure SetDir(Value:TPoint3);
     public
         property Row[i:integer]:TPoint3 read GetRow write SetRow;
         property Pos:TPoint3 read GetPos write SetPos;
         property Dir:TPoint3 read GetDir write SetDir;
         function AsStr(Digit:integer=17):string;
         constructor Create(
                            x1,y1,z1 ,
                            x2,y2,z2
                                     :extended);overload;
         constructor Create(Position,Direction:TPoint3);overload;
         procedure Normalize;
         function Clone:TRay;
     end;

     TMatrix3 = class
         XVec:TPoint3;
         YVec:TPoint3;
         ZVec:TPoint3;
         WVec:TPoint3;
     private
         function GetRow(i:integer):TPoint3;
         procedure SetRow(i:integer;Value:TPoint3);
         function Getij(i,j:integer):extended;
         procedure Setij(i,j:integer;Value:extended);
         function GetVal:TMatrix3;
         procedure SetVal(Value:TMatrix3);
     public
         property Row[i:integer]:TPoint3 read GetRow write SetRow;
         property Value:TMatrix3 read GetVal write SetVal;
         property ij[i,j:integer]:extended read Getij write Setij;
         function AsStr(Digit:integer=17):string;
         function AsStr2(Digit:integer=17):string;
         procedure Normalize;
         constructor Create(
                            x1,y1,z1 ,
                            x2,y2,z2 ,
                            x3,y3,z3 ,
                            x4,y4,z4
                                     :extended);overload;
         constructor Create(Row1,Row2,Row3,Row4:TPoint3);overload;
         function Clone:TMatrix3;
     end;

     TF3D = class
     private
     public
         function Limit(x,a,b:extended):extended;
         function ColorWave1(Color:extended = 0;White:extended = 0;black:extended = 0):tcolor;
         function ColorWave2(Color:extended = 0;White:extended = 0;black:extended = 0):tcolor;
         function MonoColor(c:TColor):TColor;
         function Point2(x,y:extended):TPoint2;
         function Point3(x,y,z:extended):TPoint3;
         function Point4(x,y,z,w:extended):TPoint4;
         function AddVec(v,s:TPoint2):TPoint2;overload;
         function AddVec(v,s:TPoint3):TPoint3;overload;
         function AddVec(v,s:TPoint4):TPoint4;overload;
         function SubtractVec(v,s:TPoint2):TPoint2;overload;
         function SubtractVec(v,s:TPoint3):TPoint3;overload;
         function SubtractVec(v,s:TPoint4):TPoint4;overload;
         function MultiplyVec(v,s:TPoint2):TPoint2;overload;
         function MultiplyVec(v,s:TPoint3):TPoint3;overload;
         function MultiplyVec(v,s:TPoint4):TPoint4;overload;
         function MultiplyVec(X:Extended;v:TPoint2):TPoint2;overload;
         function MultiplyVec(X:Extended;v:TPoint3):TPoint3;overload;
         function MultiplyVec(X:Extended;v:TPoint4):TPoint4;overload;
         function DivideVec(v,s:TPoint2):TPoint2;overload;
         function DivideVec(v,s:TPoint3):TPoint3;overload;
         function DivideVec(v,s:TPoint4):TPoint4;overload;
         function DivideVec(v:TPoint2;X:Extended):TPoint2;overload;
         function DivideVec(v:TPoint3;X:Extended):TPoint3;overload;
         function DivideVec(v:TPoint4;X:Extended):TPoint4;overload;
         function DivideVec(X:Extended;v:TPoint2):TPoint2;overload;
         function DivideVec(X:Extended;v:TPoint3):TPoint3;overload;
         function DivideVec(X:Extended;v:TPoint4):TPoint4;overload;
         function LengthVec(v:TPoint2):Extended;overload;
         function LengthVec(v:TPoint3):Extended;overload;
         function LengthVec(v:TPoint4):Extended;overload;
         function Normalize(v:TPoint2):TPoint2;overload;
         function Normalize(v:TPoint3):TPoint3;overload;
         function Normalize(v:TPoint4):TPoint4;overload;
         function Distance(v,s:TPoint2):extended;overload;
         function Distance(v,s:TPoint3):extended;overload;
         function Distance(v,s:TPoint4):extended;overload;
         function Dot(v,s:TPoint2):Extended;overload;
         function Dot(v,s:TPoint3):Extended;overload;
         function Dot(v,s:TPoint4):Extended;overload;
         function Cross(v,s:TPoint3):TPoint3;
         function DoorBin(Point3D:TPoint3;M:TMatrix3;FieldOfView:Extended):TPoint2;
         function DoorBinint(Point3D:TPoint3;M:TMatrix3;FieldOfView:Extended;Multi:integer;CenterX,CenterY:integer):TPoint;
         function RotateX(M:TMatrix3;Angle:extended):TMatrix3;
         function RotateY(M:TMatrix3;Angle:extended):TMatrix3;
         function RotateZ(M:TMatrix3;Angle:extended):TMatrix3;
         function PreRotateX(M:TMatrix3;Angle:extended;ApplyToRow4:boolean):TMatrix3;
         function PreRotateY(M:TMatrix3;Angle:extended;ApplyToRow4:boolean):TMatrix3;
         function PreRotateZ(M:TMatrix3;Angle:extended;ApplyToRow4:boolean):TMatrix3;
         //function PreRotateX(M:TMatrix3;Angle:extended;DirFromRow3:boolean):TMatrix3;overload;
         //function PreRotateY(M:TMatrix3;Angle:extended):TMatrix3;overload;
         //function PreRotateZ(M:TMatrix3;Angle:extended):TMatrix3;overload;
         function RotateByRay(P:TPoint3;Ray:TRay;Angle:extended):TPoint3;
     end;

implementation

function StrFromFloat(x:extended;digit:integer):string;
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

{M3D.Functions...}

function TF3D.Limit(x,a,b:extended):extended;
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

function TF3D.ColorWave1(Color:extended = 0;White:extended = 0;black:extended = 0):tcolor;
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

function TF3D.ColorWave2(Color:extended = 0;White:extended = 0;black:extended = 0):tcolor;
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

function TF3D.MonoColor(c:TColor):TColor;
var
    x:integer;
begin
    x := (getrvalue(c) + getgvalue(c) + getbvalue(c)) div 3;
    result := rgb(x,x,x);
end;

function TF3D.Point2(x,y:extended):TPoint2;
begin
    result := tpoint2.Create(x,y);
end;

function TF3D.Point3(x,y,z:extended):TPoint3;
begin
    result := tpoint3.Create(x,y,z);
end;

function TF3D.Point4(x,y,z,w:extended):TPoint4;
begin
    result := tpoint4.Create(x,y,z,w);
end;

function TF3D.LengthVec(v:TPoint2):extended;
begin
    result := sqrt(sqr(v.X) +
                   sqr(v.Y));
end;

function TF3D.LengthVec(v:TPoint3):extended;
begin
    result := sqrt(sqr(v.X) +
                   sqr(v.Y) +
                   sqr(v.Z));
end;

function TF3D.LengthVec(v:TPoint4):extended;
begin
    result := sqrt(sqr(v.X) +
                   sqr(v.Y) +
                   sqr(v.Z) +
                   sqr(v.W));
end;

function TF3D.Normalize(v:TPoint2):TPoint2;
var
   L:extended;
begin
    L := sqrt(sqr(v.X) +
              sqr(v.Y));
    if l = 0 then l := 0.00000000000000000001;
    result := tpoint2.Create(v.X / l ,
                             v.Y / l);
end;

function TF3D.Normalize(v:TPoint3):TPoint3;
var
   L:extended;
begin
    L := sqrt(sqr(v.X) +
              sqr(v.Y) +
              sqr(v.Z));
    if l = 0 then l := 0.00000000000000000001;
    result := tpoint3.Create(v.X / l ,
                             v.Y / l ,
                             v.Z / l);
end;

function TF3D.Normalize(v:TPoint4):TPoint4;
var
   L:extended;
begin
    L := sqrt(sqr(v.X) +
              sqr(v.Y) +
              sqr(v.Z) +
              sqr(v.W));
    if l = 0 then l := 0.00000000000000000001;
    result := tpoint4.Create(v.X / l ,
                             v.Y / l ,
                             v.Z / l ,
                             v.W / l);
end;

function TF3D.Distance(v,s:TPoint2):extended;
begin
    result := sqrt(sqr(v.X - s.X) +
                   sqr(v.Y - s.Y));
end;

function TF3D.Distance(v,s:TPoint3):extended;
begin
    result := sqrt(sqr(v.X - s.X) +
                   sqr(v.Y - s.Y) +
                   sqr(v.Z - s.Z));
end;

function TF3D.Distance(v,s:TPoint4):extended;
begin
    result := sqrt(sqr(v.X - s.X) +
                   sqr(v.Y - s.Y) +
                   sqr(v.Z - s.Z) +
                   sqr(v.W - s.W));
end;

function TF3D.Dot(v,s:TPoint2):extended;
begin
    result := v.X * s.X +
              v.Y * s.Y;
end;

function TF3D.Dot(v,s:TPoint3):extended;
begin
    result := v.X * s.X +
              v.Y * s.Y +
              v.Z * s.Z;
end;

function TF3D.Dot(v,s:TPoint4):extended;
begin
    result := v.X * s.X +
              v.Y * s.Y +
              v.Z * s.Z +
              v.W * s.W;
end;

function TF3D.Cross(v,s:TPoint3):TPoint3;
begin
    result := tpoint3.Create(v.Y * s.Z - v.Z * s.Y ,
                             v.z * s.x - v.x * s.z ,
                             v.x * s.y - v.y * s.X);
end;

function TF3D.DoorBin(Point3D:TPoint3;M:TMatrix3;FieldOfView:Extended):TPoint2;
var
    dist_pl{Distance From Plane},x,y:extended;
    cent_pl,lv3_00,lv3_01:tpoint3;
begin
    lv3_00 := self.SubtractVec(Point3D,m.Row[4]);
    dist_pl := self.Dot(lv3_00,m.Row[3]);                              {dot (p - m.row4) (m.row3)}
    lv3_00.Free;
    if FieldOfView < 0.00000000000000000001 then FieldOfView := 0.00000000000000000001;
    if (dist_pl = 0) then dist_pl := 0.0000000000000000001;
    dist_pl := FieldOfView / dist_pl;
    lv3_00 := self.MultiplyVec(1/dist_pl,m.row[3]);
    lv3_01 := self.AddVec(m.row[4],lv3_00);                                   {m.row4 + (dist_pl * m.row3)}
    cent_pl := self.SubtractVec(Point3D,lv3_01);
    x := self.Dot(cent_pl,(m.row[1])) * dist_pl;                                          {dot (p - cent_pl) (m.row1)}
    y := self.Dot(cent_pl,(m.row[2])) * dist_pl;                                          {dot (p - cent_pl) (m.row2)}
    result := self.Point2(-x,y);
    cent_pl.Free;
    lv3_00.Free;
    lv3_01.Free;
end;

function TF3D.DoorBinint(Point3D:TPoint3;M:TMatrix3;FieldOfView:Extended;Multi:integer;CenterX,CenterY:integer):TPoint;
var
    dist_pl{Distance From Plane},x,y:extended;
    cent_pl,lv3_00,lv3_01:tpoint3;
begin
    lv3_00 := self.SubtractVec(Point3D,m.Row[4]);
    dist_pl := self.Dot(lv3_00,m.Row[3]);                              {dot (p - m.row4) (m.row3)}
    lv3_00.Free;
    if FieldOfView < 0.000000000000001 then FieldOfView := 0.000000000000001;
    dist_pl := dist_pl / FieldOfView;
    if (dist_pl = 0) then dist_pl := 0.00000000000001;
    lv3_00 := self.MultiplyVec(dist_pl,m.row[3]);
    lv3_01 := self.AddVec(m.row[4],lv3_00);                                   {m.row4 + (dist_pl * m.row3)}
    cent_pl := self.SubtractVec(Point3D,lv3_01);
    x := self.Dot(cent_pl,(m.row[1])) / dist_pl;                                          {dot (p - cent_pl) (m.row1)}
    y := self.Dot(cent_pl,(m.row[2])) / dist_pl;                                          {dot (p - cent_pl) (m.row2)}
    result := Point(trunc(-x * multi + centerx) ,
                    trunc( y * multi + centery));
    cent_pl.Free;
    lv3_00.Free;
    lv3_01.Free;
end;

function TF3D.RotateX(M:TMatrix3;Angle:extended):TMatrix3;
var
    Sin_,Cos_:extended;
begin
    result := m.Clone;
    sincos(angle,sin_,cos_);
    result.ij[1,2] := m.ij[1,2] * cos_ - m.ij[1,3] * sin_;
    result.ij[1,3] := m.ij[1,2] * sin_ + m.ij[1,3] * cos_;
    result.ij[2,2] := m.ij[2,2] * cos_ - m.ij[2,3] * sin_;
    result.ij[2,3] := m.ij[2,2] * sin_ + m.ij[2,3] * cos_;
    result.ij[3,2] := m.ij[3,2] * cos_ - m.ij[3,3] * sin_;
    result.ij[3,3] := m.ij[3,2] * sin_ + m.ij[3,3] * cos_;
    result.ij[4,2] := m.ij[4,2] * cos_ - m.ij[4,3] * sin_;
    result.ij[4,3] := m.ij[4,2] * sin_ + m.ij[4,3] * cos_;
end;

function TF3D.RotateY(M:TMatrix3;Angle:extended):TMatrix3;
var
    Sin_,Cos_:extended;
begin
    result := m.Clone;
    sincos(angle,sin_,cos_);
    result.ij[1,3] := m.ij[1,3] * cos_ - m.ij[1,1] * sin_;
    result.ij[1,1] := m.ij[1,3] * sin_ + m.ij[1,1] * cos_;
    result.ij[2,3] := m.ij[2,3] * cos_ - m.ij[2,1] * sin_;
    result.ij[2,1] := m.ij[2,3] * sin_ + m.ij[2,1] * cos_;
    result.ij[3,3] := m.ij[3,3] * cos_ - m.ij[3,1] * sin_;
    result.ij[3,1] := m.ij[3,3] * sin_ + m.ij[3,1] * cos_;
    result.ij[4,3] := m.ij[4,3] * cos_ - m.ij[4,1] * sin_;
    result.ij[4,1] := m.ij[4,3] * sin_ + m.ij[4,1] * cos_;
end;

function TF3D.RotateZ(M:TMatrix3;Angle:extended):TMatrix3;
var
    Sin_,Cos_:extended;
begin
    result := m.Clone;
    sincos(angle,sin_,cos_);
    result.ij[1,1] := m.ij[1,1] * cos_ - m.ij[1,2] * sin_;
    result.ij[1,2] := m.ij[1,1] * sin_ + m.ij[1,2] * cos_;
    result.ij[2,1] := m.ij[2,1] * cos_ - m.ij[2,2] * sin_;
    result.ij[2,2] := m.ij[2,1] * sin_ + m.ij[2,2] * cos_;
    result.ij[3,1] := m.ij[3,1] * cos_ - m.ij[3,2] * sin_;
    result.ij[3,2] := m.ij[3,1] * sin_ + m.ij[3,2] * cos_;
    result.ij[4,1] := m.ij[4,1] * cos_ - m.ij[4,2] * sin_;
    result.ij[4,2] := m.ij[4,1] * sin_ + m.ij[4,2] * cos_;
end;

{function TF3D.PreRotateX(M:TMatrix3;Angle:extended):TMatrix3;
var
    Sin_,Cos_:extended;
    yy,zz :tpoint3;
begin}    {

         1   0   0
         0  cos sin
         0 -sin cos
         0  cos sin

         }
    {sincos(angle,sin_,cos_);
    result := tmatrix3.Create;
    result.Row[1] := m.Row[1];

    yy := self.MultiplyVec(cos_,m.row[2]);
    zz := self.MultiplyVec(sin_,m.Row[3]);
    result.Row[2] := self.AddVec(yy,zz);
    yy.Free;
    zz.Free;
    yy := self.MultiplyVec(-sin_,m.row[2]);
    zz := self.MultiplyVec(cos_,m.Row[3]);
    result.Row[3] := self.AddVec(yy,zz);
    yy.Free;
    zz.Free;

    result.Row[4] := m.Row[4].Clone;
    }
    {
    yy := self.MultiplyVec(sin_,self.Cross(m.row[1],m.row[4]));
	zz :=  self.MultiplyVec(cos_,m.Row[4]);
    result.Row[4] := self.AddVec(yy,zz);
    }

    {
    ww := tpoint3.Create(self.Dot(m.Row[1],m.Row[4]) ,       //do matrix rotation = 0
                         self.Dot(m.Row[2],m.Row[4]) ,
                         self.Dot(m.Row[3],m.Row[4]));
    ww.Y := -sin_ * ww.Y;                                    //rotate matrix
    ww.Z :=  cos_ * ww.Z;

    xx := self.MultiplyVec(ww.X,m.row[1]);                   //put to matrix
    yy := self.MultiplyVec(ww.Y,m.row[2]);
    zz := self.MultiplyVec(ww.Z,m.Row[3]);
    ww := tpoint3.Create(xx.x + yy.X + zz.X ,
                         xx.y + yy.y + zz.Y ,
                         xx.Z + yy.Z + zz.Z);
    }
    //
    {yy := tpoint3.Create(self.Dot(lm.row[1],m.Row[2]) ,
                         self.Dot(lm.row[2],m.Row[2]) ,
                         self.Dot(lm.row[3],m.Row[2]));
    zz := tpoint3.Create(self.Dot(lm.row[1],m.Row[3]) ,
                         self.Dot(lm.row[2],m.Row[3]) ,
                         self.Dot(lm.row[3],m.Row[3]));
    {ww := tpoint3.Create(self.Dot(lm.row[1],m.Row[4]) ,
                         self.Dot(lm.row[2],m.Row[4]) ,
                         self.Dot(lm.row[3],m.Row[4]));
    result := tmatrix3.Create(m.Row[1],yy,zz,m.Row[4]);}
{end;}

function TF3D.PreRotateX(M:TMatrix3;Angle:extended;ApplyToRow4:boolean):TMatrix3;
var
    Sin_,Cos_,xl,yl,zl:extended;
    xx,yy,zz,lv3_00 :tpoint3;
begin    {

         1   0   0
         0  cos sin
         0 -sin cos
         0  cos sin

         }
    xl := m.Row[1].Length;
    yl := m.Row[2].Length;
    zl := m.Row[3].Length;
    m.Normalize;
    sincos(angle,sin_,cos_);
    result := tmatrix3.Create;
    result.Row[1] := m.Row[1];
    yy := self.MultiplyVec(cos_,m.row[2]);
    zz := self.MultiplyVec(sin_,m.Row[3]);
    result.Row[2] := self.AddVec(yy,zz);
    yy.Free;
    zz.Free;
    yy := self.MultiplyVec(-sin_,m.row[2]);
    zz := self.MultiplyVec(cos_,m.Row[3]);
    result.Row[3] := self.AddVec(yy,zz);
    yy.Free;
    zz.Free;
    if ApplyToRow4 then
    begin
        xx := self.MultiplyVec(
                                (1 - cos_) * self.dot(m.Row[1],m.row[4]) ,
                                m.Row[1]
                               );
        lv3_00 := self.Cross(m.row[1],m.row[4]);
        yy := self.MultiplyVec(sin_,lv3_00);
	    zz :=  self.MultiplyVec(cos_,m.Row[4]);
        lv3_00.Free;
        result.Row[4] := point3(xx.X + yy.X + zz.X ,
                                xx.Y + yy.y + zz.y ,
                                xx.Z + yy.Z + zz.Z);
        xx.Free;
        yy.Free;
        zz.Free;
    end
    else
    begin
        result.Row[4] := m.Row[4];
    end;
    result.Row[1].Value := self.MultiplyVec(xl,result.Row[1]);
    result.Row[2].Value := self.MultiplyVec(yl,result.Row[2]);
    result.Row[3].Value := self.MultiplyVec(zl,result.Row[3]);
end;

function TF3D.PreRotateY(M:TMatrix3;Angle:extended;ApplyToRow4:boolean):TMatrix3;
var
    Sin_,Cos_,xl,yl,zl:extended;
    xx,yy,zz,lv3_00 :tpoint3;
begin    {

        cos  0 -sin
         0   0   0
        sin  0  cos

         }
    xl := m.Row[1].Length;
    yl := m.Row[2].Length;
    zl := m.Row[3].Length;
    m.Normalize;
    sincos(angle,sin_,cos_);
    result := tmatrix3.Create;
    result.Row[2] := m.Row[2];

    xx := self.MultiplyVec(cos_,m.row[1]);
    zz := self.MultiplyVec(sin_,m.Row[3]);
    result.Row[1] := tpoint3.Create(xx.X + zz.X ,
                                    xx.Y + zz.Y ,
                                    xx.Z + zz.Z);
    xx.Free;
    zz.Free;
    xx := self.MultiplyVec(-sin_,m.row[1]);
    zz := self.MultiplyVec(cos_,m.Row[3]);
    result.Row[3] := tpoint3.Create(xx.X + zz.X ,
                                    xx.Y + zz.Y ,
                                    xx.Z + zz.Z);
    xx.Free;
    zz.Free;
    if ApplyToRow4 then
    begin
        lv3_00 := self.normalize(m.row[2]);
        xx := self.MultiplyVec(
                                -(1 - cos_) * self.dot(lv3_00,m.row[4]) ,
                                m.row[2]
                               );
        lv3_00.Free;
        lv3_00 := self.Cross(m.row[2],m.row[4]);
        yy := self.MultiplyVec(-sin_,lv3_00);
	    zz :=  self.MultiplyVec(cos_,m.Row[4]);
        result.Row[4] := point3(xx.X + yy.X + zz.X ,
                                xx.Y + yy.y + zz.y ,
                                xx.Z + yy.Z + zz.Z);
        lv3_00.Free;
        xx.free;
        yy.Free;
        zz.Free;
    end
    else
    begin
        result.Row[4] := m.Row[4];
    end;
    result.Row[1].Value := self.MultiplyVec(xl,result.Row[1]);
    result.Row[2].Value := self.MultiplyVec(yl,result.Row[2]);
    result.Row[3].Value := self.MultiplyVec(zl,result.Row[3]);
end;

function TF3D.PreRotateZ(M:TMatrix3;Angle:extended;ApplyToRow4:boolean):TMatrix3;
var
    Sin_,Cos_,xl,yl,zl:extended;
    xx,yy,zz,lv3_00 :tpoint3;
begin    {

        cos  0  sin
       -sin  0  cos
         0   0   0

         }
    xl := m.Row[1].Length;
    yl := m.Row[2].Length;
    zl := m.Row[3].Length;
    m.Normalize;     
    sincos(angle,sin_,cos_);
    result := tmatrix3.Create;
    result.Row[3] := m.Row[3];

    xx := self.MultiplyVec(cos_,m.row[1]);
    yy := self.MultiplyVec(-sin_,m.Row[2]);
    result.Row[1] := tpoint3.Create(xx.X + yy.X ,
                                    xx.Y + yy.Y ,
                                    xx.Z + yy.Z);
    xx.Free;
    yy.Free;
    xx := self.MultiplyVec(sin_,m.row[1]);
    yy := self.MultiplyVec(cos_,m.Row[2]);
    result.Row[2] := tpoint3.Create(xx.X + yy.X ,
                                    xx.Y + yy.Y ,
                                    xx.Z + yy.Z);
    xx.Free;
    yy.Free;
    if ApplyToRow4 then
    begin
        lv3_00 := self.normalize(m.row[3]);
        xx := self.MultiplyVec(
                                (1 - cos_) * self.dot(lv3_00,m.row[4]) ,
                                m.row[3]
                               );
        lv3_00.free;
        lv3_00 := self.Cross(m.row[3],m.row[4]);
        yy := self.MultiplyVec(-sin_,lv3_00);
	    zz :=  self.MultiplyVec(cos_,m.Row[4]);
        result.Row[4] := point3(xx.X + yy.X + zz.X ,
                                xx.Y + yy.y + zz.y ,
                                xx.Z + yy.Z + zz.Z);
        lv3_00.free;
        xx.Free;
        yy.Free;
        zz.Free;
    end
    else
    begin
        result.Row[4] := m.Row[4];
    end;
    result.Row[1].Value := self.MultiplyVec(xl,result.Row[1]);
    result.Row[2].Value := self.MultiplyVec(yl,result.Row[2]);
    result.Row[3].Value := self.MultiplyVec(zl,result.Row[3]);
end;

function TF3D.RotateByRay(P:TPoint3;Ray:TRay;Angle:extended):TPoint3;
begin

end;

function TF3D.AddVec(v,s:TPoint2):TPoint2;
begin
    result := tpoint2.Create(v.X + s.X ,
                             v.Y + s.Y);
end;

function TF3D.AddVec(v,s:TPoint3):TPoint3;
begin
    result := tpoint3.Create(v.X + s.X ,
                             v.Y + s.Y ,
                             v.Z + s.Z);
end;

function TF3D.AddVec(v,s:TPoint4):TPoint4;
begin
    result := tpoint4.Create(v.X + s.X ,
                             v.Y + s.Y ,
                             v.Z + s.Z ,
                             v.W + s.W);
end;

function TF3D.SubtractVec(v,s:TPoint2):TPoint2;
begin
    result := tpoint2.Create(v.X - s.X ,
                             v.Y - s.Y);
end;

function TF3D.SubtractVec(v,s:TPoint3):TPoint3;
begin
    result := tpoint3.Create(v.X - s.X ,
                             v.Y - s.Y ,
                             v.Z - s.Z);
end;

function TF3D.SubtractVec(v,s:TPoint4):TPoint4;
begin
    result := tpoint4.Create(v.X - s.X ,
                             v.Y - s.Y ,
                             v.Z - s.Z ,
                             v.W - s.W);
end;

function TF3D.MultiplyVec(v,s:TPoint2):TPoint2;
begin
    result := tpoint2.Create(v.X * s.X ,
                             v.Y * s.Y);
end;

function TF3D.MultiplyVec(v,s:TPoint3):TPoint3;
begin
    result := tpoint3.Create(v.X * s.X ,
                             v.Y * s.Y ,
                             v.Z * s.Z);
end;

function TF3D.MultiplyVec(v,s:TPoint4):TPoint4;
begin
    result := tpoint4.Create(v.X * s.X ,
                             v.Y * s.Y ,
                             v.Z * s.Z ,
                             v.W * s.W);
end;

function TF3D.MultiplyVec(X:Extended;v:TPoint2):TPoint2;
begin
    result := tpoint2.Create(v.X * x ,
                             v.Y * x);
end;

function TF3D.MultiplyVec(X:Extended;v:TPoint3):TPoint3;
begin
    result := tpoint3.Create(v.X * x ,
                             v.Y * x ,
                             v.Z * x);
end;

function TF3D.MultiplyVec(X:Extended;v:TPoint4):TPoint4;
begin
    result := tpoint4.Create(v.X * x ,
                             v.Y * x ,
                             v.Z * x ,
                             v.W * x);
end;

function TF3D.DivideVec(v,s:TPoint2):TPoint2;
var
    i:integer;
begin
    for i := 1 to 2 do
    begin
        if s.Row[i] = 0 then s.Row[i] := 0.00000000000000000001;
    end;
    result := tpoint2.Create(v.X / s.X ,
                             v.Y / s.Y);
end;

function TF3D.DivideVec(v,s:TPoint3):TPoint3;
var
    i:integer;
begin
    for i := 1 to 3 do
    begin
        if s.Row[i] = 0 then s.Row[i] := 0.00000000000000000001;
    end;
    result := tpoint3.Create(v.X / s.X ,
                             v.Y / s.Y ,
                             v.Z / s.Z);
end;

function TF3D.DivideVec(v,s:TPoint4):TPoint4;
var
    i:integer;
begin
    for i := 1 to 4 do
    begin
        if s.Row[i] = 0 then s.Row[i] := 0.00000000000000000001;
    end;
    result := tpoint4.Create(v.X / s.X ,
                             v.Y / s.Y ,
                             v.Z / s.Z ,
                             v.W / s.W);
end;

function TF3D.DivideVec(v:TPoint2;X:Extended):TPoint2;
begin
     if x = 0 then x := 0.00000000000000000001;
     result := tpoint2.Create(v.X / x ,
                              v.Y / x);
end;

function TF3D.DivideVec(v:TPoint3;X:Extended):TPoint3;
begin
     if x = 0 then x := 0.00000000000000000001;
     result := tpoint3.Create(v.X / x ,
                              v.Y / x ,
                              v.Z / x);
end;

function TF3D.DivideVec(v:TPoint4;X:Extended):TPoint4;
begin
     if x = 0 then x := 0.00000000000000000001;
     result := tpoint4.Create(v.X / x ,
                              v.Y / x ,
                              v.Z / x ,
                              v.W / x);
end;

function TF3D.DivideVec(X:Extended;v:TPoint2):TPoint2;
var
    i:integer;
begin
    for i := 1 to 2 do
    begin
        if v.Row[i] = 0 then v.Row[i] := 0.00000000000000000001;
    end;
    result := tpoint2.Create(x / v.X ,
                             x / v.Y);
end;

function TF3D.DivideVec(X:Extended;v:TPoint3):TPoint3;
var
    i:integer;
begin
    for i := 1 to 3 do
    begin
        if v.Row[i] = 0 then v.Row[i] := 0.00000000000000000001;
    end;
    result := tpoint3.Create(x / v.X ,
                             x / v.Y ,
                             x / v.Z);
end;

function TF3D.DivideVec(X:Extended;v:TPoint4):TPoint4;
var
    i:integer;
begin
    for i := 1 to 4 do
    begin
        if v.Row[i] = 0 then v.Row[i] := 0.00000000000000000001;
    end;
    result := tpoint4.Create(x / v.X ,
                             x / v.Y ,
                             x / v.Z ,
                             x / v.W);
end;

{____________________}
{____________________}
{____________________}
{____________________}
{TPoint2.Functions...}

function Tpoint2.GetRow(i: Integer):extended;
begin
    if i = 1 then
    begin
        result := self.x;
    end
    else
    begin
        result := self.y;
    end;
end;

function Tpoint2.GetX:extended;
begin
    result := self.X_;
end;

procedure Tpoint2.SetX(Value:extended);
begin
    if value = 0 then value := 0.00000000000000000001;
    self.X_ := value;
end;

function Tpoint2.GetY:extended;
begin
    result := self.Y_;
end;

procedure Tpoint2.SetY(Value:extended);
begin
    if value = 0 then value := 0.00000000000000000001;
    self.Y_ := value;
end;

procedure Tpoint2.SetRow(i: integer; Value: Extended);
begin
    case i of
        1 : self.x := Value;
        2 : self.y := Value;
    end;
end;

constructor TPoint2.Create(X,Y:extended);
begin
    self.X := x;
    self.Y := y;
end;

function Tpoint2.Clone:TPoint2;
begin
    result := tpoint2.Create(x,y);
end;

function Tpoint2.AsStr(Digit:integer=17):string;
begin
     result := '[' +
          strfromfloat(self.X,digit) +
          ', ' +
          strfromfloat(self.y,digit) +
          ']';
end;

procedure Tpoint2.Normalize;
var
    x:extended;
begin
    x := sqrt(sqr(self.X) + sqr(self.Y));
    if x = 0 then x := 0.00000000000000000001;
    self.X := self.X / x;
    self.Y := self.Y / x;
end;

function TPoint2.Length:extended;
begin
    result := sqrt(sqr(x) + sqr(y));
end;

{TPoint3 Functions}

function Tpoint3.GetX:extended;
begin
    result := self.X_;
end;

procedure Tpoint3.SetX(Value:extended);
begin
    if value = 0 then value := 0.00000000000000000001;
    self.X_ := value;
end;

function Tpoint3.GetY:extended;
begin
    result := self.Y_;
end;

procedure Tpoint3.SetY(Value:extended);
begin
    if value = 0 then value := 0.00000000000000000001;
    self.Y_ := value;
end;

function Tpoint3.GetZ:extended;
begin
    result := self.z_;
end;

procedure Tpoint3.SetZ(Value:extended);
begin
    if value = 0 then value := 0.00000000000000000001;
    self.z_ := value;
end;


function Tpoint3.GetRow(i: Integer):extended;
begin
    case i of
        1 : result := self.x;
        2 : result := self.y;
        3 : result := self.z;
    end;
end;

procedure Tpoint3.SetRow(i: integer; Value: Extended);
begin
    case i of
        1 : self.x := Value;
        2 : self.y := Value;
        3 : self.z := Value;
    end;
end;

function TPOint3.GetVal:TPoint3;
begin
    result := self;
end;

procedure TPoint3.SetVal(Value:TPoint3);
begin
    self.X := value.X;
    self.Y := value.Y;
    self.Z := value.Z;
end;

constructor TPoint3.Create(X,Y,Z:extended);
begin
    self.X := x;
    self.Y := y;
    self.Z := z;
end;

function Tpoint3.Clone:TPoint3;
begin
    result := tpoint3.Create(x,y,z);
end;

function Tpoint3.AsStr(Digit:integer=17):string;
begin
     result := '[' +
          strfromfloat(self.X,digit) +
          ', ' +
          strfromfloat(self.y,digit) +
          ', ' +
          strfromfloat(self.z,digit) +
          ']';
end;

function Tpoint3.AsStr2(Digit:integer=17):string;
begin
     result := strfromfloat(self.X,digit) +
               #13#09#13#09 +
               strfromfloat(self.y,digit) +
               #13#09#13#09 +
               strfromfloat(self.z,digit) ;
end;

procedure Tpoint3.Normalize;
var
    x:extended;
begin
    x := sqrt(sqr(self.X) +
              sqr(self.Y) +
              sqr(self.z));
    if x = 0 then x := 0.00000000000000000001;
    self.X := self.X / x;
    self.Y := self.Y / x;
    self.z := self.z / x;
end;

function TPoint3.Length:extended;
begin
    result := sqrt(sqr(x) + sqr(y) + sqr(z));
end;

function Tpoint4.GetRow(i: Integer):extended;
begin
    case i of
        1 : result := self.x;
        2 : result := self.y;
        3 : result := self.z;
        4 : result := self.w;
    end;
end;

procedure Tpoint4.SetRow(i: integer; Value: Extended);
begin
    case i of
        1 : self.x := Value;
        2 : self.y := Value;
        3 : self.z := Value;
        4 : self.w := Value;
    end;
end;

constructor TPoint4.Create(X,Y,Z,W:extended);
begin
    self.X := x;
    self.Y := y;
    self.Z := z;
    self.W := w;
end;

function Tpoint4.Clone:TPoint4;
begin
    result := tpoint4.Create(x,y,z,w);
end;

function Tpoint4.AsStr(Digit:integer=17):string;
begin
     result := '[' +
          strfromfloat(self.X,digit) +
          ', ' +
          strfromfloat(self.y,digit) +
          ', ' +
          strfromfloat(self.z,digit) +
          ', ' +
          strfromfloat(self.w,digit) +
          ']';
end;

procedure Tpoint4.Normalize;
var
    x:extended;
begin
    x := sqrt(sqr(self.X) +
              sqr(self.Y) +
              sqr(self.z) +
              sqr(self.w));
    if x = 0 then x := 0.00000000000000000001;
    self.X := self.X / x;
    self.Y := self.Y / x;
    self.z := self.z / x;
    self.z := self.z / x;
end;

function TPoint4.Length:extended;
begin
    result := sqrt(sqr(x) + sqr(y) + sqr(z) + sqr(w));
end;

function TMatrix3.GetRow(i: Integer):TPoint3;
begin
    case i of
        1 : result := self.XVec;
        2 : result := self.YVec;
        3 : result := self.ZVec;
        4 : result := self.WVec;
    end;
end;

function TMatrix3.GetVal:TMatrix3;
begin
    result := self;
end;

procedure TMatrix3.SetVal(Value:TMatrix3);
var
    i:Shortint;
begin
    if self = nil then
        self := TMatrix3.Create;
    for i := 1 to 4 do self.Row[i].Value := value.Row[i];
end;

{______________}
{______________}
{TRay Functions}
{______________}
{______________}

function TRay.GetRow(i: Integer):TPoint3;
begin
    case i of
        1 : result := self.Position;
        2 : result := self.Direction;
    end;
end;

function TRay.GetPos:TPoint3;
begin
    result := self.Position;
end;

procedure TRay.SetPos(value:TPoint3);
begin
    self.Position := value;
end;

function TRay.GetDir:TPoint3;
begin
    result := self.Direction;
end;

procedure TRay.SetDir(value:TPoint3);
begin
    value.Normalize;
    self.Direction := value;
end;


procedure TRay.SetRow(i: integer; Value: TPoint3);
begin
    case i of
        1 : self.Pos := Value;
        2 : self.Dir := Value;
    end;
end;

function TRay.AsStr(Digit:integer=17):string;
begin
    result := '(Ray ' +
        self.Position.AsStr(digit) +
        ' ' +
        self.Direction.AsStr(digit) +
        ')';
end;

constructor TRay.Create(x1,y1,z1,x2,y2,z2:extended);
begin
    self.Position := tpoint3.Create(x1,y1,z1);
    self.Direction := tpoint3.Create(x2,y2,z2);
end;

constructor TRay.Create(Position,Direction:TPoint3);
begin
     self.Position := Position.Clone;
     self.Direction := Direction.Clone;
end;

function TRay.Clone:TRay;
begin
    result := TRay.Create(self.Position.Clone ,
                          self.Direction.Clone);
end;

procedure TRay.Normalize;
begin
    self.Direction.Normalize;
end;

{__________________}
{__________________}
{TMatrix3 Functions}
{__________________}
{__________________}
procedure TMatrix3.SetRow(i: integer; Value: TPoint3);
begin
    case i of
        1 : begin
                self.XVec := Value;
            end;
        2 : begin
                //self.YVec.Free;
                self.YVec := Value;
            end;
        3 : begin
                //self.ZVec.Free;
                self.ZVec := Value;
            end;
        4 : begin
                //self.WVec.Free;
                self.WVec := Value;
            end;    
    end;
end;

procedure TMatrix3.Setij(i,j:integer;Value:extended);
begin
    self.Row[i].Row[j] := value;
end;

function TMatrix3.Getij(i,j:integer):extended;
begin
    result := self.Row[i].Row[j];
end;

function TMatrix3.AsStr(Digit:integer=17):string;
begin
    result := '(Matrix3 ' +
        self.XVec.AsStr(digit) +
        ' ' +
        self.YVec.AsStr(digit) +
        ' ' +
        self.ZVec.AsStr(digit) +
        ' ' +
        self.WVec.AsStr(digit) +
        ')';
end;

function TMatrix3.AsStr2(Digit:integer=17):string;
begin
    result := 'Matrix3 '#13#10 +
        self.XVec.AsStr2(digit) +
        #13#10 +
        self.YVec.AsStr2(digit) +
        #13#10 +
        self.ZVec.AsStr2(digit) +
        #13#10 +
        self.WVec.AsStr2(digit) ;
end;

constructor TMatrix3.Create(x1,y1,z1 ,
                            x2,y2,z2 ,
                            x3,y3,z3 ,
                            x4,y4,z4 :extended);
begin
    self.XVec := tpoint3.Create(x1,y1,z1);
    self.YVec := tpoint3.Create(x2,y2,z2);
    self.ZVec := tpoint3.Create(x3,y3,z3);
    self.WVec := tpoint3.Create(x4,y4,z4);
end;

constructor TMatrix3.Create(Row1,Row2,Row3,Row4:TPoint3);
begin
     self.Row[1] := row1.Clone;
     self.Row[2] := row2.Clone;
     self.Row[3] := row3.Clone;
     self.Row[4] := row4.Clone;
end;

function TMatrix3.Clone:TMatrix3;
begin
    result := Tmatrix3.Create(self.XVec.Clone
                             ,self.YVec.Clone
                             ,self.ZVec.Clone
                             ,self.WVec.Clone);
end;

procedure TMatrix3.Normalize;
begin
    self.XVec.Normalize;
    self.YVec.Normalize;
    self.ZVec.Normalize;
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
