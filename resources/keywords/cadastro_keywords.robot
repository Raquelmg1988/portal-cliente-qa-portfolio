*** Settings ***
Library     Browser

Resource    ../variables_local.robot
Resource    ../locators/locators.robot


*** Keywords ***

Ir Para Cadastro De Cliente

    Click    ${MENU_CADASTRO}


Cadastrar Novo Cliente
    [Arguments]    ${nome}    ${email}    ${cpf}    ${telefone}

    Fill Text    ${CADASTRO_NOME}         ${nome}
    Fill Text    ${CADASTRO_EMAIL}        ${email}
    Fill Text    ${CADASTRO_CPF}          ${cpf}
    Fill Text    ${CADASTRO_TELEFONE}     ${telefone}

    Click    ${CADASTRO_SUBMIT}


Confirmacao De Cadastro Deve Estar Visivel

    Wait For Elements State    ${CADASTRO_SUCCESS}    visible    10s


Cliente Deve Aparecer Na Listagem
    [Arguments]    ${nome}    ${email}    ${cpf}    ${telefone}

    ${conteudo}=    Get Text    ${TABELA_CLIENTES}
    Should Contain    ${conteudo}    ${nome}
    Should Contain    ${conteudo}    ${email}
    Should Contain    ${conteudo}    ${cpf}
    Should Contain    ${conteudo}    ${telefone}


Quantidade De Linhas Na Tabela De Clientes Deve Ser
    [Arguments]    ${quantidade}

    Get Element Count    ${TABELA_CLIENTES} tbody tr    ==    ${quantidade}
