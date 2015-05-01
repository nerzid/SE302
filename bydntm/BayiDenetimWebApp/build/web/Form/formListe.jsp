<%-- 
    Document   : formListe
    Created on : May 1, 2015, 8:26:25 PM
    Author     : pinarsolak
--%>
<%@page import="java.sql.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
            String fID="";

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
             
             
             
             String query3 = "SELECT fID FROM Form where fk_cID ='"+companyID+"';";

            Statement statement3 = connection.createStatement();
             ResultSet resultSet3 = statement3.executeQuery(query3);

                     System.out.println(query3);
                  
             while (resultSet3.next()) {
                 fID = resultSet3.getString("fID");
               
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
               HttpSession httpSession = request.getSession(true);
              httpSession.setAttribute("fID", fID);
                   
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
