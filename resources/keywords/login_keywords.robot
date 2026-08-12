*** Settings ***
Library     Browser

Resource    ../variables_local.robot
Resource    ../locators/locators.robot
Resource    common_keywords.robot


*** Keywords ***

Fazer Login Com Credenciais Validas

    Abrir Navegador Na Pagina De Login

    Fill Text    ${LOGIN_EMAIL}    ${USUARIO_EMAIL}
    Fill Text    ${LOGIN_SENHA}    ${USUARIO_SENHA}
    Click        ${LOGIN_SUBMIT}

    Aguardar UI Livre


Fazer Login Com Credenciais Invalidas

    Abrir Navegador Na Pagina De Login

    Fill Text    ${LOGIN_EMAIL}    ${USUARIO_EMAIL}
    Fill Text    ${LOGIN_SENHA}    ${USUARIO_SENHA_INVALIDA}
    Click        ${LOGIN_SUBMIT}


Usuario Esta Logado

    ${url}=    Get Url

    Should Contain    ${url}    dashboard


Mensagem De Erro De Login Deve Estar Visivel

    Wait For Elements State    ${LOGIN_ERROR}    visible    10s

    Get Text    ${LOGIN_ERROR}    contains    inválidos
