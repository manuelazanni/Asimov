<%@ page import="model.ProductDAO" %>
<%@ page import="model.ProductBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it-IT">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel = "icon" href="../../images/icons/logoA.svg" type="image/x-icon">
  <title>Asimov: Gestione utenti</title>

  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/amministratore.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<%@ include file="../../header.jsp"%>

  <%
    UserDAO userDAO = new UserDAO();
    ArrayList<UserBean> utenti = userDAO.doRetrieveAll();
  %>

  <main class="containerUsers">
      <h1 style="text-align: center; padding-bottom: 1rem;">Gestione utenti</h1>
      <table id="tabella">
        <tr>
          <th>ID</th>
          <th>Nome</th>
          <th>Cognome</th>
          <th>Email</th>
          <th>Gestisci</th>
        </tr>
        <%
          for(UserBean u : utenti){
        %>
          <tr>
            <td><%=u.getId_utente()%></td>
            <td><%=u.getNome()%></td>
            <td><%=u.getCognome()%></td>
            <td><%=u.getEmail()%></td>
            <td>
              <div>
                <button value="Sospendi"></button>
                <button value="Rimuovi"></button>
              </div>
            </td>
          </tr>
        <%
          }
        %>
      </table>
  </main>

<%@ include file="../../footer.jsp"%>
</body>
</html>
