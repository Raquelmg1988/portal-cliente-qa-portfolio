document.getElementById("login-form").addEventListener("submit", (event) => {
  event.preventDefault();

  const email = document.getElementById("email").value.trim();
  const senha = document.getElementById("senha").value;
  const errorEl = document.getElementById("login-error");

  if (DB.login(email, senha)) {
    window.location.href = "dashboard.html";
    return;
  }

  errorEl.textContent = "E-mail ou senha inválidos.";
  errorEl.hidden = false;
});
