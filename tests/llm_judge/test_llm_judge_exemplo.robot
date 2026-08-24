*** Settings ***
Documentation
...    Exemplo ilustrativo do padrão "LLM como juiz" para validar respostas em
...    linguagem natural de um chatbot fictício de atendimento — cenário
...    inspirado em soluções de atendimento autônomo com IA, sem vínculo com
...    nenhum sistema real. Roda em modo simulado por padrão (sem depender de
...    nenhuma API externa) — ver libraries/LLMJudgeLibrary.py.

Library    ../../libraries/LLMJudgeLibrary.py


*** Test Cases ***

Resposta Do Bot Deve Informar Status Do Pedido
    [Documentation]    Valida semanticamente se a resposta do chatbot fictício
    ...    resolve a dúvida do cliente, em vez de comparar texto exato.

    ${pergunta}=       Set Variable    Qual o status do meu pedido PED-1002?
    ${resposta_bot}=   Set Variable    Seu pedido PED-1002 está com status "pendente" — a confirmação de pagamento ainda não foi processada. Assim que for aprovada, você receberá uma notificação por e-mail.
    ${criterio}=       Set Variable    A resposta deve informar claramente o status atual do pedido

    ${aprovado}    ${justificativa}=
    ...    Validar Resposta Semanticamente    ${pergunta}    ${resposta_bot}    ${criterio}

    Should Be True    ${aprovado}    Resposta reprovada: ${justificativa}
    Log    ${justificativa}


Resposta Vaga Do Bot Deve Ser Reprovada
    [Documentation]    Caso negativo: resposta que não atende ao critério de
    ...    negócio deve ser reprovada pelo juiz semântico.

    ${pergunta}=       Set Variable    Qual o status do meu pedido PED-1002?
    ${resposta_bot}=   Set Variable    Obrigado por entrar em contato conosco!
    ${criterio}=       Set Variable
    ...    A resposta deve informar claramente o status atual do pedido

    ${aprovado}    ${justificativa}=
    ...    Validar Resposta Semanticamente    ${pergunta}    ${resposta_bot}    ${criterio}

    Should Not Be True    ${aprovado}    Esperava reprovação: ${justificativa}
    Log    ${justificativa}
