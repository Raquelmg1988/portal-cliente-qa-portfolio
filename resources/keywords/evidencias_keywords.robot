*** Settings ***
Library     Browser

Resource    ../variables_local.robot


*** Keywords ***

Capturar Evidencia Se Falhar

    Run Keyword If Test Failed
    ...    Capturar Screenshot Da Falha


Capturar Screenshot Da Falha

    Take Screenshot
    ...    ${SCREENSHOT_DIR}/${TEST NAME}
    ...    fullPage=True
