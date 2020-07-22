<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html>
  <head>

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
        var url = "LiveSearchServlet?val="+v; //crea un url da inviare alla pagina contenente il valore letto dal form

        try {
          request.onreadystatechange = getInfo;
          request.open("GET", url, true);
          request.send();
        }
        catch (e)
        {
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

    <title>I-Buy - Home Page</title>
  </head>
  <body>
    <%
      String url = request.getRequestURL().toString();
      String name = (String) session.getAttribute("name");
      String usernameCliente = (String) session.getAttribute("usernameCliente");

      int isAdmin = 0;
      int isCliente = 0;
      if (name != null) {

      try {
        isAdmin = (int) session.getAttribute("adminIn");
        isCliente = (int) session.getAttribute("ClientIn");
      } catch (Exception e) {
        ;
      }



      if (usernameCliente != null) {
          %>


    		<p>Username Cliente: <%=usernameCliente%></p>
    <%
        }
      }
    %>

    <div id="header" align="center">
      <img src="img/logo.jpg" alt="Titolo" width=30% height=5%>
    </div>
    <!-- Navbar -->
    <div class="navbar">

      <div id="main_menu">
        <label class="toggle" for="toggle">&#9776;</label> <!-- simbolo del menu (3 linee orizzontali) -->
        <input class="toggle" id="toggle" type="checkbox">
        <nav>
          <ul id="menu">
            <!-- HOME -->
            <li class="current">
              <a href="index.jsp"><img src="img/logo.jpg" alt="Home" class="icon" id="home" width="40px" height="40px"></a>
            </li>

            <!-- PRODOTTI -->
            <li class="has_children">
              <a href=""> PRODOTTI</a> <!-- RIMOSSO LINK ALL DARIO -->
              <ul>
                <!-- dropdown menu -->

                <li>
                  <a href="AllProductList?tipo=Accessori">Accessori</a>
                </li>
                <li>
                  <a href="AllProductList?tipo=Smartphone">Smartphone</a>
                </li>
                <li>
                  <a href="AllProductList?tipo=Workstation">Workstation</a>
                </li>
                <li>
                  <a href="AllProductList?tipo=Notebook">Notebook</a>
                </li>

              </ul>
            </li>

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
              <a href="CartPage.jsp">
                <img src="img/carrello_vuoto.png" alt="Carrello" class="icon" id="cartHome" style="height: 30px; width: 30px;">
              </a>
            </li>

          </ul>
        </nav>
      </div>
    </div><!-- end navbar  -->

    <div class="dropdown-padre">
      <div class="dropdown" >
        <form name="vinform" action="" method="get">
          <label>Cerca il tuo prodotto</label>
          <br>
          <input type="text" name="t1" onkeyup="sendInfo()" id="txtbox" size="70" placeholder="Inizia a digitare per cercare un prodotto...">
        </form>

        <span id="amit"> </span>
      </div>
    </div>

    <div class="divContorno">
      <div id="contenitore">

        <div class="slideshow-container">

          <div class="mySlides fade">
            <img src="img/MacbookPro.jpg" alt="slidefade" style="width: 100%">
          </div>
          <div class="mySlides fade">
            <img src="img/Surface.jpg" alt="slidefade" style="width: 100%">
          </div>

          <div class="mySlides fade">
            <img src="img/Airpods2.jpg" alt="slidefade" style="width: 100%">
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
      //Slides con prodotti DOM JS
      var slideIndex = 0;
      showSlides();

      function showSlides() {
        var i;
        var slides = document.getElementsByClassName("mySlides"); // returns a collection of all elements in the document with the specified class name, as an HTMLCollection object.The HTMLCollection object represents a collection of nodes. The nodes can be accessed by index numbers. The index starts at 0.
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
        setTimeout(showSlides, 3000); // Cambia immagine ogni 3 secondi
      }
    </script>

    <!-- Footer -->

    <footer id="footer">
      <hr>

      <div id="info_menu">
        <p>
          <a href="perConoscerci.jsp">Per conoscerci</a>
        </p>

        <p id="right_side" align="right">
          <a href="adminPage.jsp">Zona Riservata</a>
        </p>

      </div>
    </footer>

    <hr>
    <p style="color: grey; text-align: center;">Copyright © 2020 I-Buy. All rights reserved.</p>

  </body>
</html>
