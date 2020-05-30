package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import beans.LocaleBean;
import components.DriverManagerConnectionPool;

public class LocaleModel {

    private static final String TAB_NAME = "negozio"; //Nome tabella in DB
    public String db;
    public String username;
    public String password;

    public LocaleModel(String db, String username, String password) {

        this.db = db;
        this.username = username;
        this.password = password;
    }

    //Genera query INSERT per salvare un nuovo elemento all'interno del DB
    public synchronized void doSave(LocaleBean negozio) throws SQLException {

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String insertSQL = "INSERT INTO " + LocaleModel.TAB_NAME
                + " VALUES (?, ?, ?, ?, ?, ?)";

        try {
            connection = DriverManagerConnectionPool.getConnection(db, username, password);
            preparedStatement = connection.prepareStatement(insertSQL);
            preparedStatement.setInt(1, negozio.getCodice());
            preparedStatement.setString(2, negozio.getNome());
            preparedStatement.setString(3, negozio.getVia());
            preparedStatement.setString(4, negozio.getCitta());
            preparedStatement.setInt(5, negozio.getCap());
            preparedStatement.setString(6, negozio.getTelefono());
            System.out.println(preparedStatement.toString());

            preparedStatement.executeUpdate();

            connection.commit();
        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                DriverManagerConnectionPool.releaseConnection(connection);
            }
        }
    }


    //Genera query DELETE per eliminare la riga identificata da 'code' all'interno del DB
    public synchronized boolean doDeleteInt(int code)
            throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        int result = 0;

        String deleteSQL = "DELETE FROM " + LocaleModel.TAB_NAME + " WHERE Codice = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection(db, username, password);
            preparedStatement = connection.prepareStatement(deleteSQL);
            preparedStatement.setInt(1, code);

            result = preparedStatement.executeUpdate();
            connection.commit();
        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                DriverManagerConnectionPool.releaseConnection(connection);
            }
        }
        return (result != 0);

    }

    //Genera query SELECT per ricevere i dati in base a quella determinata key
    public synchronized LocaleBean doRetrieveNegozioByKey(int code) throws SQLException {

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        LocaleBean bean = new LocaleBean();

        String selectSQL = "SELECT * FROM " + LocaleModel.TAB_NAME + " WHERE Codice = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection(db, username, password);
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, code);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                bean.setCodice(rs.getInt("Codice"));
                bean.setNome(rs.getString("nome"));
                bean.setVia(rs.getString("Via"));
                bean.setCitta(rs.getString("Citta"));
                bean.setCap(rs.getInt("CAP"));
                bean.setTelefono(rs.getString("telefono"));

            }

        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                DriverManagerConnectionPool.releaseConnection(connection);
            }
        }
        return bean;
    }


    //genera query SELECT * per prendere tutte le righe dal DB in un certo ordine
    public synchronized Collection<LocaleBean> doRetrieveAllNegozi(String order) throws SQLException {

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        Collection<LocaleBean> products = new LinkedList<LocaleBean>();

        String selectSQL = "SELECT * FROM " + LocaleModel.TAB_NAME;

        if (order != null && !order.equals("")) {
            System.out.println("Order by: " + order);
            selectSQL += " ORDER BY " + order;
        }

        try {
            connection = DriverManagerConnectionPool.getConnection(db, username, password);
            preparedStatement = connection.prepareStatement(selectSQL);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                LocaleBean bean = new LocaleBean();
                bean.setCodice(rs.getInt("Codice"));
                bean.setNome(rs.getString("Nome"));
                bean.setVia(rs.getString("Via"));
                bean.setCitta(rs.getString("Citta"));
                bean.setCap(rs.getInt("CAP"));
                bean.setTelefono(rs.getString("telefono"));

                products.add(bean);
            }

        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                DriverManagerConnectionPool.releaseConnection(connection);
            }
        }
        return products;

    }




}
