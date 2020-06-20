package components;

import model.ProductModel;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ProductPage")
public class ProductPage extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static String db = "i-buy";
    static String username = "root";
    static String password = "rootroot";

    ProductModel model = new ProductModel(db, username, password);

    public ProductPage() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int codice = Integer.parseInt(request.getParameter("codice"));
        System.out.println("Codice: " + codice);

        request.removeAttribute("prodPage");

        try {
            request.setAttribute("prodPage", model.doRetrieveProductByKey("codice"));
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            System.out.println("[ProductPage.java - setAttribute prodotto] ERROR: " + e.getMessage());
        }

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProdPage.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
