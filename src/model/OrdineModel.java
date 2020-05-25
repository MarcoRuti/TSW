package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import beans.OffertaBean;
import beans.OrdineBean;
import beans.ProdottoBean;
import components.DriverManagerConnectionPool;

public class OrdineModel {
	private static final String TAB_NAME="ordine"; //Nome tabella in DB
	public String db;
	public String username;
	public String password;
	
	
	public OrdineModel(String db, String username, String password) {
		this.db=db;
		this.username=username;
		this.password=password;
	}
	
	//Genera query INSERT per salvare un nuovo elemento all'interno del DB
	public synchronized void doSave(OrdineBean ordine) throws SQLException{
		
		Connection connection= null;
		PreparedStatement preparedStatement=null;
		
		String insertSQL="INSERT INTO "+OrdineModel.TAB_NAME+" VALUES (?, ?, ?);";
		ordine.setCodice(ordine.assegnaCodice());
		
		try {
			connection= DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement=connection.prepareStatement(insertSQL);
			preparedStatement.setInt(1, ordine.getCodice());
			preparedStatement.setString(2, ordine.getUsernameCliente());
			preparedStatement.setDouble(3, ordine.getPrezzo());
			
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
		for(int i=0;i<ordine.getProdottiOrdine().size();i++) {
				if(ordine.getProdottiOrdine().get(i) instanceof ProdottoBean) {
			PreparedStatement preparedStatement2=null;
			String insertSQL2="INSERT INTO contiene VALUES(?,?, NULL);";
			try {
				connection= DriverManagerConnectionPool.getConnection(db, username, password);
				preparedStatement2=connection.prepareStatement(insertSQL2);
				preparedStatement2.setInt(1, ordine.getCodice());
				preparedStatement2.setInt(2,ordine.getProdottiOrdine().get(i).getCodice());
							System.out.println(preparedStatement2.toString());

				
				preparedStatement2.executeUpdate();
				
				connection.commit();
			}finally {
				try {
					if(preparedStatement2 != null)
						preparedStatement2.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			
					
				}
			}

		} else if(ordine.getProdottiOrdine().get(i) instanceof OffertaBean) {
			PreparedStatement preparedStatement2=null;
			String insertSQL2="INSERT INTO contiene VALUES(?,NULL,?);";
			try {
				connection= DriverManagerConnectionPool.getConnection(db, username, password);
				preparedStatement2=connection.prepareStatement(insertSQL2);
				preparedStatement2.setInt(1, ordine.getCodice());
				preparedStatement2.setInt(2,ordine.getProdottiOrdine().get(i).getCodice());
							System.out.println(preparedStatement2.toString());

				
				preparedStatement2.executeUpdate();
				
				connection.commit();
			}finally {
				try {
					if(preparedStatement2 != null)
						preparedStatement2.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
		}
		}
}
	//Genera query DELETE per eliminare la riga identificata da 'code' all'interno del DB
	public synchronized boolean doDeleteInt(int code) 
			throws SQLException {
		
		Connection connection2 = null;
		PreparedStatement preparedStatement2 = null;

		int result = 0;

		String deleteSQL2 = "DELETE FROM contiene WHERE Ordine_codice = ?";

		try {
			connection2 = DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement2 = connection2.prepareStatement(deleteSQL2);
			preparedStatement2.setInt(1, code);

			result = preparedStatement2.executeUpdate();
			connection2.commit();
		} finally {
			try {
				if (preparedStatement2 != null)
					preparedStatement2.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection2);
			}
		}
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String deleteSQL = "DELETE FROM " +OrdineModel.TAB_NAME + " WHERE codice = ?";

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
	
	public synchronized int assegnaCodice() throws SQLException {

		Connection connection= null;
		PreparedStatement preparedStatement=null;
		int i=1;
		
		int[] array = new int[100];
		String query="SELECT codice FROM ordine ";
		try {
			connection = DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement = connection.prepareStatement(query);
		ResultSet rs= preparedStatement.executeQuery();
			while(rs.next()) {
				array[i]=rs.getInt("codice");
				System.out.println("Codici fino ad ora: "+array[i]);
				i++;
			}
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}	for(int j=0;j<array.length;j++) {
			System.out.println(array[j]);
		}
		
		for(int j=1;j<array.length;j++) {
			if(array[j]==0) {
				return j;
			}
		}
		
		return 0;
	}
}
