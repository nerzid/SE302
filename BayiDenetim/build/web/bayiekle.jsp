<%-- 
    Document   : bayiekle
    Created on : Mar 12, 2015, 7:55:53 PM
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
        
        String dealerID = request.getParameter("dealerID");
        String dealersName = request.getParameter("dealersName");
        String dealersAddress = request.getParameter("dealersAddress");
        String dealersRating = request.getParameter("dealersRating");
        String companyOffID="";

        try{
            String companyName="", address="";
            Class.forName("com.mysql.jdbc.Driver");
             System.out.println("driver loaded");
            Connection connection = DriverManager.getConnection("jdbc:mysql://mysql03.turhost.com:3306/BayiDenetim", "se302", "SE302");
             System.out.println("connection comleted");
            
            String query = "SELECT companyOffID FROM BayiDenetim.CompanyOfficer where email ='"+email+"';";

            Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query);

              while (resultSet.next()) {
                 companyOffID = resultSet.getString("companyOffID");
                
                  System.out.println( companyOffID );
             }
             
              String query2 = "INSERT INTO `BayiDenetim`.`Dealers`(`dealersID`,`dealersName`,`dealersAddress`,`dealersRating`,`companyOfficerhas`)VALUES('"+dealerID+"','"+dealersName+"','"+dealersAddress+"','"+dealersRating+"','"+companyOffID+"');";
                                System.out.println( query2 );
                   Statement statement2 = connection.createStatement();
                   statement2.executeUpdate(query2);

               response.sendRedirect("./bayilistesi.jsp");

           
            
            
            %>
        </table>
                <%
        }catch(Exception e){
                    
                    }
            
            
            
            %>
          
        
        
        
        
    </body>
</html>
