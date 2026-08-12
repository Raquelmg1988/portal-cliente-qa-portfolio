*** Settings ***
Library     Browser

Resource    ../variables_local.robot
Resource    ../locators/locators.robot


*** Keywords ***

Ir Para Cotacoes

    Click    ${MENU_COTACOES}


Criar Cotacao
    [Arguments]    ${produto}    ${quantidade}

    Select Options By    ${COTACAO_PRODUTO}    label    ${produto}
    Fill Text            ${COTACAO_QUANTIDADE}    ${quantidade}

    Click    ${COTACAO_SUBMIT}


Cotacao Deve Aparecer Na Listagem
    [Arguments]    ${produto}

    Get Text    ${TABELA_COTACOES}    contains    ${produto}


Excluir Cotacao Da Listagem
    [Arguments]    ${produto}

    ${locator}=    Set Variable    text=${produto} >> xpath=..//button[contains(@data-testid, "cotacao-excluir")]

    Click    ${locator}
