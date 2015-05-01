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
        <title>JSP Page</title>
    </head>
    <body>
     <%
       
            String qText = request.getParameter("qText");
            String qID="";
              String aText="";

            System.out.println(qText);
        try{


            Class.forName("com.mysql.jdbc.Driver");
             System.out.println("driver loaded");
            Connection connection = DriverManager.getConnection("jdbc:mysql://mysql03.turhost.com:3306/BayiDenetim", "se302", "SE302");
             System.out.println("connection comleted");
            
            String query = "SELECT qID FROM Question where qText ='"+qText+"';";

            Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query);

                     System.out.println(query);
                  
             while (resultSet.next()) {
                 qID = resultSet.getString("qID");
               
                 System.out.println("fddddd"+qID);
             }
                System.out.println("safdsf");

          
                
                String query2 = "SELECT aText FROM Answer where fk_qID ='"+qID+"';";
                     System.out.println(query2);

            Statement statement2 = connection.createStatement();
             ResultSet resultSet2 = statement2.executeQuery(query2);

                     System.out.println(query2);
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
             }
             %>
                               </tr>

             
                               <%
               }catch(Exception e){
                    
            }
             %>



    </body>
</html>
