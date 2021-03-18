const categoriesStrings = ["Fruits & Vegetables", "Dairy", "Grocery", "Meat", "Seafood", "Other"]

const initNavCategories = () => {
    const myElement = document.body;

    const categoriesNav = document.querySelector('.slick-categories-shopping')
    const categoriesTitles = document.querySelectorAll('.slick-categories-shopping > h5')
    if (categoriesNav) {
        slickBehavior(categoriesNav);
        $(categoriesNav).on('swipe', function (slick, currentSlide) {
            if (slick.cancelable) {
                slick.preventDefault();
            }
            const currentCategory = $('.slick-current')[0].lastChild.lastChild;

            const cards = document.querySelectorAll(".ingredient-shopping");

            cards.forEach((card) => {
                displayCardsByCategory(card, currentCategory);
            });
        });

        const mc = new Hammer(myElement);
        mc.on("swipeleft swiperight", function (ev) {
            let category = "";

            console.log(ev.type);
            if (ev.type == "swiperight") {
                category = $('.slick-current')[0].previousSibling.lastChild.lastChild;
                $('.slick-prev')[0].click();
            } else {
                category = $('.slick-current')[0].nextSibling.lastChild.lastChild;
                $('.slick-next')[0].click();
            }

            console.log($('.slick-current')[0]);
            const cards = document.querySelectorAll(".ingredient-shopping");

            cards.forEach((card) => {
                displayCardsByCategory(card, category);
            });
        });
    }
}

const displayCardsByCategory = (card, currentCategory) => {
    if (card.dataset.itemCategory == currentCategory.dataset.category) {
        card.classList.remove('hide');
    }
    else if (currentCategory.dataset.category == "All" & categoriesStrings.includes(card.dataset.itemCategory)) {
        card.classList.remove('hide');
    }
    else {
        card.classList.add('hide');
    }
};

const slickBehavior = (nav) => {
    $(nav).slick({
        centerMode: true,
        slidesToShow: 3,
        variableWidth: true,
        responsive: [
            {
                breakpoint: 768,
                settings: {
                    centerMode: true,
                    centerPadding: '30px',
                    slidesToShow: 3
                }
            },
            {
                breakpoint: 480,
                settings: {
                    centerMode: true,
                    centerPadding: '30px',
                    slidesToShow: 3
                }
            }
        ]
    });
}

export { initNavCategories };