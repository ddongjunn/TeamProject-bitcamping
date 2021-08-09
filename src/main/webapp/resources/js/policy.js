("use strict");

const form = document.querySelector("#form__wrap");
const checkAll = document.querySelector(".terms__check__all input");
const checkBoxes = document.querySelectorAll(".input__check input");
const submitButton = document.querySelector(".next-button");

const agreements = {
    termsOfService: false,
    privacyPolicy: false,
    allowPromotions: false
};

form.addEventListener("submit", (e) => e.preventDefault());

checkBoxes.forEach((item) => item.addEventListener("input", toggleCheckbox));

function toggleCheckbox(e) {
    const { checked, id } = e.target;
    agreements[id] = checked;
    this.parentNode.classList.toggle("active");
    checkAllStatus();
    toggleSubmitButton();
}

function checkAllStatus() {
    const { termsOfService, privacyPolicy, allowPromotions } = agreements;
    if (termsOfService && privacyPolicy && allowPromotions) {
        checkAll.checked = true;
    } else {
        checkAll.checked = false;
    }
}

function toggleSubmitButton() {
    const { termsOfService, privacyPolicy } = agreements;
    if (termsOfService && privacyPolicy) {
        submitButton.disabled = false;
    } else {
        submitButton.disabled = true;
    }
}

checkAll.addEventListener("click", (e) => {
    const { checked } = e.target;
    if (checked) {
        checkBoxes.forEach((item) => {
            item.checked = true;
            agreements[item.id] = true;
            item.parentNode.classList.add("active");
        });
    } else {
        checkBoxes.forEach((item) => {
            item.checked = false;
            agreements[item.id] = false;
            item.parentNode.classList.remove("active");
        });
    }
    toggleSubmitButton();
});

submitButton.addEventListener("click",evt => {
   regiModalOff();
   console.log("button click");
    $('html, body').css({'overflow': 'auto', 'height': '100%'}); //scroll hidden 해제 $('#element').off('scroll touchmove mousewheel'); // 터치무브 및 마우스휠 스크롤 가능
});