*** Settings ***
Library     Browser

Resource    ../../resources/variables_local.robot
Resource    ../../resources/keywords/login_keywords.robot
Resource    ../../resources/keywords/senha_keywords.robot
Resource    ../../resources/keywords/evidencias_keywords.robot

Test Setup        Fazer Login Com Credenciais Validas
Test Teardown     Sequencia De Encerramento

Documentation     Suíte isolada para o único cenário que altera a senha
...               persistida do usuário. Fica separada dos casos negativos
...               (test_validacao_senha.robot) para deixar explícito que este
...               teste muda estado compartilhado e precisa restaurá-lo.


*** Variables ***
${SENHA_NOVA_TESTE}    NovaSenha@1


*** Test Cases ***

Deve Permitir Alterar Senha Com Dados Validos

    Ir Para Alteracao De Senha

    Alterar Senha    ${USUARIO_SENHA}    ${SENHA_NOVA_TESTE}    ${SENHA_NOVA_TESTE}

    Confirmacao De Senha Alterada Deve Estar Visivel

    Fazer Logout
    Fazer Login Com Credenciais    ${USUARIO_EMAIL}    ${USUARIO_SENHA}
    Mensagem De Erro De Login Deve Estar Visivel

    Fazer Login Com Credenciais    ${USUARIO_EMAIL}    ${SENHA_NOVA_TESTE}
    Usuario Esta Logado


*** Keywords ***

Sequencia De Encerramento

    Capturar Evidencia Se Falhar
    Restaurar Senha Original
    Fechar Navegador


Restaurar Senha Original
    [Documentation]    Garante que a senha volte ao valor original, mesmo que
    ...                o browser não seja recriado antes do próximo teste.

    Ir Para Alteracao De Senha
    Alterar Senha    ${SENHA_NOVA_TESTE}    ${USUARIO_SENHA}    ${USUARIO_SENHA}
