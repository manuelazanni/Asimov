<%@ page import="model.CategoryDAO" %>
<%@ page import="model.CategoryBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it-IT">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="style/productPage.css">
    <link rel="stylesheet" href="style/filter.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <script>
        function printProductAjax(data){
            $('#productContainerID *').remove();

            if(Object.keys(data).length === 0){
                $('#productContainerID').append('<h1 style="text-align: center; margin-top: 2rem; color: var(--color-700)">Nessun risultato.</h1>');
            } else{
                for(let i = 0; i < Object.keys(data).length; i++){

                    let scontoString = '';
                    let prezzo = data[i]['prezzo'] - 0;
                    let sconto = (data[i]['prezzo'] * data[i]['sconto'])/100;
                    let prezzoAggiornato = data[i]['prezzo'] - sconto;

                    if(data[i]['sconto'] > 0){
                        scontoString = '<div class="price"><span class="oldPrice"><s>' + Math.trunc(prezzo) + '€</s></span><span class="actualPrice">' + Math.trunc(prezzoAggiornato) + '€</span></div>';
                    } else{
                        scontoString = '<div class="price">' + prezzo + '€</div>';
                    }

                    let stelleString = '';
                    let stelle = data[i]['punteggio'];

                    for(let i = 0; i < stelle; i++){
                        stelleString = stelleString.concat('<i class="fa fa-star"></i>');
                    }

                    for(let i = stelle; i < 5; i++){
                        stelleString = stelleString.concat('<i class="fa fa-star-o"></i>');
                    }

                    stelleString = stelleString.concat('</div>');

                    let quantitaString = '';

                    if(data[i]['quantita'] > 0){
                        quantitaString = quantitaString.concat('<div class="buttons"><button class="buyNow" onclick="">Compra ora</button><button class="addToCart" onclick="addToCartAjax(\'?id=' + data[i]['id'] + '&quantity=1\')">Aggiungi al carrello</button></div>');
                    } else{
                        quantitaString = quantitaString.concat('<div class="buttons"><div class="unavaible"><span>Prodotto terminato.</span></div></div>');
                    }

                    $('#productContainerID').append(
                        '<div class="card">' +
                        '<a href="ServletCatalog?id=' + data[i]["id"] + '">' +
                        '<div class="image"><img src="' + data[i]["immagine"] + '" alt="' + data[i]["nome"] + '"></div>' +
                        '</a>' +
                        '<div class="info">' +
                        '<div class="title"><span>' + data[i]["brand"] + '</span>' + data[i]["nome"] + '</div>' + scontoString + '<div class="starsCatalog">' + stelleString + quantitaString + '</div></div>');
                }
            }
        }

        function orderAjax(){
            let value = '/ServletOrderProduct?scelta=' + $('#ordinamento').val();

            $.ajax({
                url: '${pageContext.request.contextPath}' + value,
                type: 'GET',
                dataType: 'json',
                success: function (data){
                    printProductAjax(data);
                }
            });
        }

        function filterAjax(event){
            event.preventDefault();

            $('.filterOrder').remove();
            $('#productContainerID *').remove();
            let form = $('#formFilter');
            let formString = form.serialize();
            let newFormString;

            if(formString.includes("min=&max=&")){
                newFormString = formString.replace("min=&max=&", "min=0&max=0&");
            } else if(formString.includes("min=&")){
                newFormString = formString.replace("min=&", "min=0&");
            } else if(formString.includes("max=&")){
                newFormString = formString.replace("max=&", "max=0&");
            } else{
                newFormString = formString;
            }

            $.ajax({
                url: '${pageContext.request.contextPath}/ServletFilter',
                type: 'GET',
                data: newFormString,
                dataType: 'json',
                success: function (data){
                    printProductAjax(data);
                }
            });
        }
    </script>
</head>
<body>
<%
    CategoryDAO categoryDAO = new CategoryDAO();
    ArrayList<CategoryBean> listCategories = categoryDAO.doRetrieveAll();
%>

<div class="containerFilter">
    <form id="formFilter" onsubmit="filterAjax(event)">
        <div class="filterPriceTitle">Prezzo</div>
        <div class="filterPrice">
            <div class="range">
                <div class="minRange">
                    <label for="min">Minimo</label><br>
                    <input type="number" id="min" name="min" placeholder="0€">
                </div>
                <div class="maxRange">
                    <label for="max">Massimo</label><br>
                    <input type="number" id="max" name="max" placeholder="2000€">
                </div>
            </div>
        </div>

        <div class="filterCategoryTitle">Categoria</div>
        <div class="filterCategory">
            <% for(CategoryBean category : listCategories) { %>
            <div class="categoryName">
                <input type="radio" class="categoryName" name="category" id="<%= category.getNomeCategoria() %>" value="<%= category.getNomeCategoria() %>" checked>
                <label id="labelRadio" for="<%= category.getNomeCategoria() %>"><%= category.getNomeCategoria() %></label>
            </div>
            <% } %>
        </div>

        <div class="filterSearch">
            <button type="submit">
                <span class="material-symbols-outlined go" >arrow_circle_right</span>
            </button>
        </div>
    </form>
</div>


<div class="filterOrder">
    <select id="ordinamento" name="ordinamentoList" form="formFilter" onchange="orderAjax()">
        <option value="nessunaPreferenza">Nessuna preferenza</option>
        <option value="prezzoCrescente">Prezzo crescente</option>
        <option value="prezzoDecrescente">Prezzo decrescente</option>
    </select>
</div>



</body>
</html>
