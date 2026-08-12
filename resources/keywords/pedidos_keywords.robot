*** Settings ***
Library     Browser

Resource    ../variables_local.robot
Resource    ../locators/locators.robot


*** Keywords ***

Ir Para Pedidos

    Click    ${MENU_PEDIDOS}


Pedido Deve Estar Visivel Com Status
    [Arguments]    ${pedido_id}    ${status_esperado}

    ${locator}=    Set Variable    [data-testid="status-${pedido_id}"]

    Wait For Elements State    ${locator}    visible    10s

    Get Text    ${locator}    ==    ${status_esperado}
