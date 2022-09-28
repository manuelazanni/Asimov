package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.ProductBean;
import model.ProductDAO;
import model.UserBean;
import model.UserDAO;

import java.io.File;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "ServletEditProduct", value = "/ServletEditProduct")
public class ServletEditProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserBean userBean = (UserBean) request.getSession().getAttribute("user");

        RequestDispatcher dispatcher;

        if(userBean == null){
            dispatcher = request.getRequestDispatcher("/WEB-INF/error.jsp");
            request.setAttribute("msg", "Il profilo non esiste.");
            request.setAttribute("redirect", "index.jsp");
            dispatcher.include(request, response);
        }

        dispatcher = request.getRequestDispatcher("/WEB-INF/administrator/editProduct.jsp");
        dispatcher.include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        HttpSession session = request.getSession();
        UserBean user = (UserBean) request.getSession().getAttribute("user");

        RequestDispatcher dispatcher;

        if(user == null){
            dispatcher = request.getRequestDispatcher("/WEB-INF/error.jsp");
            request.setAttribute("msg", "Prima di continuare devi effettuare il login.");
            request.setAttribute("redirect", "login.jsp");
            dispatcher.include(request, response);
        }

        int id = Integer.parseInt(request.getParameter("id"));

        if(user.getAmministratore() == 1){
            String nome = request.getParameter("name");
            String descrizione = request.getParameter("description");
            String prezzo = request.getParameter("price").replace(",", ".");
            String quantita = request.getParameter("quantity");
            String sconto = request.getParameter("sales");
            String catogoria = request.getParameter("category");
            String brand = request.getParameter("brand");

            ProductDAO productDAO = new ProductDAO();

            ProductBean product = new ProductBean();

            product.setId(id);
            product.setNome(nome);
            product.setDescrizione(descrizione);
            product.setPrezzo(Double.parseDouble(prezzo));
            product.setQuantita(Integer.parseInt(quantita));
            product.setSconto(Integer.parseInt(sconto));
            product.setCategoria(catogoria);
            product.setBrand(brand);

            productDAO.doUpdate(product);

            dispatcher = request.getRequestDispatcher("WEB-INF/administrator/amministratore.jsp");
            dispatcher.include(request, response);
        } else {
            dispatcher = request.getRequestDispatcher("/WEB-INF/error.jsp");
            request.setAttribute("msg", "Impossibile modificare il prodotto.");
            request.setAttribute("redirect", "index.jsp");
            dispatcher.include(request, response);
        }
    }
}
