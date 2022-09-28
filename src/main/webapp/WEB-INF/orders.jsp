<%@ page import="model.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it-IT">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "icon" href="${pageContext.request.contextPath}/images/icons/logoA.svg" type="image/x-icon">
    <title>Asimov: I miei ordini</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/orders.css">
</head>
<body>
<%@ include file="../header.jsp"%>

<%
    OrderDAO orderDAO = new OrderDAO();
    ProductDAO productDAO = new ProductDAO();
    ArrayList<OrderBean> lista = orderDAO.doRetrieveById(user.getId_utente());
%>

    <main>
        <%
        for(OrderBean order : lista) {
            ConnectionProductOrderDAO connctionPODAO = new ConnectionProductOrderDAO();
            ArrayList<ConnectionProductOrder> listaProdotti = connctionPODAO.doRetrieveById(order.getId_order());

            double totale = 0;
        %>
        <div class="order">
        <%
            for(ConnectionProductOrder cpo : listaProdotti){
                ProductBean product = productDAO.doRetrieveById(cpo.getId_product());
                double sconto = (product.getPrezzo() * product.getSconto())/100;
                totale += product.getPrezzo() - sconto;
        %>
            <div class="cardOrder">
                <div><img src="<%=product.getImmagine()%>" alt="<%=product.getNome()%>"></div>
                <div><%=product.getNome()%></div>
                <div><%=product.getPrezzo()%>0€</div>
                <div>Quantità ordinata: <%=cpo.getQuantity()%></div>
            </div>
        <%
                }
        %>
            <%
                if(totale > 0){
            %>
            <div id="totaleOrdine">Totale: <span><%=totale%>€</span></div>
            <%
                }
            %>
        </div>
        <%
            }
        %>


    </main>

<%@ include file="../footer.jsp"%>
</body>
</html>
