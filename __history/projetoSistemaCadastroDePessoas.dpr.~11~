program projetoSistemaCadastroDePessoas;

uses
  Vcl.Forms,
  frmCadastroPessoas in 'View\frmCadastroPessoas.pas' {frmCadastroDePessoas},
  DMConexao in 'Model\DMConexao.pas' {DataModuleConexao: TDataModule},
  controlePessoas in 'Controller\controlePessoas.pas',
  modelPessoas in 'Model\modelPessoas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCadastroDePessoas, frmCadastroDePessoas);
  Application.Run;
end.
