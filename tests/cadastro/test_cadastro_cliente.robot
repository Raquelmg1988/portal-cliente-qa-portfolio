*** Settings ***
Library     Browser
Library     ../../libraries/FakeDataLibrary.py

Resource    ../../resources/variables_local.robot
Resource    ../../resources/keywords/login_keywords.robot
Resource    ../../resources/keywords/cadastro_keywords.robot
Resource    ../../resources/keywords/evidencias_keywords.robot

Suite Setup       Fazer Login Com Credenciais Validas
Suite Teardown    Fechar Navegador
Test Teardown     Capturar Evidencia Se Falhar


*** Test Cases ***

Cadastrar Novo Cliente Com Dados Fake Com Sucesso

    ${nome}=         Gerar Nome Fake
    ${email}=        Gerar Email Fake
    ${cpf}=          Gerar Cpf Fake
    ${telefone}=     Gerar Telefone Fake

    Ir Para Cadastro De Cliente

    Cadastrar Novo Cliente    ${nome}    ${email}    ${cpf}    ${telefone}

    Confirmacao De Cadastro Deve Estar Visivel
    Cliente Deve Aparecer Na Listagem    ${nome}
