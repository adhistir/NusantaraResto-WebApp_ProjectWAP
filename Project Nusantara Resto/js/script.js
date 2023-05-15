// Slider/swiper.js
var swiper = new Swiper(".mySwiper", {
    slidesPerView: 4,
    spaceBetween: 30,
    slidesPerGroup: 4,
    breakpoints: {
        // when window width is >= 320px
        320: {
            slidesPerView: 2,
            spaceBetween: 20,
            slidesPerGroup: 2
        },
        // when window width is >= 480px
        480: {
            slidesPerView: 3,
            spaceBetween: 30,
            slidesPerGroup: 3

        },
        // when window width is >= 768px
        768: {
            slidesPerView: 4,
            spaceBetween: 40,
            slidesPerGroup: 4
        }
    },
    loop: true,
    loopFillGroupWithBlank: true,
    pagination: {
        el: ".swiper-pagination",
        clickable: true,
    },
    navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
    },
});
// Slider/swiper.js

// Login See pasword
const togglePassword = document.querySelector("#togglePassword");
const password = document.querySelector("#password");

togglePassword.addEventListener("click", function () {

    // toggle the type attribute
    const type = password.getAttribute("type") === "password" ? "text" : "password";
    password.setAttribute("type", type);
    // toggle the eye icon
    this.classList.toggle('fa-eye-slash');
    this.classList.toggle('fa-eye');

});

const togglePassword2 = document.querySelector("#togglePassword2");
const password2 = document.querySelector("#password2");

togglePassword2.addEventListener("click", function () {

    // toggle the type attribute
    const type = password2.getAttribute("type") === "password" ? "text" : "password";
    password2.setAttribute("type", type);
    // toggle the eye icon
    this.classList.toggle('fa-eye-slash');
    this.classList.toggle('fa-eye');

});


// Login See pasword