<%-- 
    Document   : registerCompany
    Created on : May 2, 2015, 12:30:36 AM
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
          try{
         Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://mysql03.turhost.com:3306/BayiDenetim", "se302", "SE302");
        Statement statement = connection.createStatement();
        
        String cID = "";
        String cName = request.getParameter("cName");
        String cAddress=request.getParameter("cAddress");
        String cFax = request.getParameter("cFax");
        String cPhone = request.getParameter("cPhone");
        
       
        
         String query2 = "INSERT INTO `Company`(`cName`, `cAddress`, `cFax`, `cPhone`) VALUES('"+cName+"','"+cAddress+"','"+cFax+"','"+cPhone+"');";

         System.out.println(query2);
         Statement statement2 = connection.createStatement();
                   statement2.executeUpdate(query2);

          
  %>

            <p align="center"> <% out.println("Registration is succeed"); %></p>
   
    <%
            response.sendRedirect("/BayiDenetimWebApp/Home/homepage.html");
        
          
        }catch(Exception e){
            out.println("Registration is not succeed.");
        }
        
        
    %>




    </body>
</html>