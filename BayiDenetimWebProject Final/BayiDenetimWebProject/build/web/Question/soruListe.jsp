<%-- 
    Document   : soruListe
    Created on : May 1, 2015, 8:38:13 PM
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
     
         <form  method="get" action="../index.html">
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
       
            String fName = request.getParameter("fName");

            System.out.println(fName);
        try{
            String companyID="";
            String fID="";
            String qText="";


            Class.forName("com.mysql.jdbc.Driver");
             System.out.println("driver loaded");
            Connection connection = DriverManager.getConnection("jdbc:mysql://mysql03.turhost.com:3306/BayiDenetim", "se302", "SE302");
             System.out.println("connection comleted");
            
            String query = "SELECT fID FROM Form where fName ='"+fName+"';";

            Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query);

                     System.out.println(query);
                  
             while (resultSet.next()) {
                 fID = resultSet.getString("fID");
               
                 System.out.println("fddddd"+fID);
             }
              
                              System.out.println("safdsf");

             String query2 = "SELECT qText FROM Question where fk_fID ='"+fID+"';";
                     System.out.println(query2);

            Statement statement2 = connection.createStatement();
             ResultSet resultSet2 = statement2.executeQuery(query2);

                     System.out.println(query2);
               HttpSession httpSession = request.getSession(true);
              httpSession.setAttribute("fID", fID);
                     
                    %>
            <table>
                <tr>
                   
                    <td>Sorular</td>
                    <form method="get" action="../Question/soruEkle.html">
                      <td> <input type="submit" name="ekle" value="Soru Ekle"><br></td>
                  </form>
                </tr>
        <%
             while (resultSet2.next()) {
                 qText = resultSet2.getString("qText");
                %>
              <tr>
              <form method="get" action="../Answer/cevapListe.jsp">
                  <td> <input type="submit" name="qText" value="<%out.print(qText);%>"><br></td>
             </form>
            </tr>    
                  <%
             }
              %>
             </table> 
             
             
              <%
              
               }catch(Exception e){
                    
            }
             %>
             </div>
      <div class="fl_right"><img src="../images/demo/p1.jpg" width="350" height="350"/></div>
  </div>
</div>

    </body>
</html>
