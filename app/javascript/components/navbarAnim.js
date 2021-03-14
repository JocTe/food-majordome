
const initNavbarOnSelection = () => {
    const links = document.querySelectorAll('.navigation-link');

    links.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            document.location.replace(link.href);
            if (!link.classList.contains('active')) {
                const active = document.querySelector('.navigation-link.active');
                if (active !== null) {
                    active.classList.remove('active');
                }
                link.classList.add('active');
            }

        })
    })


}

const initNavbarOnScroll = () => {
    const navbar = document.querySelector('.navigation');

    if (navbar) {
        let lastScroll = 0;

        window.addEventListener('scroll', () => {
            let currentScroll = document.documentElement.scrollTop || document.body.scrollTop;

            if (currentScroll <= lastScroll) {
                lastScroll = currentScroll;
                navbar.classList.remove('scrolled-down');
                navbar.classList.add('scrolled-up');
            }
            else {
                lastScroll = currentScroll;
                navbar.classList.add('scrolled-down');
                navbar.classList.remove('scrolled-up');
            }
        });
    }

    // TO DO : show the navbar afer sometime when iddle
}

export { initNavbarOnSelection, initNavbarOnScroll };
