{*************************}
{ Besmelaherrahmanerrahym }
{    MHD3D_Objects_Type   }
{    Mohammad_Ghadiyany   }
{          _1388_         }
{*************************}
unit MHD3D_Objects;

interface

uses
    Windows, Messages, SysUtils, math, Graphics, Types, DateUtils, MHD3D_FNMath3D;

type
    PBoolean = ^boolean;
    TKey = packed record
        case integer of
            0: (
                Sel : boolean;
                Frm : extended;
                Val : extended;
                Tg1 : extended;
                Tg2 : extended;
                Loc : boolean
                );
            1: (
                Selected : boolean;
                Time     : extended;
                Value    : extended;
                InTg     : extended;
                OutTg    : extended;
                LockTgs  : boolean;
               );
            2: (
                S : boolean;
                _ : array [0..3] of extended;
                L : boolean;
               );
    end;

    TArKey = array of TKey;

    TController = class
    private
        Val:extended;
        function GetVal:extended;virtual;
        procedure SetVal(val_:extended);virtual;
    public
        property Value:extended read GetVal write SetVal;
        function IsAnimatable:boolean;virtual;
    end;

    TBoolean_Controller = class(TController)

    end;

    TFloat_Controller = class(TController)
    private
        Val: extended;
        function GetVal:extended;virtual;
        procedure SetVal(val_:extended);virtual;
    public
        property Value:extended read GetVal write SetVal;
    end;

    TBezier_Float = class(TFloat_Controller)
    private
        Val: extended;
        FKeys: TArKey;//array of TKey;
        AutoKey : PBoolean;
        function GetVal:extended;virtual;
        procedure SetVal(val_:extended);virtual;
    public
        property Keys : TArKey read FKeys write FKeys;
        property Value:extended read GetVal write SetVal;
        function IsAnimatable:boolean;virtual;
        function AddNewKey(Time_,Value_:Extended):integer;
        procedure ArrangeKeys;
    end;

    TVec3D_Controller = class(TController)
    private
        Val: TVec3D;
        function GetVal:TVec3D;virtual;
        function GetXVal: extended;virtual;
        function GetYVal: extended;virtual;
        function GetZVal: extended;virtual;
        procedure SetVal(val_:TVec3D);virtual;
        procedure SetXVal(L:extended);virtual;
        procedure SetYVal(L:extended);virtual;
        procedure SetZVal(L:extended);virtual;
    public
        property Value:TVec3D read GetVal write SetVal;
        property XValue: extended read GetXVal write SetXVal;
        property YValue: extended read GetYVal write SetYVal;
        property ZValue: extended read GetZVal write SetZVal;
    end;

    TXYZ_Controller = class(TVec3D_Controller)

    end;

    TPosition_XYZ_Controller = class(TXYZ_Controller)

    end;

    TRotation_XYZ_Controller = class(TXYZ_Controller)

    end;

    TScale_XYZ_Controller = class(TXYZ_Controller)

    end;

    {TBezier_Vec3D = Class(TVec3D_Controller)
    private
        X_Ctrler: TBezier_Float;
        Y_Ctrler: TBezier_Float;
        Z_Ctrler: TBezier_Float;
        function GetVal:TVec3D;virtual;
        function GetXVal: extended;virtual;
        function GetYVal: extended;virtual;
        function GetZVal: extended;virtual;
        procedure SetVal(val:TVec3D);virtual;
        procedure SetXVal(L:extended);virtual;
        procedure SetYVal(L:extended);virtual;
        procedure SetZVal(L:extended);virtual;
    public
        property X_Controller : TBezier_Float read X_Ctrler write X_Ctrler;
        property Y_Controller : TBezier_Float read Y_Ctrler write Y_Ctrler;
        property Z_Controller : TBezier_Float read Z_Ctrler write Z_Ctrler;
        property XController : TBezier_Float read X_Ctrler write X_Ctrler;
        property YController : TBezier_Float read Y_Ctrler write Y_Ctrler;
        property ZController : TBezier_Float read Z_Ctrler write Z_Ctrler;
        function IsAnimatable:boolean;virtual;
    End;}

    TMatrix3D_Controller = class(TController)
    private
        FVal : TMatrix3D;
    public

    end;

    TTransform_Controller = class(TMatrix3D_Controller)

    end;

    TTransform_XYZ_Controller = class(TTransform_Controller)
    private
        FPosCtrl : TVec3D_Controller;
        FRotCtrl : TVec3D_Controller;
        FSclCtrl : TVec3D_Controller;
        function GetPosVal : TVec3D;
        procedure SetPosVal(Val_ : TVec3D);
        function GetRotVal : TVec3D;
        procedure SetRotVal(Val_ : TVec3D);
        function GetSclVal : TVec3D;
        procedure SetSclVal(Val_ : TVec3D);
    public
        property Position : TVec3D read GetPosVal write SetPosVal;
        property Rotation : TVec3D read GetRotVal write SetRotVal;
        property Scale : TVec3D read GetSclVal write SetSclVal;
        property Position_Ctrl : TVec3D_Controller read FPosCtrl write FPosCtrl;
        property Rotation_Ctrl : TVec3D_Controller read FRotCtrl write FRotCtrl;
        property Scale_Ctrl : TVec3D_Controller read FSclCtrl write FSclCtrl;
    end;



    {
    TObj = class
    private
        function  GetTrans: TMatrix3D;
        procedure SetTrans(M: TMatrix3D);
        function  GetPos: TVec3D;
        procedure SetPos(P: TVec3D);
        function  GetRot: TVec3D;
        procedure SetRot(P: TVec3D);
        function  GetScl: TVec3D;
        procedure SetScl(P: TVec3D);
    public
        Property Transform : TMatrix3D  read GetTrans  write SetTrans;
        property Position  : TVec3D     read GetPos    write SetPos;
        property Rotation  : TVec3D     read GetRot    write SetRot;
        property Scale     : TVec3D     read GetScl    write SetScl;

        Property Tranc     : TMatrix3D  read GetTrans  write SetTrans;
        property Pos       : TVec3D     read GetPos    write SetPos;
        property Rot       : TVec3D     read GetRot    write SetRot;
        property Scl       : TVec3D     read GetScl    write SetScl;
    end;
}
implementation

function TController.GetVal:extended;
begin
    result := val;
end;

procedure TController.SetVal(val_:extended);
begin
    self.Val := val_;
end;

function TController.IsAnimatable:boolean;
begin
    result := false;
end;

function TFloat_Controller.GetVal:extended;
begin
   result := Val;
end;
procedure TFloat_Controller.SetVal(val_:extended);
begin
    val := val_;
end;

function TBezier_Float.AddNewKey(Time_,Value_:Extended):integer;
var
  I,j: Integer;
begin
    j := length(keys);
    for I := 0 to j - 1 do
    begin
        if (keys[i].Time = Time_) then
        begin
            keys[i].Val := Value_;
            exit;
        end;
    end;
    setlength(FKeys,j + 1);
    keys[i].Sel := false;
    keys[j].Frm := Time_;
    keys[j].Val := value_;
    keys[j].Tg1 := 0.0;
    keys[j].Tg2 := 0.0;
    keys[j].Loc := true;
end;

procedure TBezier_Float.ArrangeKeys;
var
  I,j,k: Integer;
  Key_ : tarkey;
begin
    key_ := keys;
    i := length(key_);
    while I > 1 do
    BEGIN
        setlength(key_,i);
        i := i - 1;
        j := i;
        k := i;
        while j > 1 do
        begin
            j := j - 1;
            if (Key_[j].Time < key_[k].Time) then
                k := j;
        end;
        key_[k] := key_[i];
        keys[length(keys) - i] := key_[k];
    END;
end;

function TBezier_Float.IsAnimatable:boolean;
begin
    result := true;
end;

function TBezier_Float.GetVal:extended;
begin
    result := Val;
end;

procedure TBezier_Float.SetVal(val_:extended);
begin
    Val := val_;
end;

function TVec3D_Controller.GetVal:TVec3D;
begin
    result := Val;
end;

function TVec3D_Controller.GetXVal: extended;
begin
    result := Val.X;
end;

function TVec3D_Controller.GetYVal: extended;
begin
    result := Val.Y;
end;

function TVec3D_Controller.GetZVal: extended;
begin
    result := Val.Z;
end;

procedure TVec3D_Controller.SetVal(val_:TVec3D);
begin
    Val := val_;
end;

procedure TVec3D_Controller.SetXVal(L:extended);
begin
    Val.X := l;
end;

procedure TVec3D_Controller.SetYVal(L:extended);
begin
    Val.Y := l;
end;

procedure TVec3D_Controller.SetZVal(L:extended);
begin
    Val.Z := l;
end;

function TTransform_XYZ_Controller.GetPosVal : TVec3D;
begin
    result := FPosCtrl.Value;
end;

procedure TTransform_XYZ_Controller.SetPosVal(Val_ : TVec3D);
begin
    FPosCtrl.Value := Val_;
end;

function TTransform_XYZ_Controller.GetRotVal : TVec3D;
begin
    result := FRotCtrl.Value;
end;

procedure TTransform_XYZ_Controller.SetRotVal(Val_ : TVec3D);
begin
    FRotCtrl.Value := Val_;
end;

function TTransform_XYZ_Controller.GetSclVal : TVec3D;
begin
    result := FSclCtrl.Value;
end;

procedure TTransform_XYZ_Controller.SetSclVal(Val_ : TVec3D);
begin
    FSclCtrl.Value := Val_;
end;

end.
