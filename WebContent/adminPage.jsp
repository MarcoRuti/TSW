<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<meta name="descrizione" content="La saporita">
<meta name=" autore" content="Romano Raffaella">
<meta name=" autore" content="Silvio Cresci">

<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/slides.css" type="text/css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">
<link rel="stylesheet" href="css/tables.css" type="text/css">

<meta name="viewport" content="width-device-width, initial-scale-1.0">

<title>Admin Page</title>
</head>
<body>
<%
	String url = request.getRequestURL().toString();
	String name = (String) session.getAttribute("name");
	String usernameCliente = (String) session.getAttribute("usernameCliente");
	String action="visualizza";
	
	int isAdmin = 0;
	int isCliente = 0;
	if(name!=null) {
%>	
<!-- 
	<p><%=name %></p>
	<a href="logout.jsp?link=<%=url %>">Logout</a><br/>
	 -->
<%
	try {
		isAdmin = (int) session.getAttribute("adminIn");  
		isCliente = (int) session.getAttribute("clienteIn"); 
	}
	catch(Exception e){
		;
	}
		
%>

<!-- Navbar -->
	<div class="navbar">
	
		<div id="main_menu">
		<label class="toggle" for="toggle">&#9776;</label> <!-- simbolo menu (3 linee orizzontali) -->
		<input class="toggle" id="toggle" type="checkbox">
		<nav>
			<ul id="menu">
				<!-- HOME -->
				<li class="current"><a href="index.jsp"><img src="img/logo.png" alt="Home" class="icon" id="home"></a></li>
<%
	if(name!=null) {
%>		
				<li style="float: right;"><a>Benvenuto <%=name%></a></li>
				<li style="float: right;"><a href="logout.jsp?link=<%=url %>"> Logout </a></li>
<%
	} 
%>
			</ul>
			</nav>
			
		</div>

	
	</div>
<%  
	} 
	try {

		String username = (String) session.getAttribute("name");
		if(isAdmin == 1) { //accesso alla pagina con account amministratore
			
%>
		<h2 align="center">Pagina administrator</h2>
		
		<br/><br/>
		
		<div class="divContorno">
		<div id="contenitore">
		
		<table width="100%" class="adminTable">
		<tr class="adminTable"><td width="50%" class="adminTable">
		<fieldset>
			<legend>Admin account</legend>
			<p><a href="./DynamicTab?tab=adminaccount&action=<%=action%>">Visualizza e gestisci lista account amministratore.</a></p> <!-- permette modifica e rimozione nella pagina aperta -->
			<p><a href="newAdminAccountForm.jsp">Aggiungi nuovo account amministratore.</a></p>
		</fieldset>
		</td><td width="50%" class="adminTable">
		<fieldset>
			<legend>Gestione cliente</legend>
			<p><a href="./DynamicTab?tab=cliente&action=<%=action%>">Visualizza e gestisci lista clienti.</a></p>
			<p><a href="newCliente.jsp">Aggiungi cliente.</a></p>
		</fieldset>
		</td></tr>
		<tr class="adminTable"><td width="50%" class="adminTable">
		<fieldset>
			<legend>Gestione locale</legend>
			<p><a href="./DynamicTab?tab=locale&action=<%=action%>">Visualizza e gestisci locale.</a></p>
			<p><a href="newLocale.jsp">Aggiungi locale.</a></p>
		</fieldset>
		</td><td width="50%" class="adminTable">
		<fieldset>
			<legend>Gestione offerta</legend>
			<p><a href="./DynamicTab?tab=offerta&action=<%=action%>">Visualizza e gestisci lista offerte.</a></p>
			<p><a href="newOfferta.jsp">Aggiungi offerta.</a></p>
		</fieldset>
		</td></tr>
		<tr class="adminTable"><td width="50%" class="adminTable">
		<fieldset>
			<legend>Gestione prodotto</legend>
			<p><a href="./DynamicTab?tab=prodotto&action=<%=action%>">Visualizza e gestisci lista prodotti.</a></p>
			<p><a href="newProdotto.jsp">Aggiungi prodotto.</a></p>
			
		</fieldset>
		</td>
		<td width="50%" class="adminTable">
		<fieldset>
			<legend>Gestione Ordini</legend>
			<p><a href="./DynamicTab?tab=ordine&action=<%=action%>">Visualizza e gestisci lista ordini.</a></p>
		</fieldset>
		</td></tr>
		</table>
		
		
		
<%
		}
		else if(isCliente == 1) { //accesso alla pagina con account locale
%>
			<h2>ACCESSO NON AUTORIZZATO!</h2>
			<p>Questa pagina è riservata solo ad account administrator. Torna alla <a href="index.jsp">home</a> per loggarti.</p>
<%			
		}
		else if(isAdmin == 0) { //isAdmin sarà = 0 quando nessun account è al momento collegato
		%>
					<h2>ACCESSO NON AUTORIZZATO!</h2>
					<p>Non sei autorizzato ad entrare in questa pagina. Torna alla <a href="index.jsp">home</a> per loggarti.</p>

		<%
		}
	} catch(NullPointerException e) {
%>	
		<!-- 	<p><%=e %></p> -->
		<p>.</p>
		<h2>ACCESSO NON AUTORIZZATO!</h2>
		<p>Non sei autorizzato ad entrare in questa pagina. Torna alla <a href="index.jsp">home</a> per loggarti.</p>
<%
	}
	
%>
	</div>
	</div>
	
</body>
</html>