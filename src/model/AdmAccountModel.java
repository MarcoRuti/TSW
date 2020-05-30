package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import beans.AdminAccountBean;
import components.DriverManagerConnectionPool;

public class AdmAccountModel {

    private static final String TAB_NAME="adminaccount"; //Nome tabella in DB
    public String db;
    public String username;
    public String password;

    public AdmAccountModel(String db, String username, String password) {

        this.db = db;
        this.username = username;
        this.password = password;
    }

    //Genera query INSERT per salvare un nuovo elemento all'interno del DB
    public synchronized void doSave(AdminAccountBean account) throws SQLException{

        Connection connection= null;
        PreparedStatement preparedStatement=null;

        String insertSQL="INSERT INTO "+AdmAccountModel.TAB_NAME+" VALUES ( ?, ?)";

        try {
            connection= DriverManagerConnectionPool.getConnection(db, username, password);
            preparedStatement=connection.prepareStatement(insertSQL);
            preparedStatement.setString(1, account.getUsername());
            preparedStatement.setString(2, account.getPassword());
            System.out.println(preparedStatement.toString());

            preparedStatement.executeUpdate();

            connection.commit();
        }finally {
            try {
                if(preparedStatement != null)
                    preparedStatement.close();
            } finally {
                DriverManagerConnectionPool.releaseConnection(connection);
            }

        }

    }
    //Genera query DELETE per eliminare la riga identificata da 'code' all'interno del DB
    public synchronized boolean doDeleteString(String code)
            throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        int result = 0;

        String deleteSQL = "DELETE FROM " + AdmAccountModel.TAB_NAME + " WHERE username = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection(db, username, password);
            preparedStatement = connection.prepareStatement(deleteSQL);
            preparedStatement.setString(1, code);

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

    public synchronized AdminAccountBean doRetrieveAccountByName(String userIn) throws SQLException {
        Connection con= null;
        PreparedStatement preparedStatement = null;

        AdminAccountBean bean = new AdminAccountBean();
        //System.out.println(userIn);

        String selectSQL = "SELECT * FROM adminaccount WHERE username = ?";

        try {

            con=DriverManagerConnectionPool.getConnection("jdbc:mysql://localhost:3306/pizzeria", "root", "root");
            preparedStatement = con.prepareStatement(selectSQL);
            preparedStatement.setString(1, userIn);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                bean.setUsername(rs.getString("username"));
                bean.setPassword(rs.getString("psw"));

            }

        }
        finally {
            try {
                if(preparedStatement != null)
                    preparedStatement.close();
            }
            finally {
                DriverManagerConnectionPool.releaseConnection(con);
            }
        }
        return bean;
    }


    //genera query SELECT * per prendere tutte le righe dal DB in un certo ordine

    public synchronized Collection<AdminAccountBean> doRetrieveAllAccount(String order) throws SQLException {

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        Collection<AdminAccountBean> products = new LinkedList<AdminAccountBean>();

        String selectSQL = "SELECT * FROM " + AdmAccountModel.TAB_NAME;

        if (order != null && !order.equals("")) {
            System.out.println("Order by: " + order);
            selectSQL += " ORDER BY " + order;
        }

        try {
            connection = DriverManagerConnectionPool.getConnection(db, username, password);
            preparedStatement = connection.prepareStatement(selectSQL);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                AdminAccountBean bean = new AdminAccountBean();
                bean.setUsername(rs.getString("username"));
                bean.setPassword(rs.getString("password"));

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
