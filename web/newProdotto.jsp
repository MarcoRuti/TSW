<%--
  Created by IntelliJ IDEA.
  User: dario
  Date: 28/05/2020
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">



    <link rel="stylesheet" type="text/css" href="css/page_style.css">
    <link rel="stylesheet" type="text/css" href="css/footer.css">
    <link rel="stylesheet" href="css/slides.css" type="text/css">
    <link rel="stylesheet" href="css/divStyle.css" type="text/css">

    <title>Add new prodotto</title>
</head>
<body>

<%
    try {
        String urlRet = request.getRequestURL().toString();
        String username = (String) session.getAttribute("username");
        String addOk = (String) session.getAttribute("addOk");
        request.getSession().removeAttribute("addOk");
%>
<!-- Navbar piccola -->
<div class="navbar">

    <div id="main_menu">
        <label class="toggle" for="toggle">&#9776;</label> <!-- simbolo menu (3 linee orizzontali) -->
        <input class="toggle" id="toggle" type="checkbox">
        <nav>
            <ul id="menu">
                <!-- HOME -->
                <li class="current"><a href="index.jsp"><img src="img/logo.png" alt="Home" class="icon" id="home"></a></li>
                <%
                    if(username!=null) {
                %>
                <li style="float: right;"><a>Benvenuto <%=username%></a></li>
                <li style="float: right;"><a href="logout.jsp?link=<%=urlRet %>"> Logout </a></li>
                <%
                    }
                %>
            </ul>
        </nav>

    </div>


</div>


<p><a href="adminPage.jsp">Torna alla pagina di amministrazione.</a></p>
<h2 align="center">Aggiungi nuovo prodotto.</h2>

<div class="divContorno">
    <div id="contenitore">
        <form action="AddProdotto" method="post">
            <table align="center" style="width:300px; height:250px">
                <caption class="tabTitle">New prodotto</caption>
                <tr><td colspan=2>Inserisci codice prodotto:</td></tr>
                <tr><td colspan=2>
                    <input type="text" placeholder="Inserisci codice prodotto:" name="codice" required maxlength="30" style="width:100%; height:100%">
                </td></tr>
                <tr><td colspan=2>Nome:</td></tr>
                <tr><td colspan=2>
                    <input type="text" placeholder="Inserisci il nome del prodotto" name="nome" required maxlength="30" style="width:100%; height:100%">
                </td></tr>
                <tr><td colspan=2>Inserisci prezzo: (Utilizza il "." per dividere i decimali)</td></tr>
                <tr><td colspan=2>
                    <input type="number" step="0.01" min="0.01" placeholder="Inserisci prezzo:" name="prezzo" required style="width:100%; height:100%">
                </td></tr>
                <tr><td colspan=2>Aggiungi Descrizione:</td></tr>
                <tr><td colspan=2>
                    <textarea placeholder="Ent" name="descrizione" required maxlength="1024" style="width:100%; height:100%" rows="4"></textarea>
                </td></tr>
                <tr><td colspan=2>Indica la Tipologia del prodotto:</td></tr>
                <tr><td colspan=2>
                    <select name="tipo">
                        <option value="Accessori">Accessori</option>
                        <option value="Smartphone">Smartphone</option>
                        <option value="Workstation">Workstation</option>
                        <option value="Notebook">Notebook</option>
                    </select>
                </td></tr>
                <tr><td class="buttonTd"><input type="submit" style="width:100%; height:100%" ></td>
                    <td class="buttonTd"><input type="reset" style="width:100%; height:100%"></td></tr>
            </table>
        </form>
        <%

            } catch(NullPointerException e) {

                e.printStackTrace(); }

        %>
    </div>
</div>

</body>
</html>
