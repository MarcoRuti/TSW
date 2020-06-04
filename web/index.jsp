<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 22/05/2020
  Time: 16:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
  <!-- Codice da inserire -->
  <!-- <meta charset="UTF-8"> -->


  <!-- Linkare bootstrap da un sito -->
  <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"> -->
  <title>I-Buy</title>
  <link rel="stylesheet" type="text/css" href="css/page_style.css">
  <link rel="stylesheet" type="text/css" href="css/footer.css">
  <link rel="stylesheet" href="css/slides.css" type="text/css">
  <link rel="stylesheet" href="css/divStyle.css" type="text/css">
  <link rel="stylesheet" type="text/css" href="css/searchProductHome.css">

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
	<p>< %=name%></p>
	<a href="logout.jsp?link=< %=url%>">Logout</a><br/>
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
<div id="header" align="center"><img src="img/logo.jpg" alt="Titolo" width=30% height=5% ></div>
<!-- Navbar -->
<div class="navbar">

  <div id="main_menu">
    <label class="toggle" for="toggle">&#9776;</label> <!-- simbolo del menu (3 linee orizzontali) -->
    <input class="toggle" id="toggle" type="checkbox">
    <nav>
      <ul id="menu">
        <!-- HOME -->
        <li class="current"><a href="index.jsp"><img src="img/logo.jpg" alt="Home"
                                                     class="icon" id="home" width="40px" height="40px"></a></li>
        <!-- PRODOTTI -->
        <li class="has_children"><a href=""> PRODOTTI</a>
          <ul>
            <!-- dropdown menu -->

            <li><a href="">Accessori</a></li>

            <li><a href="">Smartphone</a></li>

            <li><a href="">Workstation</a></li>

            <li><a href="">Notebook</a></li>

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
        <li style="float: right;"><a href="CartPage.jsp">
          <img src="img/carrello_vuoto.png" alt="Carrello" class="icon"
                id="cartHome" style="height: 30px; width: 30px;"></a></li>



      </ul>
    </nav>
  </div>

</div><!-- end navbar  -->


<div class="dropdown-padre">
  <div class="dropdown" >
    <form name="vinform" action="" method="get">
      <label>Cerca il tuo prodotto</label><br>
      <input type="text" name="search" onkeyup="sendInfo()" id="txtbox" size="70" placeholder="Es. Macbook">
    </form>

    <span id="amit"> </span>
  </div>
</div>


<div class="divContorno">
  <div id="contenitore">



    <div class="slideshow-container">
      <div class="mySlides fade">
        <img src="img/prodotto1.jpeg" style="width: 100%">

      </div>

      <div class="mySlides fade">
        <img src="img/prodotto2.jpg" style="width: 100%">

      </div>

      <div class="mySlides fade">
        <img src="img/prodotto1.jpeg" style="width: 100%">

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
  //Slides con prodotti
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
      <a href="">Per conoscerci</a>
    </p>
    <p>
      <a href="">Contatti</a>
    </p>

    <p id="right_side" align="right">
      <a href="adminPage.jsp">Zona Riservata</a>
    </p>

  </div>

</footer>

<hr>

<p style="color: grey; text-align: center;">Copyright � 2020
  I-Buy. All rights reserved.</p>
</body>
</html>
