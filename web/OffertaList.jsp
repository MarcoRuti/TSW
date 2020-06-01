<%--
  Created by IntelliJ IDEA.
  User: dario
  Date: 30/05/2020
  Time: 16:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"
         import= "beans.OffertaBean, beans.Acquistabile, java.util.*"

%>
<!DOCTYPE html>
<html>
<head>

    <%
        Collection<?> offerta = (Collection<?>) request.getAttribute("offertaList");
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

    <title>Lista Offerte</title>
</head>
<body>
<%
    String url = "http://localhost:8080/LaSaporita/index.jsp"; //la stringa url porter‡ all'index
//  String url = request.getRequestURL().toString(); //riceve una stringa contenente l'url della pagina
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
    String searchKey = (String) request.getAttribute("search");

%>
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
                <li class="has_children"><a href="./AllProductList">PRODOTTI</a>
                    <ul>
                        <!-- dropdown menu -->

                        <li><a href="./AllProductList?tipo=pizze">Pizze</a></li>

                        <li><a href="./AllProductList?tipo=panini">Panini</a></li>

                        <li><a href="./AllProductList?tipo=sfizi">Sfizi e Varie</a></li>

                        <li><a href="./AllProductList?tipo=bibite">Bibite</a></li>

                    </ul></li>

                <!-- OFFERTE -->
                <li class= "has_children"><a href="./AllOffertaList">OFFERTE</a>


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


<h2>Lista offerte </h2>

<%



    String returnCarrello = "";
    String servletToCall = "";
    if(tipoPage.equals("tutti")) {
        servletToCall = "./AllOffertaList";
        returnCarrello = "tutti";
    }

%>


<div class="divContorno">
    <div id="contenitore">
        <%
            if (offerta != null && offerta.size() != 0) {
                Iterator<?> it = offerta.iterator();
                while (it.hasNext()) {
                    Formatter formatter = new Formatter(); //UTILIZZATO PER POTER STAMPARE SEMPRE 2 DECIMALI DOPO LA VIRGOLA
                    OffertaBean bean = (OffertaBean) it.next();
                    double prezzo = bean.getPrezzo();
        %>
        <table width="100%" id="tabBigPage">
            <tr>
                <td rowspan="5" align="center" width="20%">

                    <!-- SEZIONE SELEZIONE IMMAGINE DI ANTEPRIMA -->
                    <img src="img/<%=bean.getCodice()%>.jpg" width="100px" height="100px" alt="Foto <%=bean.getCodice()%>">

                </td>

                <td align="right"><a href="./OffPage?codice=<%=bean.getCodice()%>">Codice offerta: <%= bean.getCodice() %></a></td>
                <%
                    if(isCliente!=0) {
                %>
                <!-- SEZIONE AGGIUNTA CARRELLO -->
                <td rowspan="5" style="text-align:center; vertical-align:middle;" width="20%">
                    <p>Codice Offerta: <%=bean.getCodice() %></p>
                    <a href="./OffertaControl?action=addC&codice=<%=bean.getCodice()%>&page=<%=returnCarrello%>&usernameCliente=<%=usernameCliente%>"><img src="img/cartIcon.png" alt="Aggiungi al carrello" id="cart" style="border: 3px solid #0fc68e; border-radius: 30px 30px 30px 30px;"></a>
                </td>
                <%
                    }
                %>
            </tr>
            <tr align="right"><td>Componenti: <%= bean.getDescrizione()%></td></tr>
            <tr align ="right"><td>Data Inizio Offerta: <%=bean.getDataInizio() %> </td></tr>
            <tr align ="right"><td>Data Fine Offerta: <%=bean.getDataFine() %> </td></tr>
            <tr align="right"><td style="color:black;"> Prezzo:
                &euro;<%=formatter.format("%.2f", prezzo)%></td></tr>
            <%

                formatter.close();
            %>
        </table>

        <table width="100%" id="tabSmallPage">
            <tr>
                <td align="center" width="20%">

                    <!-- SEZIONE SELEZIONE IMMAGINE DI ANTEPRIMA-->
                    <img src="img/<%=bean.getCodice()%>.jpg" width="100px" height="100px" alt="Foto <%=bean.getCodice()%>">


                </td>
            </tr><tr>
            <td><a href="./OffertaPage.jsp?codice=<%=bean.getCodice()%>"><%= bean.getCodice() %></a></td>
        </tr><tr>
            <td><%= bean.getProdottiInOfferta() %></td>
        </tr><tr>
            <%
                Formatter formatter2 = new Formatter();
            %>

            <td>&euro;<%=formatter2.format("%.2f", prezzo) %></td>

        </tr><tr>

            <!-- SEZIONE AGGIUNTA CARRELLO -->
            <td style="text-align:center; vertical-align:middle;" width="20%">
                <p>Codice Offerta: <%=bean.getCodice() %></p>
                <div id="imgContainer">
                    <a href="./OffertaControl?action=addC&codice=<%=bean.getCodice()%>&page=<%=returnCarrello%>&usernameCliente=<%=usernameCliente%>"><img src="img/cartIcon.png" alt="Aggiungi al carrello" id="cart" style="border: 3px solid #0fc68e; border-radius: 30px 30px 30px 30px;"></a>
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
            <tr><td>Non ci sono offerte da mostrare.</td></tr>
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

