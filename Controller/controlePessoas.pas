unit controlePessoas;

interface

uses
  System.SysUtils, modelPessoas, FireDAC.Comp.Client, Data.DB, IdHTTP, System.JSON, Vcl.Dialogs, Vcl.Forms;


type
  TControlePessoas = class
  private
    Model: TModelPessoas;
    function ValidarEmail(const Email: string): Boolean;
    function ConsultarViaCEP(const CEP: string): string;

  public
    constructor Create;
    destructor Destroy; override;
    function CadastrarPessoa(const Pessoa: TPessoa): Boolean;
    function EditarPessoa(const Pessoa: TPessoa): Boolean;
    function ExcluirPessoa(const ID: Integer): Boolean;
    function ListarPessoas(const Filtro: string = ''): TFDQuery;
    function ListarTodos: TFDQuery;
    function BuscarEnderecoPorCEP(const CEP: string): TPessoa;
    function RetornaDadosPessoa(const Pessoa: TPessoa): string;
  end;

implementation

uses
  RegularExpressions;

{ TControlePessoas }

constructor TControlePessoas.Create;
begin
  inherited Create;
  Model := TModelPessoas.Create;
end;

destructor TControlePessoas.Destroy;
begin
  Model.Free;
  inherited Destroy;
end;

function TControlePessoas.ValidarEmail(const Email: string): Boolean;
const
  EmailRegex = '^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$';
begin
  Result := TRegEx.IsMatch(Email, EmailRegex);
end;

function TControlePessoas.ConsultarViaCEP(const CEP: string): string;
var
  HTTP: TIdHTTP;
  Response: string;
begin
  HTTP := TIdHTTP.Create(nil);
  try
    try
      //Response := HTTP.Get('https://viacep.com.br/ws/' + CEP + '/json/');
      Response := HTTP.Get('http://localhost:5000/consulta-cep?cep=' +CEP);
      Result := Response;
    except
      on E: Exception do
        raise Exception.Create('Erro ao consultar o CEP: ' + E.Message);
    end;
  finally
    HTTP.Free;
  end;
end;

function TControlePessoas.CadastrarPessoa(const Pessoa: TPessoa): Boolean;
begin
  if not ValidarEmail(Pessoa.Email) then
    raise Exception.Create('E-mail inv�lido.');

  if not Model.ValidarCPFUnico(Pessoa.CPF) then
  begin
    if MessageDlg('O CPF j� est� cadastrado. Deseja continuar mesmo assim?', mtConfirmation, [mbYes, mbNo], 0) = 2 then
      Exit(False);
  end;

  Result := Model.InserirPessoa(Pessoa);
end;

function TControlePessoas.EditarPessoa(const Pessoa: TPessoa): Boolean;
begin
  if not ValidarEmail(Pessoa.Email) then
    raise Exception.Create('E-mail inv�lido.');

  Result := Model.AtualizarPessoa(Pessoa);
end;

function TControlePessoas.ExcluirPessoa(const ID: Integer): Boolean;
begin
  Result := Model.DeletarPessoa(ID);
end;



function TControlePessoas.ListarPessoas(const Filtro: string): TFDQuery;
begin
  Result := Model.BuscarPessoas(Filtro);
end;

function TControlePessoas.BuscarEnderecoPorCEP(const CEP: string): TPessoa;
var
  JSONResponse: TJSONObject;
  JSONData: string;
  HasError: TJSONValue;
begin
  JSONData := ConsultarViaCEP(CEP);
  JSONResponse := TJSONObject.ParseJSONValue(JSONData) as TJSONObject;
  try
    // Verifica se a chave "erro" existe
    HasError := JSONResponse.FindValue('erro');
    if (HasError <> nil) and (HasError.Value = 'true') then
      raise Exception.Create('CEP inv�lido.');

    // Preenche os campos de Result com os valores do JSON
    Result.Logradouro := JSONResponse.GetValue<string>('logradouro');
    Result.Bairro := JSONResponse.GetValue<string>('bairro');
    Result.Cidade := JSONResponse.GetValue<string>('localidade');
    Result.Estado := JSONResponse.GetValue<string>('uf');
  finally
    JSONResponse.Free;
  end;
end;


function TControlePessoas.ListarTodos: TFDQuery;
begin
  Result := Model.BuscarTodos;
end;



function TControlePessoas.RetornaDadosPessoa(const Pessoa: TPessoa): string;
begin
  Result := 'ID: ' + IntToStr(Pessoa.ID) + sLineBreak +
            'Tipo: ' + Pessoa.Tipo + sLineBreak +
            'Nome Completo: ' + Pessoa.NomeCompleto + sLineBreak +
            'Data de Nascimento: ' + DateToStr(Pessoa.DataNascimento) + sLineBreak +
            'CPF: ' + Pessoa.CPF + sLineBreak +
            'RG: ' + Pessoa.RG + sLineBreak +
            'Email: ' + Pessoa.Email + sLineBreak +
            'Telefone: ' + Pessoa.Telefone + sLineBreak +
            'CEP: ' + Pessoa.CEP + sLineBreak +
            'Logradouro: ' + Pessoa.Logradouro + sLineBreak +
            'Bairro: ' + Pessoa.Bairro + sLineBreak +
            'Cidade: ' + Pessoa.Cidade + sLineBreak +
            'Estado: ' + Pessoa.Estado;
end;



end.

