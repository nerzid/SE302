<%-- 
    Document   : bayilistesi
    Created on : Mar 12, 2015, 8:01:51 PM
    Author     : pinarsolak
--%>

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
        <li class="active"><a href="../CompanyOfficer/profile.jsp">Profil</a></li>
        
      </ul>
    </div>
    
    <br class="clear" />
  </div>
</div>    
            <div class="wrapper col3">
  <div id="intro">
    <div class="fl_left">
  

        
  <%
       request.setCharacterEncoding("UTF-8");
        String email = session.getAttribute("email").toString();
        System.out.println(email);

        try{
            String companyName="", address="";
            Class.forName("com.mysql.jdbc.Driver");
             System.out.println("driver loaded");
            Connection connection = DriverManager.getConnection("jdbc:mysql://mysql03.turhost.com:3306/BayiDenetim", "se302", "SE302");
             System.out.println("connection comleted");
            
            String query = "SELECT dName, dAddress, dRating FROM Dealer where fk_cID =(SELECT fk_cID FROM CompanyOfficer where coEmail ='"+email+"');";


            Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query);

             
                
            String dealersName="", dealersAddress="", dealersRating="";    
           
          
          
           
            %>
            <table>
                <tr>
                    <td>Bayi İsmi</td>
                    <td>Bayi Adresi</td>
                    <td>Bayi Rating</td>
                    <td></td>
                </tr>
        <%
            while(resultSet.next()){
              
              dealersName=resultSet.getString("dName");
              dealersAddress=resultSet.getString("dAddress"); 
              dealersRating=resultSet.getString("dRating");
              
              %>
              <tr>
                  <td><%out.println(dealersName);%> </td>
                  <td><%out.println(dealersAddress);%> </td>
                  <td><%out.println(dealersRating);%> </td>
                  <td><input type="submit" name="sil" value ="sil"></td>
              </tr>
              
                
                <%
              
            }
            
            %>
          
            </table>
                <%
        }catch(Exception e){
                String errorMessage = "";    
              System.out.println("check database connection");
                HttpSession httpSession = request.getSession(true);

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
