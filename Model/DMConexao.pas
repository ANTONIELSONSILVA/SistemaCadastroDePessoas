unit DMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client, FireDAC.Stan.Def,
  FireDAC.Stan.Async, FireDAC.Phys.SQLite, FireDAC.Stan.Param,
  FireDAC.Phys.SQLiteDef, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.Phys.Intf, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat;

type
  TDataModuleConexao = class(TDataModule)
    FDConnection: TFDConnection;
  public
    class function ObterConexao: TFDConnection;
  end;

var
  DataModuleConexao: TDataModuleConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

class function TDataModuleConexao.ObterConexao: TFDConnection;
var
  PathDB: string;
begin
  if not Assigned(DataModuleConexao) then
    DataModuleConexao := TDataModuleConexao.Create(nil);

  if not DataModuleConexao.FDConnection.Connected then
  begin
    // Obtém o caminho do diretório do executável
    PathDB := ExtractFilePath(ParamStr(0)) + 'dataBase\dataBase.db';

    // Define o caminho para o banco de dados
    DataModuleConexao.FDConnection.Params.Database := PathDB;

    // Conecta ao banco de dados
    DataModuleConexao.FDConnection.Connected := True;
  end;

  Result := DataModuleConexao.FDConnection;
end;


end.

