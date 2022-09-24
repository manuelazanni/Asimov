<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it-IT">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "icon" href="images/icons/logoA.svg" type="image/x-icon">
    <title>Asimov: Account</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="style/account.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <script>
        function toEdit(){
            $('.accountContainer *').remove();

            $('.accountContainer').append(
                '<h1>Gestione account</h1>' +
                '<form method="post" action="ServletChangeInfo">' +
                    '<label for="nome">Nome</label> ' +
                    '<input type="text" id="nome" name="nome">' +
                    '<label for="cognome">Cognome</label> ' +
                    '<input type="text" id="cognome" name="cognome">' +
                    '<label for="username">Username</label> ' +
                    '<input type="text" id="username" name="username">' +
                    '<label for="email">Email</label> ' +
                    '<input type="email" id="email" name="email">' +
                    '<label for="password">Password</label> ' +
                    '<input type="password" id="password" name="password">' +
                    '<label for="dataNascita">Data di nascita</label> ' +
                    '<input type="date" id="dataNascita" name="dataNascita">' +
                    '<label for="citta">Città</label> ' +
                    '<input type="text" id="citta" name="citta">' +
                    '<label for="provincia">Provincia</label> ' +
                    '<input type="text" id="provincia" name="provincia">' +
                    '<label for="indirizzo">Via</label> ' +
                    '<input type="text" id="indirizzo" name="indirizzo">' +

                    '<input type="submit" class="button" value="conferma">' +
                '</form>'
            )
        }
    </script>
</head>
<body>

<%@ include file="header.jsp"%>

<%
    UserBean userBean = (UserBean) session.getAttribute("user");
%>

    <main>
        <div class="accountContainer">
            <h1>Gestione account</h1>
            <div>Nome<p><%=userBean.getNome()%></p></div>
            <div>Cognome<p><%=userBean.getCognome()%></p></div>
            <div>Username<p><%=userBean.getUsername()%></p></div>
            <div>Email<p><%=userBean.getEmail()%></p></div>
            <div>Password<p>********</p></div>
            <!-- <div>Data di nascita<p><%=userBean.getDataNascita()%></p></div> -->


            <%
                if(userBean.getDataNascita() == null || userBean.getDataNascita().length() == 0){
            %>
                <div>Data di nascita<p>Nessun valore inserito.</p></div>
            <%
            } else{
            %>
                <div>Data di nascita<p><%=userBean.getDataNascita()%></p></div>
            <%
                }
            %>


            <%
                if(userBean.getCitta() == null || userBean.getCitta().length() == 0  ){
            %>
                <div>Città<p>Nessun valore inserito.</p></div>
            <%
            } else{
            %>
                <div>Città<p><%=userBean.getCitta()%></p></div>
            <%
                }
            %>


            <%
                if(userBean.getProvincia() == null || userBean.getProvincia().length() == 0  ){
            %>
                <div>Provincia<p>Nessun valore inserito.</p></div>
            <%
            } else{
            %>
            <div>Provincia<p><%=userBean.getProvincia()%></p></div>
            <%
                }
            %>


            <%
                if(userBean.getIndirizzo() == null || userBean.getIndirizzo().length() == 0  ){
            %>
            <div>Indirizzo<p>Nessun valore inserito.</p></div>
            <%
            } else{
            %>
            <div>Indirizzo<p><%=userBean.getIndirizzo()%></p></div>
            <%
                }
            %>


            <%
                if(userBean.getAmministratore() == 1){
            %>
                <a href="ServletLogout" class="button">Logout</a>
                <a href="#" class="button amministratore">Pagina amministratore</a>
            <%
                } else{
            %>
                <a href="ServletLogout" class="button">Logout</a>
                <button onclick="toEdit()" class="button dati">Modifica dati</button>
                <a href="ServletDeleteAccount" class="button elimina">Elimina account</a>
            <%
                }
            %>

        </div>
    </main>

<%@ include file="footer.jsp"%>

</body>
</html>
