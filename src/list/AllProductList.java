package list;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ProductModel;

/**
 * Servlet implementation class AllProductList
 */
@WebServlet("/AllProductList")
public class AllProductList extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	static String db = "pizzeria";
	static String username = "root";
	static String password = "root";
	
	ProductModel model = new ProductModel(db, username, password);
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AllProductList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String tipo = request.getParameter("tipo");
		String search = request.getParameter("search");
		
		request.removeAttribute("pagina");
		if(tipo!=null && !tipo.equals("")) { //invia una specifica variabile in modo da gestire l'eventuale ordinamento
		
			request.setAttribute("tipo", tipo);
			
			}
		
		if(search!=null && !search.equals(""))
			request.setAttribute("search", search);
		
			request.setAttribute("pagina", "tutti");
		
			request.removeAttribute("productList");
		try {
				
				if(tipo!=null) {
					request.setAttribute("productList", model.doRetrieveProductByType(tipo));
				}
				else if(search!=null) {
					request.setAttribute("productList", model.doRetrieveProductByName(search));
				}
				else
				request.setAttribute("productList", model.doRetrieveAllProduct());
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("[AllProductList.java - setAttribute productList] ERROR: " + e);
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProductList.jsp");
		dispatcher.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
