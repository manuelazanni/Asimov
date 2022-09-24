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

        userDAO.doDelete(userBean);

        HttpSession session = request.getSession(false);
        session.invalidate();

        String indirizzo = "successDelete.jsp";
        RequestDispatcher requestDispatcher = request.getRequestDispatcher(indirizzo);
        requestDispatcher.include(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
