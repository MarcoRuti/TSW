package components;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.OffertaModel;


@WebServlet("/OffPage")
public class OffPage extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static String db = "pizzeria";
    static String username = "root";
    static String password = "root";

    OffertaModel model = new OffertaModel(db, username, password);



    public OffPage() {
        super();
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int code = Integer.parseInt(request.getParameter("codice"));
        System.out.println("Codice: " + code);

        request.removeAttribute("offertaPage");

        //request.setAttribute("offertaPage", model.doRetrieveOffertaByKey(code));

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/OffertaPage.jsp");
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
