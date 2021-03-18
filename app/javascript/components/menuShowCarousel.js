const initMenuShowCarousel = () => {
    const container = document.querySelector('.slick-menu');

    if (container) {
        slickBehavior(container);
    }
};


const slickBehavior = (carousel) => {
    $(carousel).slick({
        centerMode: true,
        centerPadding: '60px',
        slidesToShow: 3,
        responsive: [
            {
                breakpoint: 768,
                settings: {
                    arrows: false,
                    centerMode: true,
                    centerPadding: '40px',
                    slidesToShow: 3
                }
            },
            {
                breakpoint: 480,
                settings: {
                    arrows: false,
                    centerMode: true,
                    centerPadding: '40px',
                    slidesToShow: 1
                }
            }
        ]
    });
}
export { initMenuShowCarousel };