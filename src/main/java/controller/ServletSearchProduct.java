package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.ProductBean;
import model.ProductDAO;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Locale;

@WebServlet(name = "ServletSearchProduct", value = "/ServletSearchProduct")
public class ServletSearchProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        String field = request.getParameter("searchBar");

        ProductDAO productDAO = new ProductDAO();
        ArrayList<ProductBean> productList = productDAO.doRetrieveAll();
        ArrayList<ProductBean> productFind = new ArrayList<>();

        for(ProductBean p : productList){
            if(p.getDescrizione().toLowerCase().contains(field.toLowerCase()) ||
                p.getNome().toLowerCase().contains(field.toLowerCase()) ||
                    p.getBrand().toLowerCase().contains(field.toLowerCase())){
                        productFind.add(p);
            }
        }

        HttpSession session = request.getSession();
        session.setAttribute("productFind", productFind);
        session.setAttribute("field", field);
        response.sendRedirect("searchResult.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
