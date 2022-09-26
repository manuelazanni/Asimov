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

    <title>Asimov: Catalogo</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="style/catalog.css">
    <link rel="stylesheet" href="style/filter.css">

    <script>
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
<%@ include file="filter.jsp"%>

<main class="section">
    <span class="popup" id="myPopup">Prodotto aggiunto ✓</span>

    <div id="productContainerID" class="productContainer">
        <%
            ProductDAO productDAO = new ProductDAO();
            ArrayList<ProductBean> listaProdotti = productDAO.doRetrieveAll();

            ReviewDAO reviewDAO = new ReviewDAO();

            for(ProductBean p : listaProdotti) {
                ArrayList<ReviewBean> reviewBean = reviewDAO.doRetrieveById(p.getId());

                int stelle = 0;

                if(reviewBean.size() > 0) {
                    double sommaPunteggi = 0;

                    for (ReviewBean r : reviewBean) {
                        sommaPunteggi += r.getPunteggio();
                    }

                    stelle = (int) sommaPunteggi / reviewBean.size();
                }
        %>
        <div class="card">
            <a href="ServletCatalog?id=<%=p.getId()%>">
                <div class="image">
                    <img src="<%=p.getImmagine()%>" alt="<%=p.getNome()%>">
                </div>
            </a>
            <div class="info">
                <div class="title"><span><%=p.getBrand()%></span><%=p.getNome()%></div>
                    <%
                        if(p.getSconto()>0){
                            double sconto = ((p.getPrezzo() * p.getSconto())/100);
                            int prezzoAggiornato = (int) (p.getPrezzo() - sconto);
                    %>
                    <div class="price">
                        <span class="oldPrice"><s><%=(int)p.getPrezzo()%>€</s></span>
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
                <%
                    if(p.getQuantita() > 0){
                %>
                <div class="buttons">
                    <button class="buyNow" onclick="">Compra ora</button>
                    <button class="addToCart" onclick="addToCartAjax('?id=<%=p.getId()%>&quantity=1')">Aggiungi al carrello</button>
                </div>
                <%
                    } else{
                %>
                <div class="buttons">
                    <div class="unavaible"><span>Prodotto terminato.</span></div>
                </div>

                <%
                    }
                %>
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
