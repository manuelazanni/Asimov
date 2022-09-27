<%@ page import="model.ProductBean" %>
<%@ page import="model.ProductDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Asimov: Modifica prodotto</title>
</head>
<body>
<%@ include file="../../header.jsp"%>

    <main>
        <%
            int id = Integer.parseInt(request.getParameter("id"));
            ProductDAO productDAO = new ProductDAO();
            ProductBean productBean = productDAO.doRetrieveById(id);
        %>

        <p><%=productBean.getNome()%></p>
    </main>

<%@ include file="../../footer.jsp"%>
</body>
</html>
