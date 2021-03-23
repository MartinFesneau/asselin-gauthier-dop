import Sortable from "sortablejs";

const initSortable = () => {
  const projectsList = document.getElementById("projects")
  Sortable.create(projectsList);
  };

export { initSortable };
