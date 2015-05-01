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
        <title>JSP Page</title>
    </head>
    <body>
        
  <%
       
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
            <table border="2" align="center">
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
            <form action="profile.jsp">
            <tr>  
                <td><input type="submit" name="anasayfa" value ="Anasayfa" action="profile.jsp"></td>
          </tr>
          </form>
            </table>
                <%
        }catch(Exception e){
                    
                    }
            
            
            
            %>
          
    </body>
</html>
