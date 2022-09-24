let indice = 1;
mostraSlide(indice);

function cambiaFoto(n){
    mostraSlide(indice += n);
}

function slideCorrente(n){
    mostraSlide(indice = n);
}

function mostraSlide(n){
    console.log(indice);
    let i;
    let slides = document.getElementsByClassName("slide");
    let dots = document.getElementsByClassName("dot");

    if(n > slides.length){
        indice = 1; //vai all'inizio
    }

    if(n < 1){
        indice = slides.length; //vai alla fine
    }

    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }

    for(i=0; i < dots.length; i++){
        dots[i].className = dots[i].className.replace(" activePhoto", "")
    }

    slides[indice-1].style.display = "block";
    dots[indice-1].className += " activePhoto";
};

