unit controlePessoas;

interface

uses
  System.SysUtils, modelPessoas, FireDAC.Comp.Client, Data.DB, IdHTTP, System.JSON;

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
    function BuscarEnderecoPorCEP(const CEP: string): TPessoa;
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
      Response := HTTP.Get('https://viacep.com.br/ws/' + CEP + '/json/');
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
    raise Exception.Create('E-mail inválido.');

  if not Model.ValidarCPFUnico(Pessoa.CPF) then
    raise Exception.Create('CPF já cadastrado.');

  Result := Model.InserirPessoa(Pessoa);
end;

function TControlePessoas.EditarPessoa(const Pessoa: TPessoa): Boolean;
begin
  if not ValidarEmail(Pessoa.Email) then
    raise Exception.Create('E-mail inválido.');

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
  JSONValue: TJSONValue;
  JSONData: string;
begin
  JSONData := ConsultarViaCEP(CEP);
  JSONResponse := TJSONObject.ParseJSONValue(JSONData) as TJSONObject;
  try
    if JSONResponse.GetValue<string>('erro') = 'true' then
      raise Exception.Create('CEP inválido.');

    Result.Logradouro := JSONResponse.GetValue<string>('logradouro');
    Result.Bairro := JSONResponse.GetValue<string>('bairro');
    Result.Cidade := JSONResponse.GetValue<string>('localidade');
    Result.Estado := JSONResponse.GetValue<string>('uf');
  finally
    JSONResponse.Free;
  end;
end;

end.

