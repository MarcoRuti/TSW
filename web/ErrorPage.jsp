
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>iBuy</title>
    <link rel="stylesheet" type="text/css" href="css/page_style.css">
    <link rel="stylesheet" type="text/css" href="css/footer.css">
    <link rel="stylesheet" href="css/slides.css" type="text/css">
    <link rel="stylesheet" href="css/divStyle.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="css/searchProductHome.css">
</head>
<body>
<%
    String url = request.getRequestURL().toString();
    String name = (String) session.getAttribute("name");
    String usernameCliente = (String) session.getAttribute("usernameCliente");

    int isAdmin = 0;
    int isCliente = 0;
    if (name != null) {

        try {
            isAdmin = (int) session.getAttribute("adminIn");
            isCliente = (int) session.getAttribute("ClientIn");
        } catch (Exception e) {
            ;
        }



        if (usernameCliente != null) {
%>



<%
        }
    }
%>

<div id="header" align="center">
    <img src="img/logo.jpg" alt="Titolo" width=30% height=5%>
</div>
<!-- Navbar -->
<div class="navbar">

    <div id="main_menu">
        <label class="toggle" for="toggle">&#9776;</label> <!-- simbolo del menu (3 linee orizzontali) -->
        <input class="toggle" id="toggle" type="checkbox">
        <nav>
            <ul id="menu">
                <!-- HOME -->
                <li class="current">
                    <a href="index.jsp"><img src="img/logo.jpg" alt="Home" class="icon" id="home" width="40px" height="40px"></a>
                </li>

                <!-- PRODOTTI -->
                <li class="has_children">
                    <a href=""> PRODOTTI</a> <!-- RIMOSSO LINK ALL DARIO -->
                    <ul>
                        <!-- dropdown menu -->

                        <li>
                            <a href="AllProductList?tipo=Accessori">Accessori</a>
                        </li>
                        <li>
                            <a href="AllProductList?tipo=Smartphone">Smartphone</a>
                        </li>
                        <li>
                            <a href="AllProductList?tipo=Workstation">Workstation</a>
                        </li>
                        <li>
                            <a href="AllProductList?tipo=Notebook">Notebook</a>
                        </li>

                    </ul>
                </li>

                <%
                    if (name != null) {
                %>
                <li style="float: right;">
                    <a>Benvenuto <%=name%></a>
                </li>
                <li style="float: right;">
                    <a href="logout.jsp?link=<%=url%>">Logout </a>
                </li>
                <%
                } else {
                %>
                <li style="float: right;">
                    <a href="login.jsp?link=<%=url%>">Login </a>
                </li>
                <%
                    }
                %>
                <li style="float: right;">
                    <a href="CartPage.jsp">
                        <img src="img/carrello_vuoto.png" alt="Carrello" class="icon" id="cartHome" style="height: 30px; width: 30px;">
                    </a>
                </li>

            </ul>
        </nav>
    </div>
</div><!-- end navbar  -->


<h2 align="center">Qualcosa non va, <a href="index.jsp"><u>Torna indietro</u></a> </h2>
<div class="divContorno">

    <div id="contenitore">

              <pre class="preDescrizione" style="white-space: pre-wrap ">
                  <h4 style="color: #F00;"><b>Per gli esperti (haha):</b> <%= exception.toString() %></h4>
                  <br>
                  <div align="center"> <img  src="img/errorpage.png"  width="300px" height="300px" alt="Foto" id="error"> </div>
                  <br>
    </pre>


    </div>
</div>




<!-- Footer -->

<footer id="footer">
    <hr>

    <div id="info_menu">
        <p>
            <a href="perConoscerci.jsp">Per conoscerci</a>
        </p>

        <p id="right_side" align="right">
            <a href="adminPage.jsp">Zona Riservata</a>
        </p>

    </div>
</footer>

<hr>
<p style="color: grey; text-align: center;">Copyright © 2020 I-Buy. All rights reserved.</p>

</body>
</html>