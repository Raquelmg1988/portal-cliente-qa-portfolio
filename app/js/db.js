/**
 * "Banco de dados" falso do Portal do Cliente (Aurora Serviços).
 * Tudo é fictício e vive apenas no localStorage do navegador —
 * não existe backend real neste projeto de portfólio.
 */
const DB = (() => {
  const KEYS = {
    session: "aurora.session",
    clientes: "aurora.clientes",
    cotacoes: "aurora.cotacoes",
    pedidos: "aurora.pedidos",
    usuario: "aurora.usuario",
  };

  const DEMO_USER = {
    email: "demo@aurora-servicos.com.br",
    senha: "Demo@123",
    nome: "Usuário Demonstração",
  };

  function seed() {
    if (!localStorage.getItem(KEYS.usuario)) {
      localStorage.setItem(KEYS.usuario, JSON.stringify(DEMO_USER));
    }
    if (!localStorage.getItem(KEYS.clientes)) {
      localStorage.setItem(KEYS.clientes, JSON.stringify([]));
    }
    if (!localStorage.getItem(KEYS.cotacoes)) {
      localStorage.setItem(KEYS.cotacoes, JSON.stringify([]));
    }
    if (!localStorage.getItem(KEYS.pedidos)) {
      const pedidosIniciais = [
        { id: "PED-1001", produto: "Plano Essencial", status: "aprovado", data: "2026-05-02" },
        { id: "PED-1002", produto: "Plano Família", status: "pendente", data: "2026-06-14" },
        { id: "PED-1003", produto: "Plano Premium", status: "recusado", data: "2026-07-01" },
      ];
      localStorage.setItem(KEYS.pedidos, JSON.stringify(pedidosIniciais));
    }
  }

  function getUsuario() {
    return JSON.parse(localStorage.getItem(KEYS.usuario));
  }

  function setUsuarioSenha(novaSenha) {
    const usuario = getUsuario();
    usuario.senha = novaSenha;
    localStorage.setItem(KEYS.usuario, JSON.stringify(usuario));
  }

  function login(email, senha) {
    const usuario = getUsuario();
    if (usuario.email === email && usuario.senha === senha) {
      sessionStorage.setItem(KEYS.session, JSON.stringify({ email, logadoEm: Date.now() }));
      return true;
    }
    return false;
  }

  function logout() {
    sessionStorage.removeItem(KEYS.session);
  }

  function estaLogado() {
    return !!sessionStorage.getItem(KEYS.session);
  }

  function exigirLogin() {
    if (!estaLogado()) {
      window.location.href = "index.html";
    }
  }

  function getClientes() {
    return JSON.parse(localStorage.getItem(KEYS.clientes));
  }

  function addCliente(cliente) {
    const clientes = getClientes();
    clientes.push(cliente);
    localStorage.setItem(KEYS.clientes, JSON.stringify(clientes));
  }

  function getCotacoes() {
    return JSON.parse(localStorage.getItem(KEYS.cotacoes));
  }

  function addCotacao(cotacao) {
    const cotacoes = getCotacoes();
    cotacoes.push(cotacao);
    localStorage.setItem(KEYS.cotacoes, JSON.stringify(cotacoes));
  }

  function removeCotacao(id) {
    const cotacoes = getCotacoes().filter((c) => c.id !== id);
    localStorage.setItem(KEYS.cotacoes, JSON.stringify(cotacoes));
  }

  function getPedidos() {
    return JSON.parse(localStorage.getItem(KEYS.pedidos));
  }

  return {
    seed,
    login,
    logout,
    estaLogado,
    exigirLogin,
    getClientes,
    addCliente,
    getCotacoes,
    addCotacao,
    removeCotacao,
    getPedidos,
    setUsuarioSenha,
    getUsuario,
  };
})();

DB.seed();
