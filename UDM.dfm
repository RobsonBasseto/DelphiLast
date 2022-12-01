object dm: Tdm
  OldCreateOrder = False
  Height = 338
  Width = 470
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=D:\Users\rrobasseto\Desktop\APP\BD\bd.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = FDConnectionAfterConnect
    BeforeConnect = FDConnectionBeforeConnect
    Left = 48
    Top = 40
  end
  object FDQLogin: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from login'
      'where email =:pEmail')
    Left = 48
    Top = 104
    ParamData = <
      item
        Name = 'PEMAIL'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object FDQLoginidlogin: TFDAutoIncField
      FieldName = 'idlogin'
      Origin = 'idlogin'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQLoginemail: TStringField
      FieldName = 'email'
      Origin = 'email'
      Required = True
      Size = 50
    end
    object FDQLoginsenha: TStringField
      FieldName = 'senha'
      Origin = 'senha'
      Required = True
      Size = 200
    end
  end
  object FDQCarro: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from carro'
      '')
    Left = 48
    Top = 176
    object FDQCarroidcarro: TFDAutoIncField
      FieldName = 'idcarro'
      Origin = 'idcarro'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQCarroplaca: TStringField
      FieldName = 'placa'
      Origin = 'placa'
      Size = 7
    end
    object FDQCarromarca: TStringField
      FieldName = 'marca'
      Origin = 'marca'
      Size = 50
    end
    object FDQCarroano: TIntegerField
      FieldName = 'ano'
      Origin = 'ano'
    end
    object FDQCarromodelo: TStringField
      FieldName = 'modelo'
      Origin = 'modelo'
      Size = 50
    end
    object FDQCarromediagasolina: TBCDField
      FieldName = 'mediagasolina'
      Origin = 'mediagasolina'
      Precision = 8
      Size = 2
    end
    object FDQCarromediaetanol: TBCDField
      FieldName = 'mediaetanol'
      Origin = 'mediaetanol'
      Precision = 8
      Size = 2
    end
    object FDQCarromediadiesel: TBCDField
      FieldName = 'mediadiesel'
      Origin = 'mediadiesel'
      Precision = 8
      Size = 2
    end
    object FDQCarroqtdtanque: TIntegerField
      FieldName = 'qtdtanque'
      Origin = 'qtdtanque'
    end
  end
  object FDQLogado: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from login where idlogin =:pidlogin')
    Left = 280
    Top = 96
    ParamData = <
      item
        Name = 'PIDLOGIN'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object FDQViagem: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from viagem')
    Left = 48
    Top = 248
  end
end
