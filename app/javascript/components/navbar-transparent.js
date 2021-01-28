const initNavbar = () => {

  if (document.querySelector("#projects-index")) {
    const navbar = document.querySelector('.navbar-lewagon');
    if (navbar) {
      const filtersHeight = document.querySelector(".filters").offsetHeight
      const bannerHeight = document.querySelector('.home-background').offsetHeight;
      window.addEventListener('scroll', (e) => {
        if (window.scrollY >= bannerHeight - navbar.offsetHeight * 1.5) {
          navbar.classList.add("normal");
          navbar.classList.remove("transparent");
        } else {
          navbar.classList.add("transparent");
          navbar.classList.remove("normal");
        }
      });
    }
  }
}

export { initNavbar }