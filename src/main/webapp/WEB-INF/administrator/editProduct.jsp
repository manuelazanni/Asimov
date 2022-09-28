<%@ page import="java.util.ArrayList" %>
<%@ page import="model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it-IT">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "icon" href="${pageContext.request.contextPath}/images/icons/logoA.svg" type="image/x-icon">
    <title>Asimov: Aggiunta prodotto</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/addProduct.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/amministratore.css">

    <script src="https://kit.fontawesome.com/yourcode.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<%@ include file="../../header.jsp"%>

    <main>
        <%
            int id = Integer.parseInt(request.getParameter("id"));
            ProductDAO productDAO = new ProductDAO();
            ProductBean productBean = productDAO.doRetrieveById(id);
            CategoryDAO categoryDAO = new CategoryDAO();
            ArrayList<CategoryBean> listCategories = categoryDAO.doRetrieveAll();
            request.setAttribute("id", id);
        %>

        <main class="containerManager containerManagerProduct">
            <div class="gest">
                <button onclick="history.back()"></button>
                <h1 class="orangeUnderline" style="text-align: center; padding: 2rem 0; text-transform: uppercase">Modifica prodotto</h1>
                <div></div>
            </div>
            <form action="${pageContext.request.contextPath}/ServletEditProduct" method="post" id="formAddProduct" enctype="multipart/form-data" >
                <div class="productBrand">
                    <label for="brand">Brand</label>
                    <input type="text" id="brand" name="brand" class="product" placeholder="Brand" maxlength="50" onblur="validaBrandProdotto()" required>
                </div>

                <div class="productName">
                    <label for="name">Nome</label>
                    <input type="text" id="name" name="name" class="product" placeholder="Nome" maxlength="30" onblur="validaNomeProdotto()" required>
                </div>

                <div class="productPrice">
                    <label for="price">Prezzo</label>
                    <input type="number" id="price" name="price" class="product" placeholder="Prezzo" onblur="validaPrezzoProdotto()" required>
                </div>

                <div class="productQuantity">
                    <label for="quantity">Quantità</label>
                    <input type="number" id="quantity" name="quantity" class="product" placeholder="Quantità" onblur="validaQuantitaProdotto()" required>
                </div>

                <div class="productSales">
                    <label for="sales">Sconto</label>
                    <input type="number" id="sales" name="sales" class="product" placeholder="Sconto" onblur="validaScontoProdotto()" required>
                </div>

                <div class="productDescription">
                    <label for="description">Descrizione</label>
                    <textarea id="description" name="description" class="product" placeholder="Descrizione" rows="6" cols="50" maxlength="255" onblur="validaDescrizioneProdotto()" required></textarea>
                </div>

                <div class="productCategory">
                    <label for="category">Categoria</label>
                    <select id="category" name="category">
                        <%
                            for (CategoryBean category: listCategories){
                                if(!category.getNomeCategoria().equalsIgnoreCase("Tutte le opzioni")){
                        %>
                        <option value="<%=category.getNomeCategoria()%>"><%=category.getNomeCategoria()%></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>

                <div id="addProductDB">
                    <input type="submit" value="Inserisci" onclick="validaEditProduct()">
                </div>
            </form>
        </main>
    </main>

<%@ include file="../../footer.jsp"%>
</body>
<script src="script/formValidator.js"></script>
</html>
