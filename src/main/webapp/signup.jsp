<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="it-IT">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "icon" href="images/icons/logoA.svg" type="image/x-icon">
    <title>Asimov: Login</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style/loginSignup.css">
    <link rel="stylesheet" href="style/style.css">
</head>
<body>

<%@ include file="header.jsp"%>

    <main class="containerFlexLoginSignup">
        <div class="containerSignup">
            <form action="ServletRegistrazione" method="post" id="formLoginSignup">
                <div class="nome">
                    <label for="nomeBox">Nome<br></label>
                    <input type="text" id="nomeBox" class="inputSpace" name="nome" placeholder="Inserisci il nome">
                </div>

                <div class="cognome margin-top">
                    <label for="cognomeBox">Cognome<br></label>
                    <input type="text" id="cognomeBox" class="inputSpace" name="cognome" placeholder="Inserisci il cognome">
                </div>

                <div class="dataNascita margin-top">
                    <label for="dataNascitaeBox">Data di nascita<br></label>
                    <input type="date" id="dataNascitaeBox" class="inputSpace" name="dataNascita" placeholder="Inserisci la data di nascita">
                </div>

                <div class="username margin-top">
                    <label for="usernameBox">Username<br></label>
                    <input type="text" id="usernameBox" class="inputSpace" name="username" placeholder="Inserisci un username">
                </div>

                <div class="email margin-top">
                    <label for="emailBox">Email<br></label>
                    <input type="email" id="emailBox" class="inputSpace" name="email" placeholder="Inserisci l'email" onblur="autenticaEmail()">
                </div>

                <div class="password margin-top">
                    <label for="passwordBox">Password<br></label>
                    <input type="password" id="passwordBox" class="inputSpace" name="password" placeholder="Inserisci la password">
                </div>

                <div class="loginSignup">
                    <input type="submit" class="button" value="Registrati" onclick="autenticaLogin()">
                </div>
            </form>
        </div>
    </main>

<%@ include file="footer.jsp"%>

</body>
<script type="text/javascript" src="script/formValidator.js"></script>
</html>
