<%--
  Created by IntelliJ IDEA.
  User: dario
  Date: 28/05/2020
  Time: 15:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


    <link rel="stylesheet" type="text/css" href="css/page_style.css">
    <link rel="stylesheet" type="text/css" href="css/footer.css">
    <link rel="stylesheet" href="css/slides.css" type="text/css">
    <link rel="stylesheet" href="css/divStyle.css" type="text/css">
    <link rel="stylesheet" href="css/tables.css" type="text/css">

    <meta name="viewport" content="width-device-width, initial-scale-1.0">

    <title>Admin Page</title>
</head>
<body>
<%
    String url = request.getRequestURL().toString();
    String name = (String) session.getAttribute("name");
    String usernameCliente = (String) session.getAttribute("usernameCliente");
    String action="visualizza";

    int isAdmin = 0;
    int isCliente = 0;
    if(name!=null) {
%>
<!--
	<p><%=name %></p>
	<a href="logout.jsp?link=<%=url %>">Logout</a><br/>
	 -->
<%
    try {
        isAdmin = (int) session.getAttribute("adminIn");
        isCliente = (int) session.getAttribute("clientIn");
    }
    catch(Exception e){
        ;
    }

%>

<!-- Navbar -->
<div class="navbar">

    <div id="main_menu">
        <label class="toggle" for="toggle">&#9776;</label> <!-- simbolo menu (3 linee orizzontali) -->
        <input class="toggle" id="toggle" type="checkbox">
        <nav>
            <ul id="menu">
                <!-- HOME -->
                <li class="current"><a href="index.jsp"><img src="img/logo.jpg" alt="Home" class="icon" id="home"></a></li>
                <%
                    if(name!=null) {
                %>
                <li style="float: right;"><a>Benvenuto <%=name%></a></li>
                <li style="float: right;"><a href="logout.jsp?link=<%=url %>"> Logout </a></li>
                <%
                    }
                %>
            </ul>
        </nav>

    </div>


</div>
<%
    }
    try {

        String username = (String) session.getAttribute("name");
        if(isAdmin == 1) { //accesso alla pagina con account amministratore

%>
<h2 align="center">Pagina Amministratore</h2>

<br/><br/>

<div class="divContorno">
    <div id="contenitore">

        <table width="100%" class="adminTable">
            <tr class="adminTable"><td width="50%" class="adminTable">
                <fieldset>
                    <legend>GESTIONE AMMINISTRATORI</legend>
                    <p><a href="DynamicTab?tab=adminaccount&action=<%=action%>">Gestisci gli account Amministratore</a></p> <!-- permette modifica e rimozione nella pagina aperta -->
                    <p><a href="newAdminAccountForm.jsp">Aggiungi nuovo Amministratore</a></p>
                </fieldset>
            </td><td width="50%" class="adminTable">
                <fieldset>
                    <legend>GESTIONE CLIENTI</legend>
                    <p><a href="DynamicTab?tab=cliente&action=<%=action%>">Gestisci gli account Cliente</a></p>
                    <p><a href="newCliente.jsp">Aggiungi Cliente</a></p>
                </fieldset>
            </td></tr>
            <tr class="adminTable"><td width="50%" class="adminTable">
                <fieldset>
                    <legend>GESTIONE PRODOTTI</legend>
                    <p><a href="DynamicTab?tab=prodotto&action=<%=action%>">Gestisci lista prodotti</a></p>
                    <p><a href="newProdotto.jsp">Aggiungi prodotto</a></p>

                </fieldset>
            </td>
                <td width="50%" class="adminTable">
                    <fieldset>
                        <legend>GESTIONE ORDINI</legend>
                        <p><a href="DynamicTab?tab=ordine&action=<%=action%>">Gestisci lista ordini</a></p>
                    </fieldset>
                </td></tr>
        </table>



        <%
        }
        else if(isCliente == 1) { //accesso alla pagina con account locale
        %>

        <h2>ACCESSO NON AUTORIZZATO!</h2>
        <p>Questa pagina è riservata solo ad account Amministratore. Torna alla <u><a href="index.jsp">home</a></u> per loggarti.</p>
        <%
        }
        else if(isAdmin == 0) { //isAdmin sarà = 0 quando nessun account è al momento collegato
        %>
        <h2>ACCESSO NON AUTORIZZATO!</h2>
        <p>Non sei autorizzato ad entrare in questa pagina. Torna alla <u><a href="index.jsp">home</a></u> per loggarti.</p>

        <%
            }
        } catch(NullPointerException e) {
        %>
        <!-- 	<p><%=e %></p> -->
        <p>.</p>
        <h2>ACCESSO NON AUTORIZZATO!</h2>
        <p>Non sei autorizzato ad entrare in questa pagina. Torna alla <u><a href="index.jsp">home</a></u> per loggarti.</p>
        <%
            }

        %>
    </div>
</div>

</body>
</html>
