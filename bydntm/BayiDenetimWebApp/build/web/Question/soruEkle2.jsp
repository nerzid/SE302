<%-- 
    Document   : soruEkle2
    Created on : May 1, 2015, 10:45:23 PM
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
       
        String email = session.getAttribute("email").toString();
        System.out.println(email);

        try{
            String companyID="";
            String fName="";

            Class.forName("com.mysql.jdbc.Driver");
             System.out.println("driver loaded");
            Connection connection = DriverManager.getConnection("jdbc:mysql://mysql03.turhost.com:3306/BayiDenetim", "se302", "SE302");
             System.out.println("connection comleted");
            
            String query = "SELECT fk_cID FROM CompanyOfficer where coEmail ='"+email+"';";

            Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query);

                     System.out.println(query);
                  
             while (resultSet.next()) {
                 companyID = resultSet.getString("fk_cID");
               
             }
              
             
             String query2 = "SELECT fName FROM Form where fk_cID ='"+companyID+"';";

            Statement statement2 = connection.createStatement();
             ResultSet resultSet2 = statement.executeQuery(query2);

                     System.out.println(query2);
                     
                     
            %>
            <table border="2" align="center">
                <tr>
                   
                    <td>Form</td>
                    <td></td>
                </tr>
        <%
            
             while (resultSet2.next()) {
                 fName = resultSet2.getString("fName");
                  %>
              <tr>
              <form method="get" action="/BayiDenetimWebApp/Question/soruListe.jsp">
                  <td> <input type="submit" name="fName" value="<%out.print(fName);%>"><br></td>
             </form>
            </tr>    
                  <%
             }
             
                  
              
               }catch(Exception e){
                    
            }
             %>
        
        



    </body>
</html>
