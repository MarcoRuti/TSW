package components;

import beans.ClienteBean;
import model.ClientModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ClientLogin")
public class ClientLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static String db = "i-buy";
    static String username = "root";
    static String password = "rootroot";

    static ClientModel model= new ClientModel(db,username,password);

    public ClientLogin() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userForm = request.getParameter("usernameCliente");
        String passForm = request.getParameter("pswCliente");
        System.out.println("Username: " + userForm + ", password: " + passForm);

        ClienteBean account = new ClienteBean();
        HttpSession session = request.getSession();
        int isAdminIn = 0;
        int isClientIn = 0;
        session.setAttribute("adminIn", isAdminIn);
        session.setAttribute("clientIn", isClientIn);
        String linkReind = (String) session.getAttribute("link");

        try {
            request.removeAttribute("accounts");
            account = model.doRetrieveClientByName(userForm);
            request.setAttribute("accounts", account);
        }catch(SQLException e) {
            System.out.println("[ClienteLogin.java] Error: "+ e);
        }

        if(account.getUsername().equals(userForm)&&account.getPassword().equals(passForm)) {
            session.setAttribute("usernameCliente", userForm);
            isClientIn = 1;
            session.setAttribute("name", account.getNome());

            //inserisco il bit nella session per leggerlo dalle page autorizzate
            session.setAttribute("clientIn", isClientIn);

            response.sendRedirect(linkReind);
        }
        else {
            response.sendRedirect(request.getContextPath()+"/loginFail.jsp");
        }
    }
}
