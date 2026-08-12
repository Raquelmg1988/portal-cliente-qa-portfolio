*** Settings ***
Library     Browser

Resource    ../variables_local.robot
Resource    ../locators/locators.robot


*** Keywords ***

Ir Para Alteracao De Senha

    Click    ${MENU_SENHA}


Alterar Senha
    [Arguments]    ${valor_atual}    ${valor_novo}    ${valor_confirmacao}

    Fill Text    ${SENHA_ATUAL}       ${valor_atual}
    Fill Text    ${SENHA_NOVA}        ${valor_novo}
    Fill Text    ${SENHA_CONFIRMA}    ${valor_confirmacao}

    Click    ${SENHA_SUBMIT}


Confirmacao De Senha Alterada Deve Estar Visivel

    Wait For Elements State    ${SENHA_SUCCESS}    visible    10s


Erro De Senha Deve Conter
    [Arguments]    ${mensagem_esperada}

    Wait For Elements State    ${SENHA_ERROR}    visible    10s

    Get Text    ${SENHA_ERROR}    contains    ${mensagem_esperada}
