package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class FavouriteDAO {

    public void doSave(int id_user, int id_product)
    {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Preferiti VALUES (?,?)");

            ps.setInt(1, id_user);
            ps.setInt(2, id_product);

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<ProductBean> doRetrieveAll(int id_utente) {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * " +
                            "FROM Preferiti " +
                            "WHERE ID_Utente=?");

            ps.setInt(1, id_utente);

            ResultSet rs = ps.executeQuery();

            ArrayList<ProductBean> preferiti = new ArrayList<>();
            ProductDAO productDAO = new ProductDAO();

            while (rs.next()) {
                ProductBean product = productDAO.doRetrieveById(rs.getInt(2));

                preferiti.add(product);
            }

            return preferiti;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
