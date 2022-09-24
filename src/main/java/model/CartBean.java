package model;

import java.util.ArrayList;

public class CartBean {

    public CartBean() {
        this.cartList = new ArrayList<>();
        this.numberObject = 0;
    }

    public int getNumberObject() {
        return numberObject;
    }

    public void setNumberObject(int numberObject) {
        this.numberObject = numberObject;
    }

    public ArrayList<ConnectionProductCart> getCartList() {
        return cartList;
    }

    public void setCartList(ArrayList<ConnectionProductCart> cartList) {
        this.cartList = cartList;

        for (ConnectionProductCart connection: cartList)
            this.numberObject += connection.getQuantity();
    }

    public void addProduct(int id_product, int quantity) {
        this.numberObject += quantity;
        boolean flag = false;

        for (ConnectionProductCart connection : cartList) {

            if (connection.getId_product() == id_product) {
                flag = true;
                int value = (connection.getQuantity() + quantity);
                connection.setQuantity(value);
            }
        }

        if (!flag) {
            ConnectionProductCart connection = new ConnectionProductCart();
            connection.setId_product(id_product);
            connection.setQuantity(quantity);
            this.cartList.add(connection);
        }
    }

    //remove

    private int numberObject;
    private ArrayList<ConnectionProductCart> cartList;
}
