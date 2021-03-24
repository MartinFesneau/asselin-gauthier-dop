import Sortable from "sortablejs";

const initSortable = () => {
  const projectsList = document.getElementById("projects");
  if (projectsList) {
    // token to authorize CSRF with fetch
    const csrfToken = document.querySelector("[name='csrf-token']").content;

    var options = {
      animation: 100,
      onEnd: (evt) => {
        console.log(evt)
        fetch("/move_project", {
          method: "PATCH",
          headers: {
            "X-CSRF-Token": csrfToken, // Set the token
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            id: evt.item.dataset.id, // params with id of the task
            position: evt.newIndex + 1, // allows to store the position of the task in the column, + 1 as it is an index
          }),
        });
      },
    };
    Sortable.create(projectsList, options);
  }
};
export { initSortable };
