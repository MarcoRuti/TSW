package adminDatabase;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.LocaleBean;
import model.LocaleModel;

@WebServlet("/AddLocale")

public class AddLocale extends HttpServlet{
    private static final long serialVersionUID = 1L;

    static String db = "pizzeria";
    static String username ="root";
    static String password = "root";
    LocaleModel model = new LocaleModel (db,username,password);

    public AddLocale() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Error. This Servlet must be called with POST method.");
    }

    protected void doSet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String nome = request.getParameter("nome");
        int codice = Integer.parseInt("codice");
        int cap = Integer.parseInt("cap");
        String citta = request.getParameter("citta");
        String telefono = request.getParameter("telefono");
        String via = request.getParameter("via");

        LocaleBean bean = new LocaleBean();
        bean.setCap(cap);
        bean.setCitta(citta);
        bean.setCodice(codice);
        bean.setNome(nome);
        bean.setTelefono(telefono);
        bean.setVia(via);


        try {
            model.doSave(bean);
        }
        catch (SQLException e) {
            e.printStackTrace();
            System.out.println("[AddLocale.java] Errore: " + e);
        }

        RequestDispatcher dispositivo = getServletContext().getRequestDispatcher("/newLocale.jsp");
        dispositivo.forward(request, response);
    }



}
