*** Settings ***
Library     Browser
Library     ../../libraries/FakeDataLibrary.py

Resource    ../../resources/variables_local.robot
Resource    ../../resources/keywords/login_keywords.robot
Resource    ../../resources/keywords/cadastro_keywords.robot
Resource    ../../resources/keywords/evidencias_keywords.robot

Test Setup        Fazer Login Com Credenciais Validas
Test Teardown     Sequencia De Encerramento


*** Test Cases ***

Cadastrar Novo Cliente Com Dados Fake Com Sucesso

    ${nome}=         Gerar Nome Fake
    ${email}=        Gerar Email Fake
    ${cpf}=          Gerar Cpf Fake
    ${telefone}=     Gerar Telefone Fake

    Ir Para Cadastro De Cliente

    Cadastrar Novo Cliente    ${nome}    ${email}    ${cpf}    ${telefone}

    Confirmacao De Cadastro Deve Estar Visivel
    Cliente Deve Aparecer Na Listagem    ${nome}    ${email}    ${cpf}    ${telefone}
    Quantidade De Linhas Na Tabela De Clientes Deve Ser    1


*** Keywords ***

Sequencia De Encerramento

    Capturar Evidencia Se Falhar
    Fechar Navegador
