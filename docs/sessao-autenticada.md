# Reaproveitamento de sessão autenticada entre testes

Um dos custos mais comuns em suítes E2E é repetir o fluxo de login antes de cada caso de
teste — preencher e-mail, senha, clicar em entrar, esperar o carregamento. Multiplicado por
dezenas de cenários, isso pode dominar boa parte do tempo total de execução sem agregar
cobertura nova (o login em si já tem sua própria suíte dedicada, ver `tests/login/`).

## A técnica usada neste repositório

As suítes que dependem de um usuário logado (`tests/cotacoes/`, `tests/pedidos/`) usam
**Suite Setup/Teardown** do Robot Framework para autenticar uma única vez por suíte e
reaproveitar a mesma sessão de navegador em todos os casos de teste seguintes:

```robotframework
*** Settings ***
Suite Setup       Fazer Login Com Credenciais Validas
Suite Teardown    Fechar Navegador
```

`Fazer Login Com Credenciais Validas` (definida em
[`resources/keywords/login_keywords.robot`](../resources/keywords/login_keywords.robot))
abre o navegador, faz o login via UI uma única vez e deixa a página autenticada aberta. Como
o Robot Framework mantém o mesmo processo de navegador entre `Suite Setup` e `Suite
Teardown`, cada caso de teste dentro da suíte já começa a partir dessa sessão — sem repetir
login, sem recarregar o navegador.

## Por que isso importa

- **Tempo de execução:** elimina N repetições do fluxo de login (N = número de casos de
  teste na suíte), mantendo apenas 1 autenticação real por suíte.
- **Isolamento de responsabilidade:** o comportamento do login (sucesso, falha, mensagens de
  erro) já é coberto isoladamente em `tests/login/test_login.robot` — não precisa ser
  revalidado em toda suíte que apenas *depende* de estar logado.
- **Legibilidade:** cada caso de teste em `test_cotacoes.robot` / `test_pedidos.robot` foca
  exclusivamente no comportamento que está validando (criar cotação, listar pedidos), sem
  ruído de setup repetido.

## Quando não usar

Se um teste específico precisa validar o próprio processo de autenticação (ex.: mensagens de
erro, bloqueio de conta, expiração de sessão), ele deve continuar fazendo login dentro do
próprio caso de teste — como já ocorre em `tests/login/test_login.robot` — em vez de herdar a
sessão do `Suite Setup`.
