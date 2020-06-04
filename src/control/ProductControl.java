package control;


import beans.ProductBean;
import components.Cart;
import model.ProductModel;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/ProductControl")
public class ProductControl extends HttpServlet {
	private static final long serialVersionUID = 1L;


	static boolean isDataSource = true;
	static String db = "i-buy";
	static String username = "root";
	static String password = "rootroot";

	static ProductModel model = new ProductModel(db,username,password);
	
	
    public ProductControl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		@SuppressWarnings("unchecked")
		Cart<ProductBean> cart = (Cart<ProductBean>) request.getSession().getAttribute("carrello");
		if (cart == null) {
			cart = new Cart<>();
			request.getSession().setAttribute("carrello", cart);
		}

		String sort = request.getParameter("sort");

		String action = request.getParameter("action");

		try {
			if (action != null) {
				if (action.equals("details")) {
					String id = request.getParameter("id");
					request.removeAttribute("product");
					request.setAttribute("product", model.doRetrieveProductByKey(id));
				} else if (action.equals("addCart")) {
					String id = request.getParameter("id");
					ProductBean bean = model.doRetrieveProductByKey("id");
					if(bean != null ) {
						cart.addItem(bean);
						request.setAttribute("message", "Product "+ bean.getNome()+" added to cart");
				}
			} else if (action.equals("clearCart")) {
				cart.deleteItems();
				request.setAttribute("message", "Cart cleaned");
			} else if (action.equals("deleteCart")) {
				String id = request.getParameter("id");
					ProductBean bean = model.doRetrieveProductByKey(id);
					if(bean != null ) {
					cart.deleteItem(bean);
					request.setAttribute("message", "Product "+ bean.getNome()+" deleted from cart");
			}
				} else if(action.equals("insert")) {
			String name = request.getParameter("name");
			String description = request.getParameter("description");
			int price = Integer.parseInt(request.getParameter("price"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));

			ProductBean bean = new ProductBean();
			bean.setNome(name);
			bean.setDescrizione(description);
			bean.setPrezzo(price);


			model.doSave(bean);
			request.setAttribute("message", "Product " + bean.getNome() + " added");
					} else if(action.equals("delete")) {
			String id = request.getParameter("id");
			ProductBean bean = model.doRetrieveProductByKey(id);
			if(bean != null) {
			model.doDeleteInt(Integer.parseInt("id"));
			request.setAttribute("message", "Product " + bean.getNome() + " deleted");
					}
				} else if(action.equals("update")) {
				String id = request.getParameter("id");
					String name = request.getParameter("name");
					String description = request.getParameter("description");
					int price = Integer.parseInt(request.getParameter("price"));
					int quantity = Integer.parseInt(request.getParameter("quantity"));

				ProductBean bean = new ProductBean();
			bean.setCodice(Integer.parseInt(id));
			bean.setNome(name);
			bean.setDescrizione(description);
			bean.setPrezzo(price);


				model.doSave(bean);
			request.setAttribute("message", "Product " + bean.getNome() + " updated");
				}
				}
	} catch(SQLException | NumberFormatException e) {
	System.out.println("Error: "+ e.getMessage());
	request.setAttribute("error", e.getMessage());
	}

	request.setAttribute("cart", cart);

	try {
	request.removeAttribute("products");
	request.setAttribute("products", model.doRetrieveAllProduct());
	} catch(SQLException e) {
	System.out.println("Error: "+ e.getMessage());
request.setAttribute("error", e.getMessage());
			}

	RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/ProductView.jsp");
	dispatcher.forward(request, response);
				}

			protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				doGet(request, response);
			}


	}