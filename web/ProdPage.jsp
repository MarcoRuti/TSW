<%@ page contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"
         import="beans.ProductBean, beans.OrdineBean, java.util.*"%>
<!DOCTYPE html>
<html>
    <%
        OrdineBean ordine=(OrdineBean) request.getAttribute("ordine");
        ProductBean bean = (ProductBean) request.getAttribute("prodPage"); //ERA "prodPage" provo altro CREA PROBLEMI AL BEAN -DARIO
                    // IL PROBLEMA E' SEMPRE DAL FILTRO PAGINA DOBBIAMO CHIARIRE QUEL TIPOPAGINA E TIPO PRODOTTI X FAR FUNZIONARE QUESTO -DARIO
                    //  VIENE USATO ANCHE PER LA RICERCA IN MANIERA TALE DA MOSTRARE LA PAROLA CERCATA NEL TITOLO ALLA RIGA 33 -DARIO
                    // BISOGNA CHIARIRE QUESTO ASPETTO -DARIO
        int isAdmin = 0; //variabile usata per tener traccia di admin loggato
        int isCliente = 0;
        try {
            isAdmin = (int) session.getAttribute("adminIn");
            isCliente = (int) session.getAttribute("clientIn"); // E' CLIENTIN NON MODIFICARE IN CLIENTEIN, QUELL'ATTRIBUTO NON ESISTE -DARIO
        }
        catch(Exception e){
            ;
        }

        String usernameCliente = (String) session.getAttribute("usernameCliente");
        if(usernameCliente == null)
            usernameCliente = "0";
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

    <link rel="stylesheet" type="text/css" href="css/page_style.css">
    <link rel="stylesheet" type="text/css" href="css/footer.css">
    <link rel="stylesheet" href="css/slides.css" type="text/css">
    <link rel="stylesheet" href="css/divStyle.css" type="text/css">

    <meta name="viewport" content="width-device-width, initial-scale-1.0">
    <title>
        <%=bean.getNome() %>
    </title>
    </head>
    <body>
        <%
            String url = "http://localhost:8080/k_war_exploded/index.jsp"; //la stringa url porter? all'index
             url = request.getRequestURL().toString(); //riceve una stringa contenente l'url della pagina
            String name = (String) session.getAttribute("name"); //riceve il nome dell'utente dalla sessione

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
                        <li class="current"><a href="index.jsp"><img src="img/logo.jpg" alt="Home"
                                                                 class="icon" id="home"></a></li>
                        <!-- PRODOTTI -->
                        <li class="has_children"><a href=""> PRODOTTI</a>
                            <ul>
                                <!-- dropdown menu -->

                                <li><a href="AllProductList?tipo=Accessori">Accessori</a></li>
                                <li><a href="AllProductList?tipo=Smartphone">Smartphone</a></li>
                                <li><a href="AllProductList?tipo=Workstation">Workstation</a></li>
                                <li><a href="AllProductList?tipo=Notebook">Notebook</a></li>

                            </ul></li>

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
                                <a href="CartPage.jsp"><img src="img/carrello_vuoto.png" alt="Carrello" class="icon" id="cartHome" style="height: 30px; width: 30px;"></a>
                            </li>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>

        <br>

        <div class="divContorno">
            <div id="contenitore">
                <%
                    Formatter formatter = new Formatter();
                    double prezzo = bean.getPrezzo();
                %>

                <!-- TABELLA MOSTRATA SU SCHERMI GRANDI -->
                <table width="100%" id="tabBigPage">
                    <tr>
                        <td rowspan="4" align="center" width="50%">
                            <img src="img/<%=bean.getNome()%>.jpg" width="200px" height="200px" alt="Foto prodotto" id="prodType" >
                        </td>
                        <td align="center">
                            <h1><%=bean.getNome() %></h1>
                        </td>
                    </tr>
                    <tr align="right">
                        <td>
                            <h3><%= bean.getDescrizione() %></h3>
                        </td>
                    </tr>

                    <tr align="right">
                        <td>
                            <h3>&euro;<%=formatter.format("%.2f", prezzo) %></h3>
                        </td>
                    </tr>


                    <tr align="right">
                        <td>
                            <h4>Codice Prodotto: <%= bean.getCodice() %></h4>
                        </td>
                    </tr>
                    <%
                        //loggato con cliente, mostra il tasto Add to Cart
                        if(isCliente!=0) {
                    %>
                    <!-- SEZIONE AGGIUNTA CARRELLO -->
                    <tr>
                        <td colspan="2" align="center">
                        <a href="ProductControl?action=addC&codice=<%=bean.getCodice()%>&page=cart&usernameCliente=<%=usernameCliente%>&ordine=<%=ordine%>"><img src="img/aggiungi_carrello.jpg" width="150px" height="100px" alt="Aggiungi al carrello" class="icon" id="cart" style="border: 3px solid #f49723; border-radius: 30px 30px 30px 30px;"></a>
                        </td>
                    </tr>
                    <%
                        }
                        formatter.close();
                    %>
                </table>

                <!-- TABELLA MOSTRATA NELLA PAGINA PICCOLA -->
                <table width="100%" id="tabSmallPage">
                    <tr>
                        <td width="50%"></td>
                    </tr>
                    <tr>
                        <td>
                            <h1><%=bean.getNome() %></h1>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h3><%= bean.getDescrizione() %></h3>
                        </td>
                    </tr>

                    <%
                        Formatter formatter2 = new Formatter();
                    %>

                    <tr>
                        <td>
                            <h3>&euro;<%=formatter2.format("%.2f", prezzo) %></h3>
                        </td>
                        </tr>
                    <tr>
                        <td>
                            <h4>Codice Prodotto: <%= bean.getCodice() %></h4>
                        </td>
                    </tr>
                    <%
                        //loggato con cliente, mostra il tasto Add to Cart
                        if(isCliente!=0) {
                    %>
                    <!-- SEZIONE AGGIUNTA CARRELLO -->
                    <tr>
                        <td colspan="2" align="center">
                            <a href="ProductControl?action=addC&id=<%=bean.getCodice()%>&page=cart&usernameCliente=<%=usernameCliente%>&ordine=<%=ordine%>"><img src="img/aggiungi_carrello.jpg" alt="Aggiungi al carrello" id="cart" style="border: 3px solid #f49723; border-radius: 30px 30px 30px 30px;"></a>
                        </td>
                    </tr>
                    <%
                        }
                        formatter2.close();
                    %>
                </table>
            </div>
        </div>

        <!-- Footer -->
        <footer id="footer">
            <div id = "info_menu">
                <p>
                    <a href="perConoscerci.jsp">Per conoscerci</a>
                </p>

                <p id="right_side" align="right">
                    <a href="adminPage.jsp">Zona Riservata</a>
                </p>
            </div>
        </footer>

        <p style="color:grey; text-align:center;">Copyright © 2020 I-Buy. All rights reserved.</p>
    </body>
</html>