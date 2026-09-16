*** Settings ***
Library     Browser

Resource    ../../resources/variables_local.robot
Resource    ../../resources/keywords/login_keywords.robot
Resource    ../../resources/keywords/pedidos_keywords.robot
Resource    ../../resources/keywords/evidencias_keywords.robot

Test Setup        Fazer Login Com Credenciais Validas
Test Teardown     Sequencia De Encerramento


*** Test Cases ***

Pedidos Devem Ser Listados Com Seus Respectivos Status

    Ir Para Pedidos

    Pedido Deve Estar Visivel Com Status    PED-1001    aprovado
    Pedido Deve Estar Visivel Com Status    PED-1002    pendente
    Pedido Deve Estar Visivel Com Status    PED-1003    recusado


*** Keywords ***

Sequencia De Encerramento

    Capturar Evidencia Se Falhar
    Fechar Navegador
