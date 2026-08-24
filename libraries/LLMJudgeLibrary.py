"""
Biblioteca de exemplo para validacao semantica de respostas em linguagem natural
(padrao "LLM como juiz"), usada quando o sistema sob teste responde em texto livre
e um assert de string exata (`Should Contain`) nao e suficiente.

Cenario fictício: um chatbot de atendimento ao cliente responde perguntas em
linguagem natural. Em vez de validar a resposta com um match literal (fragil,
quebra a cada variacao de texto do modelo), pedimos a um LLM para julgar se a
resposta atende a um criterio de negocio.

Por padrao roda em MODO_SIMULADO (sem chamar nenhuma API real), para que a suite
rode sem depender de chave de API ou servico externo, no mesmo espirito do resto
deste repositorio de portfolio. Para rodar contra uma API real (OpenAI/Anthropic),
defina a variavel de ambiente LLM_JUDGE_API_KEY.
"""

import os
import re


class LLMJudgeLibrary:
    """Keywords de validacao semantica para uso em suites Robot Framework."""

    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def __init__(self):
        self._api_key = os.environ.get("LLM_JUDGE_API_KEY")

    def validar_resposta_semanticamente(self, pergunta, resposta_bot, criterio):
        """Julga se ``resposta_bot`` atende ao ``criterio`` de negocio dado o
        contexto de ``pergunta``. Retorna (aprovado: bool, justificativa: str).

        Em modo simulado (sem LLM_JUDGE_API_KEY definido), usa uma heuristica
        simples baseada em palavras-chave apenas para demonstrar o formato de
        retorno esperado — a versao real substitui isso por uma chamada de API.
        """
        if not self._api_key:
            return self._julgar_modo_simulado(pergunta, resposta_bot, criterio)
        return self._julgar_via_api(pergunta, resposta_bot, criterio)

    def _julgar_modo_simulado(self, pergunta, resposta_bot, criterio):
        palavras_criterio = re.findall(r"\w+", criterio.lower())
        resposta_lower = resposta_bot.lower()
        encontradas = [p for p in palavras_criterio if p in resposta_lower]

        cobertura = len(encontradas) / max(len(palavras_criterio), 1)
        aprovado = cobertura >= 0.5

        justificativa = (
            f"[MODO SIMULADO] {len(encontradas)}/{len(palavras_criterio)} termos do "
            f"criterio encontrados na resposta. Isto e um placeholder heuristico — "
            f"a implementacao real substitui esta funcao por uma chamada de LLM "
            f"que avalia semantica, nao apenas presenca de palavras."
        )
        return aprovado, justificativa

    def _julgar_via_api(self, pergunta, resposta_bot, criterio):
        # Implementacao real chamaria a API do provedor (ex: Anthropic, OpenAI)
        # com um prompt estruturado pedindo julgamento booleano + justificativa.
        # Omitido neste exemplo de portfolio para nao acoplar a uma chave/API
        # especifica — o ponto de extensao esta claro para quem for adaptar.
        raise NotImplementedError(
            "Defina aqui a chamada real ao provedor de LLM escolhido. "
            "O contrato de retorno deve seguir o mesmo formato de "
            "_julgar_modo_simulado(): (bool, str)."
        )
