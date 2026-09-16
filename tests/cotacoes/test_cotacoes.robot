*** Settings ***
Library     Browser

Resource    ../../resources/variables_local.robot
Resource    ../../resources/keywords/login_keywords.robot
Resource    ../../resources/keywords/cotacoes_keywords.robot
Resource    ../../resources/keywords/evidencias_keywords.robot

Test Setup        Fazer Login Com Credenciais Validas
Test Teardown     Sequencia De Encerramento


*** Test Cases ***

Criar Nova Cotacao Deve Aparecer Na Listagem

    Ir Para Cotacoes

    Criar Cotacao    Plano Premium    5

    Cotacao Deve Aparecer Na Listagem    Plano Premium
    Quantidade De Linhas Na Tabela De Cotacoes Deve Ser    1


Excluir Cotacao Deve Remove-La Da Listagem

    Ir Para Cotacoes

    Criar Cotacao    Plano Família    2
    Cotacao Deve Aparecer Na Listagem    Plano Família
    Quantidade De Linhas Na Tabela De Cotacoes Deve Ser    1

    Excluir Cotacao Da Listagem    Plano Família

    Cotacao Nao Deve Aparecer Na Listagem    Plano Família
    Quantidade De Linhas Na Tabela De Cotacoes Deve Ser    0


*** Keywords ***

Sequencia De Encerramento

    Capturar Evidencia Se Falhar
    Fechar Navegador
