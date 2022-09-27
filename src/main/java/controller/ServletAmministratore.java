package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.UserBean;

import java.io.IOException;

@WebServlet(name = "ServletAmministratore", value = "/ServletAmministratore")
public class ServletAmministratore extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String operazione = request.getParameter("pagina");
        UserBean user = (UserBean) request.getSession().getAttribute("user");

        System.out.println("");

        String indirizzo = null;

        if(operazione.compareToIgnoreCase("utenti") == 0){
            indirizzo = "WEB-INF/administrator/manageUser.jsp";
        }

        if(operazione.compareToIgnoreCase("amministratore") == 0){
            indirizzo = "WEB-INF/administrator/amministratore.jsp";
        }

        if(operazione.compareToIgnoreCase("prodotti") == 0){
            indirizzo = "WEB-INF/administrator/manageProduct.jsp";
        }

        if(operazione.compareToIgnoreCase("aggiungiProdotti") == 0){
            indirizzo = "WEB-INF/administrator/addProduct.jsp";
        }

        if(user != null && user.getAmministratore() == 1) {
            RequestDispatcher requestDispatcher = request.getRequestDispatcher(indirizzo);
            requestDispatcher.forward(request, response);
        } else{
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/error.jsp");
            request.setAttribute("msg", "Accesso non consentito!");
            request.setAttribute("redirect", "index.jsp");
            request.setAttribute("type", "alert");
            dispatcher.include(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
