<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it-IT">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "icon" href="${pageContext.request.contextPath}/images/icons/logoA.svg" type="image/x-icon">
    <title>Asimov: Amministratore</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/amministratore.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<%@ include file="../../header.jsp"%>

    <main class="containerAdmin">
        <h1>Pagina amministratore</h1>
        <div>
            <a href="#">Gestisci ordini</a>
            <a href="ServletAmministratore?pagina=aggiungiProdotti">Aggiungi prodotto</a>
            <a href="ServletAmministratore?pagina=prodotti">Gestisci prodotti</a>
            <a href="ServletAmministratore?pagina=utenti">Gestisci utenti</a>
        </div>
    </main>

<%@ include file="../../footer.jsp"%>
</body>
</html>
