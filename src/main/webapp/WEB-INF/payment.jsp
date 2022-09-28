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

  <!--
    <h3>Informazioni</h3>
    <label for="nome">Nome</label>
    <input type="text" id="nome" name="nome" value="<%=user.getNome()%>" placeholder="Inserisci il nome">
    <label for="cognome">Nome</label>
    <input type="text" id="cognome" name="cognome" value="<%=user.getCognome()%>" placeholder="Inserisci il cognome">
    <label for="citta">Città</label>
    <input type="text" id="citta" name="citta" value="<%=user.getCitta()%>" placeholder="Inserisci la città">
    <label for="indirizzo">Indirizzo</label>
    <input type="text" id="indirizzo" name="indirizzo" value="<%=user.getIndirizzo()%>" placeholder="Inserisci l'indirizzo">

    <label for="provincia">Provincia</label>
    <input type="text" id="provincia" name="provincia" value="<%=user.getProvincia()%>" placeholder="Inserisci la provincia">

    <label for="codicePostale">Codice Postale</label>
    <input type="text" id="codicePostale" name="codicePostale" value="<%=user.getCodicePostale()%>" placeholder="Inserisci il codice postale">


              <h3>Pagamento</h3>

              <label for="cname">Name on Card</label>
              <input type="text" id="cname" name="cardname" placeholder="John More Doe">
              <label for="ccnum">Credit card number</label>
              <input type="text" id="ccnum" name="cardnumber" placeholder="1111-2222-3333-4444">
              <label for="expmonth">Exp Month</label>
              <input type="text" id="expmonth" name="expmonth" placeholder="September">
              <div class="row">
                <div class="col-50">
                  <label for="expyear">Exp Year</label>
                  <input type="text" id="expyear" name="expyear" placeholder="2018">
                </div>
                <div class="col-50">
                  <label for="cvv">CVV</label>
                  <input type="text" id="cvv" name="cvv" placeholder="352">
                </div>
              </div>
            </div>

          </div>
          <input type="submit" value="Continue to checkout" class="btn">
        </form>
      </div>
    </div>
    <div class="col-25">
      <div class="container">
        <h4>Carrello <span class="price" style="color:black"><i class="fa fa-shopping-cart"></i> <b><%=cart.getNumberObject()%></b></span></h4>
        <%
          for(ConnectionProductCart connection : cart.getCartList()){
            ProductBean p = productDAO.doRetrieveById(connection.getId_product());
        %>
        <p><%=connection.getQuantity()%>x <a href="ServletCatalog?id=<%=p.getId()%>"><%=p.getNome()%></a> <span class="price"><%=(int) (connection.getQuantity() * p.getPrezzo())%>€</span></p>
        <%
          }
        %>
        <hr>
        <p>Totale <span class="price" style="color:black"><b><%= session.getAttribute("totale")%>€</b></span></p>
      </div>
    </div>
  </div>
  -->

<%@ include file="../footer.jsp"%>

</body>
</html>
