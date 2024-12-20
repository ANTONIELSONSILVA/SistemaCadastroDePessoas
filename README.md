# SistemaCadastroDePessoas
Teste Prático para Desenvolvedor Delphi Júnior: Sistema de Cadastro de Pessoas

## Estrutura do Projeto
- **Pasta `Debug` e `Release`:** Contém os executáveis do sistema e da API Python APICEP.
- **Pasta `dataBase`:** Contém o banco de dados SQLite e o script de criação. O banco já está configurado e incluído nas pastas `Debug` e `Release` para facilitar a execução.
- **Pasta `APICEP`:** Contém o código-fonte da API Python.

## Configuração da API Python
O executável da API **APICEP** já está pronto para uso nas pastas `Debug` e `Release`. Caso deseje, você pode recompilar a API acessando a pasta `APICEP` e executando o comando:

```bash
pyinstaller --noconsole --onefile APICEP.py
```

O executável gerado estará na pasta `dist`.

## Executando o Sistema
- **Sistema Delphi:** Compile e execute o projeto na IDE ou utilize o executável nas pastas `Debug` ou `Release`.
- **API Python:** Utilize o executável `APICEP.exe` nas pastas `Debug` ou `Release`. Caso prefira, também é possível executar o código diretamente via:

```bash
python APICEP.py
```

