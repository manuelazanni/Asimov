package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;

import java.io.IOException;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "ServletPayment", value = "/ServletPayment")
public class ServletPayment extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        HttpSession session = request.getSession();
        UserBean userBean = (UserBean) session.getAttribute("user");
        RequestDispatcher dispatcher;

        if (userBean == null) {

            dispatcher = request.getRequestDispatcher("/WEB-INF/error.jsp");
            request.setAttribute("msg", "Attenzione! Prima di continuare devi effettuare l'accesso.");
            request.setAttribute("redirect", "login.jsp");
            dispatcher.include(request, response);
        } else{
            CartBean cartBean = (CartBean) session.getAttribute("cart");
            ProductDAO productDAO = new ProductDAO();
            double totale = 0;

            for(ConnectionProductCart connection : cartBean.getCartList()){
                ProductBean product = productDAO.doRetrieveById(connection.getId_product());

                if(product.getSconto() == 0){
                    totale = totale + (product.getPrezzo() * connection.getQuantity());
                } else{
                    totale = totale + (product.getPrezzo() - ((product.getPrezzo() * product.getSconto())/100)) * connection.getQuantity();
                }

                if(connection.getQuantity() > product.getQuantita()){
                    dispatcher = request.getRequestDispatcher("/WEB-INF/error.jsp");
                    request.setAttribute("msg", "La quantità da te richiesta per il prodotto \"" + product.getNome() + "\" è superiore alla quantità presente in magazzino.<br>(Quantità disponibile: " + connection.getQuantity() + ")");
                    request.setAttribute("redirect", request.getContextPath() + "/cart.jsp");
                    dispatcher.include(request, response);
                    break;
                }
            }

            request.setAttribute("totale", String.format("%.2f", totale));
            session.setAttribute("totale", totale);
            dispatcher = request.getRequestDispatcher("/WEB-INF/payment.jsp");
            dispatcher.include(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        /*
        final Pattern patternNumber =  Pattern.compile("^\\d+$");
        final Pattern patternPossessore =  Pattern.compile("^([a-zA-Z\\\\xE0\\xE8\\xE9\\xF9\\xF2\\xEC\\x27]\\s?){2,255}$");

        int counter = 0;

        HttpSession session = request.getSession();

        String numeroCarta = request.getParameter("numeroCarta");
        Matcher matcher = patternNumber.matcher(numeroCarta);
        boolean matchFound = matcher.find();
        if (numeroCarta.length() == 16  && matchFound){
            counter++;
        }

        String cvv = request.getParameter("cvv");
        matcher = patternNumber.matcher(cvv);
        matchFound = matcher.find();
        if (cvv.length() == 3 && matchFound){
            counter++;
        }

        String exp = request.getParameter("scadenza");
        GregorianCalendar today = new GregorianCalendar();
        String[] dateSplit = exp.split("-");
        int year = Integer.parseInt(dateSplit[0]);
        int month = Integer.parseInt(dateSplit[1]);
        int day = Integer.parseInt(dateSplit[2]);
        month--;
        GregorianCalendar expCalendar = new GregorianCalendar(year, month, day);
        if (expCalendar.after(today)){
            counter++;
        }

        String possessore = request.getParameter("titolare");
        matcher = patternPossessore.matcher(possessore);
        matchFound = matcher.find();
        if (matchFound){
            counter++;
        }*/

        //if (counter == 4) {
        HttpSession session = request.getSession();
            UserBean user = new UserBean();
            user = (UserBean) session.getAttribute("user");

            OrderBean order = new OrderBean();
            order.setId_user(user.getId_utente());
            order.setTotal((Double) session.getAttribute("totale"));

            OrderDAO orderDAO = new OrderDAO();
            int orderId = orderDAO.doSave(order);

            CartBean cart = (CartBean) session.getAttribute("cart");

            ProductDAO productDAO = new ProductDAO();

            for (ConnectionProductCart connectionPC : cart.getCartList()) {

                ConnectionProductOrder connectionPO = new ConnectionProductOrder();
                connectionPO.setId_product(connectionPC.getId_product());
                connectionPO.setQuantity(connectionPC.getQuantity());
                connectionPO.setPrice(productDAO.doRetrieveById(connectionPC.getId_product()).getPrezzo());
                connectionPO.setId_order(orderId);

                ConnectionProductOrderDAO connectionProductOrderDAO = new ConnectionProductOrderDAO();
                connectionProductOrderDAO.doSave(connectionPO);

                ProductBean productBean = productDAO.doRetrieveById(connectionPC.getId_product());
                productBean.setQuantita(productBean.getQuantita() - connectionPC.getQuantity());
                productDAO.doUpdate(productBean);
            }

            PaymentBean payment = new PaymentBean();

            payment.setOrder(orderId);
            payment.setDatePayment("2022-09-28");
            payment.setCardNumber("1234567891123456");
            payment.setCVV("123");
            payment.setExpiration("2025-09-28");
            payment.setNameUserCard("Giovanni");

            PaymentDAO paymentDAO = new PaymentDAO();
            paymentDAO.doSave(payment);

            CartDAO cartDAO = new CartDAO();
            cartDAO.doDelete(user.getId_utente());
            cart.setCartList(cartDAO.getCart(user.getId_utente()));
            cart.setNumberObject(0);
            session.setAttribute("cart", cart);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/success.jsp");
            request.setAttribute("msg", "Ordine confermato");
            request.setAttribute("redirect", request.getContextPath() + "/index.jsp");
            dispatcher.include(request, response);
        } //else {

           // RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/error.jsp");
          //  request.setAttribute("msg", "Ricontrollare i campi!");
          //  request.setAttribute("redirect", request.getContextPath() + "/payment-servlet");
           // dispatcher.include(request, response);
        //}
   // }
}
