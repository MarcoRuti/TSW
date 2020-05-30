<%--
  Created by IntelliJ IDEA.
  User: dario
  Date: 30/05/2020
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"
         import="components.Cart, beans.OrdineBean, beans.ProductBean, java.util.*, java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
    String name = (String) session.getAttribute("name"); //prendo nome negozio
    OrdineBean ordine=(OrdineBean) session.getAttribute("ordine");
    String usernameCliente = (String) session.getAttribute("usernameCliente"); //prendo id negozio
    if(usernameCliente == null) //se id negozio = null lo imposto a 0 per visualizzazione default
        usernameCliente = "0";
    String url = "http://localhost:8080/LaSaporita/index.jsp"; //la stringa url porterà all'index
//String url = request.getRequestURL().toString(); //prendo url pagina per passarlo al login
//Cart cart = (Cart) request.getAttribute("cart"); //prendo un carrello
    Cart cart = (Cart) session.getAttribute("cart"); //prendo un carrello dalla sessione
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

    <meta name="description" content="La Saporita">
    <meta name=" author" content="Silvio Cresci">
    <meta name=" author" content="Raffaella Romano">

    <link rel="stylesheet" type="text/css" href="css/page_style.css">
    <link rel="stylesheet" type="text/css" href="css/footer.css">
    <link rel="stylesheet" href="css/slides.css" type="text/css">
    <link rel="stylesheet" href="css/divStyle.css" type="text/css">

    <meta name="viewport" content="width-device-width, initial-scale-1.0">

    <title>Acquisto Effettuato</title>
</head>
<body>

<%
    int isAdmin = 0; //variabile usata per tener traccia di admin loggato
    int isCliente = 0; //variabile usata per tener traccia di negozio loggato
    try { //prende una o l'altra variabile (non potranno essere prese entrambe - 1 login)
        isAdmin = (int) session.getAttribute("adminIn");
        isCliente = (int) session.getAttribute("clienteIn");
    }
    catch(Exception e){
        ;
    }

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
                                                             class="icon" id="home" style=></a></li>

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
<%
    double prezzo=ordine.getPrezzo();
    Formatter formatter = new Formatter(); //UTILIZZATO PER POTER STAMPARE SEMPRE 2 DECIMALI DOPO LA VIRGOLA


%>

<h1 align="center">Acquisto effettuato con successo</h1>
<h3 align="right">Totale pagato: &euro;<%=formatter.format("%.2f", prezzo) %></h3>
<% formatter.close();
    session.removeAttribute("ordine");
%>
<p><a href="index.jsp">CLICCA QUI</a> per continuare con i tuoi acquisti</p>

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
        } else if(isCliente == 1) { //Cliente connesso.
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

<p style="color:grey; text-align:center;">Copyright 2018 La Saporita. All rights reserved.</p>
</body>
</html>
