package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.CartBean;
import model.CartDAO;
import model.ConnectionProductCart;
import model.UserBean;

import java.io.IOException;

@WebServlet(name = "ServletRemoveFromCart", value = "/ServletRemoveFromCart")
public class ServletRemoveFromCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        int id_product = Integer.parseInt(request.getParameter("id_product"));

        HttpSession session = request.getSession();
        CartBean cartBean = (CartBean) session.getAttribute("cart");
        UserBean userBean = (UserBean) session.getAttribute("user");
        CartDAO cartDAO = new CartDAO();

        cartBean.removeProduct(id_product);

        if(userBean != null){
            cartDAO.doDelete(userBean.getId_utente());

            for(ConnectionProductCart connection : cartBean.getCartList()){
                cartDAO.doSave(userBean.getId_utente(), connection.getId_product(), connection.getQuantity());
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
