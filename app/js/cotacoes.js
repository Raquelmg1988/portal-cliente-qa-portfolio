function renderCotacoes() {
  const tbody = document.getElementById("cotacoes-tbody");
  const vazio = document.getElementById("cotacoes-vazio");
  const cotacoes = DB.getCotacoes();

  tbody.innerHTML = "";
  vazio.hidden = cotacoes.length > 0;

  cotacoes.forEach((cotacao) => {
    const tr = document.createElement("tr");
    tr.dataset.id = cotacao.id;
    tr.innerHTML = `
      <td>${cotacao.produto}</td>
      <td>${cotacao.quantidade}</td>
      <td class="row-actions">
        <button class="delete" data-testid="cotacao-excluir-${cotacao.id}" data-id="${cotacao.id}">Excluir</button>
      </td>
    `;
    tbody.appendChild(tr);
  });

  tbody.querySelectorAll("button.delete").forEach((btn) => {
    btn.addEventListener("click", () => {
      DB.removeCotacao(btn.dataset.id);
      renderCotacoes();
    });
  });
}

document.getElementById("cotacao-form").addEventListener("submit", (event) => {
  event.preventDefault();

  const produto = document.getElementById("produto").value;
  const quantidade = document.getElementById("quantidade").value;
  if (!produto) return;

  DB.addCotacao({
    id: `cot-${Date.now()}`,
    produto,
    quantidade,
  });

  renderCotacoes();
  event.target.reset();
  document.getElementById("quantidade").value = 1;
});

renderCotacoes();
