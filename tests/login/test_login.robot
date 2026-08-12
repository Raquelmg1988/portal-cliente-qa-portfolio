*** Settings ***
Library     Browser

Resource    ../../resources/variables_local.robot
Resource    ../../resources/keywords/login_keywords.robot
Resource    ../../resources/keywords/evidencias_keywords.robot

Test Teardown    Sequencia De Encerramento


*** Test Cases ***

Login Com Credenciais Validas Deve Acessar O Dashboard

    Fazer Login Com Credenciais Validas

    Usuario Esta Logado


Login Com Credenciais Invalidas Deve Exibir Mensagem De Erro

    Fazer Login Com Credenciais Invalidas

    Mensagem De Erro De Login Deve Estar Visivel


*** Keywords ***

Sequencia De Encerramento

    Capturar Evidencia Se Falhar
    Fechar Navegador
