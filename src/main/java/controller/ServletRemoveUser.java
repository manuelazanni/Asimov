package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.ConnectionProductCart;
import model.ProductBean;
import model.UserBean;
import model.UserDAO;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name = "ServletRemoveUser", value = "/ServletRemoveUser")
public class ServletRemoveUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");

        int id = Integer.parseInt(request.getParameter("id"));

        UserDAO userDAO = new UserDAO();
        UserBean user = userDAO.doRetrieveById(id);

        userDAO.doDelete(user);

        ArrayList<UserBean> listaUtentiAggiornata = userDAO.doRetrieveAll();

        JSONArray jsonArray = new JSONArray();

        for (UserBean u: listaUtentiAggiornata) {
            JSONObject jsonUser = new JSONObject();

            jsonUser.put("id", u.getId_utente());
            jsonUser.put("nome", u.getNome());
            jsonUser.put("cognome", u.getCognome());
            jsonUser.put("email", u.getEmail());
            jsonUser.put("amministratore", u.getAmministratore());
            jsonUser.put("sospeso", u.getSospeso());

            jsonArray.put(jsonUser);
        }

        PrintWriter out = response.getWriter();
        out.write(String.valueOf(jsonArray));
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
