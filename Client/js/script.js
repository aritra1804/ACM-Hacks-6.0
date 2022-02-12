let loginForm = document.querySelector(".header .login-form");

document.querySelector("#login-btn").onclick = () => {
    loginForm.classList.toggle("active");
    navbar.classList.remove("active");
};

let navbar = document.querySelector(".header .navbar");

document.querySelector("#menu-btn").onclick = () => {
    navbar.classList.toggle("active");
    loginForm.classList.remove("active");
};

window.onscroll = () => {
    loginForm.classList.remove("active");
    navbar.classList.remove("active");

    if (window.scrollY > 0) {
        document.querySelector(".header").classList.add("active");
    } else {
        document.querySelector(".header").classList.remove("active");
    }
};

window.onload = () => {
    if (window.scrollY > 0) {
        document.querySelector(".header").classList.add("active");
    } else {
        document.querySelector(".header").classList.remove("active");
    }
};

let containerEle = document.getElementById("box-container-animals");

async function fetchData() {
    let entireData = "";
    fetch(`https://acm-hacks.herokuapp.com/api/animals/all`).then(
        (response) => {
            response.json().then((data) => {
                data.forEach((element, index) => {
                    console.log(element);
                    let animalData = `  <div class="box">
            <div class="icons">
                <a href="#" class="fas fa-shopping-cart"></a>
                <a href="#" class="fas fa-heart"></a>
                <a href="#" class="fas fa-eye"></a>
            </div>
            <div class="image">
                <img src="${element.image}" alt="">
            </div>
            <div class="content">
                <h3>${element.name}</h3>
                <div class="amount">$${element.price}</div>
            </div>
        </div>`;
                    entireData += animalData;
                });
                containerEle.innerHTML = entireData;
            });
        }
    );
}

window.addEventListener("load", fetchData);
