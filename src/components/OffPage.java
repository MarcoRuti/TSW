package components;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/OffPage")
public class OffPage extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static String db = "pizzeria";
    static String username = "root";
    static String password = "root";





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
