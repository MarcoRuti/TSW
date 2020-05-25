package adminDatabase;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.OrdineBean;
import model.OrdineModel;
@WebServlet("/AddOrdine")

public class AddOrdine extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	static String db = "pizzeria";
	static String username = "root";
	static String password = "root";
	
OrdineModel model = new OrdineModel(db,username,password);


public AddOrdine() {
	super();
}
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("Error. This Servlet must be called with POST method.");
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	int codice = Integer.parseInt(request.getParameter("codice"));
	double prezzo = Double.parseDouble(request.getParameter("prezzo"));
	String usernameCliente = request.getParameter("username_cliente");
	
	OrdineBean bean = new OrdineBean();
	bean.setCodice(codice);
	bean.setUsernameCliente(usernameCliente);
	

try {
	model.doSave(bean);
	
}
catch (SQLException e) {
	e.printStackTrace();
	System.out.println("[AddOrdine.java] Errore:" + e);
}

RequestDispatcher dispositivo = getServletContext().getRequestDispatcher("/newOrdine.jsp");
dispositivo.forward(request, response);
}
}


