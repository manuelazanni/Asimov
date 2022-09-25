package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ServletGetCart", value = "/ServletGetCart")
public class ServletGetCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");

        HttpSession session = request.getSession();
        CartBean cartBean = (CartBean) session.getAttribute("cart");
        UserBean userBean = (UserBean) session.getAttribute("user");
        ProductDAO productDAO = new ProductDAO();

        if(userBean != null){

        }

        JSONArray jsonArray = new JSONArray();

        for(ConnectionProductCart connection : cartBean.getCartList()){
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
