const initFilters = () => {
  const filters = document.querySelectorAll(".filter");
  filters.forEach((filter) => {
    filter.addEventListener("click", () => {
      filter.classList.add("active");
    })
  })
}

export { initFilters };