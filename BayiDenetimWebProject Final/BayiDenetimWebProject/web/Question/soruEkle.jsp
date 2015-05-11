<%-- 
    Document   : soruEkle
    Created on : May 1, 2015, 6:15:42 PM
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
          String formID = session.getAttribute("fID").toString();

        
        String soru = request.getParameter("soru");
        String cevapA = request.getParameter("cevapA");
        String cevapB = request.getParameter("cevapB");
        String cevapC = request.getParameter("cevapC");
        String qid="";

         try {

            Class.forName("com.mysql.jdbc.Driver");
            System.err.println("Driver loadeddd");
            Connection connection = DriverManager.getConnection("jdbc:mysql://mysql03.turhost.com:3306/BayiDenetim", "se302", "SE302");
            System.err.println("Connection completed");
            
          String query = "INSERT INTO `Question`(`qText`, `fk_fID`) VALUES ('"+soru+"','"+formID+"')";
                        System.out.println( query );
                   Statement statement = connection.createStatement();
                   statement.executeUpdate(query);

                   


            String query2 = "SELECT `qID` FROM `Question` WHERE fk_fID='"+formID+"'";

            Statement statement2 = connection.createStatement();
             ResultSet resultSet = statement2.executeQuery(query2);

              while (resultSet.next()) {
                 qid = resultSet.getString("qID");
                
                  System.out.println( qid );
             }
             
              
             
           String query3 = "INSERT INTO `Answer`(`aText`, `fk_qID`) VALUES ('"+cevapA+"','"+qid+"')";
            System.out.println( query3 );
           Statement statement3 = connection.createStatement();
            statement3.executeUpdate(query3);

            String query4 = "INSERT INTO `Answer`(`aText`, `fk_qID`) VALUES ('"+cevapB+"','"+qid+"')";
            System.out.println( query4 );
           Statement statement4 = connection.createStatement();
            statement4.executeUpdate(query4);
            
             String query5 = "INSERT INTO `Answer`(`aText`, `fk_qID`) VALUES ('"+cevapC+"','"+ qid +"')";
            System.out.println( query5 );
           Statement statement5 = connection.createStatement();
            statement5.executeUpdate(query5);

        
            response.sendRedirect("../BayiDenetimWebProject/index.html");
        }  catch (Exception e) {

               System.out.println("olmadı");

        }
            
       
        
        
        
        %>

    </body>
</html>
