<%-- 
    Document   : cevapListe
    Created on : May 1, 2015, 9:41:00 PM
    Author     : pinarsolak
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.sql.*"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Answer Page</title>
    </head>
    <body><html>
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
            String qText = request.getParameter("qText");
            String qID="";
              String aText="";
              String aID="";
              String aCount="";
            System.out.println(qText);
        try{


            Class.forName("com.mysql.jdbc.Driver");
             System.out.println("driver loaded");
            Connection connection = DriverManager.getConnection("jdbc:mysql://mysql03.turhost.com:3306/BayiDenetim", "se302", "SE302");
             System.out.println("connection comleted");
            
            String query = "SELECT qID FROM Question where qText ='"+qText+"';";

            Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query);

                  
             while (resultSet.next()) {
                 qID = resultSet.getString("qID");
               
             }

                
                String query2 = "SELECT aText FROM Answer where fk_qID ='"+qID+"';";
                 Statement statement2 = connection.createStatement();
             ResultSet resultSet2 = statement2.executeQuery(query2);

                 
                     
                     
                     
                     
                    %>
            <table border="2" align="center">
                <tr>
                    <td>Cevapları</td>
                </tr>
                <tr>
                   <td><%out.print(qText);%></td>

                
        <%
             while (resultSet2.next()) {
                 aText = resultSet2.getString("aText");
                %>
             
                  <td> <%out.print(aText);%><br></td>
        
              
                  <%
               String query3 = "SELECT aID FROM `Answer` WHERE fk_qID ='"+qID+"' and aText ='"+aText+"'";

               
                Statement statement3 = connection.createStatement();
             ResultSet resultSet3 = statement3.executeQuery(query3);

                  
             while (resultSet3.next()) {
                 aID = resultSet3.getString("aID");
                
             }
              System.out.println("aid"+aID);
              
              String query4 = "SELECT aCount FROM `Answer` WHERE aID='"+aID+"'";

            Statement statement4 = connection.createStatement();
             ResultSet resultSet4 = statement4.executeQuery(query4);

    
             while (resultSet4.next()) {

                 aCount = resultSet4.getString("aCount");
              %>
             
                  <td> <%out.print(aCount);%><br></td>
        
              
                  <%
        }
        }
             
             %>
                               </tr>

            </table>
                               <%
               }catch(Exception e){
                   System.out.println("Check database connection");
                   
                    
            }
             %>

     </div>
      <div class="fl_right"><img src="../images/demo/p1.jpg" width="350" height="350"/></div>
  </div>
</div>

    </body>
</html>
