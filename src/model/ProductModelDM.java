package model;

import beans.ProductBean;
import components.DriverManagerConnectionPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

public class ProductModelDM extends ProductBean {


    public ProductBean doRetrieveByKey(String code) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        ProductBean bean = new ProductBean();

        String selectSQL = "SELECT * FROM product WHERE code = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, Integer.parseInt(code));

            System.out.println("doRetrieveByKey: "+ preparedStatement.toString());
            ResultSet rs = preparedStatement.executeQuery();

            while(rs.next()) {
                bean.setCodice(rs.getInt("code"));
                bean.setNome(rs.getString("name"));
                bean.setDescrizione(rs.getString("description"));
                bean.setPrezzo(rs.getInt("price"));
            }

            System.out.println(bean);
        } finally {
            try {
                if(preparedStatement != null)
                    preparedStatement.close();
            } finally {
                DriverManagerConnectionPool.releaseConnection(connection);
            }
        }

        return bean;
    }


    public Collection<ProductBean> doRetrieveAll(String order) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        Collection<ProductBean> products = new LinkedList<ProductBean>();

        String selectSQL = "SELECT * FROM product";

        if(order != null && !order.equals("")) {
            selectSQL += " ORDER BY " + order;
        }

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);

            System.out.println("doRetrieveAll:" + preparedStatement.toString());
            ResultSet rs = preparedStatement.executeQuery();

            while(rs.next()) {
                ProductBean bean = new ProductBean();

                bean.setCodice(rs.getInt("code"));
                bean.setNome(rs.getString("name"));
                bean.setDescrizione(rs.getString("description"));
                bean.setPrezzo(rs.getInt("price"));


                products.add(bean);
            }
        } finally {
            try {
                if(preparedStatement != null)
                    preparedStatement.close();
            } finally {
                DriverManagerConnectionPool.releaseConnection(connection);
            }
        }

        return products;
    }


    public void doSave(ProductBean product) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String insertSQL = "INSERT INTO product" +
                " (name, description, price) VALUES (?, ?, ?)";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);

            preparedStatement.setString(1, product.getNome());
            preparedStatement.setString(2, product.getDescrizione());
            preparedStatement.setInt(3, (int) product.getPrezzo());


            System.out.println("doSave: "+ preparedStatement.toString());
            preparedStatement.executeUpdate();

            connection.commit();

        } finally {
            try {
                if(preparedStatement != null)
                    preparedStatement.close();
            } finally {
                DriverManagerConnectionPool.releaseConnection(connection);
            }
        }
    }


    public void doUpdate(ProductBean product) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String updateSQL = "UPDATE product SET " +
                " name = ?, description = ?, price = ?, quantity = ? WHERE code = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(updateSQL);

            preparedStatement.setString(1, product.getNome());
            preparedStatement.setString(2, product.getDescrizione());
            preparedStatement.setInt(3, (int) product.getPrezzo());


            preparedStatement.setInt(5, product.getCodice());

            System.out.println("doUpdate: "+ preparedStatement.toString());
            preparedStatement.executeUpdate();

            connection.commit();

        } finally {
            try {
                if(preparedStatement != null)
                    preparedStatement.close();
            } finally {
                DriverManagerConnectionPool.releaseConnection(connection);
            }
        }
    }


    public void doDelete(ProductBean product) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String deleteSQL = "DELETE FROM product WHERE code = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(deleteSQL);
            preparedStatement.setInt(1, product.getCodice());

            System.out.println("doDelete: "+ preparedStatement.toString());
            preparedStatement.executeUpdate();

            connection.commit();

        } finally {
            try {
                if(preparedStatement != null)
                    preparedStatement.close();
            } finally {
                DriverManagerConnectionPool.releaseConnection(connection);
            }
        }
    }

}