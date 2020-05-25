package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import beans.OffertaBean;
import beans.ProdottoBean;
import components.DriverManagerConnectionPool;

public class ProductModel {
	private static final String TAB_NAME = "prodotto"; //Nome tabella in DB
	public String db;
	public String username;
	public String password;
	
	public ProductModel(String db, String username, String password) {
	
		this.db = db;
		this.username = username;
		this.password = password;
	}
	
	//Genera query INSERT per salvare un prodotto appena creato ma non ancora venduto
	public synchronized void doAddProduct(ProdottoBean product) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + ProductModel.TAB_NAME
				+ " VALUES (?, ?, ?, ?, ?)";

		try {
			connection = DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement = connection.prepareStatement(insertSQL);
			
			preparedStatement.setDouble(1, product.getCodice());
			preparedStatement.setString(2, product.getNome());
			preparedStatement.setString(3, product.getTipo());
			preparedStatement.setDouble(4, product.getPrezzo());
			preparedStatement.setString(5, product.getComponenti());
			
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
	
	//Genera query INSERT per salvare un nuovo elemento all'interno del DB
	public synchronized void doSave(ProdottoBean product) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + ProductModel.TAB_NAME
				+ " (codice, nome, prezzo, ingredienti, Tipo) "
				+ "VALUES (?, ?, ?, ?, ?)";

		try {
			connection = DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setInt(1, product.getCodice());
			preparedStatement.setString(2, product.getNome());
			preparedStatement.setDouble(3, product.getPrezzo());
			preparedStatement.setString(4, product.getComponenti());
			preparedStatement.setString(5, product.getTipo());
			
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
		
		Connection connection1 = null;
		PreparedStatement preparedStatement1 = null;

		int result = 0;

		String deleteSQL1 = "DELETE FROM riguarda WHERE Prodotto_codice = ?";

		try {
			connection1 = DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement1 = connection1.prepareStatement(deleteSQL1);
			preparedStatement1.setInt(1, code);

			result = preparedStatement1.executeUpdate();
			connection1.commit();
		} finally {
			try {
				if (preparedStatement1 != null)
					preparedStatement1.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection1);
			}
		}
		OffertaModel model= new OffertaModel(db, username, password);
		model.doDeleteInt(getCodiciOfferte(code));
		
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;


		String deleteSQL = "DELETE FROM " + ProductModel.TAB_NAME + " WHERE codice = ?";

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

	public synchronized ProdottoBean doRetrieveProductByName(String nome) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		ProdottoBean bean = new ProdottoBean();


		String selectSQL = "SELECT * FROM " + ProductModel.TAB_NAME + " WHERE Nome = ?";

		try {
			connection = DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, nome);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {

				bean.setCodice(rs.getInt("Codice"));
				bean.setNome(rs.getString("Nome"));
				bean.setComponenti(rs.getString("Ingredienti"));
				bean.setPrezzo(rs.getDouble("Prezzo"));
				bean.setTipo(rs.getString("Tipo"));
			
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

	public synchronized Collection<ProdottoBean> doRetrieveAllProduct()throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<ProdottoBean> products = new LinkedList<ProdottoBean>();

		String selectSQL = "SELECT * FROM " + ProductModel.TAB_NAME;

		try {
			connection = DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				ProdottoBean bean = new ProdottoBean();
				bean.setCodice(rs.getInt("Codice"));
				bean.setNome(rs.getString("Nome"));
				bean.setComponenti(rs.getString("ingredienti"));
				bean.setPrezzo(rs.getDouble("Prezzo"));
				bean.setTipo(rs.getString("Tipo"));

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
public synchronized Collection<ProdottoBean> doRetrieveProductByType(String tipo)throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<ProdottoBean> products = new LinkedList<ProdottoBean>();

		String selectSQL = "SELECT * FROM " + ProductModel.TAB_NAME+ " WHERE tipo= ?";
		try {
			connection = DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, tipo);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				ProdottoBean bean = new ProdottoBean();
				bean.setCodice(rs.getInt("Codice"));
				bean.setNome(rs.getString("Nome"));
				bean.setComponenti(rs.getString("ingredienti"));
				bean.setPrezzo(rs.getDouble("Prezzo"));
				bean.setTipo(rs.getString("Tipo"));

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

public synchronized ProdottoBean doRetrieveProductByKey(int code) throws SQLException {
	
	Connection connection = null;
	PreparedStatement preparedStatement = null;

	ProdottoBean bean= new ProdottoBean();

	String selectSQL = "SELECT * FROM " + ProductModel.TAB_NAME + " WHERE codice = ?";

	try {
		connection = DriverManagerConnectionPool.getConnection(db, username, password);
		preparedStatement = connection.prepareStatement(selectSQL);
		preparedStatement.setInt(1, code);

		ResultSet rs = preparedStatement.executeQuery();

		while (rs.next()) {
			bean.setCodice(rs.getInt("Codice"));
			bean.setNome(rs.getString("Nome"));
			bean.setComponenti(rs.getString("Ingredienti"));
			bean.setPrezzo(rs.getDouble("Prezzo"));
			bean.setTipo(rs.getString("Tipo"));
			
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
public synchronized int getCodiciOfferte (int code) throws SQLException {

Connection connection3 = null;
PreparedStatement preparedStatement3 = null;
int i=0;



String selectSQL = "SELECT Offerta_codice FROM riguarda WHERE Prodotto_codice= ?";

try {
	connection3 = DriverManagerConnectionPool.getConnection(db, username, password);
	preparedStatement3 = connection3.prepareStatement(selectSQL);
	preparedStatement3.setInt(1, code);

	ResultSet rs = preparedStatement3.executeQuery();

	while (rs.next()) {
		i=rs.getInt("Offerta_codice");
		
	}

} finally {
	try {
		if (preparedStatement3 != null)
			preparedStatement3.close();
	} finally {
		DriverManagerConnectionPool.releaseConnection(connection3);
	}
}
	return i;
}
}

