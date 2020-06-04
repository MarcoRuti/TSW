package adminDatabase;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.AdminAccountBean;
import model.AdmAccountModel;

@WebServlet("/AddCAdminAccount")

public class AddAdminAccount extends HttpServlet{
    private static final long serialVersionUID = 1L;

    static String db = "i-buy";
    static String username = "root";
    static String password = "rootroot";

    static AdmAccountModel model = new AdmAccountModel(db, username, password);

    public AddAdminAccount() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        System.out.println("Questa Servlet deve essere chiamata con il metodo Post!");
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String userForm = request.getParameter("Username");
        String passwordForm = request.getParameter("Password");

        //Creo il bean per contenere i dati da inserire
        AdminAccountBean bean = new AdminAccountBean();
        bean.setPassword(passwordForm);
        bean.setUsername(userForm);

        HttpSession session = request.getSession();
        session.setAttribute("AddOk", "");
        try {
            model.doSave(bean);
            session.setAttribute("AddOk", userForm);
        }
        catch (SQLException e) {
            e.printStackTrace();
            System.out.println("[AddAdminAccount.java] Errore: " + e);
            session.setAttribute("AddOk", "Errore");
        }

        //Trasferisco il cliente sulla pagina dopo il login
        RequestDispatcher dispositivo = getServletContext().getRequestDispatcher("/newAdminAccountForm.jsp");
        dispositivo.forward(request, response);
    }
}

