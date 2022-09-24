package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.ProductBean;
import model.ProductDAO;
import model.ReviewBean;
import model.ReviewDAO;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name = "ServletFilter", value = "/ServletFilter")
public class ServletFilter extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");

        int minPrice = Integer.parseInt(request.getParameter("min"));
        int maxPrice = Integer.parseInt(request.getParameter("max"));
        String category = request.getParameter("category");

        if (maxPrice < minPrice){
            maxPrice = minPrice;
        }

        ProductDAO productDAO = new ProductDAO();
        ArrayList<ProductBean> productList = productDAO.doRetrieveByFilter(minPrice, maxPrice, category);
        ReviewDAO reviewDAO = new ReviewDAO();

        JSONArray jsonArray = new JSONArray();

        for (ProductBean product: productList) {
            JSONObject jsonProduct = new JSONObject();

            ArrayList<ReviewBean> reviewBean = reviewDAO.doRetrieveById(product.getId());
            double sommaPunteggi = 0;
            int counter = 0;

            for (ReviewBean r : reviewBean) {
                counter++;
                sommaPunteggi += r.getPunteggio();
            }

            int stelle = (int) sommaPunteggi/counter;


            jsonProduct.put("id", product.getId());
            jsonProduct.put("nome", product.getNome());
            jsonProduct.put("descrizione", product.getDescrizione());
            jsonProduct.put("prezzo", product.getPrezzo());
            jsonProduct.put("quantita", product.getQuantita());
            jsonProduct.put("immagine", product.getImmagine());
            jsonProduct.put("brand", product.getBrand());
            jsonProduct.put("sconto", product.getSconto());
            jsonProduct.put("punteggio", stelle);
            jsonProduct.put("categoria", product.getCategoria());

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
