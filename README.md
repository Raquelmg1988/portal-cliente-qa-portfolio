# Portal do Cliente — QA Automation Portfolio

Projeto de portfólio de automação de testes end-to-end, construído com **Robot Framework** + **Browser Library (Playwright)**.

> ⚠️ **Projeto 100% fictício.** "Aurora Serviços" não é uma empresa real, e a aplicação testada (pasta [`app/`](app)) é um front-end estático criado especificamente para este repositório, sem nenhum backend, dado real ou vínculo com qualquer empresa. Foi feito para demonstrar habilidades de automação de testes de forma segura, sem expor código ou dados de projetos profissionais/confidenciais.

## Sobre o projeto

O repositório simula um portal do cliente de uma empresa de planos/serviços, com os fluxos mais comuns encontrados em portais reais:

- **Login** (sucesso e falha)
- **Cadastro de cliente** (dados gerados dinamicamente com [Faker](https://faker.readthedocs.io/))
- **Cotações** (criar e excluir)
- **Pedidos** (listagem com status)
- **Alteração de senha** (com validação de regras de segurança)

A aplicação sob teste é um front-end estático (`app/`), sem backend — os dados são persistidos em `localStorage`/`sessionStorage` do navegador, o que permite rodar a suíte completa sem depender de nenhum serviço externo.

## Stack

| Camada              | Tecnologia                              |
|---------------------|------------------------------------------|
| Automação de testes | Robot Framework 7                        |
| Interação com UI    | [robotframework-browser](https://robotframework-browser.org/) (Playwright) |
| Massa de dados       | Faker                                    |
| Relatórios          | Allure                                   |
| CI                   | GitHub Actions                           |
| Aplicação sob teste | HTML/CSS/JS estático                     |

## Estrutura

```
app/                    # Aplicação fake (front-end estático)
libraries/              # Bibliotecas Python customizadas (Faker -> keywords Robot)
resources/
  keywords/             # Keywords reutilizáveis por domínio (login, cadastro, cotações...)
  locators/             # Seletores centralizados
  variables_local.robot # URLs e credenciais de teste
tests/
  login/
  cadastro/
  cotacoes/
  pedidos/
.github/workflows/ci.yml
```

## Como rodar localmente

Pré-requisitos: Python 3.10+.

```bash
python -m venv .venv
.venv\Scripts\activate          # Windows
pip install -r requirements.txt
rfbrowser init                  # instala os browsers do Playwright

# em um terminal: sobe a aplicação fake
python -m http.server 8000 --directory app

# em outro terminal: roda a suíte
robot --outputdir output tests/
```

O relatório padrão do Robot Framework é gerado em `output/report.html` e `output/log.html`.

## Credenciais de demonstração

| Campo  | Valor                          |
|--------|----------------------------------|
| E-mail | `demo@aurora-servicos.com.br`   |
| Senha  | `Demo@123`                       |

## Documentação de processo

Além da automação, este repositório inclui um exemplo de documentação de QA usada em processos reais de mudança (GMUD):

👉 **[GMUD — Ajustes na aba Acessos (exemplo ilustrativo)](docs/GMUD-acessos.md)**

> Documento com dados fictícios, elaborado para demonstrar a estrutura de uma GMUD (escopo, riscos, cutover, rollback, hypercare) — não corresponde a uma tela específica da aplicação fake deste repositório.

👉 **[Reaproveitamento de sessão autenticada entre testes](docs/sessao-autenticada.md)**

> Explica a técnica de Suite Setup/Teardown já usada em `tests/cotacoes/` e `tests/pedidos/` para autenticar uma vez por suíte em vez de repetir login em cada caso de teste.

## Licença

Projeto de portfólio, livre para consulta e estudo.
