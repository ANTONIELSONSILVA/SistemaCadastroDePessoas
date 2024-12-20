unit frmCadastroPessoas;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Buttons, controlePessoas, modelPessoas,
  Vcl.Mask,FireDAC.Comp.Client, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls,
  ShellAPI, Windows, System.StrUtils, Vcl.Graphics;

type
  TfrmCadastroDePessoas = class(TForm)
    pcPrincipal: TPageControl;
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
    btnEditar: TBitBtn;
    ledPesquisa: TLabeledEdit;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure ledCEPExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdDadosDblClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure ledPesquisaChange(Sender: TObject);
    procedure grdDadosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    ControlePessoas: TControlePessoas;
    procedure LimparCampos;
    procedure CarregarDados;
    procedure ajustaTabela;
    function retornaPessoa: TPessoa;

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

    pcPrincipal.ActivePage := TabSheet1;

end;


procedure TfrmCadastroDePessoas.grdDadosDblClick(Sender: TObject);
var
  PessoaDados: TPessoa;
  Msg: string;
begin

  PessoaDados := retornaPessoa;

  // Chama o m�todo do controller para formatar os dados
  Msg := ControlePessoas.RetornaDadosPessoa(PessoaDados);

  // Exibe a mensagem formatada
  ShowMessage(Msg);

end;




procedure TfrmCadastroDePessoas.grdDadosDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if ContainsText(dtsListagem.DataSet.FieldByName('NomeCompleto').AsString, ledPesquisa.Text) then
  begin
    // Altera o fundo da linha para destacar
    grdDados.Canvas.Brush.Color := clYellow; // Cor de fundo da linha
    grdDados.Canvas.Font.Color := clBlack;  // Cor do texto
  end;
  // Desenha o conte�do da c�lula
  grdDados.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCadastroDePessoas.ledPesquisaChange(Sender: TObject);
var
  TextoPesquisa: string;
  Encontrado: Boolean;
begin
  // Obter o texto do campo de pesquisa
  TextoPesquisa := ledPesquisa.Text;
  // Verificar se o dataset est� ativo e se h� registros
  if Assigned(dtsListagem.DataSet) and not dtsListagem.DataSet.IsEmpty then
  begin
    // Desmarcar qualquer sele��o anterior na grade
    grdDados.SelectedRows.Clear;
    try
      // Procurar registros correspondentes ao texto de pesquisa
      Encontrado := False;
      dtsListagem.DataSet.DisableControls; // Desabilitar controles para melhorar performance
      try
        dtsListagem.DataSet.First; // Ir para o primeiro registro
        while not dtsListagem.DataSet.Eof do
        begin
          if ContainsText(dtsListagem.DataSet.FieldByName('NomeCompleto').AsString, TextoPesquisa) then
          begin
            // Adiciona o registro � sele��o do grid
            grdDados.SelectedRows.CurrentRowSelected := True;
            Encontrado := True;
          end;
          dtsListagem.DataSet.Next;
        end;
      finally
        dtsListagem.DataSet.EnableControls; // Reabilitar controles
      end;
      // Se encontrado, mover o cursor para o primeiro registro correspondente
      if Encontrado then
      begin
        dtsListagem.DataSet.First;
        while not dtsListagem.DataSet.Eof do
        begin
          if ContainsText(dtsListagem.DataSet.FieldByName('NomeCompleto').AsString, TextoPesquisa) then
          begin
            dtsListagem.DataSet.RecNo := dtsListagem.DataSet.RecNo; // Move o cursor
            Break;
          end;
          dtsListagem.DataSet.Next;
        end;
      end;
    except
      on E: Exception do
        ShowMessage('Erro ao pesquisar: ' + E.Message);
    end;
  end;
end;

function  TfrmCadastroDePessoas.retornaPessoa(): TPessoa;
var
  Pessoa: TPessoa;
begin
  // Preenche os dados da pessoa com base no dataset selecionado
  Pessoa.ID := dtsListagem.DataSet.FieldByName('ID').AsInteger;
  Pessoa.Tipo := dtsListagem.DataSet.FieldByName('Tipo').AsString;
  Pessoa.NomeCompleto := dtsListagem.DataSet.FieldByName('NomeCompleto').AsString;
  Pessoa.DataNascimento := dtsListagem.DataSet.FieldByName('DataNascimento').AsDateTime;
  Pessoa.CPF := dtsListagem.DataSet.FieldByName('CPF').AsString;
  Pessoa.RG := dtsListagem.DataSet.FieldByName('RG').AsString;
  Pessoa.Email := dtsListagem.DataSet.FieldByName('Email').AsString;
  Pessoa.Telefone := dtsListagem.DataSet.FieldByName('Telefone').AsString;
  Pessoa.CEP := dtsListagem.DataSet.FieldByName('CEP').AsString;
  Pessoa.Logradouro := dtsListagem.DataSet.FieldByName('Logradouro').AsString;
  Pessoa.Bairro := dtsListagem.DataSet.FieldByName('Bairro').AsString;
  Pessoa.Cidade := dtsListagem.DataSet.FieldByName('Cidade').AsString;
  Pessoa.Estado := dtsListagem.DataSet.FieldByName('Estado').AsString;

  Result := Pessoa;


end;




procedure TfrmCadastroDePessoas.btnSalvarClick(Sender: TObject);
var
  Pessoa: TPessoa;
begin
  try
    // Valida��es b�sicas
    if ledNome.Text = '' then
      raise Exception.Create('O campo Nome � obrigat�rio.');

    if ledCPF.Text = '' then
      raise Exception.Create('O campo CPF � obrigat�rio.');

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
    Pessoa.Logradouro := ledLogradouro.Text;
    Pessoa.Bairro := ledBairro.Text;
    Pessoa.Cidade := ledCidade.Text;
    Pessoa.Estado := ledEstado.Text;

    // Chamar o m�todo do Controller para cadastrar
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
  // Certifique-se de que h� um registro selecionado
  if not Assigned(dtsListagem.DataSet) or dtsListagem.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum registro selecionado para apagar.');
    Exit;
  end;

  // Obtenha os valores do registro atual
  Codigo := dtsListagem.DataSet.FieldByName('ID').AsString; // Substitua por seu campo real
  Descricao := dtsListagem.DataSet.FieldByName('NomeCompleto').AsString; // Substitua por seu campo real

  // Pergunte ao usu�rio se deseja apagar o registro
  if MessageDlg(Format('Apagar o registro:%s%sC�digo: %s%sDescri��o: %s',
    [sLineBreak, sLineBreak, Codigo, sLineBreak, Descricao]),
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  try
    // Chame o m�todo para excluir o registro
    ControlePessoas.ExcluirPessoa(StrToInt(Codigo)); // Adapte para o m�todo correto no seu controller
    ShowMessage('Registro apagado com sucesso!');
    CarregarDados; // Atualize a listagem
  except
    on E: Exception do
      ShowMessage('Erro durante a opera��o de remo��o: ' + E.Message);
  end;

  // Ajusta as colunas da tabela
  ajustaTabela

end;


procedure TfrmCadastroDePessoas.btnCancelarClick(Sender: TObject);
begin
  LimparCampos;
end;

procedure TfrmCadastroDePessoas.btnEditarClick(Sender: TObject);
var
  PessoaDados: TPessoa;
begin
  // Onclick Editar
  PessoaDados := retornaPessoa;

  cbTipoPessoa.Text := PessoaDados.Tipo;
  ledNome.Text := PessoaDados.NomeCompleto;
  ledNascimento.Text := FormatDateTime('dd/mm/yyyy', PessoaDados.DataNascimento);
  ledCPF.Text := PessoaDados.CPF;
  ledRG.Text := PessoaDados.RG;
  ledEmail.Text := PessoaDados.Email;
  ledTelefone.Text := PessoaDados.Telefone;
  ledCEP.Text := PessoaDados.CEP;
  ledLogradouro.Text := PessoaDados.Logradouro;
  ledBairro.Text := PessoaDados.Bairro;
  ledCidade.Text := PessoaDados.Cidade;
  ledEstado.Text := PessoaDados.Estado;

  pcPrincipal.ActivePage := TabSheet1;

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
    // Preencher os campos de endere�o
    ledLogradouro.Text := PessoaEndereco.logradouro;
    ledBairro.Text := PessoaEndereco.Bairro;
    ledCidade.Text := PessoaEndereco.Cidade;
    ledEstado.Text := PessoaEndereco.Estado;
  except
    on E: Exception do
      ShowMessage('Erro ao buscar endere�o: ' + E.Message);
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

