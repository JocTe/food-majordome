const initNavCategories = () => {
    const categoriesNav = document.querySelector('.slick-categories-shopping')
    const categoriesTitles = document.querySelectorAll('.slick-categories-shopping > h5')
    const categoriesStrings = ["Fruits & Vegetables", "Dairy", "Grocery", "Meat", "Seafood", "Other"]
    if (categoriesNav) {
        slickBehavior(categoriesNav);
        $(categoriesNav).on('afterChange', function (slick, currentSlide) {
            const currentCategory = $('.slick-current')[0].lastChild.lastChild;

            const cards = document.querySelectorAll(".ingredient-shopping");

            cards.forEach((card) => {
                if (card.dataset.itemCategory == currentCategory.dataset.category) {
                    card.classList.remove('hide');
                }
                else if (currentCategory.dataset.category == "All" & categoriesStrings.includes(card.dataset.itemCategory)) {
                    card.classList.remove('hide');
                }
                else {
                    card.classList.add('hide');
                }
            });
        });
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