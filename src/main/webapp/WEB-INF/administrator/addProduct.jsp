<%@ page import="model.CategoryBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.CategoryDAO" %>
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

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <script>
        function imageUpload(event) {
            $(".fa-file-circle-xmark").addClass("fa-solid fa-file-circle-check").removeClass("fa-file-circle-xmark");
            let src = URL.createObjectURL(event.target.files[0]);
            $(".preview").attr("src", src);
        }
    </script>
</head>
<body>
<%@ include file="../../header.jsp"%>

    <%
        CategoryDAO categoryDAO = new CategoryDAO();
        ArrayList<CategoryBean> listCategories = categoryDAO.doRetrieveAll();
    %>

    <main class="containerManager">
        <div class="gest">
            <button onclick="history.back()"></button>
            <h1 class="orangeUnderline" style="text-align: center; padding: 2rem 0; text-transform: uppercase">Aggiungi un prodotto</h1>
            <form action="${pageContext.request.contextPath}/ServletAddProduct" method="post" id="formAddProduct" enctype="multipart/form-data" >
                <div class="productName">
                    <label for="name">Nome</label>
                    <input type="text" id="name" name="name" class="product" placeholder="Nome" maxlength="30" required>
                </div>

                <div class="productDescription">
                    <label for="description">Descrizione</label>
                    <textarea id="description" name="description" class="product" placeholder="Descrizione" rows="6" maxlength="255" required></textarea>
                </div>

                <div class="productPrice">
                    <label for="price">Prezzo</label>
                    <input type="text" id="price" name="price" class="product" placeholder="Prezzo" pattern="^[1-9]\d*(\.\d+)?$" required>
                </div>

                <div class="productQuantity">
                    <label for="quantity">Quantità</label>
                    <input type="text" id="quantity" name="quantity" class="product" placeholder="Quantità" pattern="[0-9]+" required>
                </div>

                <div class="productSales">
                    <label for="sales">Sconto</label>
                    <input type="text" id="sales" name="sales" class="product" placeholder="Sconto" pattern="[0-9]+" required>
                </div>

                <div class="product-image">
                    <label for="image" id="imageUpload">Immagine
                        <i class="fa-solid fa-file-circle-xmark"></i>
                        <input type="file" id="image" name="image" class="product" onchange="imageUpload(event)" accept="image/*" required></label>
                    <img src="" alt="" class="preview">
                </div>

                <div class="productBrand">
                    <label for="brand">Brand</label>
                    <input type="text" id="brand" name="brand" class="product" placeholder="Brand" maxlength="50" required>
                </div>

                <div class="product-category">
                    <label for="category">Categoria</label>
                    <select id="category" name="category">
                        <%
                            for (CategoryBean category: listCategories){
                        %>
                        <option value="<%=category.getNomeCategoria()%>"><%=category.getNomeCategoria()%></option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="add-product">
                    <input type="submit" value="Inserisci">
                </div>
            </form>
        </div>

    </main>
<%@ include file="../../footer.jsp"%>
</body>
</html>
