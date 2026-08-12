*** Settings ***
Library     Browser

Resource    ../../resources/variables_local.robot
Resource    ../../resources/keywords/login_keywords.robot
Resource    ../../resources/keywords/cotacoes_keywords.robot
Resource    ../../resources/keywords/evidencias_keywords.robot

Suite Setup       Fazer Login Com Credenciais Validas
Suite Teardown    Fechar Navegador
Test Teardown      Capturar Evidencia Se Falhar


*** Test Cases ***

Criar Nova Cotacao Deve Aparecer Na Listagem

    Ir Para Cotacoes

    Criar Cotacao    Plano Premium    5

    Cotacao Deve Aparecer Na Listagem    Plano Premium


Excluir Cotacao Deve Remove-La Da Listagem

    Ir Para Cotacoes

    Criar Cotacao    Plano Família    2
    Cotacao Deve Aparecer Na Listagem    Plano Família

    Excluir Cotacao Da Listagem    Plano Família
