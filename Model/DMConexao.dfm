object DataModuleConexao: TDataModuleConexao
  Height = 1080
  Width = 1440
  PixelsPerInch = 144
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      
        'Database=C:\Users\Antonielson\Desktop\SistemaCadastroDePessoas\W' +
        'in32\Debug\dataBase\dataBase.db'
      'LockingMode=Normal'
      'Synchronous=Normal')
    LoginPrompt = False
    Left = 640
    Top = 264
  end
end
