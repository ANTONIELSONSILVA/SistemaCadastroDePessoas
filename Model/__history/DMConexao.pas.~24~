unit DMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client;

type
  TDataModuleConexao = class(TDataModule) // Altere para TDataModuleConexao
  private
    Conexao: TFDConnection;
    procedure ConfigurarConexaoSQLite;
  public
    procedure ConectarBanco;
    function ObterConexao: TFDConnection;
  end;

var
  DataModuleConexao: TDataModuleConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TDataModuleConexao.ObterConexao: TFDConnection;
begin
  Result := Conexao;
end;

procedure TDataModuleConexao.ConectarBanco;
begin
  try
    ConfigurarConexaoSQLite;
    Conexao.Open;
  except
    on E: Exception do
      raise Exception.Create('Erro ao conectar ao banco SQLite: ' + E.Message);
  end;
end;

procedure TDataModuleConexao.ConfigurarConexaoSQLite;
var
  CaminhoBanco: string;
begin
  CaminhoBanco := ExtractFilePath(ParamStr(0)) + 'bancoDados.db';

  Conexao.Close;
  Conexao.Params.Clear;
  Conexao.DriverName := 'SQLite';
  Conexao.Params.Add('Database=' + CaminhoBanco);
  Conexao.Params.Add('OpenMode=ReadWrite');
  Conexao.Params.Add('LockingMode=Normal');
  Conexao.Params.Add('Synchronous=Normal');
end;

end.

