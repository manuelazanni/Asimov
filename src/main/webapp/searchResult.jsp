<%@ page import="java.util.ArrayList" %>
<%@ page import="model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it-IT">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "icon" href="images/icons/logoA.svg" type="image/x-icon">
    <%
        String field = (String) request.getSession(false).getAttribute("field");

        if(field.length() == 0){
            field = "Catalogo";
        }
    %>
    <title>Asimov: <%=""+field%></title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="style/filter.css">
    <link rel="stylesheet" href="style/catalog.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <script>
        function filterAjaxSearch(event){
            event.preventDefault();
            $('#productContainerID *').remove();
            let form = $('#formFilter');

            $.ajax({
                url: '${pageContext.request.contextPath}/ServletFilterSearch',
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
                    }
                }
            });

        }

        function addToCartAjax(value){
            $.ajax({
                url: '${pageContext.request.contextPath}/ServletAddToCart' + value,
                type: 'GET'
            });

            var popup = document.getElementById("myPopup");
            popup.classList.remove("hide");
            popup.classList.add("show");

            setTimeout(function() {
                popup.classList.remove("show");
                popup.classList.add("hide");
            },1000);
        }
    </script>
</head>
<body>

<%@ include file="header.jsp"%>

<%
    ArrayList<ProductBean> trovati = (ArrayList<ProductBean>) request.getSession(false).getAttribute("productFind");
    if(trovati.size() > 0){
%>
<%
    CategoryDAO categoryDAO = new CategoryDAO();
    ArrayList<CategoryBean> listCategories = categoryDAO.doRetrieveAll();
%>

<div class="containerFilter">
    <form id="formFilter" onsubmit="filterAjaxSearch(event)">
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
<%
    } else{
%>
    <h1 style="text-align: center; margin-top: 2rem; color: var(--color-700)">Nessun risultato.</h1>
<%
    }
%>

<main class="section">
    <span class="popup" id="myPopup">Prodotto aggiunto ✓</span>

    <div id="productContainerID" class="productContainer">
        <%
            ReviewDAO reviewDAO = new ReviewDAO();

            for(ProductBean p : trovati) {
                ArrayList<ReviewBean> reviewBean = reviewDAO.doRetrieveById(p.getId());
                double sommaPunteggi = 0;

                for (ReviewBean r : reviewBean) {
                    sommaPunteggi += r.getPunteggio();
                }

                int stelle = (int) sommaPunteggi / reviewBean.size();
        %>
        <div class="card">
            <a href="ServletCatalog?id=<%=p.getId()%>">
                <div class="image">
                    <img src="<%=p.getImmagine()%>" alt="<%=p.getNome()%>">
                </div>
            </a>
            <div class="info">
                <h3><%=p.getNome()%></h3>
                <%
                    if(p.getSconto()>0){
                        double sconto = ((p.getPrezzo() * p.getSconto())/100);
                        int prezzoAggiornato = (int) (p.getPrezzo() - sconto);
                %>
                <div class="price">
                        <span class="oldPrice">
                            <%=(int)p.getPrezzo()%>€
                            <i class="material-icons">clear</i>
                        </span>
                    <span class="actualPrice"><%=prezzoAggiornato%>€</span>
                </div>
                <%
                } else{
                %>
                <div class="price"><%=(int)p.getPrezzo()%>€</div>
                <%
                    }
                %>
                <div class="starsCatalog">
                    <%
                        int i;
                        for(i = 0; i < stelle; i++){
                    %>
                    <i class="fa fa-star"></i>
                    <%
                        }
                        for(i = stelle; i < 5; i++){
                    %>
                    <i class="fa fa-star-o"></i>
                    <%
                        }
                    %>
                </div>
                <div class="buttons">
                    <button class="buyNow" onclick="">Compra ora</button>
                    <button class="addToCart" onclick="addToCartAjax('?id=<%=p.getId()%>&quantity=1')">Aggiungi al carrello</button>
                </div>
            </div>
        </div>

        <%
            }
        %>
    </div>
</main>

<%@ include file="footer.jsp"%>

</body>
</html>