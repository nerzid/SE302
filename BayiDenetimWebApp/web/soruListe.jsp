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
        <title>JSP Page</title>
    </head>
    <body>
             <%
       
            String fName = request.getParameter("fName");
            System.out.println("HEHEHE BURDAA");

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
                    %>
            <table border="2" align="center">
                <tr>
                   
                    <td>Sorular</td>
                    <td></td>
                </tr>
        <%
             while (resultSet2.next()) {
                 qText = resultSet2.getString("qText");
                %>
              <tr>
              <form method="get" action="cevapListe.jsp">
                  <td> <input type="submit" name="qText" value="<%out.print(qText);%>"><br></td>
             </form>
            </tr>    
                  <%
             }
              
              
               }catch(Exception e){
                    
            }
             %>


    </body>
</html>
