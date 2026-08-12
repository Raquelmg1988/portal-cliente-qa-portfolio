const REGRA_SENHA_FORTE = /^(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$/;

document.getElementById("senha-form").addEventListener("submit", (event) => {
  event.preventDefault();

  const errorEl = document.getElementById("senha-error");
  const successEl = document.getElementById("senha-success");
  errorEl.hidden = true;
  successEl.hidden = true;

  const atual = document.getElementById("senha-atual").value;
  const nova = document.getElementById("senha-nova").value;
  const confirma = document.getElementById("senha-confirma").value;

  if (atual !== DB.getUsuario().senha) {
    errorEl.textContent = "Senha atual incorreta.";
    errorEl.hidden = false;
    return;
  }

  if (!REGRA_SENHA_FORTE.test(nova)) {
    errorEl.textContent = "A nova senha não atende aos critérios de segurança.";
    errorEl.hidden = false;
    return;
  }

  if (nova !== confirma) {
    errorEl.textContent = "A confirmação de senha não confere.";
    errorEl.hidden = false;
    return;
  }

  DB.setUsuarioSenha(nova);
  successEl.hidden = false;
  event.target.reset();
});
