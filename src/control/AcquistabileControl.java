package control;

import beans.Acquistabile;
import beans.OrdineBean;
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
import java.util.List;

// Servlet implementation class AcquistabileControl

@WebServlet("/AcquistabileControl")
public class AcquistabileControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public int i=0;

    static boolean isDataSource = true;
    static String db = "i-buy";
    static String username = "root";
    static String password = "rootroot";

    static ProductModel model = new ProductModel(db, username, password);

    public AcquistabileControl() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usernameCliente=(String) request.getSession().getAttribute("usernameCliente");
        OrdineBean ordine= (OrdineBean) request.getSession().getAttribute("ordine");
        i++;

        //Prende un oggetto di tipo carrello dalla sessione
        // Se non è presente, lo crea e lo aggiunge alla sessione
        Cart cart = (Cart)request.getSession().getAttribute("cart");
        if(cart == null) {
            cart = new Cart();
            request.getSession().setAttribute("cart", cart);
        }
        if(ordine==null) {
            ordine= new OrdineBean();
            request.getSession().setAttribute("ordine", ordine);
        }

        //Riceve il parametro per capire quale azione effettuare
        String action = request.getParameter("action");

        //Riceve la pagina che ha aggiunto l'articolo al carrello per poterci tornare
        String page = request.getParameter("page");

        System.out.println("Aggiunto in pagina: " + page);
        ordine.setCodice(i);

        try {
            if (action != null) {
                if (action.equalsIgnoreCase("addC")) {
                    //	System.out.println("Entrato nell'if.");
                    int codice = Integer.parseInt(request.getParameter("codice"));
                    System.out.println("Provo ad aggiungere il prodotto Codice: " + codice);
                    int justAdded=0;
                    List <Acquistabile> inCart = cart.getItems();

                    if(inCart.size()>0) {
                        System.out.println("Sono presenti " + inCart.size() + " elementi nel carrello.");
                        for(int i=0; i<inCart.size(); i++){
                            if(codice==inCart.get(i).getCodice()) {
                                justAdded = 1;
                            }
                        }
                    }
                    if(justAdded == 0) {

                        Acquistabile prod = null;
                        if(prod instanceof ProductBean)
                            model.doRetrieveProductByKey(codice); // ABBIAMO AGGIUNTO PARSE INT


                        prod.toString();
                        cart.addItem(prod);
                        ordine.addProdotto(prod);
                        ordine.setUsernameCliente(usernameCliente);
                        System.out.println("Aggiunto al carrello oggetto " + codice + ".");
                    }
                    else    System.out.println("Elemento già nel carrello.");

                } else if (action.equalsIgnoreCase("deleteC")) {
                    int cod = Integer.parseInt(request.getParameter("codice"));
                    cart.deleteItem(model.doRetrieveProductByKey(cod));
                    ordine.deleteProduct(model.doRetrieveProductByKey(cod));
                }
                else if (action.equalsIgnoreCase("deleteAll")) {
                    cart.deleteItems();
                    ordine.setArray(null);
                }
            }

        } catch (SQLException e) {
            System.out.println("[AcquistabileControl - action] Error:" + e.getMessage());
        }

        request.getSession().setAttribute("cart", cart);
        request.setAttribute("cart", cart);
        request.setAttribute("ordine", ordine);
        request.getSession().setAttribute("ordine", ordine);


/*
		String order = request.getParameter("order"); //Se order è null, in ProductModel verrà gestito

		try {
			request.removeAttribute("products");
			request.setAttribute("products", model.doRetrieveAllProduct(order));
		} catch(SQLException e) {
			System.out.println("[ProductControl - order] Error: " + e);
		}
*/
//		System.out.println("Product Control eseguito. Trasferisco su JSP.");

        if(page.equals("cart")) {
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/CartPage.jsp");
            dispatcher.forward(request, response);
        }
        else if(page.equals("tutti")) {

            response.sendRedirect("./AllProductList?");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
