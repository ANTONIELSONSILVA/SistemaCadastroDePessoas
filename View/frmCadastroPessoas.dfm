object frmCadastroDePessoas: TfrmCadastroDePessoas
  Left = 0
  Top = 0
  Caption = 'Cadastro De Pessoas'
  ClientHeight = 596
  ClientWidth = 1134
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object pcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 1134
    Height = 596
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 1124
    ExplicitHeight = 578
    object TabSheet1: TTabSheet
      Caption = 'CADASTRO'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1126
        Height = 73
        Align = alTop
        Caption = 'Cadastro de Pessoas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -60
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ExplicitTop = -6
      end
      object Panel2: TPanel
        Left = 0
        Top = 73
        Width = 1126
        Height = 493
        Align = alClient
        TabOrder = 1
        object lbTipoPessoa: TLabel
          Left = 32
          Top = 11
          Width = 81
          Height = 15
          Caption = 'Tipo de Pessoa:'
        end
        object ledNome: TLabeledEdit
          Left = 32
          Top = 80
          Width = 409
          Height = 23
          EditLabel.Width = 90
          EditLabel.Height = 15
          EditLabel.Caption = 'Nome completo:'
          TabOrder = 0
          Text = ''
          TextHint = 'Informe o nome'
        end
        object ledNascimento: TLabeledEdit
          Left = 32
          Top = 128
          Width = 409
          Height = 23
          EditLabel.Width = 108
          EditLabel.Height = 15
          EditLabel.Caption = 'Data de nascimento:'
          TabOrder = 1
          Text = ''
          TextHint = 'dd/mm/aaaa'
        end
        object ledCPF: TLabeledEdit
          Left = 32
          Top = 177
          Width = 409
          Height = 23
          EditLabel.Width = 24
          EditLabel.Height = 15
          EditLabel.Caption = 'CPF:'
          TabOrder = 2
          Text = ''
          TextHint = '000.000.000-00'
        end
        object ledRG: TLabeledEdit
          Left = 32
          Top = 224
          Width = 409
          Height = 23
          EditLabel.Width = 18
          EditLabel.Height = 15
          EditLabel.Caption = 'RG:'
          TabOrder = 3
          Text = ''
          TextHint = '00.000.000-0'
        end
        object ledEmail: TLabeledEdit
          Left = 32
          Top = 270
          Width = 409
          Height = 23
          EditLabel.Width = 37
          EditLabel.Height = 15
          EditLabel.Caption = 'E-mail:'
          TabOrder = 4
          Text = ''
          TextHint = 'email@dominio.com.br'
        end
        object ledTelefone: TLabeledEdit
          Left = 32
          Top = 320
          Width = 409
          Height = 23
          EditLabel.Width = 47
          EditLabel.Height = 15
          EditLabel.Caption = 'Telefone:'
          TabOrder = 5
          Text = ''
          TextHint = '(00) 000 0000-0000'
        end
        object ledCEP: TLabeledEdit
          Left = 536
          Top = 32
          Width = 145
          Height = 23
          EditLabel.Width = 24
          EditLabel.Height = 15
          EditLabel.Caption = 'CEP:'
          TabOrder = 6
          Text = ''
          TextHint = '0000-000'
          OnExit = ledCEPExit
        end
        object ledBairro: TLabeledEdit
          Left = 536
          Top = 177
          Width = 569
          Height = 23
          EditLabel.Width = 34
          EditLabel.Height = 15
          EditLabel.Caption = 'Bairro:'
          TabOrder = 7
          Text = ''
        end
        object ledCidade: TLabeledEdit
          Left = 536
          Top = 224
          Width = 569
          Height = 23
          EditLabel.Width = 40
          EditLabel.Height = 15
          EditLabel.Caption = 'Cidade:'
          TabOrder = 8
          Text = ''
        end
        object ledEstado: TLabeledEdit
          Left = 536
          Top = 128
          Width = 569
          Height = 23
          EditLabel.Width = 38
          EditLabel.Height = 15
          EditLabel.Caption = 'Estado:'
          TabOrder = 9
          Text = ''
        end
        object cbTipoPessoa: TComboBox
          Left = 32
          Top = 32
          Width = 409
          Height = 23
          TabOrder = 10
          TextHint = 'Informe o tipo de pessoa'
        end
        object btnSalvar: TBitBtn
          Left = 536
          Top = 280
          Width = 161
          Height = 63
          Caption = '&SALVAR'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FF6B3B3B6B3B3B9191918F8F8F8C8C8C89
            89898787878383838080817E7E7E6B3B3B6B3B3B6B3B3BFF00FFFF00FF6B3B3B
            CF6F0ACB6A0AF7F7F7C2620ABE5E0ADEDEDED3D3D3C8C8C8BEBEBEB4B3B3A847
            0AA4440A6B3B3BFF00FFFF00FF6B3B3BD3730AD06F0AFBFBFBC6650AC1620AE4
            E4E4DADAD9D0D0CFC4C4C5BABBBAAB4B0AA7470A6B3B3BFF00FFFF00FF6B3B3B
            D7770AD3730AFCFCFCCB6A0AC6660AE9EAE9E1E1E1D5D6D6CCCBCBC0C0C0AD4E
            0AAB4A0A6B3B3BFF00FFFF00FF6B3B3BDC7B0AD6760AEDCBA5FCFCFCF7F7F7EF
            EFEFE6E6E6DCDDDCD2D1D1C09E83B1500AAE4E0A6B3B3BFF00FFFF00FF6B3B3B
            DF7E0ADB7B0AD7760AD3730ACF6F0ACA690AC5650AC2610ABE5D0AB9590AB555
            0AB1510A6B3B3BFF00FFFF00FF6B3B3BE3830ADF7F0ADB7A0AD7760AD2730ACF
            6E0ACA690AC6650AC1620ABD5D0AB9590AB5540A6B3B3BFF00FFFF00FF6B3B3B
            E7870AFCF6EAFBF4E4FCF1E0FBEEDAFCEDD4FCEAD0FBE8CAFBE5C4FBE4C0FBE3
            BCB9580A6B3B3BFF00FFFF00FF6B3B3BEA890AEDEAE5E9E5DFE5E1D8E1DBD2DD
            D7CBDAD1C4D7CEBFD4CAB9D1C6B4CFC2AEBD5D0A6B3B3BFF00FFFF00FF6B3B3B
            EE8D0AFCF8F1FCF7ECFCF5E7FCF2E2FCF0DDFBEDD7FBEBD1FCE9CCFCE6C6FBE5
            C1C1610A6B3B3BFF00FFFF00FF6B3B3BF1900AF1EFECEDEAE6E9E5E1E5E1D9E2
            DCD2DED7CCDAD2C6D7CEBFD4CABAD1C6B5C5640A6B3B3BFF00FFFF00FF6B3B3B
            F4930AFCFAF7FCF8F3FCF7EEFCF6E9FCF3E4FCF1DEFCEED9FBECD3FCEACFFCE7
            C8C9690A6B3B3BFF00FFFF00FF6B3B3BF7960AACAAFBA0A2FA959AF98993F87E
            8CF77485F6697FF56178F35874F2516EF0CE6E0A6B3B3BFF00FFFF00FF6B3B3B
            6B3B3B2D2BB4292AB42627B42125B41E22B41920B4171EB4141CB4111AB40E19
            B46B3B3B6B3B3BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 11
          OnClick = btnSalvarClick
        end
        object btnCancelar: TBitBtn
          Left = 752
          Top = 280
          Width = 161
          Height = 63
          Caption = 'L&IMPAR'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C30E0000C30E00000000000000000000FF00FFFF00FF
            FF00FFBDA79BB17B5BA95C2FA44B199B3B0A9B3B0A9D400FA8592DB17B5EBEA8
            9EFF00FFFF00FFFF00FFFF00FFFF00FFAB6945A44A12BF6E21D89D5AE6BF8BEE
            CC97EFCB91EDC486E1AE71C6844AA65020AF7556FF00FFFF00FFFF00FFFF00FF
            A14818E9BA7CF6DCBBF7E4CCF7ECDBF7E6CBF8E0BAF9DAAAF9D9A9F9D7A8F0C8
            95A44E22FF00FFFF00FFFF00FFFF00FFA3491AF4D1A6F5DAB6F6E3C7F7E9D4F7
            E4C6F7DEB5F8D9A7F8D8A7F9D6A7F9D4A5A34818FF00FFFF00FFFF00FFC3B8B2
            AE5E2DF3D0A1F4D8B1F5E1C2F6E6CFF7E2C0F7DCB0F7D7A5F8D7A5F8D6A6F9D4
            A5B36132C3BBB6FF00FFFF00FFBEA89EBB723EF2CE9DF3D6AEF4DEBFF5E4C8F6
            DFBBF7D9ACF7D6A3F7D5A3F8D5A4F8D4A4C27B4DBEAAA0FF00FFFF00FFB89787
            C7824BF1CC99F2D4AAF3DCBAF4E1C2F5DCB6F6D8A9F7D4A0F7D4A2F7D4A3F8D4
            A4CF9163B99A89FF00FFFF00FFB48973CF9054F0CA96F2D2A6F2DAB6F3DEBDF4
            DAB1F5D6A6F6D39EF7D3A0F7D3A1F7D2A2DDA877B58A73FF00FFFF00FFAF7658
            D89C5DEFC891F1D0A2F2D8B1F3DBB8F4D8ADF5D4A2F6D29CF6D29EF7D2A0F7D2
            A2E6B485B1795BFF00FFFF00FFAA643CE0A768EFC68EF0CE9EF1D6AEF2D9B3F3
            D6A9F4D29FF5D19AF6D19DF7D29FF7D2A1EDC091AC6844FF00FFFF00FFA55426
            E5B172F0D0A2F2D8B3F5E3C7F5E4CBF6E5CBF6E5CBF7E6CDF7E7D0F7E1C0F8DD
            B9F3CA9AAA5A2FFF00FFFF00FFBE805FEBCB9CE4B162E1A64ADD9A34DFA141E1
            A84FE3AE5CE5B569E7BB76ECCA95F1D8B2F4E3CDC79073FF00FFFF00FF9E4211
            B45D0FC57315CF8322D79431DFA242E1A84FE4AE5DE5B56AE1B16FDAA76CCF97
            62B97344A24B1FFF00FFFF00FFC3B8B2B2836AAB6238A653239F44139B3B0A9B
            3B0A9B3B0A9B3B0AA14415A7562AAE6C48B48A75C5BEBBFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 12
          OnClick = btnCancelarClick
        end
        object ledLogradouro: TLabeledEdit
          Left = 536
          Top = 80
          Width = 569
          Height = 23
          EditLabel.Width = 65
          EditLabel.Height = 15
          EditLabel.Caption = 'Logradouro:'
          TabOrder = 13
          Text = ''
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'PESQUISA E ALTERA'#199#194'O'
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 1126
        Height = 73
        Align = alTop
        Caption = 'Listagem e Edi'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -50
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ExplicitWidth = 1116
      end
      object Panel4: TPanel
        Left = 0
        Top = 73
        Width = 1126
        Height = 493
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 1116
        ExplicitHeight = 475
        object grdDados: TDBGrid
          Left = 0
          Top = 0
          Width = 1145
          Height = 353
          DataSource = dtsListagem
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          OnDrawColumnCell = grdDadosDrawColumnCell
          OnDblClick = grdDadosDblClick
        end
        object DBNavigator1: TDBNavigator
          Left = 352
          Top = 374
          Width = 384
          Height = 33
          DataSource = dtsListagem
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
          TabOrder = 1
        end
        object btnApagar: TBitBtn
          Left = 352
          Top = 426
          Width = 169
          Height = 31
          Caption = 'APAGA&R'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            2D2BAA252595FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0101
            60000073FF00FFFF00FFFF00FF3836B61111B81C1CB82F2FA4FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FF06066D01018A00008B020074FF00FF3F3FBB1616C5
            0A0AC20A0AC02222C43737ADFF00FFFF00FFFF00FFFF00FF11117B0505910000
            9000009000008B0200743B3BB22C2CD30D0DD00D0DCE0C0CC92828CC3D3DB4FF
            00FFFF00FF1F1F8E0C0C9F00009200009000009000008800005DFF00FF4747C1
            3333DE1111DA0F0FD50D0DCF2A2AD13C3CB42F2FA41717B40303A30101990000
            91010189010160FF00FFFF00FFFF00FF5454CC3C3CE71313E11111DA0E0ED328
            28CF2222C60707B50505AA0303A0060693050566FF00FFFF00FFFF00FFFF00FF
            FF00FF5C5CD33F3FEA1414E31111DC0E0ED10C0CC70909BC0606B10D0DA40E0E
            77FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5B5BD03D3DE61414E311
            11DA0D0DCF0A0AC21616B5181886FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF6E6ECE5B5BE92020E71313E10F0FD40C0CC91616B7181887FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7878CE7474E75353EE4848ED35
            35E92020DD1111CE0A0ABF0F0FAB0E0E79FF00FFFF00FFFF00FFFF00FFFF00FF
            7F7FCB8787E56D6DF26363F05757EF5C5CDE5252D83B3BDA2D2DCE1F1FC01818
            A5111176FF00FFFF00FFFF00FF8484C79797E38484F47B7BF37070F27272E05B
            5BBB4D4DB15151CF4141D43838C92F2FBD2929A51B1B78FF00FF8686C2A0A0E0
            9999F69191F68888F48383DE6767BCFF00FFFF00FF4747A55050C54242CB3737
            C02E2EB52929A01D1D7A9393B7A5A5EAA1A1F79A9AF69292DD6E6EBDFF00FFFF
            00FFFF00FFFF00FF3F3F9C4A4ABC3B3BC03232B52D2DA92B2B8EFF00FF9594B6
            A7A7E99D9DDC7676BBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3C3C984141
            B53535B0343495FF00FFFF00FFFF00FF9796B68080C0FF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FF3636933E3E9AFF00FFFF00FF}
          TabOrder = 2
          OnClick = btnApagarClick
        end
        object btnEditar: TBitBtn
          Left = 552
          Top = 426
          Width = 184
          Height = 31
          Caption = 'E&DITAR'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFB25D13AF5912AD5612AC5311AA4F10A84E0FA54A0EA4
            480DA1440DA0420C9F3F0C9D3E0BFF00FFFF00FFFF00FFFF00FFB56114FCF7EF
            FBF6EBF3EBE0FCF2E3FBF0DEFBEFDAFBEDD5FBEBD1FBE9CDFBE7C89E400BFF00
            FFFF00FFFF00FFFF00FFB86516FCF8F3FCF7EF1D2B321B2F37A7C0C5EDE0CFF4
            E0C8F8E6CFFBEBD1FBEACEA1430CFF00FFFF00FFFF00FFFF00FFBB6916FCFAF7
            FCF8F43F5A655999A455B9D12A84A64A8763E3C0A5E4C1A4E8C9ABA2450DFF00
            FFFF00FFFF00FFFF00FFBE6D17FCFBF9FCFAF7B2CDD96BBAD688E9EF2381400E
            6D0D0E6E0EE3C0A5E3BFA2A3470DFF00FFFF00FFFF00FFFF00FFC07217FCFBFC
            FCFBF9EBEFF14190B23687509CDEB056B86D146F110E6E0EE3C0A6A54A0EFF00
            FFFF00FFFF00FFFF00FFC37519FCFCFCFCFCFCFCFBFA5B9A9A53975392C69994
            E1AC4EB565146F110E6E0EA84C0FFF00FFFF00FFFF00FFFF00FFC57919FCFCFC
            FCFCFCFCFCFCFCFBF931833550955080BC8784DCA046B15E146F110E6E0EFF00
            FFFF00FFFF00FFFF00FFC77C1AFCFCFCFCFCFCFCFCFCFCFCFCFCFBFB31833547
            8F476DB27573D7943EAE58116A0E0E6E9B84ACBDFF00FFFF00FFC97F1CFCFCFC
            FCFCFCFCFCFCFCFCFCFCFCFCFCFCFA3183353C893C5AA96461D1874297AC34A3
            CC0E6E9BFF00FFFF00FFCC821CFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC
            FCFA3183353183354297AC9AFBFB4297AC141EB10A0A9AFF00FFCE851DFCFCFC
            FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFBFB4297AC87EDF64297AC476B
            FC1D46F72231C34B4BAACF861DFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC
            FCFCFCFCFCEEF5F74297AC1116A6476BFC1D46F70A0A9AFF00FFCF871DCF871D
            CE861DCC831CCC821CCA801BC87D1BC67A1AC47719C37419C172170A0A9A2231
            C30A0A9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FF4B4BAAFF00FFFF00FFFF00FF}
          TabOrder = 3
          OnClick = btnEditarClick
        end
        object ledPesquisa: TLabeledEdit
          Left = 11
          Top = 374
          Width = 289
          Height = 23
          EditLabel.Width = 104
          EditLabel.Height = 15
          EditLabel.Caption = 'Digite sua pesquisa:'
          TabOrder = 4
          Text = ''
          OnChange = ledPesquisaChange
        end
      end
    end
  end
  object dtsListagem: TDataSource
    Left = 1036
    Top = 42
  end
end
