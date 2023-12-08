unit EditFloat_Unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

function SetCursureFloat(var P:tpoint;X1,Y1,X2,Y2:integer):tpoint;

type
    TChangeValExtended = procedure(Sender : TObject;NewVal:extended) of object;
    TEditFloat = class(TEdit)
    private
        FVal : extended;
        FMax: extended;
        FMin: extended;

        FCurrentVal : extended;
        FCurrentDownVal : extended;
        FRectCursor : TRect;
        FMultiChangeVal : extended;
        Timer : TTimer;

        FOnChangeedVal : TChangeValExtended;
        procedure SetPos(p:tpoint);
        function GetPos:tpoint;
        procedure SetMax(x:extended);
        procedure SetMin(x:extended);
        procedure SetVal(x:extended);
        procedure MhdOnMouseDown(Sender: TObject; Button: TMouseButton;
             Shift: TShiftState; X, Y: Integer);
        procedure MhdEditKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure MhdEditExit(Sender: TObject);
        procedure OnTimerTicks(Sender : TObject);
    public
        constructor Create(AOwner:TComponent);overload;
        procedure Update;overload;
    published
        property Pos : tpoint read getpos write setpos;
        property Value : extended read Fval write setval;
        property Maximum : extended read Fmax write Fmax;
        property Minimum : extended read Fmin write Fmin;
        property OnChangedVal : TChangeValExtended read FOnChangeedVal write FOnChangeedVal;
    end;

procedure Register;
function Maxi(const a,b:extended):extended;overload;
function Mini(const a,b:extended):extended;overload;
procedure SetInRange(var x : SmallInt;const min_,max_:SmallInt);overload;
procedure SetInRange(var x : integer;const min_,max_:integer);overload;
procedure SetInRange(var x:extended;const Min_,Max_:extended);overload;

implementation

procedure Register;
begin
    RegisterComponents('Samples',[TEditFloat]);
end;

function Maxi(const a,b:extended):extended;
begin
    if a > b then
        result := a
    else
        result := b;
end;

function Mini(const a,b:extended):extended;
begin
    if a < b then
        result := a
    else
        result := b;
end;

procedure SetInRange(var x:extended;const Min_,Max_:extended);
begin
    if x < min_ then
        x := min_;
    if x > max_ then
        x := Max_;
end;

procedure SetInRange(var x : integer;const min_,max_:integer);
begin
    if x < min_ then
        x := min_;
    if x > max_ then
        x := max_;
end;

procedure SetInRange(var x : SmallInt;const min_,max_:SmallInt);
begin
    if x < min_ then
        x := min_;
    if x > max_ then
        x := max_;
end;

procedure TEditFloat.Update;
begin
    inherited;
    Self.Text := floattostr(Value);
end;

procedure TEditFloat.setpos(p:tpoint);
begin
    self.top := p.Y;
    self.left := p.X;
end;

function TEditFloat.getpos:tpoint;
begin
    result := point(left,top);
end;

procedure TEditFloat.SetVal(x:extended);
begin
    if x > FMax then
        FVal := Fmax
    else
        if x < Fmin then
            FVal := Fmin
        else
            FVal := x;
    Update;
    if Assigned(FOnChangeedVal) then
        FOnChangeedVal(self,Fval);
end;

procedure TEditFloat.SetMax(x:extended);
begin
    fmax := x;
    if fmin > fmax then
        fmin := fmax;
    if fVal > fmax then
        Value := fmax;
end;

procedure TEditFloat.SetMin(x:extended);
begin
   fmin := x;
   if fmax < fmin then
        fmax := fmin;
   if fval < fmin then
        Value := FMin;
end;

constructor TEditFloat.Create(AOwner:TComponent);
begin
    inherited;
    self.FMin := -10000;
    self.FMax := 10000;
    self.FVal := 0;

    FCurrentVal := 0;
    FCurrentVal := 0;
    FRectCursor := rect(0,0,100,20);
    {
    rect(self.ClientOrigin.X + self.ClientWidth - 10 ,
                                                 ClientOrigin.Y - 150,
                         self.ClientOrigin.X + self.ClientWidth ,
                         self.ClientOrigin.y + self.ClientHeight + 150);
    }
    FMultiChangeVal := 1;
    Timer := nil;

    self.OnChangedVal := nil;
    Self.OnMouseDown := Self.MhdOnMouseDown;
    self.OnExit := Self.MhdEditExit;
    self.OnKeyDown := self.MhdEditKeyDown;
    self.Update;
end;

function SetCursureFloat(var P:tpoint;X1,Y1,X2,Y2:integer):tpoint;
var
    wid,hei:integer;
begin
    if x1 < 0 then
        x1 := 0;
    if y1 < 0 then
        y1 := 0;
    if x2 > Screen.Width - 1 then
        x2 := Screen.Width - 1;
    if y2 > Screen.Height - 1 then
        Y2 := Screen.Height - 1;
    wid:= x2;//Screen.Width;
    hei := y2;//Screen.Height;
    GetCursorPos(p);
    if p.X <= x1{0} then
        result.X := Wid - 2
    else
        if (p.X >= Wid - 1) then
            result.X := x1 + 1
        else
            result.X := p.X;

    if p.y <= y1{0} then
        result.y := hei - 2
    else
        if (p.y >= hei - 1) then
            result.y := y1 + 1
        else
            result.y := p.y;
    {if not (result.Y > 0) then
        result.Y := Screen.Height - 2
    else
        if not (result.Y < Screen.Height - 1) then
            result.Y := 1;}
    if (p.X <> result.X) or (p.Y <> result.Y) then
        SetCursorPos(result.X,result.Y);
end;

{
procedure TEditFloat.MhdOnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    p,p1,cr:tpoint;
    self_ : TEditFloat;
    xx,yy,zz,multi : extended;
    rect_:trect;
begin
    self_ := (sender as TEditFloat);
    self_.OnExit(self_);
    xx := self_.Value;
    //multi := 0.123456 + abs(100 * xx / (self_.Max - self_.Min));
    //multi := ((abs(xx) + 1) + 0.01) / 200 + ((abs(xx) + 1) / (self_.FMax - self_.FMin));
    multi := 0.5 + ((abs(xx) + 1) / (self_.FMax - self_.FMin + 1.0));
    GetCursorPos(p);
    cr := p;
    yy := p.y;
    rect_ := rect(self_.ClientOrigin.X + self_.ClientWidth - 10 ,
                                                 ClientOrigin.Y - 150,
                         self_.ClientOrigin.X + self_.ClientWidth ,
                         self_.ClientOrigin.y + self_.ClientHeight + 150);
    while (abs(GetAsyncKeyState(VK_MBUTTON)) > 10) do
    begin
         if (abs(GetAsyncKeyState(VK_rBUTTON)) > 10) then
         begin
            self_.Value := xx;
            SetCursorPos(cr.X ,cr.Y);
            exit;
         end;
         p1 := SetCursureFloat(p,Rect_.Left,rect_.Top,rect_.Right,rect_.Bottom);
         yy := yy + (p1.Y - p.Y);
         zz := xx + ((yy - p1.Y) * multi);
         //SetRange(zz,self_.min,self_.Max);
         if self_.Value <> zz then
         begin
            self_.Value := zz;
            //self_.Update;
         end;
    end;
    SetCursorPos(cr.x,cr.y);
end;
}

procedure TEditFloat.OnTimerTicks(Sender : TObject);
var
    p,p1 :  TPoint;
    zz : extended;
begin
    if (abs(GetAsyncKeyState(VK_MBUTTON)) < 10) then
    begin
        (Sender as TTimer).Enabled := false;
        SetCursorPos((FRectCursor.Left + FRectCursor.Right) div 2,(FRectCursor.Top + FRectCursor.Bottom) div 2);
        exit;
    end;
    if (abs(GetAsyncKeyState(VK_ESCAPE)) > 10) then
    begin
        (Sender as TTimer).Enabled := false;
        self.Value := self.FCurrentVal;
        SetCursorPos((FRectCursor.Left + FRectCursor.Right) div 2,(FRectCursor.Top + FRectCursor.Bottom) div 2);
        exit;
    end;
         p1 := SetCursureFloat(p,FRectCursor.Left,FRectCursor.Top,FRectCursor.Right,FRectCursor.Bottom);
         FCurrentDownVal := FCurrentDownVal + (p1.Y - p.Y);
         zz := Self.FCurrentVal + ((FCurrentDownVal - p1.Y) * self.FMultiChangeVal);
         if self.Value <> zz then
         begin
            self.Value := zz;
         end;
end;


procedure TEditFloat.MhdOnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    p,p1,cr:tpoint;
    self_ : TEditFloat;
begin
    self_ := (sender as TEditFloat);
    self_.OnExit(self_);
    FCurrentVal := self_.Value;
    FMultiChangeVal := 0.5 + ((abs(FCurrentVal) + 1) / (self_.FMax - self_.FMin + 1.0));
    GetCursorPos(p);
    cr := p;
    FCurrentDownVal := p.y;
    FRectCursor := rect(self_.ClientOrigin.X + self_.ClientWidth - 10 ,
                                                 ClientOrigin.Y - 10{150},
                         self_.ClientOrigin.X + self_.ClientWidth ,
                         self_.ClientOrigin.y + self_.ClientHeight + 10{150});
    if Timer = nil then
    begin
        Timer := TTimer.Create(self_.Parent);
        Timer.Enabled := false;
        Timer.Interval := 1;
        Timer.OnTimer := self.OnTimerTicks;
    end;
    if (abs(GetAsyncKeyState(VK_MBUTTON)) > 10) then
        Timer.Enabled := true;
end;

procedure TEditFloat.MhdEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if key = VK_RETURN then
        self.Value := StrToFloatDef(self.Text,self.Value);
end;

procedure TEditFloat.MhdEditExit(Sender: TObject);
begin
    self.Value := StrToFloatDef(self.Text,self.Value);
end;

end.
