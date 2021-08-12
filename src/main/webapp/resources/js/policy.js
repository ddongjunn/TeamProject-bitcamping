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
    console.log('1');
}

function checkAllStatus() {
    console.log('2');
    const { termsOfService, privacyPolicy, allowPromotions } = agreements;
    if (termsOfService && privacyPolicy && allowPromotions) {
        checkAll.checked = true;
    } else {
        checkAll.checked = false;
    }
}

function toggleSubmitButton() {
    console.log('3');
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
    console.log('4');
});

submitButton.addEventListener("click",evt => {
    console.log('5');
   regiModalOff();
});
