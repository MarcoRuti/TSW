package control;

import beans.OrdineBean;
import components.Cart;
import model.OrdineModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// Servlet implementation class OrdiniControl

@WebServlet("/OrdiniControl")
public class OrdiniControl extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static boolean isDataSource = true;
    int i=0;
    static String db = "i-buy";
    static String username = "root";
    static String password = "rootroot";

    static OrdineModel model= new OrdineModel(db, username, password);

    public OrdiniControl() {
        super();
    }

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
                    cart.deleteItems();
                    response.sendRedirect("./acquistoj.jsp?ordine="+ordine);

                }
            }
        }catch(Exception e) {
            e.printStackTrace();
        }
    }

      protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
