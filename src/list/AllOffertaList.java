package list;
import java.io.IOException;
import java.sql.SQLException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import model.OffertaModel;

@WebServlet("/AllOffertaList")

public class AllOffertaList extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static String db = "pizzeria";
    static String username = "root";
    static String password = "root";

    OffertaModel model = new OffertaModel(db, username, password);


    public AllOffertaList() {
        super();
        // TODO Auto-generated constructor stub
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        request.removeAttribute("pagina");

        request.setAttribute("pagina", "tutti");

        request.removeAttribute("offertaList");
        try {


            request.setAttribute("offertaList", model.doRetrieveAllOfferta());

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            System.out.println("[AllOffertaList.java - setAttribute offertaList] ERROR: " + e);
        }

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/OffertaList.jsp");
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