*** Settings ***
Library     Browser

Resource    ../../resources/variables_local.robot
Resource    ../../resources/keywords/login_keywords.robot
Resource    ../../resources/keywords/senha_keywords.robot
Resource    ../../resources/keywords/evidencias_keywords.robot

Test Setup        Fazer Login Com Credenciais Validas
Test Teardown     Sequencia De Encerramento

Documentation     Casos negativos de alteração de senha. Nenhum destes cenários
...               chega a persistir uma nova senha, então não há necessidade de
...               restaurar estado no teardown. O caso de sucesso, que muda a
...               senha do usuário, vive em test_alterar_senha.robot.


*** Test Cases ***

Nao Deve Permitir Senha Fraca

    Ir Para Alteracao De Senha

    Alterar Senha    ${USUARIO_SENHA}    123456    123456

    Erro De Senha Deve Conter    critérios de segurança


Nao Deve Permitir Confirmacao De Senha Divergente

    Ir Para Alteracao De Senha

    Alterar Senha    ${USUARIO_SENHA}    NovaSenha@1    NovaSenha@2

    Erro De Senha Deve Conter    não confere


*** Keywords ***

Sequencia De Encerramento

    Capturar Evidencia Se Falhar
    Fechar Navegador
