package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.UserBean;
import model.UserDAO;

import java.io.IOException;

@WebServlet(name = "ServletDeleteAccount", value = "/ServletDeleteAccount")
public class ServletDeleteAccount extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        UserBean userBean = (UserBean) request.getSession().getAttribute("user");

        RequestDispatcher dispatcher;

        if(userBean == null){
            dispatcher = request.getRequestDispatcher("/WEB-INF/error.jsp");
            request.setAttribute("msg", "Il profilo non esiste.");
            request.setAttribute("redirect", "index.jsp");
            dispatcher.include(request, response);
        }

        userDAO.doDelete(userBean);

        HttpSession session = request.getSession(false);
        session.invalidate();

        dispatcher = request.getRequestDispatcher("/WEB-INF/success.jsp");
        request.setAttribute("msg", "Profilo eliminato correttamente!");
        dispatcher.include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
