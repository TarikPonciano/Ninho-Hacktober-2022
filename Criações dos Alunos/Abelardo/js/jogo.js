const grid = document.querySelector("[data-grid]");
let primeiroCard = "";
let segundoCard = "";

const personargens = [
  "beth",
  "jerry",
  "jessica",
  "meeseeks",
  "morty",
  "pessoa-passaro",
  "pickle-rick",
  "rick",
  "scroopy",
  "summer",
];

function criarElemento(tag, classe) {
  const elemento = document.createElement(tag);
  elemento.className = classe;
  return elemento;
}
function checarVitoria() {
  const cardsDesabilitados = document.querySelectorAll(".desabilitarCard");
  if (cardsDesabilitados.length === 20) {
    window.alert("Parabéns você ganhou!");
  }
}

function checarCards() {
  if (primeiroCard.dataset.personargem === segundoCard.dataset.personargem) {
    primeiroCard.firstChild.classList.add("desabilitarCard");
    segundoCard.firstChild.classList.add("desabilitarCard");
    primeiroCard = "";
    segundoCard = "";

    checarVitoria();
  } else {
    setTimeout(() => {
      primeiroCard.classList.remove("revelarCard");
      segundoCard.classList.remove("revelarCard");
      primeiroCard = "";
      segundoCard = "";
    }, 500);
  }
}

function revelarCard({ target }) {
  if (target.parentNode.className.includes("revelarCard")) {
    return;
  }
  if (primeiroCard === "") {
    target.parentNode.classList.add("revelarCard");
    primeiroCard = target.parentNode;
  } else if (segundoCard === "") {
    target.parentNode.classList.add("revelarCard");
    segundoCard = target.parentNode;

    checarCards();
  }
}

function criarCard(personargem) {
  const card = criarElemento("div", "card");
  const front = criarElemento("div", "face front");
  const back = criarElemento("div", "face back");

  front.style.backgroundImage = `url(../images/${personargem}.png)`;
  card.appendChild(front);
  card.appendChild(back);

  card.addEventListener("click", revelarCard);
  card.setAttribute("data-personargem", personargem);
  return card;
}

function carregarJogo() {
  const duplicarPersonargens = [...personargens, ...personargens];
  const embaralharArray = duplicarPersonargens.sort(() => Math.random() - 0.5);
  embaralharArray.forEach((personargem) => {
    const card = criarCard(personargem);
    grid.appendChild(card);
  });
}

carregarJogo();
