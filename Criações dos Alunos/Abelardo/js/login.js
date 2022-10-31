const input = document.querySelector("[data-input]");
const button = document.querySelector("[data-button]");
const form = document.querySelector("[data-form]");

function validarInput({ target }) {
  if (target.value.length >= 3) {
    button.removeAttribute("disabled");
  } else {
    button.setAttribute("disabled", "");
  }
}

function enviarSubmit(event) {
  event.preventDefault();
  localStorage.setItem("player", input.value);
  window.location = "pages/jogo.html";
}

input.addEventListener("input", validarInput);
form.addEventListener("submit", enviarSubmit);
