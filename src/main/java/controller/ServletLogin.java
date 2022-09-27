package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.CartBean;
import model.CartDAO;
import model.UserBean;
import model.UserDAO;

import java.io.IOException;

@WebServlet(name = "ServletLogin", value = "/ServletLogin")
public class ServletLogin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        UserBean userBean = userDAO.doRetrieveByEmailAndPassword(email, password);

        if(userBean != null){
            if(userBean.getSospeso() == 1){
                RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
                request.setAttribute("msg", "Il tuo account è momentaneamente sospeso.");
                dispatcher.forward(request, response);
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("user", userBean);
            CartBean cartBean = new CartBean();
            CartDAO cartDAO = new CartDAO();

            cartBean.setCartList(cartDAO.getCart(userBean.getId_utente()));
            session.setAttribute("cart", cartBean);

            request.getRequestDispatcher("/index.jsp").include(request, response);
        } else if(userBean == null){
            RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
            request.setAttribute("msg", "Email o password errati");
            dispatcher.include(request, response);
        } else{
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/error.jsp");
            request.setAttribute("type", "alert");
            request.setAttribute("msg", "Errore imprevisto");
            request.setAttribute("redirect", "login.jsp");
            dispatcher.include(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
