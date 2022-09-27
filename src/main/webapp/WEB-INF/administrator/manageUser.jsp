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
  <link rel = "icon" href="${pageContext.request.contextPath}/images/icons/logoA.svg" type="image/x-icon">
  <title>Asimov: Gestione utenti</title>

  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/amministratore.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

  <script>
    function removeUser(id){
      $.ajax({
        url: '${pageContext.request.contextPath}/ServletRemoveUser',
        data: "id="+id,
        type: 'GET',
        dataType: 'json',
        success: function (data) {
          printUsersAjax(data);
        }
      });
    };

    function suspendUser(id, azione){
      console.log(id + "    " + azione);
      $.ajax({
        url: '${pageContext.request.contextPath}/ServletSuspendUser',
        data: "id="+id+"&azione="+azione,
        type: 'GET',
        dataType: 'json',
        success: function (data) {
          printUsersAjax(data);
        }
      });
    };

    function printUsersAjax(data){
      $('#tabella').remove();

      $('.containerManager').append('<table id="tabella"><tr><th>ID</th><th>Nome</th><th>Cognome</th><th>Email</th><th>Gestisci</th></tr></table>');

      for(let i = 0; i < Object.keys(data).length; i++) {
        if (data[i]["amministratore"] === 0) {
          if (data[i]["sospeso"] === 0) {
              $('#tabella').append('<tr>' +
                      '<td>' + data[i]["id"] + '</td>' +
                      '<td>' + data[i]["nome"] + '</td>' +
                      '<td>' + data[i]["cognome"] + '</td>' +
                      '<td>' + data[i]["email"] + '</td><td>' +
                      '<div class="buttonsTable">' +
                      '<button class="buttonsTable--sospendi" onclick="suspendUser(' + data[i]["id"] + ', \'sospendi\')">Sospendi</button>' +
                      '<button class="buttonsTable--elimina" onclick="removeUser(' + data[i]["id"] + ')">Elimina</button>' +
                      '</div></td></tr>');
            } else {
              $('#tabella').append('<tr>' +
                      '<td>' + data[i]["id"] + '</td>' +
                      '<td>' + data[i]["nome"] + '</td>' +
                      '<td>' + data[i]["cognome"] + '</td>' +
                      '<td>' + data[i]["email"] + '</td><td>' +
                      '<div class="buttonsTable">' +
                      '<button class="buttonsTable--sblocca" onclick="suspendUser(' + data[i]["id"] + ', \'sblocca\')">Sblocca</button>' +
                      '<button class="buttonsTable--elimina" onclick="removeUser(' + data[i]["id"] + ')">Elimina</button>' +
                      '</div></td></tr>');
            }
          } else {
          $('#tabella').append('<tr>' +
                  '<td>' + data[i]["id"] + '</td>' +
                  '<td>' + data[i]["nome"] + '</td>' +
                  '<td>' + data[i]["cognome"] + '</td>' +
                  '<td>' + data[i]["email"] + '</td><td>' +
                  '<p style="text-align: center; font-weight: 700; text-transform: uppercase;">Amministratore</p>' +
                  '</td></tr>');
        }
      }
    };

  </script>
</head>
<body>
<%@ include file="../../header.jsp"%>

  <%
    UserDAO userDAO = new UserDAO();
    ArrayList<UserBean> utenti = userDAO.doRetrieveAll();
  %>


  <main class="containerManager">
    <div class="gest">
      <button onclick="history.back()"></button>
      <h1 class="orangeUnderline" style="text-align: center; padding: 2rem 0; text-transform: uppercase">Gestione utenti</h1>
      <div></div>
    </div>

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
            <%
              if(u.getAmministratore() == 0){
            %>
            <div class="buttonsTable">
              <%
                if(u.getSospeso() == 1){
              %>
                <button class="buttonsTable--sblocca" onclick="suspendUser(<%=u.getId_utente()%>, 'sblocca')">Sbocca</button>
              <%
                } else{
              %>
              <button class="buttonsTable--sospendi" onclick="suspendUser(<%=u.getId_utente()%>, 'sospendi')">Sospendi</button>
              <%
                }
              %>
              <button class="buttonsTable--elimina" onclick="removeUser(<%=u.getId_utente()%>)">Elimina</button>
            </div>
            <%
              } else {
            %>
            <p style="text-align: center; font-weight: 700; text-transform: uppercase;">Amministratore</p>
            <%
              }
            %>
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
