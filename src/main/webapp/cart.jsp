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
                }
            }
        %>
    </main>

<%@ include file="footer.jsp"%>

</body>
</html>
