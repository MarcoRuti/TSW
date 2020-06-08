<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"
         import="beans.ProductBean, java.util.*"%>

<!DOCTYPE html>
<html>
    <head>
        <%
            Collection<?> products = (Collection<?>) request.getAttribute("productList");
            String usernameCliente = (String) session.getAttribute("usernameCliente");
            if(usernameCliente == null)     usernameCliente = "0";
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
            String url = "localhost:8080/k_war_exploded/index.jsp";
            url = request.getRequestURL().toString();
            String name = (String) session.getAttribute("name");

            int isAdmin = 0;
            int isCliente = 0;
            try {
                isAdmin = (int) session.getAttribute("adminIn");
                isCliente = (int) session.getAttribute("clientIn");
            }
            catch(Exception e){
            }

            String tipoPage = (String) request.getAttribute("pagina");
            String tipoProd = (String) request.getAttribute("tipo");
            String searchKey = (String) request.getAttribute("search");
        %>

        <!-- Navbar grande -->
        <div class="navbar">

            <div id="main_menu">
                <!-- " &#9776 "Simbolo del menù -->
                <label class="toggle" for="toggle">&#9776;</label>
                <input class="toggle" id="toggle" type="checkbox">

                <nav>
                    <ul id="menu">
                        <!-- HOME -->
                        <li class="current"><a href="index.jsp"><img src="img/logo.jpg" alt="Home" class="icon" id="home"></a></li>

                        <!-- PRODOTTI -->
                        <li class="has_children"><a href="AllProductList?tipo=tutti"> PRODOTTI</a>
                            <ul>
                                <!-- dropdown menu -->

                                <li><a href="AllProductList?tipo=Accessori">Accessori</a></li>
                                <li><a href="AllProductList?tipo=Smartphone">Smartphone</a></li>
                                <li><a href="AllProductList?tipo=Workstation">Workstation</a></li>
                                <li><a href="AllProductList?tipo=Notebook">Notebook</a></li>

                            </ul>
                        </li>

                        <%
                        if (name != null) {
                        %>

                        <li style="float: right;">
                            <a>Benvenuto <%=name%></a>
                        </li>
                        <li style="float: right;">
                            <a href="logout.jsp?link=<%=url%>"> Logout </a>
                        </li>

                        <%
                            } else {
                        %>

                        <li style="float: right;">
                            <a href="login.jsp?link=<%=url%>"> Login </a>
                        </li>

                        <%
                            }
                        %>

                        <li style="float: right;">
                            <a href="CartPage.jsp"><img src="img/carrello_vuoto.png" alt="Carrello" class="icon" id="cartHome" style="height: 30px; width: 30px;"></a>
                        </li>

                    </ul>
                </nav>
            </div>
        </div>

        <!-- DA CAMBIARE 04/06/2020
    	    <p>Tipo: < %=tipoProd%></p>

        <%
            if(tipoPage.equals("tutti")) {
        %>
        -->

        <h2>Lista prodotti</h2>

        <%
            if(searchKey!=null && !searchKey.equals("")) {
        %>

        <h4>Chiave di ricerca: <%=searchKey %></h4>

        <%
            }
            String returnCarrello = "";
            String servletToCall = "";
            if(tipoPage.equals("tutti")) {
                servletToCall = "AllProductList";
                returnCarrello = "tutti";
            }
        %>

        <!-- FORM BARRA RICERCA -->
        <form action="<%=servletToCall %>" method="get">
            <input type="hidden" name="id" value="<%=usernameCliente%>">
            <input type="text" name="search" placeholder="Search..">
            <input type="submit">
        </form>

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

                        <td align="right">
                            <a href="ProductPage?codice=<%=bean.getCodice()%>"><%= bean.getNome() %></a>
                        </td>

                        <%
                            if(isCliente!=0) {
                        %>
                        <!-- SEZIONE AGGIUNTA CARRELLO -->
                        <td rowspan="5" style="text-align:center; vertical-align:middle;" width="20%">
                            <p>Codice Prodotto: <%=bean.getCodice() %></p>
                            <a href="ProductControl?action=addC&codice=<%=bean.getCodice()%>&page=<%=returnCarrello%>&usernameCliente=<%=usernameCliente%>&tipo=<%=tipoProd%>"><img src="img/carrello_vuoto.png" alt="Aggiungi al carrello" id="cart" style="border: 3px solid #0fc68e; border-radius: 30px 30px 30px 30px;"></a>
                        </td>

                        <%
                            }
                        %>
                    </tr>

                    <tr align="right">
                        <td><%= bean.getDescrizione()%></td>
                    </tr>

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
                    </tr>
                    <tr>
                        <td>
                            <a href="ProductPage?codice=<%=bean.getCodice()%>"><%= bean.getNome() %></a>
                        </td>
                    </tr>
                    <tr>
                        <td><%= bean.getDescrizione() %></td>
                    </tr>
                    <tr>
                        <%
                            Formatter formatter2 = new Formatter();
                        %>

                        <td>&euro;<%=formatter2.format("%.2f", prezzo) %></td>
                    </tr>
                    <tr>

                        <!-- SEZIONE AGGIUNTA CARRELLO -->
                        <td style="text-align:center; vertical-align:middle;" width="20%">
                            <p>Codice Prodotto: <%=bean.getCodice() %></p>
                            <div id="imgContainer">
                                <a href="ProductControl?action=addC&codice=<%=bean.getCodice()%>&page=<%=returnCarrello%>&usernameCliente=<%=usernameCliente%>&tipo=<%=tipoProd%>"><img src="img/carrello_vuoto.png" alt="Aggiungi al carrello" id="cart" style="border: 3px solid #0fc68e; border-radius: 30px 30px 30px 30px;"></a>
                            </div>
                        </td>
                    </tr>
                </table>
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
                <p id = "right_side" align="right">
                    <a href="login.jsp?link=<%=url %>">Zona Riservata</a>
                </p>

                <%
                } else { //nessuno connesso. Porta alla pagina di login
                %>
                <p id = "right_side" align="right">
                    <a href="login.jsp?link=<%=url %>">Zona Riservata</a>
                </p>

                <%
                    }
                %>
            </div>
        </footer>

        <hr>
        <p style="color:grey; text-align:center;">Copyright © 2020 I-Buy. All rights reserved.</p>

    </body>
</html>