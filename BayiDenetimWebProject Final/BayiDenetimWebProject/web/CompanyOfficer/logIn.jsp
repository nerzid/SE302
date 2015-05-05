<%-- 
    Document   : login
    Created on : 26.Kas.2014, 22:33:51
    Author     : P?narSolak
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
    
       <%
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String email1 = "", password1 = "";
        try {

            Class.forName("com.mysql.jdbc.Driver");
            System.err.println("Driver loadeddd");
            Connection connection = DriverManager.getConnection("jdbc:mysql://mysql03.turhost.com:3306/BayiDenetim", "se302", "SE302");
            System.err.println("Connection completed");
           
            Statement statement = connection.createStatement();
            String query = "SELECT coEmail, coPass FROM CompanyOfficer where coEmail='" + email + "' and coPass='" + password + "'";

            ResultSet resultSet = statement.executeQuery(query);

            
            while (resultSet.next()) {
                 email1 = resultSet.getString("coEmail");
                password1 = resultSet.getString("coPass");
                
                  System.out.println(email1 +" "+ password1);

             }

        } catch (Exception e) {

        }
        if ((email.equals(email1)) && (password.equals(password1))) {

            HttpSession httpSession = request.getSession(true);
            httpSession.setAttribute("email", email);
            httpSession.setAttribute("password", password);
            response.sendRedirect("./profile.jsp");

        } else {%>
    <p align="center"> <% out.println("Oturum açma başarısız"); %></p>
    <%

        }


    %>
    
    
      
    
    
   
   
</body>
</html>
