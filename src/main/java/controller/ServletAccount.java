package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.UserBean;

import java.io.IOException;

@WebServlet(name = "ServletAccount", value = "/ServletAccount")
public class ServletAccount extends HttpServlet {
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

        dispatcher = request.getRequestDispatcher("/WEB-INF/account.jsp");
        dispatcher.include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
