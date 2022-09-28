<%@ page import="java.util.ArrayList" %>
<%@ page import="model.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it-IT">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "icon" href="images/icons/logoA.svg" type="image/x-icon">
    <title>Asimov: Carrello</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="style/cart.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <script>
        window.onload = function() {
            $.ajax({
                url: '${pageContext.request.contextPath}/ServletGetCart',
                type: 'POST',
                dataType: 'json',
                success: function (data) {
                    printCartAjax(data);
                }
            });
        };

        function printCartAjax(data){
            $('.cartSection *').remove();
            $('.recapCartContainer *').remove();
            let totale = 0;
            if (Object.keys(data).length === 0) {
                $('.cartSection').append('<h1 style="text-align: center; margin-top: 2rem; color: var(--color-700)">Carrello vuoto.</h1>');
                $('.recapCartContainer *').remove();
            } else {
                for(let i = 0; i < Object.keys(data).length; i++){
                    let stringa1 = '<div class="productInCart">';
                    let stringa2 = '<a href="ServletCatalog?id=' + data[i]["id"] + '"><img src="' + data[i]["img"] +'" alt="' + data[i]["nome"] + '"></a>';
                    let stringa3 = '<h3>' + data[i]["nome"] + '</h3>';
                    let stringa4 = '<h3>' + data[i]["price"] + '€</h3>';
                    let stringa5 = '<div class="quantitySection">';
                    let stringaIf = '<button class="plusMinus" onclick="editQuantityAjax(\'?id=' + data[i]["id"] + '&quantity=-1\')">-</button>';
                    let stringa6 = '<h3>' + data[i]["qty"] + '</h3>';
                    let stringa7 = '<button class="plusMinus" onclick="editQuantityAjax(\'?id=' + data[i]["id"] + '&quantity=1\')">\+</button>';
                    let stringa8 = '</div><button class="deleteFromCart" onclick="removeFromCartAjax(\'?id_product=' + data[i]["id"] + '\')">Elimina</button></div>';

                    totale += data[i]["price"];

                    if(data[i]["qty"] > 1){
                        $('.cartSection').append(stringa1 + stringa2 + stringa3 + stringa4 + stringa5 + stringaIf + stringa6 + stringa7 + stringa8);
                    } else{
                        $('.cartSection').append(stringa1 + stringa2 + stringa3 + stringa4 + stringa5 + stringa6 + stringa7 + stringa8);
                    }
                }
                $('.recapCartContainer').append('<div class="recapCart"><span>Numero di oggetti <p>' + Object.keys(data).length + '</p></span><span>Totale <p>' + totale + '€</p></span><a href="ServletPayment" value="ordina">Effettua ordine</a></div>');
            }
        };

        function removeFromCartAjax(value){
            $.ajax({
                url: '${pageContext.request.contextPath}/ServletRemoveFromCart' + value,
                type: 'POST',
                dataType: 'json',
                success: function (data) {
                    printCartAjax(data);
                }
            });
        };

        function editQuantityAjax(value){
            $.ajax({
                url: '${pageContext.request.contextPath}/ServletAddToCart' + value,
                type: 'POST',
                dataType: 'json',
                success: function (data) {
                    printCartAjax(data);
                }
            });
        };

    </script>
</head>
<body>

<%@ include file="header.jsp"%>

<main class="cartSection">
    <h1 style="text-align: center; margin-top: 2rem; color: var(--color-700)">Carrello vuoto.</h1>
</main>
<div class="recapCartContainer">
    <div class="recapCart"></div>
</div>



<%@ include file="footer.jsp"%>

</body>
</html>
