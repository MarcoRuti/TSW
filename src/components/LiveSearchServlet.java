package components;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LiveSearchServlet
 */
@WebServlet("/LiveSearchServlet")
public class LiveSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LiveSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String s=request.getParameter("val");
//		System.out.println("value: " + s);
		
		response.setContentType("text/html");
	    PrintWriter out = response.getWriter();
		
		if(s==null || s.trim().equals("")){
	//		out.print("Please enter name");
		}
		else {
			String name = s;
			
			out.print("<div id=\"myDropdown\" class=\"dropdown-content\">");
			

			try{
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/progettoPW";
				String user = "root";
				String psw = "root";
				Connection con = DriverManager.getConnection(url, user, psw);
				Statement st=con.createStatement();
				String query = "select * from prodotto where nome LIKE '%" + name + "%'";
			//	out.print(query);
				ResultSet rs=st.executeQuery(query);
				while(rs.next()){
				//	out.println(rs.getInt("Codice")+" "+rs.getString("Nome") + "<br/>");
					out.print("<a href='./ProductPage?codice=" + rs.getInt("Codice") + "'>" + rs.getInt("Codice")+" - "+rs.getString("Nome") + "</a>");
				}
				con.close();
				out.print("</div>");
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
