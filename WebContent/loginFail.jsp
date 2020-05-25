<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String url = (String) session.getAttribute("link");
%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="descrizione" content="La saporita">
<meta name=" autore" content="Romano Raffaella">
<meta name=" autore" content="Silvio Cresci">

<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/slides.css" type="text/css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">
<meta http-equiv="Refresh" content="3;url=login.jsp?link=<%=url %>"> <!-- Reindirizza alla pagina di login dopo 3 secondi -->
<title>Login Fail</title>
</head>
<body>

<!-- Navbar mini-piccola -->
	<div class="navbar">
	
		<div id="main_menu">
		<label class="toggle" for="toggle">&#9776;</label> <!-- simbolo menu (3 linee orizzontali) -->
		<input class="toggle" id="toggle" type="checkbox">
		<nav>
			<ul id="menu">
				<!-- HOME -->
				<li class="current"><a href="index.jsp"><img src="img/logo.jpg" alt="Home" class="icon" id="home"></a></li>
			</ul>
		</nav>
			
		</div>

	
	</div>

	<br/>
	<div class="divContorno">
		<div id="contenitore">
			<p>I dati che hai inserito non sono validi.Tra 3 secondi sarai reindirizzato alla pagina di login.</p>
		</div>
	</div>
</body>
</html>