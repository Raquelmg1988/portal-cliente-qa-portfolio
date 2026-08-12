*** Settings ***
Library     Browser

Resource    ../variables_local.robot


*** Keywords ***

Abrir Navegador Na Pagina De Login

    New Browser
    ...    ${BROWSER}
    ...    headless=${HEADLESS}

    New Context

    New Page    ${URL}

Fechar Navegador

    Close Browser    ALL

Aguardar UI Livre

    Wait For Load State    networkidle
