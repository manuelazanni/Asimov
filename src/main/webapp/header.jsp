<%@ page import="model.UserBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it-IT">
<head>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="style/header.css">
</head>
<body>
    <header class="header">
        <div class="utility">
            <form class="searchBox" action="ServletSearchProduct" method="get">
                <input type="text" id="searchInput" name="searchBar">
                <button class="searchButton" onsubmit="searchProduct()">
                    <span class="material-symbols-outlined search">search</span>
                </button>
            </form>
        </div>

        <div class="logoSection">
            <a href="index.jsp"><div id="logo"></div></a>
        </div>

        <div class="userArea">
            <%
                if(session == null || session.getAttribute("user") == null) {
            %>
            <a href="login.jsp">
            <%
                } else{
            %>
            <a href="ServletAccount">
            <%
                }
            %>
                <div class="userSection">
                    <%
                        UserBean user = (UserBean) session.getAttribute("user");
                        if(user != null) {
                    %>

                    <h3 class="userName">Ciao <%=user.getUsername()+"!"%> </h3>

                    <div class="lecterCircle"><%=user.getUsername().substring(0,1).toUpperCase()%></div>

                    <%
                        }
                    %>
                     <span class="material-symbols-outlined user">account_circle</span>
                </div>
            </a>

            <a href="cart.jsp"> <span class="material-symbols-outlined cart">shopping_bag</span> </a>
            <span class="material-symbols-outlined bar" onclick="apriNavBar()">menu</span>
        </div>
    </header>

    <!-- Navigation Bar -->
    <nav class="navigationBar">
        <a href="catalog.jsp" class="underlineEffect">Catalogo</a>
        <a href="sales.jsp" class="underlineEffect">Offerte</a>
        <a href="news.jsp" class="underlineEffect">News</a>
        <a href="#" class="underlineEffect">Collaborazioni</a>
    </nav>

</body>
<script src="script/header.js"></script>
</html>
