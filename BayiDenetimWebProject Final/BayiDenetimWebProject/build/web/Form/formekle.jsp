<%-- 
    Document   : formekle
    Created on : Mar 12, 2015, 8:02:10 PM
    Author     : pinarsolak
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>


       <%
           request.setCharacterEncoding("UTF-8");
          String email = session.getAttribute("email").toString();
   
        String formName = request.getParameter("fName");
        String formType = request.getParameter("fType");
        String fID = "";
                String fk_cID = "";

                boolean connect = false;
        try {

            Class.forName("com.mysql.jdbc.Driver");
            System.err.println("Driver loadeddd");
            Connection connection = DriverManager.getConnection("jdbc:mysql://mysql03.turhost.com:3306/BayiDenetim", "se302", "SE302");
            System.err.println("Connection completed");
            
            connect = true;
              String query = "SELECT fk_cID FROM CompanyOfficer where coEmail ='"+ email+"';";

            Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query);

              while (resultSet.next()) {
                 fk_cID = resultSet.getString("fk_cID");
                
                  System.out.println( fk_cID );
             }
             
              
              
              String query2 = "INSERT INTO `Form`(`fName`, `fType`, `fk_cID`) VALUES('"+formName+"','"+formType+"','"+fk_cID+"');";
                                System.out.println( query2 );
                   Statement statement2 = connection.createStatement();
                   statement2.executeUpdate(query2);


                   String query3 = "SELECT `fID` FROM `Form` WHERE fName='"+ formName+"' and  fType= '"+formType+"';";
                          System.out.println( query3 );

                  Statement statement3 = connection.createStatement();
             ResultSet resultSet2 = statement3.executeQuery(query3);
                   
             
             
               while (resultSet2.next()) {
                 fID = resultSet2.getString("fID");
                
                  System.out.println( fID );
           
               }
                   
                    HttpSession httpSession = request.getSession(true);
                  httpSession.setAttribute("fID", fID);
                   
                   
                   response.sendRedirect("../Question/soruEkle.html");

        
        }  catch (Exception e) {
            String errorMessage="";
            if(connect == false){
                errorMessage = "database connection problem";
                
            }
            else{
                errorMessage = "database insertion problem";
            }
            
              HttpSession httpSession = request.getSession(true);

          httpSession.setAttribute("errorMessage", errorMessage);
            response.sendRedirect("../error.jsp");

        }
            
       
       
       
       
       
       %>



    </body>
</html>
