

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <link rel="stylesheet" href="../layout/styles/layout.css" type="text/css" />

        <title>JSP Page</title>
    </head>
   <body id="top">
       

       
  <%
      request.setCharacterEncoding("UTF-8");
        String email = session.getAttribute("email").toString();
        System.out.println(email);
        String login = "login";
              System.out.println(login);

        try{
            String companyName="", companyOffName="";
            Class.forName("com.mysql.jdbc.Driver");
             System.out.println("driver loaded");
            Connection connection = DriverManager.getConnection("jdbc:mysql://mysql03.turhost.com:3306/BayiDenetim", "se302", "SE302");
             System.out.println("connection comleted");
             
             
            Statement statement = connection.createStatement();
            String query = " SELECT coName FROM CompanyOfficer WHERE coEmail = '"+email+"'";
            ResultSet resultSet = statement.executeQuery(query);

            while(resultSet.next()){
                companyOffName=resultSet.getString("coName");
                
               
                 System.out.println(companyName);
            }
            

            
            
            %>
       
                
    <div class="wrapper col1">
  <div id="header">
    <div id="logo">
      <h1><a href="#">Bayi Denetim</a></h1>
      <p><strong></strong></p>
    </div>
    <div id="newsletter">
      <p></p>
     
         <form  method="post" action="../index.html">
        <fieldset>
          <legend>NewsLetter</legend>
       
   
        <input type="submit" name="logout" value="Log-out" />
        </fieldset>
      </form>
    </div>
  </div>
</div>
         
<div class="wrapper col2">
  <div id="topbar">
    <div id="topnav">
      <ul>
        <li class="active"><a href="../CompanyOfficer/profile.jsp">Welcome Dear <%out.println(companyOffName);%></a></li>
        
      </ul>
    </div>
    
    <br class="clear" />
  </div>
</div>    
            
            
            
            
            
            <div class="wrapper col3">
  <div id="intro">
    <div class="fl_left">
  
              <br><br>
                <table>
                    <form action="../Dealer/bayiekle.html" method="post">
                    <tr>
                        <td>Bayi Ekle</td><td><input type="submit" name="bayiEkle" value ="Bayi Ekle" width="150" height="100"><br><br></td>
        </tr>
                    </form><form action="../Dealer/bayilistesi.jsp" method="post">
                <tr>
            <td>Bayi Listesini Gör</td><td><input type="submit" name="bliste" value ="Bayi Listesi" width="150" height="100"><br><br></td>
        </tr>
        </form><form action="../Form/formekle.html" method="post">
                <tr>
            <td>Form Ekle</td><td><input type="submit" name="fekle" value ="Form Ekle" width="150" height="100"><br><br></td>
        </tr>
        </form><form action="../Form/formListe.jsp" method="post">
                <tr>
                    <td>Form Listesini Gör</td><td><input type="submit" name="fliste" value ="Form Listesi" width="150" height="100"><br><br></td>
        </tr>
               </form>
                
            </table>
            
              
            
            
            
            <%
          
        }
        catch(Exception e){
             HttpSession httpSession = request.getSession(true);
              String errorMessage = "Database connection problem";

          httpSession.setAttribute("errorMessage", errorMessage);
            response.sendRedirect("../error.jsp");
            
        }
  
  
  %>

  
    </div>
      <div class="fl_right"><img src="../images/demo/p1.jpg" width="350" height="350"/></div>
  </div>
</div>
    
  
    </body>
</html>
