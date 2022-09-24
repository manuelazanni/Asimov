const emailPattern = /^[a-zA-Z\d._%-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,20}$/;

function autenticaEmail(){
    email = document.getElementById("emailBox");
    if(emailPattern.test(email.value)){
        email.style.borderColor = "rgb(204, 197, 185)";
    } else{
        email.style.borderColor = "rgb(235, 94, 40)";
    }
};