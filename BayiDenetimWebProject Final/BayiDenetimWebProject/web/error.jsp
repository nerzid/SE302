<%-- 
    Document   : error
    Created on : May 14, 2015, 9:36:43 PM
    Author     : pinarsolak
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="layout/styles/layout.css" type="text/css" />

    </head>

     <body id="top">
<div class="wrapper col1">
  <div id="header">
    <div id="logo">
      <h1><a href="#">Bayi Denetim</a></h1>
      <p><strong></strong></p>
    </div>
    <div id="newsletter">
      <p></p>
      <form  method="post" action="./CompanyOfficer/logIn.jsp">
        <fieldset>
          <legend>NewsLetter</legend>
 <input type="text" name="email" required="required"/>
<input type="text" name="password" required="required"/>
 <input type="submit" name="login" value="login" />
 
        </fieldset>
      </form>
    </div>
  </div>
</div>
         
<div class="wrapper col2">
  <div id="topbar">
    <div id="topnav">
      <ul>
        <li class="active"><a href="./index.html">Anasayfa</a></li>
        <li><a href="./hakkimizda.html">Hakkimizda</a></li>
        <li><a href="./Home/registerCompany.html">Ücretsiz Üye Ol</a></li>
        <li><a href="./iletisim.html">Iletisim</a></li>

        <li class="last"><a href="./bayidenetim.html">Bayi Denetim Sistemi</a></li>
      </ul>
    </div>
    
    <br class="clear" />
  </div>
</div>

  <div class="wrapper col3">
  <div id="intro">
    <div class="fl_left">
      <h6>ERROR PAGE</h6>
      
      
      <%
      
        request.setCharacterEncoding("UTF-8");
        String errorMessage = session.getAttribute("errorMessage").toString();
        
      %>
      <p> <%out.println(errorMessage);%></p>
      
      
    </div>
    <div class="fl_right"><img src="images/demo/bayi.png" alt="" /></div>
    <br class="clear" />
  </div>
</div>
         
         


    </body>
</html>
