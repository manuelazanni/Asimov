package model;

import java.util.Calendar;
import java.util.GregorianCalendar;

public class ReviewBean {

    public ReviewBean() {}

    public String getRecensione() {
        return recensione;
    }

    public void setRecensione(String recensione) {
        this.recensione = recensione;
    }

    public double getPunteggio() {
        return punteggio;
    }

    public void setPunteggio(double punteggio) {
        this.punteggio = punteggio;
    }

    public String getData() {
        return (data.get(Calendar.YEAR)) + "-" +
                (data.get(Calendar.MONTH)+1) + "-" +
                (data.get(Calendar.DAY_OF_MONTH));
    }

    public void setData(String data) {
        if(data.length()>0){
            String[] dataSplit = data.split("-");

            int anno = Integer.parseInt(dataSplit[0]);
            int mese = Integer.parseInt(dataSplit[1])-1;
            int giorno = Integer.parseInt(dataSplit[2]);

            this.data = new GregorianCalendar(anno, mese, giorno);
        } else{
            this.data = new GregorianCalendar(2000, 0, 1);
        }
    }

    public int getId_utente() {
        return id_utente;
    }

    public void setId_utente(int id_utente) {
        this.id_utente = id_utente;
    }

    public int getId_prodotto() {
        return id_prodotto;
    }

    public void setId_prodotto(int id_prodotto) {
        this.id_prodotto = id_prodotto;
    }

    private String recensione;
    private double punteggio;
    private int id_utente;
    private int id_prodotto;
    private GregorianCalendar data;
}
