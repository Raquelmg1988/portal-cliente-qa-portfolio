*** Settings ***
Library     Browser

Resource    ../../resources/variables_local.robot
Resource    ../../resources/keywords/login_keywords.robot
Resource    ../../resources/keywords/senha_keywords.robot
Resource    ../../resources/keywords/evidencias_keywords.robot

Suite Setup       Fazer Login Com Credenciais Validas
Suite Teardown    Fechar Navegador
Test Teardown     Capturar Evidencia Se Falhar


*** Test Cases ***

Nao Deve Permitir Senha Fraca

    Ir Para Alteracao De Senha

    Alterar Senha    ${USUARIO_SENHA}    123456    123456

    Erro De Senha Deve Conter    critérios de segurança


Nao Deve Permitir Confirmacao De Senha Divergente

    Ir Para Alteracao De Senha

    Alterar Senha    ${USUARIO_SENHA}    NovaSenha@1    NovaSenha@2

    Erro De Senha Deve Conter    não confere


Deve Permitir Alterar Senha Com Dados Validos

    Ir Para Alteracao De Senha

    Alterar Senha    ${USUARIO_SENHA}    NovaSenha@1    NovaSenha@1

    Confirmacao De Senha Alterada Deve Estar Visivel
