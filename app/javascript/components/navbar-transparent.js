const initNavbar = () => {

  if (document.querySelector("#projects-index")) {
    const navbar = document.querySelector('.navbar-lewagon');
    console.log(navbar)
    
    if (navbar) {
      const bannerHeight = document.querySelector('.home-background').offsetHeight;
      const filters = document.querySelector('.filters');
      const filtersHeight = filters.offsetHeight;
      
      const limit = bannerHeight - filtersHeight
      console.log(bannerHeight)
      window.addEventListener('scroll', (e) => {
        if (window.scrollY >= bannerHeight) {
          console.log(bannerHeight)
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