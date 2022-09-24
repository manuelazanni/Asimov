package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.UserBean;
import model.UserDAO;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "ServletRegistrazione", value = "/ServletRegistrazione")
public class ServletRegistrazione extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String dataNascita = request.getParameter("dataNascita");

        UserBean user = new UserBean();
        user.setNome(nome);
        user.setCognome(cognome);
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setDataNascita(dataNascita);

        UserDAO userDAO = new UserDAO();
        userDAO.doSave(user);

        HttpSession session = request.getSession();

        session.setAttribute("user", user);
        request.getRequestDispatcher("/index.jsp").include(request, response);
    }
}
