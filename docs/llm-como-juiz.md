# Validação semântica com "LLM como juiz" (LLM-as-judge)

## O problema

Quando o sistema sob teste responde em **linguagem natural** — como um chatbot
de atendimento com IA generativa — um `Should Contain` ou `Should Be Equal`
tradicional não funciona bem: o mesmo modelo pode responder corretamente de
formas diferentes a cada execução, então um assert de texto exato ou fixo
quebra a suíte por variação de fraseado, não por regressão real.

## A técnica

Em vez de comparar texto, delega-se o julgamento a um LLM: dado a pergunta
original, a resposta do sistema e um **critério de negócio** em linguagem
natural, o juiz retorna se a resposta atende ao critério — e por quê.

```robotframework
${aprovado}    ${justificativa}=
...    Validar Resposta Semanticamente    ${pergunta}    ${resposta_bot}    ${criterio}

Should Be True    ${aprovado}    Resposta reprovada: ${justificativa}
```

Isso desacopla a validação da forma exata do texto e a acopla ao que
**realmente importa**: a resposta resolveu o que o cliente perguntou?

## Neste repositório

- [`libraries/LLMJudgeLibrary.py`](../libraries/LLMJudgeLibrary.py) — biblioteca
  Python com a keyword `Validar Resposta Semanticamente`, no mesmo padrão do
  [`FakeDataLibrary.py`](../libraries/FakeDataLibrary.py) já usado no projeto.
- [`tests/llm_judge/test_llm_judge_exemplo.robot`](../tests/llm_judge/test_llm_judge_exemplo.robot) —
  suíte de exemplo com um caso aprovado e um reprovado.

Por padrão a biblioteca roda em **modo simulado** (heurística simples de
palavras-chave) para que a suíte execute sem depender de nenhuma API externa —
consistente com o resto deste projeto de portfólio, que não depende de
serviços externos para rodar. O ponto de extensão para plugar uma API real de
LLM (Anthropic, OpenAI) está isolado em `_julgar_via_api()`, claramente
sinalizado no código.

## Quando usar

- Sistemas que respondem em linguagem natural (chatbots, geração de texto,
  resumos automáticos).
- Quando a variação de fraseado é esperada e não deve reprovar o teste.
- **Não** substitui validação estrutural (status HTTP, schema, campos
  obrigatórios) — esses continuam sendo validados com asserts tradicionais.
