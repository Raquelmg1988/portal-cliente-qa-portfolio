DB.exigirLogin();

document.getElementById("logout-btn").addEventListener("click", () => {
  DB.logout();
  window.location.href = "index.html";
});
