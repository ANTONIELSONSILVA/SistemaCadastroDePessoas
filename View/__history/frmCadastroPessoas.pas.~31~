unit frmCadastroPessoas;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Buttons, controlePessoas, modelPessoas,
  Vcl.Mask;

type
  TfrmCadastroDePessoas = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    ledNome: TLabeledEdit;
    ledNascimento: TLabeledEdit;
    ledCPF: TLabeledEdit;
    ledRG: TLabeledEdit;
    ledEmail: TLabeledEdit;
    ledTelefone: TLabeledEdit;
    ledCEP: TLabeledEdit;
    ledBairro: TLabeledEdit;
    ledCidade: TLabeledEdit;
    ledEstado: TLabeledEdit;
    cbTipoPessoa: TComboBox;
    btnSalvar: TBitBtn;
    TabSheet2: TTabSheet;
    btnCancelar: TBitBtn;
    lbTipoPessoa: TLabel;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure ledCEPExit(Sender: TObject);
  private
    ControlePessoas: TControlePessoas;
    procedure LimparCampos;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmCadastroDePessoas: TfrmCadastroDePessoas;

implementation

{$R *.dfm}

uses
  Vcl.Dialogs;

constructor TfrmCadastroDePessoas.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlePessoas := TControlePessoas.Create;

  // Inicializar o ComboBox de Tipo de Pessoa
  cbTipoPessoa.Items.Add('Cliente');
  cbTipoPessoa.Items.Add('Fornecedor');
  cbTipoPessoa.Items.Add('Transportador');
  cbTipoPessoa.Items.Add('Outro');
end;

destructor TfrmCadastroDePessoas.Destroy;
begin
  ControlePessoas.Free;
  inherited Destroy;
end;

procedure TfrmCadastroDePessoas.btnSalvarClick(Sender: TObject);
var
  Pessoa: TPessoa;
begin
  try
    // Validações básicas
    if ledNome.Text = '' then
      raise Exception.Create('O campo Nome é obrigatório.');

    if ledCPF.Text = '' then
      raise Exception.Create('O campo CPF é obrigatório.');

    if cbTipoPessoa.ItemIndex = -1 then
      raise Exception.Create('Selecione o Tipo de Pessoa.');

    // Coletar dados dos campos
    Pessoa.Tipo := cbTipoPessoa.Text;
    Pessoa.NomeCompleto := ledNome.Text;

    // Validar e converter Data de Nascimento
    if ledNascimento.Text <> '' then
      Pessoa.DataNascimento := StrToDate(ledNascimento.Text)
    else
      Pessoa.DataNascimento := 0;

    Pessoa.CPF := ledCPF.Text;
    Pessoa.RG := ledRG.Text;
    Pessoa.Email := ledEmail.Text;
    Pessoa.Telefone := ledTelefone.Text;
    Pessoa.CEP := ledCEP.Text;
    Pessoa.Bairro := ledBairro.Text;
    Pessoa.Cidade := ledCidade.Text;
    Pessoa.Estado := ledEstado.Text;

    // Chamar o método do Controller para cadastrar
    if ControlePessoas.CadastrarPessoa(Pessoa) then
    begin
      ShowMessage('Pessoa cadastrada com sucesso!');
      LimparCampos;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao cadastrar pessoa: ' + E.Message);
  end;
end;

procedure TfrmCadastroDePessoas.btnCancelarClick(Sender: TObject);
begin
  LimparCampos;
end;

procedure TfrmCadastroDePessoas.ledCEPExit(Sender: TObject);
var
  PessoaEndereco: TPessoa;
  CEPValue: string;
begin
  CEPValue := ledCEP.Text;
  if CEPValue.Trim = '' then Exit;

  try
    PessoaEndereco := ControlePessoas.BuscarEnderecoPorCEP(ledCEP.Text);

    // Preencher os campos de endereço
    ledBairro.Text := PessoaEndereco.Bairro;
    ledCidade.Text := PessoaEndereco.Cidade;
    ledEstado.Text := PessoaEndereco.Estado;
  except
    on E: Exception do
      ShowMessage('Erro ao buscar endereço: ' + E.Message);
  end;
end;


procedure TfrmCadastroDePessoas.LimparCampos;
begin
  cbTipoPessoa.ItemIndex := -1;
  ledNome.Clear;
  ledNascimento.Clear;
  ledCPF.Clear;
  ledRG.Clear;
  ledEmail.Clear;
  ledTelefone.Clear;
  ledCEP.Clear;
  ledBairro.Clear;
  ledCidade.Clear;
  ledEstado.Clear;
end;

end.

