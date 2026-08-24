> Documento fictício, elaborado para fins de portfólio. Nome de empresa, responsáveis, e-mails e datas foram substituídos por dados fictícios; o conteúdo técnico (escopo, riscos, cutover, rollback, hypercare) reflete a estrutura real de uma GMUD conduzida em produção.

# 📄 GMUD – Gestão de Mudança
## Portal do Cliente – Administrativo > Acessos

### 📌 1. Informações Gerais

🏷️ **Projeto / Nome da Mudança:** Portal do Cliente – Ajustes na aba Acessos (renomeação, status de acesso, filtro e reenvio de código OTP)

🚦 **Classificação da Mudança:** Normal (requer CAB) — alteração de interface e regra de negócio em área administrativa, sem caráter emergencial e com impacto restrito ao módulo Administrativo

📅 **Data do Deploy:** A definir

### 📝 2. Resumo Executivo

**❓ O que é a mudança?**
Ajustes na tela Administrativo > Histórico de acessos do Portal do Cliente, que passará a se chamar "Acessos". A mudança inclui a criação de uma coluna de Status (Código expirado, NF Pendente ou OK), um filtro de busca por status e a funcionalidade de reenvio de um novo código OTP (válido por 15 minutos) para contas com código expirado, diretamente pelo administrador.

**💡 Por que é necessária? (Business Case)**
Atualmente o administrador não consegue identificar rapidamente qual a situação de cada acesso, nem reenviar um novo código OTP sem intervenção técnica. A mudança melhora a visibilidade das pendências de autenticação e de nota fiscal, permitindo que a equipe de suporte resolva problemas de acesso de forma autônoma, reduzindo o tempo de atendimento e o volume de chamados técnicos relacionados a códigos OTP expirados.

**✅ Resultados da Validação (UAT)**

Renomeação da aba
- Alterar o nome da aba "Histórico de acessos" para "Acessos".

Nova coluna "Status" e filtro permitindo consultar os registros pelos status:
- Código expirado, NF Pendente e OK

### 🎯 3. Escopo da Mudança

**✔️ O que ESTÁ incluído**
- 🔤 Renomeação da aba "Histórico de acessos" para "Acessos", na seção Administrativo.
- 🧩 Inclusão da coluna "Status" na listagem de acessos.
- 🔍 Implementação do filtro por status: Código expirado, NF Pendente e OK.
- 🔴 Exibição do status "Código expirado" com a ação "Enviar código", incluindo modal de confirmação.
- 📧 Reenvio de um novo código OTP para o e-mail da conta, com validade de 15 minutos.
- 🟢 Exibição de mensagem de sucesso após o envio do novo código.
- 🟡 Exibição do status "NF Pendente" (apenas informativo, sem ação disponível).
- ⚪ Exibição do status "OK" como um traço ("-"), sem ação disponível.
- ♻️ Utilização da rotina existente de geração e envio de OTP.

**🚫 O que NÃO ESTÁ incluído**
- 🔒 Alterações nas regras atuais de autenticação e geração de OTP.
- 🧾 Alterações no fluxo ou nas regras de validação/aprovação de nota fiscal (NF Pendente).
- ➕ Criação de novos status além dos três definidos (Código expirado, NF Pendente e OK).
- 🖥️ Alterações em outras abas ou telas da seção Administrativo.

### ⚠️ 4. Avaliação de Impacto e Riscos

**📊 Impacto no Negócio**
Criticidade: Baixa/Média. Impacto positivo — os administradores do Portal do Cliente passam a ter visibilidade imediata do status de cada acesso e podem resolver pendências de código OTP expirado sem depender de suporte técnico. Não há impacto para os usuários finais (clientes) fora do recebimento de um novo e-mail com código OTP quando solicitado pelo administrador.

**🛡️ Riscos Residuais e Mitigação**

| ⚠️ Risco | 🛡️ Mitigação |
|---|---|
| 📧 Reenvio de OTP falhar silenciosamente (e-mail não entregue). | Exibir mensagem de sucesso apenas após confirmação do envio pelo serviço de e-mail; monitorar logs de envio no pós-deploy. |
| 🔀 Divergência na classificação do status (ex.: conta com NF pendente sendo exibida como "Código expirado"). | Validar em homologação a regra de precedência entre os status antes do go-live; casos de teste específicos para contas com mais de uma pendência. |
| 🔓 Ação "Enviar código" disponível indevidamente para status NF Pendente ou OK. | Bloqueio da ação implementado a nível de back-end (não apenas visual), validado em QA. |
| 🐢 Impacto em performance da listagem devido à nova consulta de status. | Monitoramento de performance da tela nas primeiras execuções após o deploy. |

### 🚀 5. Plano de Implantação (Cutover)

**🗓️ Cronograma Macro**

| ⏰ Horário | 📋 Atividade |
|---|---|
| [Definir] | 🧊 Congelamento de código (code freeze) e comunicação às áreas envolvidas. |
| [Definir] | 📦 Publicação/deploy das alterações no ambiente de produção (renomeação de aba, coluna e filtro de status, ação de reenvio de OTP). |
| [Definir] | 🔎 Validação pós-deploy pela equipe técnica: renomeação da aba, exibição dos três status e do filtro. |
| [Definir] | 🧪 Teste controlado do fluxo de reenvio de código OTP (modal de confirmação, novo código com validade de 15 minutos e mensagem de sucesso). |
| [Definir] | 🔐 Confirmação de bloqueio de ação para os status NF Pendente e OK. |
| [Definir] | ✅ Liberação para uso pelos administradores e encerramento do cutover. |

*Observação: horários a serem definidos em conjunto com o responsável técnico considerando janela de baixo uso do Portal do Cliente.*

### ↩️ 6. Plano de Rollback (Contingência)

**🚨 Gatilhos para Rollback**
- 🖥️ Erro que impeça o carregamento da listagem de acessos na aba "Acessos" após o deploy.
- 🔀 Coluna Status ou filtro exibindo informações incorretas de forma sistemática (ex.: status divergente do real para múltiplas contas).
- 📧 Falha no envio do novo código OTP (e-mails não entregues) em volume relevante durante os testes controlados.
- 🔓 Ação "Enviar código" disponível para registros com status NF Pendente ou OK (falha de bloqueio de regra de negócio).
- ⏱️ Geração de código OTP com validade diferente de 15 minutos.
- 🔒 Qualquer impacto identificado nas regras atuais de autenticação de usuários já existentes.

**🔧 Procedimento de Rollback**
- ↩️ Reversão do deploy para a versão anterior da tela (aba "Histórico de acessos", sem coluna Status, sem filtro e sem ação de reenvio de código).
- 📢 Comunicação imediata às áreas de negócio e suporte sobre a reversão e o novo prazo estimado.
- 🔍 Verificação de que a rotina existente de geração e envio de OTP permanece íntegra e não foi impactada pela reversão.
- 🎫 Abertura de chamado técnico para investigação da causa raiz antes de uma nova tentativa de deploy.

### 🩺 7. Plano Pós-Implementação (Hypercare)

**⏳ Duração e Ações**
Período sugerido: 1 a 2 semanas após o go-live, com monitoramento contínuo e suporte priorizado, contemplando:
- 📆 Acompanhamento diário dos registros de status gerados na aba Acessos, verificando consistência dos três status.
- 📊 Monitoramento do volume e sucesso de envios de código OTP reenviados pelos administradores.
- ☎️ Canal direto com o time técnico e key-user de negócio para reporte rápido de inconsistências.
- 💬 Coleta de feedback dos administradores sobre a usabilidade do filtro e da ação de reenvio de código.
- 🏁 Encerramento do hypercare mediante confirmação de estabilidade e ausência de chamados críticos relacionados à mudança.

**👥 Contatos Operacionais**

| 🧑‍💻 Papel | 👤 Responsável |
|---|---|
| 👨‍💻 Desenvolvedor Responsável | Rafael Lima — rafael.lima@empresa-ficticia.com.br |
| 🔑 Key-user Negócio | Camila Duarte — camila.duarte@empresa-ficticia.com.br |
| 🧪 QA | Raquel Mendes — raquel.mendes@empresa-ficticia.com.br |
