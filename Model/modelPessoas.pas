unit modelPessoas;

interface

uses
  System.SysUtils, Data.DB, DMConexao, FireDAC.Comp.Client;

type
  TPessoa = record
    ID: Integer;
    Tipo: string;
    NomeCompleto: string;
    DataNascimento: TDateTime;
    CPF: string;
    RG: string;
    Email: string;
    Telefone: string;
    CEP: string;
    Logradouro: string;
    Bairro: string;
    Cidade: string;
    Estado: string;
  end;


  TModelPessoas = class
  private
    Conexao: TFDConnection;
  public
    constructor Create;
    destructor Destroy; override;
    function InserirPessoa(const Pessoa: TPessoa): Boolean;
    function AtualizarPessoa(const Pessoa: TPessoa): Boolean;
    function DeletarPessoa(const ID: Integer): Boolean;
    function BuscarPessoas(const Filtro: string = ''): TFDQuery;
    function ValidarCPFUnico(const CPF: string): Boolean;
  end;

implementation

{ TModelPessoas }

constructor TModelPessoas.Create;
begin
  inherited Create;
  Conexao := DataModuleConexao.ObterConexao;
end;

destructor TModelPessoas.Destroy;
begin
  // Destruir recursos se necessário
  inherited Destroy;
end;

function TModelPessoas.InserirPessoa(const Pessoa: TPessoa): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Conexao;
    Query.SQL.Text :=
      'INSERT INTO pessoa (Tipo, NomeCompleto, DataNascimento, CPF, RG, Email, Telefone, ' +
      'CEP, Logradouro, Bairro, Cidade, Estado) ' +
      'VALUES (:Tipo, :NomeCompleto, :DataNascimento, :CPF, :RG, :Email, :Telefone, ' +
      ':CEP, :Logradouro, :Bairro, :Cidade, :Estado)';
    Query.ParamByName('Tipo').AsString := Pessoa.Tipo;
    Query.ParamByName('NomeCompleto').AsString := Pessoa.NomeCompleto;
    Query.ParamByName('DataNascimento').AsString := FormatDateTime('yyyy-mm-dd', Pessoa.DataNascimento);
    Query.ParamByName('CPF').AsString := Pessoa.CPF;
    Query.ParamByName('RG').AsString := Pessoa.RG;
    Query.ParamByName('Email').AsString := Pessoa.Email;
    Query.ParamByName('Telefone').AsString := Pessoa.Telefone;
    Query.ParamByName('CEP').AsString := Pessoa.CEP;
    Query.ParamByName('Logradouro').AsString := Pessoa.Logradouro;
    Query.ParamByName('Bairro').AsString := Pessoa.Bairro;
    Query.ParamByName('Cidade').AsString := Pessoa.Cidade;
    Query.ParamByName('Estado').AsString := Pessoa.Estado;
    Query.ExecSQL;
    Result := True;
  finally
    Query.Free;
  end;
end;

function TModelPessoas.AtualizarPessoa(const Pessoa: TPessoa): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Conexao;
    Query.SQL.Text :=
      'UPDATE pessoa SET Tipo = :Tipo, NomeCompleto = :NomeCompleto, ' +
      'DataNascimento = :DataNascimento, CPF = :CPF, RG = :RG, Email = :Email, Telefone = :Telefone, ' +
      'CEP = :CEP, Logradouro = :Logradouro, Bairro = :Bairro, Cidade = :Cidade, Estado = :Estado ' +
      'WHERE ID = :ID';
    Query.ParamByName('Tipo').AsString := Pessoa.Tipo;
    Query.ParamByName('NomeCompleto').AsString := Pessoa.NomeCompleto;
    Query.ParamByName('DataNascimento').AsString := FormatDateTime('yyyy-mm-dd', Pessoa.DataNascimento);
    Query.ParamByName('CPF').AsString := Pessoa.CPF;
    Query.ParamByName('RG').AsString := Pessoa.RG;
    Query.ParamByName('Email').AsString := Pessoa.Email;
    Query.ParamByName('Telefone').AsString := Pessoa.Telefone;
    Query.ParamByName('CEP').AsString := Pessoa.CEP;
    Query.ParamByName('Logradouro').AsString := Pessoa.Logradouro;
    Query.ParamByName('Bairro').AsString := Pessoa.Bairro;
    Query.ParamByName('Cidade').AsString := Pessoa.Cidade;
    Query.ParamByName('Estado').AsString := Pessoa.Estado;
    Query.ParamByName('ID').AsInteger := Pessoa.ID;
    Query.ExecSQL;
    Result := True;
  finally
    Query.Free;
  end;
end;

function TModelPessoas.DeletarPessoa(const ID: Integer): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Conexao;
    Query.SQL.Text := 'DELETE FROM pessoa WHERE ID = :ID';
    Query.ParamByName('ID').AsInteger := ID;
    Query.ExecSQL;
    Result := True;
  finally
    Query.Free;
  end;
end;

function TModelPessoas.BuscarPessoas(const Filtro: string): TFDQuery;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Conexao;
    if Filtro.Trim <> '' then
    begin
      Query.SQL.Text := 'SELECT * FROM pessoa WHERE NomeCompleto LIKE :Filtro ORDER BY NomeCompleto';
      Query.ParamByName('Filtro').AsString := '%' + Filtro + '%';
    end
    else
    begin
      Query.SQL.Text := 'SELECT * FROM pessoa ORDER BY NomeCompleto';
    end;
    Query.Open;
    Result := Query;
  except
    Query.Free;
    raise;
  end;
end;

function TModelPessoas.ValidarCPFUnico(const CPF: string): Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Conexao;
    Query.SQL.Text := 'SELECT COUNT(*) AS Total FROM pessoa WHERE CPF = :CPF';
    Query.ParamByName('CPF').AsString := CPF;
    Query.Open;
    Result := Query.FieldByName('Total').AsInteger = 0;
  finally
    Query.Free;
  end;
end;

end.
