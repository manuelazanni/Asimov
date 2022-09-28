package model;

import java.util.Calendar;
import java.util.GregorianCalendar;

public class PaymentBean {

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getCVV() {
        return CVV;
    }

    public void setCVV(String CVV) {
        this.CVV = CVV;
    }

    public String getNameUserCard() {
        return nameUserCard;
    }

    public void setNameUserCard(String nameUserCard) {
        this.nameUserCard = nameUserCard;
    }

    public String getExpiration() {
        return expiration.get(Calendar.YEAR) + "-"
                + ((expiration.get(Calendar.MONTH) + 1)) + "-"
                + (expiration.get(Calendar.DAY_OF_MONTH));
    }

    public void setExpiration(String expiration) {

        String[] dateSplit = expiration.split("-");

        int year = Integer.parseInt(dateSplit[0]);
        int month = Integer.parseInt(dateSplit[1]);
        int day = Integer.parseInt(dateSplit[2]);

        month--;

        this.expiration = new GregorianCalendar(year, month, day);
    }

    public String getDatePayment() {

        return datePayment.get(Calendar.YEAR) + "-"
                + ((datePayment.get(Calendar.MONTH) + 1)) + "-"
                + (datePayment.get(Calendar.DAY_OF_MONTH));
    }

    public void setDatePayment(String datePayment) {

        String[] dateSplit = datePayment.split("-");

        int year = Integer.parseInt(dateSplit[0]);
        int month = Integer.parseInt(dateSplit[1]);
        int day = Integer.parseInt(dateSplit[2]);

        month--;

        this.datePayment = new GregorianCalendar(year, month, day);
    }

    private int order;
    private String cardNumber, CVV, nameUserCard;
    private GregorianCalendar datePayment, expiration;
}
