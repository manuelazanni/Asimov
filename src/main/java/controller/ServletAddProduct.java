package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 5 * 5)
@WebServlet(name = "ServletAddProduct", value = "/ServletAddProduct")
public class ServletAddProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute("user");

        if(user.getAmministratore() == 1){
            final Pattern patternDecimale = Pattern.compile("^(\\d+(?:[.,]\\d{2})?)$");
            final Pattern patternIntero = Pattern.compile("^\\d+$");
            int counter = 0;

            String nome = request.getParameter("name");
            if (nome.length() > 0 && nome.length() <= 20){
                counter++;
            }

            String descrizione = request.getParameter("description");
            if (descrizione.length() > 0 && descrizione.length() <= 255){
                counter++;
            }

            String prezzo = request.getParameter("price").replace(",", ".");
            Matcher matcher = patternDecimale.matcher(prezzo);
            boolean result = matcher.find();
            if (result){
                counter++;
            }

            String quantita = request.getParameter("quantity");
            matcher = patternIntero.matcher(quantita);
            result = matcher.find();
            if (result){
                counter++;
            }

            String sconto = request.getParameter("sales");
            matcher = patternIntero.matcher(sconto);
            result = matcher.find();
            if (result){
                counter++;
            }

            String catogoria = request.getParameter("category");
            if (catogoria.length() > 0 && catogoria.length() <= 20){
                counter++;
            }

            Part part = request.getPart("image");
            String subpath;
            if (!part.getSubmittedFileName().isEmpty()) {
                String uploadPath = getServletContext().getRealPath("") + "\\images\\products";
                String imagepath = uploadPath + File.separator + part.getSubmittedFileName();
                part.write(imagepath);
                subpath = "images/products/" + part.getSubmittedFileName();
            }
            else {
                subpath = "images/products/nophoto.png";
            }

            String brand = request.getParameter("brand");
            if (brand.length() > 0 && brand.length() <= 30){
                counter++;
            }


            ProductDAO productDAO = new ProductDAO();

            if (counter == 7 && !productDAO.isAlreadyRegistered(nome, descrizione)) {
                ProductBean product = new ProductBean();

                product.setNome(nome);
                product.setDescrizione(descrizione);
                product.setPrezzo(Double.parseDouble(prezzo));
                product.setQuantita(Integer.parseInt(quantita));
                product.setSconto(Integer.parseInt(sconto));
                product.setCategoria(catogoria);
                product.setImmagine(subpath);
                product.setBrand(brand);

                productDAO.doSave(product);

                RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/administrator/amministratore.jsp");
                dispatcher.include(request, response);
            } else{
                if (productDAO.isAlreadyRegistered(nome, descrizione)) {
                    RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/administrator/addProduct.jsp");
                    request.setAttribute("msg", "Prodotto già presente");
                    dispatcher.include(request, response);
                } else {
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/error.jsp");
                    request.setAttribute("msg", "Errore durante l'inserimento inserimento");
                    dispatcher.include(request, response);
                }
            }
        } else {
            String address = "index.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(address);
            dispatcher.forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
