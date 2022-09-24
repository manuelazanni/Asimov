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
        function getCartAjax(event){
            event.preventDefault();
            $('#productContainerID *').remove();
            let form = $('#formFilter');

            $.ajax({
                url: '${pageContext.request.contextPath}/ServletCart',
                type: 'GET',
                data: form.serialize(),
                dataType: 'json',
                success: function (data){
                    if(Object.keys(data).length === 0){
                        $('#productContainerID').append('<h1 style="text-align: center; margin-top: 2rem; color: var(--color-700)">Nessun risultato.</h1>');
                    } else{
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
                        }
                    }
                }
            });
        }
    </script>
</head>
<body>

<%@ include file="header.jsp"%>

    <main class="cartSection">
        <%
            CartBean cb = (CartBean) request.getSession(false).getAttribute("cart");
            CartDAO cartDAO = new CartDAO();
            ProductDAO productDAO = new ProductDAO();
            ArrayList<ConnectionProductCart> list;

            if(user != null){
                list = cartDAO.getCart(user.getId_utente());
            } else if(cb != null){
                    list = cb.getCartList();
            } else{
                list = null;
            }

            if(list != null){
                for(ConnectionProductCart connection : list){
                    ProductBean p = productDAO.doRetrieveById(connection.getId_product());
                    double priceUpdate = p.getPrezzo() * connection.getQuantity();
        %>

        <div class="productInCart">
            <img src="<%=p.getImmagine()%>" alt="<%=p.getNome()%>">
            <h3><%=p.getNome()%></h3>
            <h3><%=priceUpdate%>€</h3>
            <div class="quantitySection">
                <%
                    if(connection.getQuantity() > 1) {
                %>
                    <button class="plusMinus" onclick="">-</button>
                <%
                    }
                %>
                <h3><%=connection.getQuantity()%></h3>
                <button class="plusMinus">+</button>
            </div>
            <button class="deleteFromCart">Elimina</button>
        </div>

        <%
                    //}
                }
            }
        %>
    </main>

<%@ include file="footer.jsp"%>

</body>
</html>
