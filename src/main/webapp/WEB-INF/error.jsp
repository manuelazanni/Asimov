<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="it-IT">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "icon" href="images/icons/logoA.svg" type="image/x-icon">
    <title>Asimov: Attenzione</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/style.css">

    <script>
        window.onload = function() {
            setTimeout("window.location.href='<%= (String) request.getAttribute("redirect") %>'", 3000);
        }
    </script>
</head>
<body>

<%@ include file="../header.jsp"%>

<main style="display: flex; justify-content: center; align-items: center; text-align: center; flex-direction: column; gap: 1rem;">
    <h1 style="color: var(--color-red)"><%= (String) request.getAttribute("msg") %></h1>
    <h3>A breve sarai reindirizzato alla home.</h3>
</main>

<%@ include file="../footer.jsp"%>

</body>
</html>
