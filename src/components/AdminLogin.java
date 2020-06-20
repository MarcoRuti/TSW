package components;

import beans.AdminAccountBean;
import model.AdmAccountModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static String db = "i-buy";
    static String username = "root";
    static String password = "rootroot";

    static AdmAccountModel model = new AdmAccountModel(db,username,password);

    public AdminLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Error. This servlet must be called with POST method.");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String userForm=request.getParameter("Username");
        String passForm=request.getParameter("Password");
        System.out.println("Username: " + userForm + ", password: " + passForm);

        AdminAccountBean account = new AdminAccountBean();
        HttpSession session=request.getSession();
        //Questa variabile a 0 serve per prevenire l'accesso non autorizzato alla pagina dopo il login
        int isAdminIn = 0;
        int isClientIn = 0;

        //salvo la variabile nella session per leggerla dalle pagine autorizzate
        session.setAttribute("adminIn", isAdminIn);
        session.setAttribute("clientIn", isClientIn);
        String linkReind = (String) session.getAttribute("link");
        System.out.println(linkReind);

        try {
            request.removeAttribute("accounts");
            account = model.doRetrieveAccountByName(userForm);
            request.setAttribute("accounts", account);
            System.out.println(account.toString());
        } catch(SQLException e) {
            System.out.println("[AdminLogin.java] Error: " + e);
        }

        if(account.getUsername().equals(userForm) && account.getPassword().equals(passForm)) {

            //username e password corrispondono
            //salvo il nome dell'admin nella sessione
            session.setAttribute("Username", userForm);

            //metto il bit di controllo admin a 1 per l'accesso autorizzato
            isAdminIn = 1;

            //inserisco il bit nella session per leggerlo dalle pagine autorizzate
            session.setAttribute("adminIn", isAdminIn);
            session.setAttribute("name",account.getUsername());
            response.sendRedirect("index.jsp");
        }
        else {
            //username o psw o entrambi errati
            //vado sulla pagina di errore login
            response.sendRedirect(request.getContextPath() + "/loginFail.jsp");
        }
    }
}
