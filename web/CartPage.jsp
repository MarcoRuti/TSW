
<%@page import="beans.Acquistabile"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"
         import="components.Cart, beans.OrdineBean, beans.ProductBean, java.util.*, java.sql.*"%>

<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<%
    String name = (String) session.getAttribute("name"); //prendo nome negozio
    OrdineBean ordine=(OrdineBean) session.getAttribute("ordine");
    String usernameCliente = (String) session.getAttribute("usernameCliente"); //prendo id negozio
    if(usernameCliente == null) //se id negozio = null lo imposto a 0 per visualizzazione default
        usernameCliente = "0";
    String url = "http://localhost:8080/k_war_exploded/index.jsp"; //la stringa url porterà all'index
 // String url = request.getRequestURL().toString(); //prendo url pagina per passarlo al login
// Cart cart = (Cart) request.getAttribute("cart"); //prendo un carrello
   Cart cart = (Cart) session.getAttribute("cart"); //prendo un carrello dalla sessione
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


    <link rel="stylesheet" type="text/css" href="css/page_style.css">
    <link rel="stylesheet" type="text/css" href="css/footer.css">
    <link rel="stylesheet" href="css/slides.css" type="text/css">
    <link rel="stylesheet" href="css/divStyle.css" type="text/css">

    <meta name="viewport" content="width-device-width, initial-scale-1.0">

    <title>Carrello</title>
</head>
<body>

<%
    int isAdmin = 0; //variabile usata per tener traccia di admin loggato
    int isCliente = 0; //variabile usata per tener traccia di  loggato
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
                <li class="current"><a href="index.jsp"><img src="img/logo.jpg" alt="Home"
                                                             class="icon" id="home" style=></a></li>

                <!-- PRODOTTI -->
                <li class="has_children"><a href="AllProductList"> PRODOTTI</a>
                    <ul>
                        <!-- dropdown menu -->

                        <li><a href="AllProductList?tipo=pizze">Pizze</a></li>

                        <li><a href="AllProductList?tipo=panini">Panini</a></li>

                        <li><a href="AllProductList?tipo=sfizi">Sfizi e Varie</a></li>

                        <li><a href="AllProductList?tipo=bibite">Bibite</a></li>

                    </ul></li>


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
                        src="img/carrello_vuoto.png" alt="Carrello" class="icon"
                        id="cartHome" style="height: 30px; width: 30px;"></a></li>



            </ul>
        </nav>
    </div>

</div>

<h2>Carrello</h2>
<%
    if(name!=null) {
%>
<!-- 		<p>Nome: <%=name %>, id: <%=usernameCliente %></p>  -->
<%
    }

    double totalPrice = 0;
    int prod = 0;
    if(isCliente == 1) //cliente connesso
    {
%>
<p>Cliente <%=usernameCliente + ". " + name %> connesso.</p>
<!-- QUI VA TUTTO IL CODICE DEL CARRELLO -->
<div class="divContorno">

    <div id="contenitore">
        <%
            if(cart != null) { //è presente un carrello nella sessione

        %>

        <%
            List<Acquistabile> prodcart = cart.getItems(); 	//prendi i prodotti già presenti nel carrello
            for(Acquistabile beancart: prodcart) { //per ogni prodotto ricevuto nel carrello
                if(beancart instanceof ProductBean){
                    System.out.println(beancart.toString());
                    Formatter formatter = new Formatter(); //UTILIZZATO PER POTER STAMPARE SEMPRE 2 DECIMALI DOPO LA VIRGOLA

        %>
        <table width="100%" id="tabBigPage">
            <tr>
                <td rowspan="5" align="center" width="20%">

                    <!-- SEZIONE SELEZIONE IMMAGINE DI ANTEPRIMA -->
                    <img src="img/<%=beancart.getNome()%>.jpg" width="100px" height="100px" alt="Foto">
                </td>
                <td align="right"><%= beancart.getNome() %></td>

                <td rowspan="5" style="text-align:center; vertical-align:middle;" width="20%">
                    <p>Codice Prodotto: <%=beancart.getCodice() %></p>
                    <a href="ProductControl?action=deleteC&codice=<%=beancart.getCodice()%>&page=cart&ordine=<%=ordine%>"><img src="img/cestino.png" alt="Rimuovi dal carrello" id="cartDel" style="heigth: 50px; width: 50px; border: 3px solid #f49723; border-radius: 20px 20px 20px 20px;"></a>
                </td>
            </tr>

            <%
                double prezzo = beancart.getPrezzo();

            %>
            <tr align="right"><td>&euro;<%=formatter.format("%.2f", prezzo) %></td></tr>
            <%

                formatter.close();
                totalPrice += prezzo;
            %>
        </table>

        <table width="100%" id="tabSmallPage">
            <tr>
                <td align="center" width="20%">

                    <!-- SEZIONE SELEZIONE IMMAGINE DI ANTEPRIMA -->
                    <img src="img/<%=beancart.getNome()%>.jpg" width="100px" height="100px" alt="Foto">
                </td>
            </tr><tr>
            <td><%= beancart.getNome() %></td>

            <%
                double prezzo2 = beancart.getPrezzo();
                Formatter formatter2 = new Formatter();

            %>
            <td>&euro;<%=formatter2.format("%.2f", prezzo2) %></td>

        </tr><tr>
            <td style="text-align:center; vertical-align:middle;" width="20%">
                <p>Codice Prodotto: <%=beancart.getCodice() %></p>
                <a href="ProductControl?action=deleteC&codice=<%=beancart.getCodice()%>&page=cart&ordine<%=ordine%>"><img src="img/cestino.png" alt="Rimuovi dal carrello" id="cartDel" style="heigth: 50px; width: 50px; border: 3px solid #f49723; border-radius: 20px 20px 20px 20px;"></a>
            </td>
        </tr>
        </table>
        <hr/>
        <%
            prod++;
            formatter2.close();
        } else if(beancart instanceof ProductBean){

            Formatter formatter = new Formatter(); //UTILIZZATO PER POTER STAMPARE SEMPRE 2 DECIMALI DOPO LA VIRGOLA

        %>
        <table width="100%" id="tabBigPage">
            <tr>
                <td rowspan="5" align="center" width="20%">

                    <!-- SEZIONE SELEZIONE IMMAGINE DI ANTEPRIMA -->
                    <img src="img/<%=beancart.getNome()%>.jpg" width="100px" height="100px" alt="Foto">
                </td>
                <td align="right"><%= beancart.getNome() %></td>

                <td rowspan="5" style="text-align:center; vertical-align:middle;" width="20%">
                    <p>Codice Prodotto: <%=beancart.getCodice() %></p>

                    <a href="ProductControl?action=deleteC&codice=<%=beancart.getCodice()%>&page=cart&ordine=<%=ordine%>"><img src="img/cestino.png" alt="Rimuovi dal carrello" id="cartDel" style="heigth: 50px; width: 50px; border: 3px solid #f49723; border-radius: 20px 20px 20px 20px;"></a>
                </td>
            </tr>

            <%
                double prezzo = beancart.getPrezzo();

            %>
            <tr align="right"><td>&euro;<%=formatter.format("%.2f", prezzo) %></td></tr>
            <%

                formatter.close();
                totalPrice += prezzo;
            %>
        </table>

        <table width="100%" id="tabSmallPage">
            <tr>
                <td align="center" width="20%">

                    <!-- SEZIONE SELEZIONE IMMAGINE DI ANTEPRIMA -->
                    <img src="img/<%=beancart.getNome()%>.jpg" width="100px" height="100px" alt="Foto">
                </td>
            </tr><tr>
            <td><%= beancart.getNome() %></td>

            <%
                double prezzo2 = beancart.getPrezzo();
                Formatter formatter2 = new Formatter();

            %>
            <td>&euro;<%=formatter2.format("%.2f", prezzo2) %></td>

        </tr><tr>
            <td style="text-align:center; vertical-align:middle;" width="20%">
                <p>Codice Prodotto: <%=beancart.getCodice() %></p>
                <a href="ProductControl?action=deleteC&codice=<%=beancart.getCodice()%>&page=cart&ordine<%=ordine%>"><img src="img/cestino.png" alt="Rimuovi dal carrello" id="cartDel" style="heigth: 50px; width: 50px; border: 3px solid #f49723; border-radius: 20px 20px 20px 20px;"></a>
            </td>
        </tr>
        </table>
        <hr/>
        <%
                    prod++;
                    formatter2.close();

                }
            }
        %>

        <%
            if(prod==0) {
        %>
        <p>Nessun articolo nel carrello.</p>
        <%
        }
        else { //se è presente almeno un articolo nel carrello

        %>
        <a href="./ProductControl?action=deleteAll&page=cart&ordine<%=ordine%>"><img src="img/cestino.png" alt="Rimuovi tutto" id="cartDelAll" style="heigth: 50px; width: 50px; border: 3px solid #f49723; border-radius: 20px 20px 20px 20px;"></a>
        <a href="./OrdiniControl?action=compra&page=cart&ordine=<%=ordine%>"><img src="img/soldi.png" alt="Compra" id="cartDelAll" style="heigth: 50px; width: 50px; border: 3px solid #f49723; border-radius: 20px 20px 20px 20px;"></a>

        <%
            }

        }
        else {
        %>
        <p>Nessun articolo nel carrello.</p>
        <%
            }
        %>
    </div>
</div>
<%
    if(prod>0) {
        Formatter formatter = new Formatter();
%>
<div align="left">
    <h3>Totale: <%=formatter.format("%.2f", totalPrice) %>&euro;</h3>
</div>
<%
        formatter.close();
    }
}
else {
%>
<p>Per accedere al carrello devi essere connesso con un account Cliente.</p>
<p><a href="login.jsp?link=<%=url %>">Clicca qui</a> per loggarti.</p>
<%
    }
%>
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

<p style="color:grey; text-align:center;">Copyright 2020 I-Buy. All rights reserved.</p>
</body>
</html>