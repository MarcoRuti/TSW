<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!doctype html>
    <%
        String url = (String) request.getParameter("link");
    %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

        <!-- <meta http-equiv="Refresh" content="2;url=login.jsp?link=<%=url %>">  Reindirizza alla pagina di login dopo 2 secondi -->
        <meta http-equiv="Refresh" content="2;url=index.jsp">

        <link rel="stylesheet" type="text/css" href="css/page_style.css">
        <link rel="stylesheet" type="text/css" href="css/footer.css">
        <link rel="stylesheet" href="css/slides.css" type="text/css">
        <link rel="stylesheet" href="css/divStyle.css" type="text/css">

        <title>Logout </title>
    </head>
    <body>
        <div class = "navbar">

            <div id="main_menu">
                <label class="toggle" for="toggle">&#9776;</label> <!-- simbolo menu (3 linee orizzontali) -->
                <input class="toggle" id="toggle" type="checkbox">
                <nav>
                    <ul id="menu">
                        <!-- HOME -->
                        <li class="current">
                            <a href="index.jsp"><img src="img/logo.jpg" alt="Home" class="icon" id="home"></a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>

        <%
            HttpSession session2 = request.getSession();
            session2.invalidate();
        %>

        <div class="divContorno">
            <div id="contenitore">
                <p>Disconnessione in corso... Verrai reindirizzato alla Home in pochi secondi.</p>
            </div>
        </div>
    </body>
</html>