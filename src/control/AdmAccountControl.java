package controls;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.AdmAccountModel;

/**
 * Servlet implementation class AdmAccountControl
 */
@WebServlet("/AdmAccountControl")
public class AdmAccountControl extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static boolean isDataSource = true;
    static String db = "pizzeria";
    static String username = "root";
    static String password = "root";

    static AdmAccountModel model = new AdmAccountModel(db, username, password);

    public AdmAccountControl() {
        super();
        // TODO Auto-generated constructor stub
    }



    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        String order = request.getParameter("order"); //Se order Ë null, in ProductModel verr‡ gestito


        try {
            request.removeAttribute("accounts");
            request.setAttribute("accounts", model.doRetrieveAllAccount(order));
        } catch(SQLException e) {
            System.out.println("Error: " + e);
        }

        System.out.println("AdmAccountControl eseguito.");
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("#");
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
