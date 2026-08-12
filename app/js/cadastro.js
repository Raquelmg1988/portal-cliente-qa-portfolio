function renderClientes() {
  const tbody = document.getElementById("clientes-tbody");
  const vazio = document.getElementById("clientes-vazio");
  const clientes = DB.getClientes();

  tbody.innerHTML = "";
  vazio.hidden = clientes.length > 0;

  clientes.forEach((cliente) => {
    const tr = document.createElement("tr");
    tr.innerHTML = `
      <td>${cliente.nome}</td>
      <td>${cliente.email}</td>
      <td>${cliente.cpf}</td>
      <td>${cliente.telefone}</td>
    `;
    tbody.appendChild(tr);
  });
}

document.getElementById("cadastro-form").addEventListener("submit", (event) => {
  event.preventDefault();

  const cliente = {
    nome: document.getElementById("nome").value.trim(),
    email: document.getElementById("email").value.trim(),
    cpf: document.getElementById("cpf").value.trim(),
    telefone: document.getElementById("telefone").value.trim(),
  };

  DB.addCliente(cliente);
  renderClientes();

  const success = document.getElementById("cadastro-success");
  success.hidden = false;
  event.target.reset();
});

renderClientes();
