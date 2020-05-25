<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name = "descrizione" content="La Saporita">
<meta name = "autore" content="Raffaella Romano">
<meta name = "autore" content="Silvio Cresci">

<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/slides.css" type="text/css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">


<title>Add new administrator account</title>
</head>
<body>

<%
try {
	String url = request.getRequestURL().toString();
	String username = (String) session.getAttribute("name");
	String AddOk = (String) session.getAttribute("AddOk");
	request.getSession().removeAttribute("AddOk");
%>

<!-- Navbar piccola -->
<div class = "navbar">

<div id = "main_menu">
<label class="toggle" for="toggle">&#9776;</label>
<input class="toggle" id="toggle" type="checkbox">
<nav>
<ul id = "menu">
<!-- HOME -->
<li class="current"><a href="index.jsp"><img src="img/logo.png" alt="Home" class="icon" id="home"></a></li>
<%
		if (username != null) {
%>
     <li style = "float: right;"><a>Benvenuto <%=username %></a></li>
     <li style="float: right;"><a href="logout.jsp?link=<%=url %>"> Logout </a></li>
<%
}
%>
</ul>
</nav>
</div>

</div>

<p><a href="adminPage.jsp">Return to the admin page.</a></p>
		<h2 align="center">Add new admin account.</h2>
		
		<div class="divContorno">
		<div id="contenitore">
		<form action="./AddAdminAccount" method="post">
			<table style="width:300px; height:250px" align="center">
				<caption class="tabTitle">New admin account</caption>
				<tr><td colspan=2>Username:</td></tr>
				<tr><td colspan=2>
					<input type="text" placeholder="Enter username" name="Username" required maxlength="45" style="width:100%; height:100%">
				</td></tr>
				<tr><td colspan=2>Password</td></tr>
				<tr><td colspan=2>
					<input type="password" placeholder="Enter password" name="Password" required maxlength="45" style="width:100%; height:100%">
				</td></tr>
				<tr><td class="buttonTd"><input type="submit" style="width:100%; height:100%" ></td>
					<td class="buttonTd"><input type="reset" style="width:100%; height:100%"></td></tr>
			</table>
		</form>
		
<% 
	} catch(NullPointerException e) {

		e.printStackTrace();} %>

	</div>
	</div>

</body>
</html>