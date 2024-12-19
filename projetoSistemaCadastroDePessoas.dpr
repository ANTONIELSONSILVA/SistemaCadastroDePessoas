program projetoSistemaCadastroDePessoas;

uses
  Vcl.Forms,
  frmCadastroPessoas in 'View\frmCadastroPessoas.pas' {frmCadastroDePessoas},
  controlePessoas in 'Controller\controlePessoas.pas',
  modelPessoas in 'Model\modelPessoas.pas',
  DMConexao in 'Model\DMConexao.pas' {DataModuleConexao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCadastroDePessoas, frmCadastroDePessoas);
  Application.CreateForm(TDataModuleConexao, DataModuleConexao);
  Application.Run;
end.
