<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it-IT">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "icon" href="../images/icons/logoA.svg" type="image/x-icon">
    <title>Asimov: Account</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/account.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <%
        UserBean userBean = (UserBean) session.getAttribute("user");
    %>

    <script>
        function toEdit(){
            $('.accountContainer *').remove();

            $('.accountContainer').append(
                '<h1>Gestione account</h1>' +
                '<form method="post" action="ServletChangeInfo">' +
                    '<label for="nome">Nome</label> ' +
                    '<input type="text" id="nome" name="nome" placeholder="<%=userBean.getNome()%>">' +
                    '<label for="cognome">Cognome</label> ' +
                    '<input type="text" id="cognome" name="cognome" placeholder="<%=userBean.getCognome()%>">' +
                    '<label for="username">Username</label> ' +
                    '<input type="text" id="username" name="username" placeholder="<%=userBean.getUsername()%>">' +
                    '<label for="email">Email</label> ' +
                    '<input type="email" id="email" name="email" placeholder="<%=userBean.getEmail()%>">' +
                    '<label for="password">Password</label> ' +
                    '<input type="password" id="password" name="password" placeholder="<%=userBean.getPassword()%>">' +
                    '<label for="citta">Città</label> ' +
                    <%
                        if(userBean.getCitta() != null){
                    %>
                    '<input type="text" id="citta" name="citta" placeholder="<%=userBean.getCitta()%>">' +
                    <%
                        } else {
                    %>
                    '<input type="text" id="citta" name="citta" placeholder="Inserisci la città">' +
                    <%
                        }
                    %>
                    '<label for="provincia">Provincia</label> ' +
                    <%
                        if(userBean.getProvincia() != null){
                    %>
                    '<input type="text" id="provincia" name="provincia" placeholder="<%=userBean.getProvincia()%>">' +
                    <%
                        } else {
                    %>
                    '<input type="text" id="provincia" name="provincia" placeholder="Inserisci la provincia">' +
                    <%
                        }
                    %>
                    '<label for="indirizzo">Via</label> ' +
                    <%
                        if(userBean.getIndirizzo() != null){
                    %>
                    '<input type="text" id="indirizzo" name="indirizzo" placeholder="<%=userBean.getIndirizzo()%>">' +
                    <%
                        } else {
                    %>
                    '<input type="text" id="indirizzo" name="indirizzo" placeholder="Inserisci l\'indirizzo">' +
                    <%
                        }
                    %>
                    '<label for="telefono">Telefono</label> ' +
                    <%
                        if(userBean.getIndirizzo() != null){
                    %>
                    '<input type="text" id="telefono" name="telefono" placeholder="<%=userBean.getTelefono()%>">' +
                    <%
                        } else {
                    %>
                    '<input type="text" id="telefono" name="telefono" placeholder="Inserisci il numero di telefono">' +
                    <%
                        }
                    %>


                    '<input type="submit" class="button" value="conferma">' +
                '</form>'
            )
        }
    </script>
</head>
<body>

<%@ include file="../header.jsp"%>

    <main>
        <div class="accountContainer">
            <h1>Gestione account</h1>
            <div>Nome<p><%=userBean.getNome()%></p></div>
            <div>Cognome<p><%=userBean.getCognome()%></p></div>
            <div>Username<p><%=userBean.getUsername()%></p></div>
            <div>Email<p><%=userBean.getEmail()%></p></div>
            <div>Password<p>********</p></div>

            <%
                if(userBean.getTelefono() == null || userBean.getTelefono().length() == 0){
            %>
                <div>Telefono<p>Nessun valore inserito.</p></div>
            <%
            } else{
            %>
                <div>Telefono<p><%=userBean.getTelefono()%></p></div>
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
                <a href="ServletAmministratore?pagina=amministratore" class="button amministratore">Pagina amministratore</a>
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

<%@ include file="../footer.jsp"%>

</body>
</html>
