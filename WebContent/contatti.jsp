<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<meta name="description" content="La Saporita">
<meta name=" author" content="Silvio Cresci">
<meta name=" author" content="Raffaella Romano">


<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/slides.css" type="text/css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">

<title>Contatti</title>
</head>
<body>


<%
	String url = request.getRequestURL().toString();
	String name = (String) session.getAttribute("name");
	String usernameCliente = (String) session.getAttribute("usernameCliente");
	
	int isAdmin = 0;
	int isCliente = 0;
	if(name!=null) {

	try {
		isAdmin = (int) session.getAttribute("adminIn");  
		isCliente = (int) session.getAttribute("clienteIn"); 
	}
	catch(Exception e){
		;
	}
%>

	
<%
			if(usernameCliente!=null) {
%>
<!-- 		<p>ID negozio: <%=usernameCliente %></p>  -->
<% 
			}
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
                                                         class="icon" id="home"></a></li>
			<!-- PRODOTTI -->
			<li class="has_children"><a href="./AllProductList?"> PRODOTTI</a>
				<ul>
					<!-- dropdown menu -->

					<li><a href="./AllProductList?tipo=pizza">Pizza</a></li>

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
	
	<br/>
	<div class="divContorno">
		<div id="contenitore">
		
		<h2>Silvio Cresci</h2>
		<p>Mail studenti: <a>s.cresci@studenti.unisa.it</a></p>
		<p>Mail personale: <a>silviocresci1996@gmail.com</a></p>
		<p><a><img src="img/facebook.png" alt="facebook" class="icon" id="facebook" style="height: 25px; width: 25px;"></a>Profilo Facebook</p>
		
		<h2>Raffella Romano</h2>
		<p>Mail studenti: <a>r.romano54@studenti.unisa.it</a></p>
		<p>Mail personale: <a>raffaellaromano4c@yahoo.it</a></p>
		<p><a><img src="img/facebook.png" alt="facebook" class="icon" id="facebook" style="height: 25px; width: 25px;"></a>Profilo Facebook</p>
		
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
	
	<p style="color:grey; text-align:center;">Copyright © 2018 La Saporita. All rights reserved.</p>

</body>
</html>