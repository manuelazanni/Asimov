<%@ page import="model.ProductDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.ProductBean" %>
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
        function removeProduct(id){
            $.ajax({
                url: '${pageContext.request.contextPath}/ServletRemoveProduct',
                data: "id="+id,
                type: 'POST',
                dataType: 'json',
                success: function (data) {
                    printProductsAjax(data);
                }
            });
        };

        function printProductsAjax(data){
            $('#tabella').remove();

            $('.containerManager').append('<table id="tabella"><tr><th>ID</th><th>Nome</th><th>Descrizione</th><th>Quantita</th><th>Prezzo</th><th>Sconto</th><th>Categoria</th><th>Gestisci</th></tr></table>');

            for(let i = 0; i < Object.keys(data).length; i++) {
                $('#tabella').append('<tr>' +
                    '<td>' + data[i]["id"] + '</td>' +
                    '<td><span>' + data[i]["brand"] + ' </span>' + data[i]["nome"] + '</td>' +
                    '<td>' + data[i]["descrizione"] + '</td>' +
                    '<td>' + data[i]["quantita"] + '</td>' +
                    '<td>' + data[i]["prezzo"] + '</td>' +
                    '<td>' + data[i]["sconto"] + '</td>' +
                    '<td>' + data[i]["categoria"] + '</td><td>' +
                    '<div class="buttonsTable">' +
                    '<button class="buttonsTable--elimina" onclick="removeProduct(' + data[i]["id"] + ')">Elimina</button>' +
                    '</div></td></tr>');
            }
        };
    </script>
</head>
<body>
<%@ include file="../../header.jsp"%>

<%
    ProductDAO productDAO = new ProductDAO();
    ArrayList<ProductBean> prodotti = productDAO.doRetrieveAll();
%>


    <main class="containerManager">
        <div class="gest">
            <button onclick="history.back()"></button>
            <h1 class="orangeUnderline" style="text-align: center; padding: 2rem 0; text-transform: uppercase">Gestione prodotti</h1>
            <div></div>
        </div>

        <table id="tabella">
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Descrizione</th>
                <th>Quantità</th>
                <th>Prezzo</th>
                <th>Sconto</th>
                <th>Categoria</th>
                <th>Gestisci</th>
            </tr>
            <%
                for(ProductBean p : prodotti){
            %>
            <tr>
                <td><%=p.getId()%></td>
                <td><span><%=p.getBrand()%></span> <%=p.getNome()%></td>
                <td><%=p.getDescrizione()%></td>
                <td><%=p.getQuantita()%></td>
                <td><%=(int) p.getPrezzo()%>€</td>
                <td><%=p.getSconto()%></td>
                <td><%=p.getCategoria()%></td>
                <td>
                    <div class="buttonsTable">
                        <form method="get" action="ServletEditProduct">
                            <input type="hidden" value="<%=p.getId()%>" name="id">
                            <button type="submit" class="buttonsTable--modifica">Modifica</button>
                        </form>
                        <button class="buttonsTable--elimina" onclick="removeProduct(<%=p.getId()%>)">Elimina</button>
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
