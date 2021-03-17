const initNavCategories = () => {

    const nav = document.querySelector(".categories-shopping");
    const sticky = nav.offsetTop;

    if (nav) {



        const navbarCategories = () => {

            if (window.pageYOffset >= sticky) {
                nav.classList.add("sticky")
            } else {
                nav.classList.remove("sticky");
            }
        }
        window.onscroll = navbarCategories();

    }


}

export { initNavCategories };