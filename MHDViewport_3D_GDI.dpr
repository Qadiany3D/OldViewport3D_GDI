program MHDViewport_3D_GDI;

{$R *.dres}

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  MHD3D_FNMath3D in 'MHD3D_FNMath3D.pas',
  Form_About in 'Form_About\Form_About.pas' {Form_About_3D_Viewport},
  MHD3D_Objects in 'MHD3D_Objects.pas',
  EditFloat_Unit in 'EditFloat_Unit.pas';

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  //Application.CreateForm(TForm_About_3D_Viewport, Form_About_3D_Viewport);
  Application.Run;
end.
