unit frmCadastroPessoas;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Buttons, controlePessoas, modelPessoas,
  Vcl.Mask,FireDAC.Comp.Client, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls,
  ShellAPI, Windows;

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
    Panel3: TPanel;
    Panel4: TPanel;
    grdDados: TDBGrid;
    dtsListagem: TDataSource;
    ledLogradouro: TLabeledEdit;
    DBNavigator1: TDBNavigator;
    btnApagar: TBitBtn;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure ledCEPExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    ControlePessoas: TControlePessoas;
    procedure LimparCampos;
    procedure CarregarDados;
    procedure ajustaTabela;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmCadastroDePessoas: TfrmCadastroDePessoas;
  ProcessInfo: TProcessInformation;
  StartupInfo: TStartupInfo;

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



procedure TfrmCadastroDePessoas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ProcessInfo.hProcess <> 0 then
  begin
    // Encerra o processo
    TerminateProcess(ProcessInfo.hProcess, 0);

    // Fecha os handles do processo
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end;
end;


procedure TfrmCadastroDePessoas.FormShow(Sender: TObject);
var
  ExecutablePath: string;
begin
 CarregarDados;
 ajustaTabela;

  ExecutablePath := ExtractFilePath(ParamStr(0)) + 'APICEP.exe';

  // Inicializa o StartupInfo
  ZeroMemory(@StartupInfo, SizeOf(TStartupInfo));
  StartupInfo.cb := SizeOf(TStartupInfo);

  // Inicializa o ProcessInfo
  ZeroMemory(@ProcessInfo, SizeOf(TProcessInformation));

  // Cria o processo
  if not CreateProcess(
    nil,
    PChar(ExecutablePath),
    nil,
    nil,
    False,
    0,
    nil,
    nil,
    StartupInfo,
    ProcessInfo
  ) then
    ShowMessage('Erro ao iniciar o processo: ' + SysErrorMessage(GetLastError));
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
      CarregarDados;
      ajustaTabela;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao cadastrar pessoa: ' + E.Message);
  end;
end;

procedure TfrmCadastroDePessoas.btnApagarClick(Sender: TObject);
var
  Codigo, Descricao: string;
begin
  // Certifique-se de que há um registro selecionado
  if not Assigned(dtsListagem.DataSet) or dtsListagem.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum registro selecionado para apagar.');
    Exit;
  end;

  // Obtenha os valores do registro atual
  Codigo := dtsListagem.DataSet.FieldByName('ID').AsString; // Substitua por seu campo real
  Descricao := dtsListagem.DataSet.FieldByName('NomeCompleto').AsString; // Substitua por seu campo real

  // Pergunte ao usuário se deseja apagar o registro
  if MessageDlg(Format('Apagar o registro:%s%sCódigo: %s%sDescrição: %s',
    [sLineBreak, sLineBreak, Codigo, sLineBreak, Descricao]),
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  try
    // Chame o método para excluir o registro
    ControlePessoas.ExcluirPessoa(StrToInt(Codigo)); // Adapte para o método correto no seu controller
    ShowMessage('Registro apagado com sucesso!');
    CarregarDados; // Atualize a listagem
  except
    on E: Exception do
      ShowMessage('Erro durante a operação de remoção: ' + E.Message);
  end;

  // Ajusta as colunas da tabela
  ajustaTabela

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
    ledLogradouro.Text := PessoaEndereco.logradouro;
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
  ledLogradouro.Clear;
end;


procedure TfrmCadastroDePessoas.CarregarDados;
var
  Query: TFDQuery;
begin
  try
    Query := ControlePessoas.ListarTodos;
    dtsListagem.DataSet := Query; // Associa o conjunto de dados ao TDataSource
  except
    on E: Exception do
      ShowMessage('Erro ao carregar dados: ' + E.Message);
  end;
end;


procedure TfrmCadastroDePessoas.ajustaTabela;
begin

 // Ajustar a largura das colunas
  grdDados.Columns[0].Width := 50;  // ID
  grdDados.Columns[1].Width := 100; // Tipo
  grdDados.Columns[2].Width := 200; // NomeCompleto
  grdDados.Columns[3].Width := 80;  // DataNascimento
  grdDados.Columns[4].Width := 120; // CPF
  grdDados.Columns[5].Width := 100; // RG
  grdDados.Columns[6].Width := 200; // Email
  grdDados.Columns[7].Width := 100; // Telefone
  grdDados.Columns[8].Width := 80;  // CEP
  grdDados.Columns[9].Width := 150; // Logradouro
  grdDados.Columns[10].Width := 100; // Bairro
  grdDados.Columns[11].Width := 100; // Cidade
  grdDados.Columns[12].Width := 50; // Estado

end;




end.

