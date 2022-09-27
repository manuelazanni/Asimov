package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@WebServlet(name = "ServletOrderProduct", value = "/ServletOrderProduct")
public class ServletOrderProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");

        String scelta = request.getParameter("scelta");

        ProductDAO productDAO = new ProductDAO();
        ArrayList<ProductBean> listaProdotti = productDAO.doRetrieveAll();

        JSONArray jsonArray = new JSONArray();

        if(scelta.compareToIgnoreCase("prezzoCrescente") == 0){
            while(listaProdotti.size() != 0){
                ProductBean max = listaProdotti.get(0);

                for(ProductBean p : listaProdotti){
                    if(max.getPrezzo() < p.getPrezzo()){
                        max = p;
                    }
                }

                ReviewDAO reviewDAO = new ReviewDAO();
                ArrayList<ReviewBean> reviewBean = reviewDAO.doRetrieveById(max.getId());
                int stelle = 0;
                if(reviewBean.size() > 0) {
                    double sommaPunteggi = 0;

                    for (ReviewBean r : reviewBean) {
                        sommaPunteggi += r.getPunteggio();
                    }

                    stelle = (int) sommaPunteggi / reviewBean.size();
                }

                JSONObject jsonProduct = new JSONObject();


                jsonProduct.put("id", max.getId());
                jsonProduct.put("nome", max.getNome());
                jsonProduct.put("descrizione", max.getDescrizione());
                jsonProduct.put("prezzo", max.getPrezzo());
                jsonProduct.put("quantita", max.getQuantita());
                jsonProduct.put("immagine", max.getImmagine());
                jsonProduct.put("brand", max.getBrand());
                jsonProduct.put("sconto", max.getSconto());
                jsonProduct.put("punteggio", stelle);
                jsonProduct.put("categoria", max.getCategoria());

                listaProdotti.remove(max);
                jsonArray.put(jsonProduct);
            }
        }  else{
            while(listaProdotti.size() != 0){
                ProductBean min = listaProdotti.get(0);

                for(ProductBean p : listaProdotti){
                    if(min.getPrezzo() > p.getPrezzo()){
                        min = p;
                    }
                }

                JSONObject jsonProduct = new JSONObject();

                jsonProduct.put("id", min.getId());
                jsonProduct.put("nome", min.getNome());
                jsonProduct.put("descrizione", min.getDescrizione());
                jsonProduct.put("prezzo", min.getPrezzo());
                jsonProduct.put("quantita", min.getQuantita());
                jsonProduct.put("immagine", min.getImmagine());
                jsonProduct.put("brand", min.getBrand());
                jsonProduct.put("sconto", min.getSconto());
                jsonProduct.put("categoria", min.getCategoria());

                listaProdotti.remove(min);
                jsonArray.put(jsonProduct);
            }
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
