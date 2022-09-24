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
        function filterAjax(event){
            event.preventDefault();
            $('#productContainerID *').remove();
            let form = $('#formFilter');

            $.ajax({
                url: '${pageContext.request.contextPath}/ServletFilter',
                type: 'GET',
                data: form.serialize(),
                dataType: 'json',
                success: function (data){
                    if(Object.keys(data).length === 0){
                        $('#productContainerID').append('<h1 style="text-align: center; margin-top: 2rem; color: var(--color-700)">Nessun risultato.</h1>');
                    } else{
                        for(let i = 0; i < Object.keys(data).length; i++){

                            let image = '<div class="image"><img src="' + data[i]["immagine"] + '" alt="' + data[i]["nome"] + '"></div>';
                            let info;
                            let stars = '<div class="stars">';

                            if(data[i]["sconto"].valueOf() > 0) {
                                let sconto = ((data[i]["prezzo"].valueOf() * data[i]["sconto"].valueOf()) / 100);
                                let prezzoAggiornato = data[i]["prezzo"].valueOf() - sconto;

                                info = '<div class="info"><h3>' + data[i]["nome"] + '</h3><div class="price">' +
                                    '<span class="oldPrice" style="padding-right: 10px;">' + data[i]["prezzo"] + '<i class="material-icons" style="padding-left: 15px;">clear</i></span><span class="actualPrice">' +
                                    prezzoAggiornato.toFixed(0) + '€</span>' + '</div>';
                            } else{
                                info = '<div class="price">' + data[i]["prezzo"].valueOf().toFixed(0) + '€</div>';
                            }

                            let rec = data[i]["punteggio"].valueOf().toFixed(0);
                            for(let i = 0; i < rec; i++ ){
                                stars.concat('<i class="fa fa-star"></i>');
                            }
                            for(let i = rec; i < 5; i++){
                                stars.concat('<i class="fa fa-star-o"></i>');
                            }
                            stars.concat('</div>');

                            let buttons = '<div class="buttons"><a class="buyNow">Compra ora</a><a href="ServletAddToCart?id='+data[i]["id"]+'&quantity=1" class="addToCart">Aggiungi al carrello</a></div>';

                            $('#productContainerID').append('<div class="card">' + image + info + stars + buttons);
                        }

                        /*
                        for(let i = 0; i < Object.keys(data).length; i++){
                            $('#productContainerID').append(
                                '<div class="card">' +
                                '<div class="image"><img src="' + data[i]["immagine"] + '" alt="' + data[i]["nome"] + '"></div>' +
                                '<div class="info">' +
                                '<h3>' + data[i]["nome"] + '</h3>' +
                                '<div class="price">' + data[i]["prezzo"] +'€</div>' +
                                '<div class="stars"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-half-o"></i></div>' +
                                '<div class="buttons">' +
                                '<a class="buyNow">Compra ora</a>' +
                                '<a href="ServletAddToCart?id=' + data[i]["id"] + '&quantity=1" class="addToCart">Aggiungi al carrello</a>' +
                                '</div>' +
                                '</div>' +
                                '</div>');
                        }*/
                    }
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
                    <input type="number" id="min" name="min" value="1" placeholder="0€">
                </div>
                <div class="maxRange">
                    <label for="max">Massimo</label><br>
                    <input type="number" id="max" name="max" value="100" placeholder="2000€">
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

</body>
</html>
