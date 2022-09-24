<%@ page import="java.util.ArrayList" %>
<%@ page import="model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it-IT">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "icon" href="images/icons/logoA.svg" type="image/x-icon">

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="script/starRating.js"></script>
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="style/productPage.css">

    <%
        ProductBean product = (ProductBean) request.getAttribute("product");
        ReviewDAO reviewDAO = new ReviewDAO();
        ArrayList<ReviewBean> reviewBeans = reviewDAO.doRetrieveById(product.getId());
    %>

    <title>Asimov: <%=product.getNome()%></title>

    <script>
        let rate = 0;

        $(document).ready(function(){
            $('#one').click(function () {
                checkStarOne();
                this.rate = 1;
            });
        });

        $(document).ready(function(){
            $('#two').click(function () {
                checkStarTwo();
                this.rate = 2;
            });
        });

        $(document).ready(function(){
            $('#three').click(function () {
                checkStarThree();
                this.rate = 3;
            });
        });

        $(document).ready(function(){
            $('#four').click(function () {
                checkStarFour();
                this.rate = 4;
            });
        });

        $(document).ready(function(){
            $('#five').click(function () {
                checkStarFive();
                this.rate = 5;
            });
        });

        function checkRate(){
            console.log(this.rate.toString());
        }

        function favouriteAjax(){
            $.ajax({
                url: '${pageContext.request.contextPath}/ServletAddToCart' + value,
                type: 'GET'
            });

            // modifica
        }

    </script>

</head>
<body>

<%@ include file="header.jsp"%>

    <main>
        <div class="gridContainer">
            <div class="containerImage">
                <img src="<%=product.getImmagine()%>" alt="<%=product.getNome()%>">
            </div>

            <div class="containerTitle">
                <div class="orangeUnderlineDiv">
                    <h1><%=product.getNome()%></h1>
                </div>
            </div>

            <div class="containerDescription">
                <ul>
                    <%
                    String[] result = product.getDescrizione().split("-");

                    for(String s : result){
                    %>
                    <li><%=s%></li>
                    <%
                        }
                    %>
                </ul>
                <div class="containerPrice">
                    <%
                        if(product.getSconto() == 0){
                    %>
                    <div class="price">Prezzo: <span><%=(int) product.getPrezzo()%>€</span></div>
                    <%
                    } else{
                        int sconto = (int) (product.getPrezzo() * product.getSconto())/100;
                    %>
                    <div class="price">Prezzo: <span><%=(int) product.getPrezzo()%>€</span></div>
                    <div class="orangeLine"></div>
                    <div class="price discount">Prezzo scontato: <span><%=(int) product.getPrezzo()-sconto%>€</span></div>
                    <%
                        }
                    %>
                </div>
            </div>

            <%
                if(product.getQuantita() > 0){
            %>
            <div class="containerButtons">
                <a href="ServletAddToCart" class="addToCart--productpPage">
                    <span class="material-symbols-outlined">shopping_bag</span>
                    <p>Aggiungi al carrello</p>
                </a>
                <span class="material-symbols-outlined favourite" onclick="favouriteAjax()">favorite</span>
            </div>
            <%
            } if(product.getQuantita() == 0){
            %>
            <div class="containerButtons">
                <div class="unavaible--productpPage">
                    <span class="material-symbols-outlined">close</span>
                    <p>Prodotto terminato</p>
                </div>
                <span class="material-symbols-outlined favourite" onclick="favouriteAjax()">favorite</span>
            </div>
            <%
                }
            %>
        </div>

        <div class="containerReview">
            <%
                if(reviewBeans.size() == 0){
            %>
            <div class="textTitleReview">Nessuna recensione.</div>
            <%
                }
            %>
            <%
                if(user != null) {
            %>
            <div class="reviewWrite">
                <form method="post" action="#">
                    <div style="font-weight: 500; font-size: 1.2rem; color: var(--color-500);"><%=user.getUsername()%></div>
                    <div class="stars starsWriting">
                        <i class="fa fa-star-o" id="one"></i>
                        <i class="fa fa-star-o" id="two"></i>
                        <i class="fa fa-star-o" id="three"></i>
                        <i class="fa fa-star-o" id="four"></i>
                        <i class="fa fa-star-o" id="five"></i>
                    </div>
                    <textarea style="width: 70%; height: 10rem;" placeholder="Scrivi qui la tua recensione"></textarea>
                    <input type="submit" value="Invia recensione">
                </form>
            </div>

            <div class="textTitleReview">Recensioni</div>

            <%
                }

                for(ReviewBean r : reviewBeans){
                    UserDAO userDAO = new UserDAO();
                    UserBean recensore = userDAO.doRetrieveById(r.getId_utente());
            %>

            <div class="review">
                <div style="font-weight: 700; font-size: 1.4rem; color: var(--color-500);"><%=recensore.getUsername()%></div>
                <div style="display: flex; align-items: center; gap: 1rem; color: var(--color-500);">
                    <div class="stars">
                        <%
                            int i;
                            for(i = 0; i < (int) r.getPunteggio(); i++){
                        %>
                        <i class="fa fa-star"></i>
                        <%
                            }
                            for(i = (int) r.getPunteggio(); i < 5; i++){
                        %>
                        <i class="fa fa-star-o"></i>
                        <%
                            }
                        %>
                    </div>
                    <div class="data"><%=r.getData()%></div>
                </div>


                <div style="margin-top: 1rem; font-size: 1.1rem;"><%=r.getRecensione()%></div>
            </div>
            <%
                }
            %>

        </div>
    </main>

<%@ include file="footer.jsp"%>

</body>
</html>
