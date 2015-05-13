
<%@page import="java.sql.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>



<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <link rel="stylesheet" href="../layout/styles/layout.css" type="text/css" />

        <title>JSP Page</title>
    </head>
     <body id="top">
         
         
         <div class="wrapper col1">
  <div id="header">
    <div id="logo">
      <h1><a href="#">Bayi Denetim</a></h1>
      <p><strong></strong></p>
    </div>
    <div id="newsletter">
      <p></p>
     
         <form  method="get" action="../index.html">
        <fieldset>
          <legend>NewsLetter</legend>
       
   
        <input type="submit" name="logout" value="Log-out" />
        </fieldset>
      </form>
    </div>
  </div>
</div>  

         <div class="wrapper col2">
  <div id="topbar">
    <div id="topnav">
      <ul>
        <li class="active"><a href="../CompanyOfficer/profile.jsp">Profil</a></li>
        
      </ul>
    </div>
    
    <br class="clear" />
  </div>
</div>    
            <div class="wrapper col3">
  <div id="intro">
    <div class="fl_left">
  
 
       
               <%
       request.setCharacterEncoding("UTF-8");
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
           
    
            <table>
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
              <form method="post" action="../Question/soruListe.jsp">
                  <td> <input type="submit" name="fName" value="<%out.print(fName);%>"><br></td>
                   </form>
             
            </tr>    
                  <%
             }
             
              %> 
              
               </table>
              
              <%
               }catch(Exception e){
                    
            }
             %>

             
             
                   </div>
      <div class="fl_right"><img src="../images/demo/p1.jpg" width="350" height="350"/></div>
  </div>
</div>
    </body>
</html>
