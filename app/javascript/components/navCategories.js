const initNavCategories = () => {
    const categoriesNav = document.querySelector('.slick-categories-shopping')
    if (categoriesNav) {
        $(categoriesNav).slick({
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
}

export { initNavCategories };