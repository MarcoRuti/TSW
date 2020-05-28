<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 27/05/2020
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.lang.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

    <meta name="descrizione" content="i-buy">


    <link rel="stylesheet" type="text/css" href="css/Style1.css">

    <link rel="stylesheet" type="text/css" href="css/footer.css">

    <link rel="stylesheet" href="css/divStyle.css" type="text/css">


<!--
    <meta name="viewport" content="width-device-width, initial-scale-1.0">
-->

    <title>Login</title>
</head>
<body>

<%
    String url = (String) request.getParameter("link"); //riceve il link della pagina che lo ha chiamato
    session.setAttribute("link", url);
%>

<!-- Navbar mini-piccola -->
<div class="navbar">

    <div id="main_menu">
        <label class="toggle" for="toggle">&#9776;</label> <!-- simbolo menu (3 linee orizzontali) -->
        <input class="toggle" id="toggle" type="checkbox">
        <nav>
            <ul id="menu">
                <!-- HOME -->
                <li class="current"><a href="index.jsp"><img src="img/logo.jpg" alt="Home" class="icon" id="home"></a></li>
            </ul>
        </nav>

    </div>


</div>

<!-- 	<p>Richiesta login ricevuto da <%=url %></p>  -->

<h2 align="center">Login</h2>

<div class="divContorno">
    <div id="contenitore">


        <%
            try {

                String username = (String) session.getAttribute("name");
                if(username!=null) {
        %>
        <p>Utente < %=username %> gi‡ connesso!</p>
        <p><a href="logout.jsp?link=< %=url %>">Logout</a></p>
        <%
        } else {
        %>
        -->

        <div id="leftLogin">
            <form action="./AdminLogin" method="POST">
                <table align="center" style="width:300px; height:250px">
                    <caption class="tabTitle">Admin</caption>
                    <tr><td colspan=2>Username:</td></tr>
                    <tr><td colspan=2>
                        <input type="text" placeholder="Enter username" name="Username" required style="width:100%; height:100%">
                    </td></tr>
                    <tr><td colspan=2>Password</td></tr>
                    <tr><td colspan=2>
                        <input type="password" placeholder="Enter password" name="Password" required style="width:100%; height:100%">
                    </td></tr>
                    <tr><td class="buttonTd"><input type="submit" style="width:100%; height:100%" ></td>
                        <td class="buttonTd"><input type="reset" style="width:100%; height:100%"></td></tr>
                </table>
            </form>
        </div>

        <div id="rightLogin">
            <form action="./ClientLogin" method="POST">
                <table align="center" style="width:300px; height:250px">
                    <caption class="tabTitle">Cliente</caption>
                    <tr><td colspan=2>Username:</td></tr>
                    <tr><td colspan=2>
                        <input type="text" placeholder="Enter username" name="usernameCliente" required style="width:100%; height:100%">
                    </td></tr>
                    <tr><td colspan=2>Password</td></tr>
                    <tr><td colspan=2>
                        <input type="password" placeholder="Enter password" name="PswCliente" required style="width:100%; height:100%">
                    </td></tr>
                    <tr><td class="buttonTd"><input type="submit" style="width:100%; height:100%" ></td>
                        <td class="buttonTd"><input type="reset" style="width:100%; height:100%"></td></tr>
                </table>
            </form>
        </div>
        <%
            }
        } catch(NullPointerException e) {
        %>
        <p>Error in page.</p>
        <%
            }
        %>

    </div>
</div>
</body>
</html>
