<%--
  Created by IntelliJ IDEA.
  User: dario
  Date: 28/05/2020
  Time: 15:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"
         import="beans.ProductBean, beans.Acquistabile, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <%
        Collection<?> products = (Collection<?>) request.getAttribute("productList");
        String usernameCliente = (String) session.getAttribute("usernameCliente");
        if(usernameCliente == null)
            usernameCliente = "0";
    %>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">



    <link rel="stylesheet" type="text/css" href="css/page_style.css">
    <link rel="stylesheet" type="text/css" href="css/footer.css">
    <link rel="stylesheet" href="css/slides.css" type="text/css">
    <link rel="stylesheet" href="css/divStyle.css" type="text/css">

    <meta name="viewport" content="width-device-width, initial-scale-1.0">

    <title>Lista Prodotti</title>
</head>
<body>


<%
    String url = "http://localhost:8080/LaSaporita/index.jsp"; //la stringa url porter‡ all'index
//	String url = request.getRequestURL().toString(); //riceve una stringa contenente l'url della pagina
    String name = (String) session.getAttribute("name"); //riceve il nome dell'utente dalla sessione

    int isAdmin = 0; //variabile usata per tener traccia di admin loggato
    int isCliente = 0;
    try {
        isAdmin = (int) session.getAttribute("adminIn");
        isCliente = (int) session.getAttribute("clientIn");
    }
    catch(Exception e){
        ;
    }
    String tipoPage = (String) request.getAttribute("pagina");
    String tipoProd = (String) request.getAttribute("tipo");
    String searchKey = (String) request.getAttribute("search");

%>

<!-- Navbar grande -->
<div class="navbar">

    <div id="main_menu">
        <label class="toggle" for="toggle">&#9776;</label> <!-- simbolo del menu (3 linee orizzontali) -->
        <input class="toggle" id="toggle" type="checkbox">
        <nav>
            <ul id="menu">
                <!-- HOME -->
                <li class="current"><a href="index.jsp"><img src="img/logo.png" alt="Home"
                                                             class="icon" id="home"></a></li>
                <!-- PRODOTTI -->
                <li class="has_children"><a href="./AllProductList"> PRODOTTI</a>
                    <ul>
                        <!-- dropdown menu -->

                        <li><a href="./AllProductList?tipo=pizze">Pizze</a></li>

                        <li><a href="./AllProductList?tipo=panini">Panini</a></li>

                        <li><a href="./AllProductList?tipo=sfizi">Sfizi e Varie</a></li>

                        <li><a href="./AllProductList?tipo=bibite">Bibite</a></li>

                    </ul></li>
                <!-- OFFERTE -->
                <li class= "has_children"><a href="./AllOffertaList?">OFFERTE</a>
                        <%
				if (name != null) {
			%>
                <li style="float: right;"><a>Benvenuto <%=name%></a></li>
                <li style="float: right;"><a href="logout.jsp?link=<%=url%>">
                    Logout </a></li>
                <%
                } else {
                %>
                <li style="float: right;"><a href="login.jsp?link=<%=url%>">
                    Login </a></li>
                <%
                    }
                %>
                <li style="float: right;"><a href="CartPage.jsp"><img
                        src="img/empty-cart-light.png" alt="Carrello" class="icon"
                        id="cartHome" style="height: 30px; width: 30px;"></a></li>



            </ul>
        </nav>
    </div>

</div>

<!-- 	<p>Tipo: <%=tipoProd%></p>  -->

<%
    if(tipoPage.equals("tutti")) {
%>
<h2>Lista prodotti</h2>
<%
    }

    if(searchKey!=null && !searchKey.equals("")) {
%>
<h4>Chiave ricerca: <%=searchKey %></h4>
<%
    }
    String returnCarrello = "";
    String servletToCall = "";
    if(tipoPage.equals("tutti")) {
        servletToCall = "./AllProductList";
        returnCarrello = "tutti";
    }

%>
<!-- FORM BARRA RICERCA -->
<form action="<%=servletToCall %>" method="get">
    <input type="hidden" name="id" value="<%=usernameCliente%>">
    <input type="text" name="search" placeholder="Search..">
    <input type="submit">
</form>

<br/><br/>
<div class="divContorno">
    <div id="contenitore">
        <%
            if (products != null && products.size() != 0) {
                Iterator<?> it = products.iterator();
                while (it.hasNext()) {
                    Formatter formatter = new Formatter(); //UTILIZZATO PER POTER STAMPARE SEMPRE 2 DECIMALI DOPO LA VIRGOLA
                    ProductBean bean = (ProductBean) it.next();
                    double prezzo = bean.getPrezzo();
        %>
        <table width="100%" id="tabBigPage">
            <tr>
                <td rowspan="5" align="center" width="20%">

                    <!-- SEZIONE SELEZIONE IMMAGINE DI ANTEPRIMA -->
                    <%
                        if(bean.getTipo().equals("pizze")) {
                    %>
                    <img src="img/<%=bean.getNome()%>.jpg" width="100px" height="100px" alt="Foto <%=bean.getNome()%>" id="pizze">
                    <%
                    }
                    else if(bean.getTipo().equals("panini")) {
                    %>
                    <img src="img/<%=bean.getNome()%>.jpg"  width="100px" height="100px" alt="Foto <%=bean.getNome()%>" id="panini">
                    <%
                    }
                    else if(bean.getTipo().equals("sfizi")) {
                    %>
                    <img src="img/<%=bean.getNome()%>.jpg"  width="100px" height="100px" alt="Foto <%=bean.getNome()%>" id="sfizi">
                    <%
                    }
                    else if(bean.getTipo().equals("bibite")) {
                    %>
                    <img src="img/<%=bean.getNome()%>.jpg" width="100px" height="100px"  alt="Foto <%=bean.getNome()%>" id="bibite">
                    <%
                    }
                    else {
                    %>
                    FOTO NON TROVATA
                    <%
                        }
                    %>
                </td>

                <td align="right"><a href="./ProductPage?codice=<%=bean.getCodice()%>"><%= bean.getNome() %></a></td>
                <%
                    if(isCliente!=0) {
                %>
                <!-- SEZIONE AGGIUNTA CARRELLO -->
                <td rowspan="5" style="text-align:center; vertical-align:middle;" width="20%">
                    <p>Codice Prodotto: <%=bean.getCodice() %></p>
                    <a href="./ProductControl?action=addC&codice=<%=bean.getCodice()%>&page=<%=returnCarrello%>&usernameCliente=<%=usernameCliente%>&tipo=<%=tipoProd%>"><img src="img/cartIcon.png" alt="Aggiungi al carrello" id="cart" style="border: 3px solid #0fc68e; border-radius: 30px 30px 30px 30px;"></a>
                </td>
                <%
                    }
                %>
            </tr>
            <tr align="right"><td><%= bean.getDescrizione()%></td></tr>

            <tr align="right"><td style="color:green;">
                &euro;<%=formatter.format("%.2f", prezzo)%></td></tr>
            <%

                formatter.close();
            %>
        </table>

        <table width="100%" id="tabSmallPage">
            <tr>
                <td align="center" width="20%">

                    <!-- SEZIONE SELEZIONE IMMAGINE DI ANTEPRIMA -->
                    <%
                        if(bean.getTipo().equals("pizze")) {
                    %>
                    <img src="img/<%=bean.getNome()%>.jpg" width="100px" height="100px" alt="Foto <%=bean.getNome()%>">
                    <%
                    }
                    else if(bean.getTipo().equals("panini")) {
                    %>
                    <img src="img/<%=bean.getNome()%>.jpg"  width="100px" height="100px" alt="Foto <%=bean.getNome()%>">
                    <%
                    }
                    else if(bean.getTipo().equals("sfizi")) {
                    %>
                    <img src="img/<%=bean.getNome()%>.jpg"  width="100px" height="100px" alt="Foto <%=bean.getNome()%>">
                    <%
                    }
                    else if(bean.getTipo().equals("bibite")) {
                    %>
                    <img src="img/<%=bean.getNome()%>.jpg" width="100px" height="100px"  alt="Foto <%=bean.getNome()%>">
                    <%
                    }
                    else {
                    %>
                    FOTO NON TROVATA
                    <%
                        }
                    %>
                </td>
            </tr><tr>
            <td><a href="./ProductPage?codice=<%=bean.getCodice()%>"><%= bean.getNome() %></a></td>
        </tr><tr>
            <td><%= bean.getDescrizione() %></td>
        </tr><tr>
            <%
                Formatter formatter2 = new Formatter();
            %>

            <td>&euro;<%=formatter2.format("%.2f", prezzo) %></td>

        </tr><tr>

            <!-- SEZIONE AGGIUNTA CARRELLO -->
            <td style="text-align:center; vertical-align:middle;" width="20%">
                <p>Codice Prodotto: <%=bean.getCodice() %></p>
                <div id="imgContainer">
                    <a href="./ProductControl?action=addC&codice=<%=bean.getCodice()%>&page=<%=returnCarrello%>&usernameCliente=<%=usernameCliente%>&tipo=<%=tipoProd%>"><img src="img/cartIcon.png" alt="Aggiungi al carrello" id="cart" style="border: 3px solid #0fc68e; border-radius: 30px 30px 30px 30px;"></a>
                </div>
            </td>

        </tr>
        </table>
        <hr/>
        <%
                formatter2.close();

            }
        }
        else {
        %>
        <table>
            <tr><td>Non ci sono prodotti da mostrare.</td></tr>
        </table>
        <%
            }
        %>
    </div>
</div>

<!-- Footer -->

<footer id="footer">
    <hr>

    <div id = "info_menu">
        <p><a href="perConoscerci.jsp">Per conoscerci</a> </p>
        <p><a href="contatti.jsp">Contatti</a></p>
        <%
            if(isAdmin == 1) { //Admin connesso. Passa a pannello controllo admin
        %>
        <p id = "right_side" align="right"><a href="adminPage.jsp">Zona Riservata</a></p>
        <%
        } else if(isCliente == 1) { //cliente connesso
        %>
        <p id = "right_side" align="right"><a href="login.jsp?link=<%=url %>">Zona Riservata</a></p>
        <%
        } else { //nessuno connesso. Porta alla pagina di login
        %>
        <p id = "right_side" align="right"><a href="login.jsp?link=<%=url %>">Zona Riservata</a></p>
        <%
            }
        %>

    </div>

</footer>


<hr>

<p style="color:grey; text-align:center;">Copyright © 2020 I-Buy. All rights reserved.</p>
</body>
</html>