program projetoSistemaCadastroDePessoas;

uses
  Vcl.Forms,
  frmCadastroPessoas in 'View\frmCadastroPessoas.pas' {Form1},
  DMConexao in 'Model\DMConexao.pas' {DataModuleConexao: TDataModule},
  controlePessoas in 'Controller\controlePessoas.pas',
  modelPessoas in 'Model\modelPessoas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModuleConexao, DataModuleConexao);
  Application.Run;
end.
