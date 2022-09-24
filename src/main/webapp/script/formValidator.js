const generalRegex = /^([a-zA-Z\xE0\xE8\xE9\xF9\xF2\xEC\x27]\s?){2,20}$/;
const usernameRegex = /^[A-Za-z][A-Za-z0-9_]{1,19}$/;
const emailRegex = /^[a-zA-Z\d._%-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,20}$/;
const passwordRegex = /^[a-zA-Z\d\-\xE0\xE8\xE9\xF9\xF2\xEC\x27]{6,16}/;

function validaNome() {

    let nome = document.getElementById("nomeBox");
    if (generalRegex.test(nome.value)) {
        nome.style.borderColor = "rgb(204, 197, 185)";
        return true;
    }
    else {
        nome.style.borderColor = "rgb(235, 94, 40)";
        return false;
    }
}

function validaCognome() {

    let cognome = document.getElementById("cognomeBox");
    if (generalRegex.test(cognome.value)) {
        cognome.style.borderColor = "rgb(204, 197, 185)";
        return true;
    }
    else {
        cognome.style.borderColor = "rgb(235, 94, 40)";
        return false;
    }
}

function validaUsername() {

    let username = document.getElementById("usernameBox");
    if (usernameRegex.test(username.value)) {
        username.style.borderColor = "rgb(204, 197, 185)";
        return true;
    }
    else {
        username.style.borderColor = "rgb(235, 94, 40)";
        return false;
    }
}

function validaEmail(){
    let email = document.getElementById("emailBox");
    if(emailRegex.test(email.value)){
        email.style.borderColor = "rgb(204, 197, 185)";
        return true;
    } else{
        email.style.borderColor = "rgb(235, 94, 40)";
        return false;
    }
};

function validaPassword(){
    let password = document.getElementById("passwordBox");
    if(passwordRegex.test(password.value)){
        password.style.borderColor = "rgb(204, 197, 185)";
        return true;
    } else{
        password.style.borderColor = "rgb(235, 94, 40)";
        return false;
    }
};

function login(event){
    event.preventDefault();

    if(validaEmail() && validaPassword()){
        document.getElementById("formLoginSignup").submit();
    }
};

function signup(event){
    event.preventDefault();

    if(validaNome() && validaCognome() && validaUsername() && validaEmail() && validaPassword()){
        document.getElementById("formLoginSignup").submit();
    }
};

