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
        response.setContentType("text/html");

        final Pattern patternGenerale = Pattern.compile("^([a-zA-Z\\xE0\\xE8\\xE9\\xF9\\xF2\\xEC\\x27]\\s?){2,20}$");
        final Pattern patternUsername = Pattern.compile("/^[A-Za-z][A-Za-z0-9_]{1,19}$/");
        final Pattern patternEmail = Pattern.compile("^[a-zA-Z\\d._%-]+@[a-zA-Z\\d.-]+\\.[a-zA-Z]{2,20}$");
        final Pattern patternPassword = Pattern.compile("^[a-zA-Z\\d\\-\\xE0\\xE8\\xE9\\xF9\\xF2\\xEC\\x27]{6,16}");

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        int counter = 0;
        UserDAO userDAO = new UserDAO();
        HttpSession session = request.getSession();

        Matcher matcher = patternGenerale.matcher(nome);
        boolean matchFound = matcher.find();
        if (matchFound){
            counter++;
        }

        matcher = patternGenerale.matcher(cognome);
        matchFound = matcher.find();
        if (matchFound){
            counter++;
        }

        matcher = patternUsername.matcher(username);
        matchFound = matcher.find();
        if (matchFound){
            counter++;
        }

        matcher = patternEmail.matcher(email);
        matchFound = matcher.find();
        if (matchFound){
            counter++;
        }

        matcher = patternPassword.matcher(password);
        matchFound = matcher.find();
        if (matchFound){
            counter++;
        }


        if(counter == 5 && !(userDAO.isRegistered(email))){

            UserBean user = new UserBean();

            user.setNome(nome);
            user.setCognome(cognome);
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);

            userDAO.doSave(user);

            session.setAttribute("user", user);
            request.getRequestDispatcher("/index.jsp").include(request, response);
        } else if(userDAO.isRegistered(email)){
            RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
            request.setAttribute("msg", "Email già in uso.");
            dispatcher.include(request, response);
        } else{
            RequestDispatcher dispatcher = request.getRequestDispatcher("/signup.jsp");
            request.setAttribute("msg", "Errore durante la registrazione.");
            dispatcher.include(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
