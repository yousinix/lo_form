var isInitialized = false;

window.addEventListener("message", (e) => {
  const state = JSON.parse(e.data);
  stateToTable(state);
  initView();
});

const initView = () => {
  if (isInitialized) return;

  const loadingClass = "card--loading";

  const formCard = document.getElementById("form-card");
  formCard.classList.remove(loadingClass);

  const tableCard = document.getElementById("table-card");
  tableCard.classList.remove(loadingClass);

  isInitialized = true;
};

const stateToTable = (state) => {
  const table = document.getElementById("state-table");
  const tbody = table.getElementsByTagName("tbody")[0];

  // Field rows
  for (var i = 0; i < state.fields.length; i++) {
    if (isInitialized) tbody.deleteRow(i);

    const field = state.fields[i];
    const row = tbody.insertRow(i);

    const cell0 = row.insertCell(0);
    cell0.innerHTML = field.loKey;

    const cell1 = row.insertCell(1);
    cell1.innerHTML = `<span class="status--${field.status}"></span>`;

    const cell2 = row.insertCell(2);
    cell2.innerHTML = field.initialValue ?? '-';

    const cell3 = row.insertCell(3);
    cell3.innerHTML = field.touched
      ? `<i class="fas fa-check-circle text--green"></i>`
      : `<i class="fas fa-times-circle text--red"></i>`;
  }

  // Form row
  const tfoot = table.getElementsByTagName("tfoot")[0];

  if (isInitialized) tfoot.deleteRow(0);

  const row = tfoot.insertRow(0);
  const cell0 = row.insertCell(0);
  cell0.innerHTML = "Form";

  const cell1 = row.insertCell(1);
  cell1.innerHTML = `<span class="status--${state.status}"></span>`;

  row.insertCell(2);
  row.insertCell(3);
};
