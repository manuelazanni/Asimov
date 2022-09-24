package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ReviewDAO {

    public void doSave(int id_user, int id_product, ReviewBean review)
    {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Valutazione VALUES (?,?,?,?,?,?)");

            ps.setInt(2, id_user);
            ps.setInt(3, id_product);
            ps.setDouble(4, review.getPunteggio());
            ps.setString(5, review.getRecensione());
            ps.setString(6, review.getData());

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<ReviewBean> doRetrieveById(int id_product) {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * " +
                            "FROM Valutazione " +
                            "WHERE ID_Prodotto=?");

            ps.setInt(1, id_product);
            ArrayList<ReviewBean> reviewList = new ArrayList<>();

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ReviewBean reviewBean = new ReviewBean();

                reviewBean.setId_utente(rs.getInt(2));
                reviewBean.setId_prodotto(rs.getInt(3));
                reviewBean.setPunteggio(rs.getDouble(4));
                reviewBean.setRecensione(rs.getString(5));
                reviewBean.setData(rs.getString(6));

                reviewList.add(reviewBean);
            }

            return reviewList;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
