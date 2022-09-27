package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class NewsDAO {
    public ArrayList<NewsBean> doRetrieveAll() {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM News");

            ArrayList<NewsBean> listaNews = new ArrayList<>();
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                NewsBean news = new NewsBean();

                news.setTitolo(rs.getString(2));
                news.setTesto(rs.getString(3));

                listaNews.add(news);
            }

            return listaNews;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
