function renderPedidos() {
  const tbody = document.getElementById("pedidos-tbody");
  tbody.innerHTML = "";

  DB.getPedidos().forEach((pedido) => {
    const tr = document.createElement("tr");
    tr.dataset.testid = `pedido-${pedido.id}`;
    tr.innerHTML = `
      <td>${pedido.id}</td>
      <td>${pedido.produto}</td>
      <td>${pedido.data}</td>
      <td><span class="badge ${pedido.status}" data-testid="status-${pedido.id}">${pedido.status}</span></td>
    `;
    tbody.appendChild(tr);
  });
}

renderPedidos();
