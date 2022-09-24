<%@ page import="model.ProductDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.ProductBean" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it-IT">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "icon" href="images/icons/logoA.svg" type="image/x-icon">
    <%
        String brand = request.getParameter("Brand");
    %>
    <title>Asimov: <%=brand%></title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="style/productPage.css">
</head>
<body>

<%@ include file="header.jsp"%>
    <main>
        <h1 style="text-align: center; margin: 1rem 0;">Il prodotto è già presente nel carrelo, modifica la quantità <a href="cart.jsp">qui</a></h1>
    </main>

<%@ include file="footer.jsp"%>

</body>
</html>
