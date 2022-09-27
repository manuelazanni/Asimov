package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.ProductBean;
import model.ProductDAO;
import model.UserBean;
import model.UserDAO;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name = "ServletRemoveProduct", value = "/ServletRemoveProduct")
public class ServletRemoveProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");

        int id = Integer.parseInt(request.getParameter("id"));

        ProductDAO productDAO = new ProductDAO();
        ProductBean userBean = productDAO.doRetrieveById(id);

        productDAO.doDelete(userBean);

        ArrayList<ProductBean> listaProdottiAggiornata = productDAO.doRetrieveAll();

        JSONArray jsonArray = new JSONArray();

        for (ProductBean p: listaProdottiAggiornata) {
            JSONObject jsonProduct = new JSONObject();

            jsonProduct.put("id", p.getId());
            jsonProduct.put("nome", p.getNome());
            jsonProduct.put("descrizione", p.getDescrizione());
            jsonProduct.put("prezzo", p.getPrezzo());
            jsonProduct.put("quantita", p.getQuantita());
            jsonProduct.put("brand", p.getBrand());
            jsonProduct.put("sconto", p.getSconto());
            jsonProduct.put("categoria", p.getCategoria());

            jsonArray.put(jsonProduct);
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
