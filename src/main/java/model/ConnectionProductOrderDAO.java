package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ConnectionProductOrderDAO {
    public void doSave(ConnectionProductOrder orderProductBean)
    {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Ordine_Prodotto VALUES (?,?,?,?)");

            ps.setInt(1, orderProductBean.getId_order());
            ps.setInt(2, orderProductBean.getId_product());
            ps.setInt(3, orderProductBean.getQuantity());
            ps.setDouble(4, orderProductBean.getPrice());

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<ConnectionProductOrder> doRetrieveById(int id) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * " +
                            "FROM Ordine_Prodotto " +
                            "WHERE ID_Ordine=?");

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            ArrayList<ConnectionProductOrder> products = new ArrayList<>();

            while (rs.next()) {
                ConnectionProductOrder product = new ConnectionProductOrder();
                product.setId_order(rs.getInt(1));
                product.setId_product(rs.getInt(2));
                product.setQuantity(rs.getInt(3));
                product.setPrice(rs.getDouble(4));
                products.add(product);
            }

            return products;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
