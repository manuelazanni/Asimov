package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CartDAO {

    public void doSave(int id_user, int id_product, int quantity) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Carrello VALUES (?,?,?)");

            ps.setInt(1, id_user);
            ps.setInt(2, id_product);
            ps.setInt(3, quantity);

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doDelete(int user) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM Carrello WHERE ID_Utente=?");

            ps.setInt(1, user);

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<ConnectionProductCart> getCart(int id_user) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT ID_Prodotto, Quantita FROM Carrello WHERE ID_Utente=?");

            ps.setInt(1, id_user);
            ResultSet rs = ps.executeQuery();

            ArrayList<ConnectionProductCart> products = new ArrayList<>();

            while (rs.next()) {

                ConnectionProductCart connection = new ConnectionProductCart();
                connection.setId_product(rs.getInt(1));
                connection.setQuantity(rs.getInt(2));
                products.add(connection);
            }

            return products;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
