<%-- 
    Document   : register
    Created on : Mar 12, 2015, 6:01:19 PM
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
        
        String CompanyOffID = request.getParameter("CompanyOffID");
        String password = request.getParameter("password");
        String email=request.getParameter("email");
        String CompanyOffName = request.getParameter("CompanyOffName");
        String CompanyName = request.getParameter("CompanyName");
        String companyID="";
        
        String query= "SELECT companyID from BayiDenetim.Company where companyName='"+CompanyName+"'";
        
        ResultSet rs = statement.executeQuery(query);
                 System.out.println(CompanyOffID +" "+ password + " " +email +" "+ CompanyName);

        while (rs.next()) {
                 companyID = rs.getString("companyID");
                
        }
        
         String query2 = "INSERT INTO `BayiDenetim`.`CompanyOfficer`(`companyOffID`,`companyOffName`,`password`,`email`,`companyID`)VALUES('"+CompanyOffID+"','"+CompanyOffName+"','"+password+"','"+email+"','"+companyID+"');";

         System.out.println(query2);
         Statement statement2 = connection.createStatement();
                   statement2.executeUpdate(query2);

              // response.sendRedirect("./profile.jsp");

           
        
           out.println("Your registiration is successfully.");
          
          
        }catch(Exception e){
            out.println("Registration is not succeed.");
        }
        
        
    %>


    </body>
</html>
