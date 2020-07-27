<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

        <link rel="stylesheet" type="text/css" href="css/page_style.css">
        <link rel="stylesheet" type="text/css" href="css/footer.css">
        <link rel="stylesheet" href="css/slides.css" type="text/css">
        <link rel="stylesheet" href="css/divStyle.css" type="text/css">

        <title>Add new Cliente</title>
    </head>
    <body>
        <%
            try {
                String urlRet = request.getRequestURL().toString();
                String username = (String) session.getAttribute("name");
                String addOk = (String) session.getAttribute("AddOk");
                request.getSession().removeAttribute("AddOk");
        %>
        <!-- Navbar piccola -->
        <div class="navbar">

            <div id="main_menu">
                <label class="toggle" for="toggle">&#9776;</label> <!-- simbolo menu (3 linee orizzontali) -->
                <input class="toggle" id="toggle" type="checkbox">
                <nav>
                    <ul id="menu">
                        <!-- HOME -->
                        <li class="current"><a href="index.jsp"><img src="img/logo.jpg" alt="Home" class="icon" id="home"></a></li>
                        <%
                            if(username!=null) {
                        %>
                        <li style="float: right;">
                            <a>Benvenuto <%=username%></a>
                        </li>
                        <li style="float: right;">
                            <a href="logout.jsp?link=<%=urlRet %>"> Logout </a>
                        </li>
                        <%
                            }
                        %>
                    </ul>
                </nav>
            </div>
        </div>
        <p>
            <a href="adminPage.jsp"><--Torna al pannello di Amministrazione</a>
        </p>
        <h2 align="center">Aggiungi nuovo cliente</h2>

        <div class="divContorno">
            <div id="contenitore">
                <form action="AddCliente" method="post">
                    <table align="center" style="width:300px; height:250px">
                        <caption class="tabTitle">New Cliente</caption>
                        <tr>
                            <td colspan=2>Nome:</td>
                        </tr>
                        <tr>
                            <td colspan=2>
                                <input type="text" placeholder="Enter name" name="nome" required maxlength="30" style="width:100%; height:100%">
                            </td>
                        </tr>
                        <tr>
                            <td colspan=2>Cognome:</td>
                        </tr>
                        <tr>
                            <td colspan=2>
                                <input type="text" placeholder="Enter surname" name="cognome" required maxlength="30" style="width:100%; height:100%">
                            </td>
                        </tr>

                        <tr>
                            <td colspan=2>Username:</td>
                        </tr>
                        <tr>
                            <td colspan=2>
                                <input type="text" placeholder="Enter username" name="username" required maxlength="45" style="width:100%; height:100%">
                            </td>
                        </tr>
                        <tr>
                            <td colspan=2>Password:</td>
                        </tr>
                        <tr>
                            <td colspan=2>
                                <input type="password" placeholder="Enter password" name="password" required maxlength="45" style="width:100%; height:100%">
                            </td>
                        </tr>

                        <tr>
                            <td class="buttonTd">
                                <input type="submit" style="width:100%; height:100%" >
                            </td>
                            <td class="buttonTd">
                                <input type="reset" style="width:100%; height:100%">
                            </td>
                        </tr>
                    </table>
                </form>

                <%
                    } catch(NullPointerException e) {
                        e.printStackTrace();
                    }
                %>

            </div>
        </div>
        <hr>
        <p style="color:grey; text-align:center;">Copyright © 2020 I-Buy. All rights reserved.</p>

    </body>
</html>