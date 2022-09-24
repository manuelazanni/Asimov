package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "ServletAddToCart", value = "/ServletAddToCart")
public class ServletAddToCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<CartBean> list = new ArrayList<>();

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

        session.setAttribute("cart", cartBean);
        response.sendError(303);
        //request.getRequestDispatcher("WEB-INF/productAdded.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
