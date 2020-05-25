<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta name="descrizione" content="La saporita">
<meta name=" autore" content="Romano Raffaella">
<meta name=" autore" content="Silvio Cresci">

<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/slides.css" type="text/css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add new Locale</title>
</head>

<body>
<%  
	try {
		String url = request.getRequestURL().toString();
		String username = (String) session.getAttribute("name");
		String addOk = (String) session.getAttribute("addOk");
		request.getSession().removeAttribute("addOk");
%> 
<!-- Navbar piccola -->
	<div class="navbar">
	
		<div id="main_menu">
		<label class="toggle" for="toggle">&#9776;</label> <!-- simbolo menu (3 linee orizzontali) -->
		<input class="toggle" id="toggle" type="checkbox">
		<nav>
			<ul id="menu">
				<!-- HOME -->
				<li class="current"><a href="index.jsp"><img src="img/logo.png" alt="Home" class="icon" id="home"></a></li>
<%
	if(username!=null) {
%>		
				<li style="float: right;"><a>Benvenuto <%=username%></a></li>
				<li style="float: right;"><a href="logout.jsp?link=<%=url %>"> Logout </a></li>
<%
	} 
%>
			</ul>
			</nav>
			
		</div>

	
	</div>
	
		
		<p><a href="adminPage.jsp">Torna alla pagina di amministrazione.</a></p>
		<h2 align="center">Aggiungi nuovo locale.</h2>
		
		<div class="divContorno">
		<div id="contenitore">
		<form action="./AddLocale" method="post">
			<table align="center" style="width:300px; height:250px">
				<caption class="tabTitle">New locale</caption>
				<tr><td colspan=2>Codice:</td></tr>
				<tr><td colspan=2>
					<input type="text" placeholder="Enter id" name="codice" required style="width:100%; height:100%" maxlength="16">
				</td></tr>
				<tr><td colspan=2>Nome:</td></tr>
				<tr><td colspan=2>
					<input type="text" placeholder="Enter name" name="nome" required maxlength="20" style="width:100%; height:100%">
				</td></tr>
				<tr><td colspan=2>Via:</td></tr>
				<tr><td colspan=2>
					<input type="text" placeholder="Enter address" name="via" required maxlength="30" style="width:100%; height:100%">
				</td></tr>
				<tr><td colspan=2>Città:</td></tr>
				<tr><td colspan=2>
					<input type="text" placeholder="Enter city" name="citta" required maxlength="20" style="width:100%; height:100%">
				</td></tr>
				<tr><td colspan=2>CAP:</td></tr>
				<tr><td colspan=2>
					<input type="text" placeholder="Enter CAP" name="cap" required style="width:100%; height:100%" maxlength="5">
				</td></tr>
				<tr><td colspan=2>Telefono:</td></tr>
				<tr><td colspan=2>
					<input type="text" placeholder="Enter phone" name="telefono" required style="width:100%; height:100%" maxlength="5">
				
				<tr><td class="buttonTd"><input type="submit" style="width:100%; height:100%" ></td>
					<td class="buttonTd"><input type="reset" style="width:100%; height:100%"></td></tr>
			</table>
		</form>
		
<% 
	} catch(NullPointerException e) {

		e.printStackTrace(); }
		%>
		

</div>
</div>
</body>
</html>