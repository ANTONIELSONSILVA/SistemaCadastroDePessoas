object DataModuleConexao: TDataModuleConexao
  Height = 1080
  Width = 1440
  PixelsPerInch = 144
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      'LockingMode=Normal'
      'Synchronous=Normal')
    LoginPrompt = False
    Left = 640
    Top = 264
  end
end
