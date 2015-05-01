

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
       System.out.println("burdaaa");
        String email = session.getAttribute("email").toString();
        System.out.println(email);
        String login = "login";
              System.out.println(login);

        try{
            String companyName="", companyOffName="";
            Class.forName("com.mysql.jdbc.Driver");
             System.out.println("driver loaded");
            Connection connection = DriverManager.getConnection("jdbc:mysql://mysql03.turhost.com:3306/BayiDenetim", "se302", "SE302");
             System.out.println("connection comleted");
             
             
            Statement statement = connection.createStatement();
            String query = " SELECT coName FROM CompanyOfficer WHERE coEmail = '"+email+"'";
            ResultSet resultSet = statement.executeQuery(query);

            while(resultSet.next()){
               //companyName=resultSet.getString("coID");
                companyOffName=resultSet.getString("coName");
                
               
                 System.out.println(companyName);
            }
            

            
            
            %>
          
            
              <caption width="200px"><td>Welcome Dear <%out.println(companyOffName);%> </caption> 
              <br><br>
                <table border="2" align="left">
                    <form action="bayiekle.html" method="get">
                    <tr>
                        <td>Bayi Ekle</td><td><input type="submit" name="bayiEkle" value ="bayiEkle"><br><br></td>
        </tr>
                    </form><form action="bayilistesi.jsp" method="get">
                <tr>
            <td>Bayi Listesini Gör</td><td><input type="submit" name="bliste" value ="bliste"><br><br></td>
        </tr>
        </form><form action="formekle.html" method="get">
                <tr>
            <td>Form Ekle</td><td><input type="submit" name="fekle" value ="fekle"><br><br></td>
        </tr>
        </form><form action="formListe.jsp" method="get">
                <tr>
            <td>Form Listesini Gör</td><td><input type="submit" name="fliste" value ="fliste"><br><br></td>
        </tr>
               </form>
            </table>
            
            
            
            
            <%
          
        }
        catch(Exception e){
            
        }
  
  
  %>

  
  
    </body>
</html>
