package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public void doSave(ProductBean productBean) {

        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Prodotto (Nome, Descrizione, Prezzo, Quantita, Path_Immagine, Brand, Sconto, Nome_Categoria) VALUES(?,?,?,?,?,?,?,?)",
                    Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, productBean.getNome());
            ps.setString(2, productBean.getDescrizione());
            ps.setDouble(3, productBean.getPrezzo());
            ps.setInt(4, productBean.getQuantita());
            ps.setString(5, productBean.getImmagine());
            ps.setString(6, productBean.getBrand());
            ps.setInt(7, productBean.getSconto());
            ps.setString(8, productBean.getCategoria());


            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

            ResultSet rs = ps.getGeneratedKeys();
            rs.next();
            int id = rs.getInt(1);
            productBean.setId(id);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doDelete(ProductBean userBean) {

        try (Connection con = ConPool.getConnection()) {

            Statement st = con.createStatement();
            String query = "SET foreign_key_checks = 0";
            String query2 = "DELETE FROM Prodotto WHERE ID_Prodotto = " + userBean.getId();
            st.executeUpdate(query);
            st.executeUpdate(query2);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

     /*
    public void doUpdate(ProductBean productBean)
    {
        try (Connection con = ConPool.getConnection()) {

            Statement st = con.createStatement();
            String query = "UPDATE Prodotto SET Nome = '" + productBean.getNome() + "', Descrizione = '" + productBean.getDescrizione() + "', Prezzo = '" +
                    productBean.getPrezzo() + "', Quantita = '" + productBean.getQuantita() + "', Path_Immagine = '" +
                    productBean.getImmagine() +  "', ID_Categoria = '" + productBean.getCategoria() + "'WHERE ID_Prodotto = " + productBean.getId();
            st.executeUpdate(query);

            st.executeUpdate(query);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    } */

    public ProductBean doRetrieveById(int id_product) {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * " +
                            "FROM Prodotto " +
                            "WHERE ID_Prodotto=?");

            ps.setInt(1, id_product);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ProductBean prodotto = new ProductBean();

                prodotto.setId(rs.getInt(1));
                prodotto.setNome(rs.getString(2));
                prodotto.setDescrizione(rs.getString(3));
                prodotto.setPrezzo(rs.getDouble(4));
                prodotto.setQuantita(rs.getInt(5));
                prodotto.setImmagine(rs.getString(6));
                prodotto.setBrand(rs.getString(7));
                prodotto.setSconto(rs.getInt(8));
                prodotto.setCategoria(rs.getString(9));

                return prodotto;
            }

            return null;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<ProductBean> doRetrieveAll() {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM Prodotto");

            ArrayList<ProductBean> listaProdotti = new ArrayList<>();
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                ProductBean prodotto = new ProductBean();

                prodotto.setId(rs.getInt(1));
                prodotto.setNome(rs.getString(2));
                prodotto.setDescrizione(rs.getString(3));
                prodotto.setPrezzo(rs.getDouble(4));
                prodotto.setQuantita(rs.getInt(5));
                prodotto.setImmagine(rs.getString(6));
                prodotto.setBrand(rs.getString(7));
                prodotto.setSconto(rs.getInt(8));
                prodotto.setCategoria(rs.getString(9));

                listaProdotti.add(prodotto);
            }

            return listaProdotti;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<ProductBean> doRetrieveByBrand(String brand) {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT *" +
                    " FROM Prodotto" + " WHERE Brand = ?");

            ps.setString(1, brand);

            ArrayList<ProductBean> listaProdotti = new ArrayList<>();
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                ProductBean prodotto = new ProductBean();

                prodotto.setId(rs.getInt(1));
                prodotto.setNome(rs.getString(2));
                prodotto.setDescrizione(rs.getString(3));
                prodotto.setPrezzo(rs.getDouble(4));
                prodotto.setQuantita(rs.getInt(5));
                prodotto.setImmagine(rs.getString(6));
                prodotto.setBrand(rs.getString(7));
                prodotto.setSconto(rs.getInt(8));
                prodotto.setCategoria(rs.getString(9));

                listaProdotti.add(prodotto);
            }

            return listaProdotti;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<ProductBean> doRetrieveByFilter(int minPrice, int maxPrice, String category) {
        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps;

            if (category.equalsIgnoreCase("Tutte le opzioni")) {
                ps = con.prepareStatement("SELECT *" +
                        " FROM Prodotto" + " WHERE Prezzo >= ? AND Prezzo <= ?");

                ps.setInt(1, minPrice);
                ps.setInt(2, maxPrice);
            } else {
                ps = con.prepareStatement(
                        "SELECT * " +
                                "FROM Prodotto " +
                                "WHERE Prezzo >= ? AND Prezzo <= ? AND Nome_categoria = ?");

                ps.setInt(1, minPrice);
                ps.setInt(2, maxPrice);
                ps.setString(3, category);
            }

            ArrayList<ProductBean> listaProdotti = new ArrayList<ProductBean>();
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                ProductBean prodotto = new ProductBean();

                prodotto.setId(rs.getInt(1));
                prodotto.setNome(rs.getString(2));
                prodotto.setDescrizione(rs.getString(3));
                prodotto.setPrezzo(rs.getDouble(4));
                prodotto.setQuantita(rs.getInt(5));
                prodotto.setImmagine(rs.getString(6));
                prodotto.setBrand(rs.getString(7));
                prodotto.setSconto(rs.getInt(8));
                prodotto.setCategoria(rs.getString(9));

                listaProdotti.add(prodotto);
            }

            return listaProdotti;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean isAlreadyRegistered(String name, String description) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * " +
                            "FROM Prodotto " +
                            "WHERE Nome=? AND Descrizione=?");

            ps.setString(1, name);
            ps.setString(2, description);

            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
