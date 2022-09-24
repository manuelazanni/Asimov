package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.UserBean;
import model.UserDAO;

import java.io.IOException;
import java.nio.file.FileStore;

@WebServlet(name = "ServletChangeInfo", value = "/ServletChangeInfo")
public class ServletChangeInfo extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String telefono = request.getParameter("telefono");
        String citta = request.getParameter("citta");
        String provincia = request.getParameter("provincia");
        String indirizzo = request.getParameter("indirizzo");

        UserBean userBean = (UserBean) request.getSession().getAttribute("user");

        if(nome.length() > 0){
            userBean.setNome(nome);
        }

        if(cognome.length() > 0){
            userBean.setCognome(cognome);
        }

        if(username.length() > 0){
            userBean.setUsername(username);
        }

        if(email.length() > 0){
            userBean.setEmail(email);
        }

        if(password.length() > 0){
            userBean.setPassword(password);
        }

        if(telefono.length() > 0){
            userBean.setTelefono(telefono);
        }

        if(citta.length() > 0){
            userBean.setCitta(citta);
        }

        if(provincia.length() > 0){
            userBean.setProvincia(provincia);
        }

        if(indirizzo.length() > 0){
            userBean.setIndirizzo(indirizzo);
        }

        UserDAO userDAO = new UserDAO();
        userDAO.doUpdate(userBean);

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("account.jsp");
        requestDispatcher.include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
