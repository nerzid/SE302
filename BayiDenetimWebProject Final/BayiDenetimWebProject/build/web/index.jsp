<%-- 
    Document   : index
    Created on : 02.May.2015, 06:34:53
    Author     : nerzid
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
    <h1>Hello World!</h1>
    
    <% 
        request.setCharacterEncoding("UTF-8");
        response.sendRedirect("/BayiDenetimWebProject/Home/homePage.html");
    %>
</body>
</html>
