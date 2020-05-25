package controls;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import components.Cart;
import model.OrdineModel;
import beans.OrdineBean;
import beans.ProdottoBean;

/**
 * Servlet implementation class OrdiniControl
 */
@WebServlet("/OrdiniControl")
public class OrdiniControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static boolean isDataSource = true;
	int i=0;
	static String db = "pizzeria";
	static String username = "root";
	static String password = "root";
	
	static OrdineModel model= new OrdineModel(db, username, password);
       
    public OrdiniControl() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		OrdineBean ordine= (OrdineBean) request.getSession().getAttribute("ordine");
		Cart cart=(Cart)request.getSession().getAttribute("cart");
		
		if(cart==null) {
			cart=new Cart();
			request.getSession().setAttribute("cart", cart);
		}
		
		String action=request.getParameter("action");
		String page = request.getParameter("page");
		
		try {
			if(action!=null) {
				if(action.equalsIgnoreCase("compra")) {
					
					model.doSave(ordine);
					request.removeAttribute("ordine");
					cart.deleteAll();
					response.sendRedirect("./acquisto.jsp?ordine="+ordine);
					
					
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
