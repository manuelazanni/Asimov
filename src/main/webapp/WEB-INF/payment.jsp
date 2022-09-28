<%@ page import="model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it-IT">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel = "icon" href="${pageContext.request.contextPath}/images/icons/logoA.svg" type="image/x-icon">
  <title>Asimov: Account</title>

  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/payment.css">

    <script>
        window.onload = function(){
            document.forms['acquista'].submit();
        }
    </script>
</head>
<body>

<%@ include file="../header.jsp"%>

<%
  CartBean cart = (CartBean) session.getAttribute("cart");
  ProductDAO productDAO = new ProductDAO();
%>

<main>
    <form method="post" action="ServletPayment" id="acquista"></form>
</main>

<%@ include file="../footer.jsp"%>

</body>
</html>
