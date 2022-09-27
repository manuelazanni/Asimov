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

    <title>Asimov: News</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="style/news.css">
</head>
<body>

<%@ include file="header.jsp"%>

<h1 class="orangeUnderline" style="text-align: center; padding-top: 2rem; text-transform: uppercase;">News</h1>
<main>
    <%
        NewsDAO newsDAO = new NewsDAO();
        ArrayList<NewsBean> listaNews = newsDAO.doRetrieveAll();
        for(NewsBean news : listaNews){
    %>
    <div class="cardNews" style="margin: 2rem">
        <div class="titoloNews"><%=news.getTitolo()%></div>
        <div class="testoNews"><%=news.getTesto()%></div>
    </div>
    <%
        }
    %>
</main>

<%@ include file="footer.jsp"%>

</body>
</html>
