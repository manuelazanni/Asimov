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
        System.out.println("sono qui");

        String scelta = request.getParameter("scelta");

        ProductDAO productDAO = new ProductDAO();
        ArrayList<ProductBean> listaProdotti = productDAO.doRetrieveAll();

        ArrayList<ProductBean> ordinato = new ArrayList<>();

        if(scelta.compareToIgnoreCase("prezzoCrescente") == 0){
            while(listaProdotti.size() != 0){
                ProductBean max = listaProdotti.get(0);

                for(ProductBean p : listaProdotti){
                    if(max.getPrezzo() < p.getPrezzo()){
                        max = p;
                    }
                }
                ordinato.add(max);
                listaProdotti.remove(max);
            }
        }

        if(scelta.compareToIgnoreCase("prezzoDecrescente") == 0){
            while(listaProdotti.size() != 0){
                ProductBean min = listaProdotti.get(0);

                for(ProductBean p : listaProdotti){
                    if(min.getPrezzo() > p.getPrezzo()){
                        min = p;
                    }
                }
                ordinato.add(min);
                listaProdotti.remove(min);
            }
        }

        JSONArray jsonArray = new JSONArray();

        System.out.println("sono qui 1");
        for (ProductBean product: ordinato) {
            System.out.println("sono qui 2");
            JSONObject jsonProduct = new JSONObject();

            ReviewDAO reviewDAO = new ReviewDAO();
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
            System.out.println("sono qui 3");
        }

        System.out.println("sono qui 4");
        PrintWriter out = response.getWriter();
        out.write(String.valueOf(jsonArray));
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
