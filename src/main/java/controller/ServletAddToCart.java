package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name = "ServletAddToCart", value = "/ServletAddToCart")
public class ServletAddToCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");

        int id_product = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        HttpSession session = request.getSession();
        ProductDAO productDAO = new ProductDAO();
        CartBean cartBean = (CartBean) session.getAttribute("cart");
        CartDAO cartDAO = new CartDAO();
        UserBean user = (UserBean) session.getAttribute("user");
        ProductBean productBean = productDAO.doRetrieveById(id_product);

        if(cartBean == null){
            cartBean = new CartBean();
        }

        if(productBean.getQuantita() >= quantity){
            cartBean.addProduct(id_product, quantity);
        } else{
            response.sendError(400);
        }

        if(user != null){
            cartDAO.doDelete(user.getId_utente());

            for(ConnectionProductCart connection : cartBean.getCartList()){
                cartDAO.doSave(user.getId_utente(), connection.getId_product(), connection.getQuantity());
            }
        }

        JSONArray jsonArray = new JSONArray();

        for (ConnectionProductCart connection: cartBean.getCartList()) {
            JSONObject jsonProduct = new JSONObject();

            ProductBean p = productDAO.doRetrieveById(connection.getId_product());

            jsonProduct.put("id", p.getId());
            jsonProduct.put("nome", p.getNome());
            jsonProduct.put("qty", connection.getQuantity());
            jsonProduct.put("img", p.getImmagine());
            jsonProduct.put("price", p.getPrezzo() * connection.getQuantity());

            jsonArray.put(jsonProduct);
        }

        session.setAttribute("cart", cartBean);

        PrintWriter out = response.getWriter();
        out.write(String.valueOf(jsonArray));
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
