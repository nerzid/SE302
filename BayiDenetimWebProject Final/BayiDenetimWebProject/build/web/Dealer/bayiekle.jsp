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
       request.setCharacterEncoding("UTF-8");
        String email = session.getAttribute("email").toString();
        System.out.println(email);
        
        String dealerID = request.getParameter("dealerID");
        String dealersName = request.getParameter("dealersName");
        String dealersAddress = request.getParameter("dealersAddress");
        String dealersRating = request.getParameter("dealersRating");
        String tabletKey=request.getParameter("tabletKey");
        String tabletPassword=request.getParameter("tabletPass");
        String companyID="";

        try{
            String companyName="", address="";
            Class.forName("com.mysql.jdbc.Driver");
             System.out.println("driver loaded");
            Connection connection = DriverManager.getConnection("jdbc:mysql://mysql03.turhost.com:3306/BayiDenetim", "se302", "SE302");
             System.out.println("connection comleted");
            
            String query = "SELECT fk_cID FROM CompanyOfficer where coEmail ='"+email+"';";

            Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query);

              while (resultSet.next()) {
                 companyID = resultSet.getString("fk_cID");
                
                  System.out.println( companyID );
             }
             
              String query2 = " INSERT INTO `Dealer`(`dName`, `dAddress`, `dRating`, `dTabletKey`, `dTabletPass`, `fk_cID`)VALUES('"+dealersName+"','"+dealersAddress+"','"+dealersRating+"','"+tabletKey+"','"+tabletPassword+"','"+companyID+"');";
                                System.out.println( query2 );
                   Statement statement2 = connection.createStatement();
                   statement2.executeUpdate(query2);

               response.sendRedirect("./bayilistesi.jsp");

           
         
        }catch(Exception e){
                    
                    }
            
            
            
            %>
          
        
        
        
        
    </body>
</html>
