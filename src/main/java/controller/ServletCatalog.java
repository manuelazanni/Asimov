package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.ProductBean;
import model.ProductDAO;

import java.io.IOException;

@WebServlet(name = "ServletCatalog", value = "/ServletCatalog")
public class ServletCatalog extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        ProductDAO productDAO = new ProductDAO();
        ProductBean productBean = productDAO.doRetrieveById(id);

        request.setAttribute("product", productBean);
        String indirizzo = "productPage.jsp";
        RequestDispatcher requestDispatcher = request.getRequestDispatcher(indirizzo);
        requestDispatcher.include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
