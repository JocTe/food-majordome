const initNavCategories = () => {
    const categoriesNav = document.querySelector('.slick-categories-shopping')
    const categoriesTitles = document.querySelectorAll('.slick-categories-shopping > h5')
    if (categoriesNav) {
        slickBehavior(categoriesNav);
        categoriesNav.
    }
}

const slickBehavior = (nav) => {
    $(nav).slick({
        centerMode: true,
        slidesToShow: 3,
        arrows: true,
        variableWidth: true,
        responsive: [
            {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    centerMode: true,
                    centerPadding: '30px',
                    slidesToShow: 3
                }
            },
            {
                breakpoint: 480,
                settings: {
                    arrows: true,
                    centerMode: true,
                    centerPadding: '30px',
                    slidesToShow: 3
                }
            }
        ]
    });
}

export { initNavCategories };