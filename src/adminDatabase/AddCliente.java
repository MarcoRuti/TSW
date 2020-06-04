package adminDatabase;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ClienteBean;
import model.ClientModel;

@WebServlet("/AddCliente")
public class AddCliente extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static String db = "i-buy";
    static String username= "root";
    static String password = "rootroot";


    ClientModel model = new ClientModel(db, username, password);

    public AddCliente() {
        super();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Questa Servlet deve essere chiamata con il metodo Post!");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        //Creo il bean per contenere i dati da inserire
        ClienteBean bean = new ClienteBean();
        bean.setNome(nome);
        bean.setCognome(cognome);
        bean.setPassword(password);
        bean.setUsername(username);

        try {
            model.doSave(bean);

        }
        catch (SQLException e) {
            e.printStackTrace();
            System.out.println("[AddCliente.java] Errore: " + e );

        }
        RequestDispatcher dispositivo = getServletContext().getRequestDispatcher("/newCliente.jsp");
        dispositivo.forward(request, response);
    }
}
