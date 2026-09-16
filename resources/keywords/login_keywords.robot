*** Settings ***
Library     Browser

Resource    ../variables_local.robot
Resource    ../locators/locators.robot
Resource    common_keywords.robot


*** Keywords ***

Fazer Login Com Credenciais Validas

    Abrir Navegador Na Pagina De Login
    Fazer Login Com Credenciais    ${USUARIO_EMAIL}    ${USUARIO_SENHA}


Fazer Login Com Credenciais Invalidas

    Abrir Navegador Na Pagina De Login
    Fazer Login Com Credenciais    ${USUARIO_EMAIL}    ${USUARIO_SENHA_INVALIDA}


Fazer Login Com Credenciais
    [Documentation]    Preenche e envia o formulário de login assumindo que a página de login já está aberta.
    [Arguments]    ${email}    ${senha}

    Fill Text    ${LOGIN_EMAIL}    ${email}
    Fill Text    ${LOGIN_SENHA}    ${senha}
    Click        ${LOGIN_SUBMIT}

    Aguardar UI Livre


Fazer Logout

    Click    ${LOGOUT_BTN}
    Aguardar UI Livre


Usuario Esta Logado

    ${url}=    Get Url

    Should Contain    ${url}    dashboard


Mensagem De Erro De Login Deve Estar Visivel

    Wait For Elements State    ${LOGIN_ERROR}    visible    10s

    Get Text    ${LOGIN_ERROR}    contains    inválidos
