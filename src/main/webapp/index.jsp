<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it-IT">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "icon" href="images/icons/logoA.svg" type="image/x-icon">
    <title>Asimov: Homepage</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="style/homePage.css">
</head>
<body>

<%@ include file="header.jsp"%>

    <main>
        <div class="advertise">
            <div class="containerFlexDescription">
                <div class="advInfo">
                    <div class="titleAdv">
                        <h1>Nothing Phone 1</h1>
                    </div>
                    <div class="descriptionBox">
                        <p>
                            <b>Meno distrazioni. Più anima.</b><br>

                            Solo istinto puro, nella forma di un dispositivo. Raccontato attraverso
                            bellissimi simboli. Interazioni più profonde. E coraggiosa semplicità.<br><br>

                            Phone 1 segna il ritorno all'origine. <p class="orangeUnderline">A noi.</p>
                        </p>
                    </div>
                </div>
            </div>

            <div class="containerFlexGallery">
                <div class="gallerySection">
                    <div class="buttonPrev">
                        <div id="prev" onclick="cambiaFoto(-1)">&#10094;</div>
                    </div>

                    <div class="containerGalleria">
                        <div class="slide transition">
                            <img src="images/gallery/image1.png" alt="Nothing Phone 1" style="width:100%">
                        </div>
                        <div class="slide transition">
                            <img src="images/gallery/image2.png" alt="Nothing Phone 1" style="width:100%">
                        </div>
                        <div class="slide transition">
                            <img src="images/gallery/image3.png" alt="Nothing Phone 1" style="width:100%">
                        </div>
                        <div class="slide transition">
                            <img src="images/gallery/image4.png" alt="Nothing Phone 1" style="width:100%">
                        </div>
                    </div>

                    <div class="buttonNext">
                        <div id="next" onclick="cambiaFoto(1)">&#10095;</div>
                    </div>

                    <div class="dotsView">
                        <span class="dot" onclick="slideCorrente(1)"></span>
                        <span class="dot" onclick="slideCorrente(2)"></span>
                        <span class="dot" onclick="slideCorrente(3)"></span>
                        <span class="dot" onclick="slideCorrente(4)"></span>
                    </div>
                </div>
            </div>
        </div>
    </main>

<%@ include file="footer.jsp"%>

</body>
<script src="script/script.js"></script>
</html>