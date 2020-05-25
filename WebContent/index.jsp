<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<meta name="description" content="La Saporita">
<meta name="author" content="Silvio Cresci">
<meta name="author" content="Raffaella Romano">

<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/slides.css" type="text/css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">
<link rel="stylesheet" type="text/css" href="css/dropdownSearch.css">

<script>
	//Ricerca Live homepage

	var request = new XMLHttpRequest(); //crea una XMLRequest
	function sendInfo() {
		var v = document.vinform.t1.value; //legge il valore del textbox 't1' nel form 'vinform' 
		var url = "./LiveSearchServlet?val=" + v; //crea un url da inviare alla pagina contenente il valore letto dal form

		try {
			request.onreadystatechange = getInfo;
			request.open("GET", url, true);
			request.send();
		} catch (e) {
			alert("Unable to connect to server");
		}
	}

	function getInfo() {
		if (request.readyState == 4) {
			var val = request.responseText;
			document.getElementById('amit').innerHTML = val;
		}
	}
</script>

<title>La Saporita - HomePage</title>
</head>
<body>
<%
		String url = request.getRequestURL().toString();
		String name = (String) session.getAttribute("name");
		String usernameCliente = (String) session.getAttribute("usernameCliente");

		int isAdmin = 0;
		int isCliente = 0;
		if (name != null) {
	%>
	<!-- 
	<p><%=name%></p>
	<a href="logout.jsp?link=<%=url%>">Logout</a><br/>
	 -->
	<%
		try {
				isAdmin = (int) session.getAttribute("adminIn");
				isCliente = (int) session.getAttribute("ClienteIn");
			} catch (Exception e) {
				;
			}
	%>


	<%
		if (usernameCliente != null) {
	%>		
	<!-- 		<p>Username Cliente: <%=usernameCliente%></p>  -->
	<%
		}
		}
	%>
	<div id="header" align="center"><img src="img/titolo.png" alt="Titolo" width=30% height=5% ></div>
	<!-- Navbar -->
	<div class="navbar">
	
	<div id="main_menu">
		<label class="toggle" for="toggle">&#9776;</label> <!-- simbolo del menu (3 linee orizzontali) -->
		<input class="toggle" id="toggle" type="checkbox">
		<nav>
		<ul id="menu">
			<!-- HOME -->
			<li class="current"><a href="index.jsp"><img src="img/logo.png" alt="Home"
                                                         class="icon" id="home" width="40px" height="40px"></a></li>
			<!-- PRODOTTI -->
			<li class="has_children"><a href="./AllProductList?"> PRODOTTI</a>
				<ul>
					<!-- dropdown menu -->

					<li><a href="./AllProductList?tipo=pizze">Pizze</a></li>

					<li><a href="./AllProductList?tipo=panini">Panini</a></li>

					<li><a href="./AllProductList?tipo=sfizi">Sfizi</a></li>

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

	</div><!-- end navbar  -->

	
	<div class="dropdown-padre">
		<div class="dropdown" >
			<form name="vinform" action="AllProductList" method="get">
				<label>Cerca il tuo prodotto</label><br>
				<input type="text" name="search" onkeyup="sendInfo()" id="txtbox" size="70" placeholder="Es. Margherita">
			</form>
	
			<span id="amit"> </span>
		</div>
	</div>

	
	<div class="divContorno">
		<div id="contenitore">

			<!-- SLIDE SHOW OFFERTE -->

			<div class="slideshow-container">
				<div class="mySlides fade">
					<img src="img/Presentazione.jpg" style="width: 100%">
					
				</div>

				<div class="mySlides fade">
					<img src="img/Pascale.jpg" style="width: 100%">

				</div>

				<div class="mySlides fade">
					<img src="img/Offerta.jpg" style="width: 100%">

				</div>

			</div>
			<br>

			<div style="text-align: center">
				<span class="dot"></span> 
				<span class="dot"></span> 
				<span class="dot"></span> 
			
			</div>

		</div>
	</div>


	<script type="text/javascript">
		//Slides con offerte
		var slideIndex = 0;
		showSlides();

		function showSlides() {
			var i;
			var slides = document.getElementsByClassName("mySlides");
			var dots = document.getElementsByClassName("dot");
			for (i = 0; i < slides.length; i++) {
				slides[i].style.display = "none";
			}
			slideIndex++;
			if (slideIndex > slides.length) {
				slideIndex = 1
			}
			for (i = 0; i < dots.length; i++) {
				dots[i].className = dots[i].className.replace(" active", "");
			}
			slides[slideIndex - 1].style.display = "block";
			dots[slideIndex - 1].className += " active";
			setTimeout(showSlides, 5000); // Cambia immagine ogni 5 secondi
		}
	</script>


	<!-- Footer -->

	<footer id="footer">
	<hr>

	<div id="info_menu">
		<p>
			<a href="perConoscerci.jsp">Per conoscerci</a>
		</p>
		<p>
			<a href="contatti.jsp">Contatti</a>
		</p>
		<%
			if (isAdmin == 1) { //Admin connesso. Passa a pannello controllo admin
		%>
		<p id="right_side" align="right">
			<a href="adminPage.jsp">Zona Riservata</a>
		</p>
		<%
			} else if (isCliente == 1) { 
		%>
		<p id="right_side" align="right">
			<a href="login.jsp?link=<%=url%>">Zona Riservata</a>
		</p>
		<%
			} else { //nessuno connesso. Porta alla pagina di login
		%>
		<p id="right_side" align="right">
			<a href="login.jsp?link=<%=url%>">Zona Riservata</a>
		</p>
		<%
			}
		%>
	</div>

	</footer>

	<hr>

	<p style="color: grey; text-align: center;">Copyright © 2018
		La Saporita. All rights reserved.</p>
</body>
</html>