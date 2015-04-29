<%-- 
    Document   : formlistesi
    Created on : Mar 12, 2015, 8:02:02 PM
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
            String companyOffID="";
            Class.forName("com.mysql.jdbc.Driver");
             System.out.println("driver loaded");
            Connection connection = DriverManager.getConnection("jdbc:mysql://mysql03.turhost.com:3306/BayiDenetim", "se302", "SE302");
             System.out.println("connection comleted");
            
            String query = "SELECT companyOffID FROM BayiDenetim.CompanyOfficer where email ='"+email+"';";

            Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query);

                                        System.out.println(query);

              while (resultSet.next()) {
                 companyOffID = resultSet.getString("companyOffID");
                
                  System.out.println( companyOffID );
             }
             
             
             String query2 = "SELECT question FROM BayiDenetim.Question where formID = (Select Form_has_CompanyOfficer.formID from BayiDenetim.Form_has_CompanyOfficer where Form_has_CompanyOfficer.companyOffID='"+companyOffID+"');";
             Statement statement2 = connection.createStatement();
             ResultSet resultSet2 = statement2.executeQuery(query2);

                System.out.println(query2);

                
            String question="";   
            
            String answer1, answer2, answer3;
                
                 String query3= "SELECT Answer.answer From BayiDenetim.Answer Where Answer.questionID IN (SELECT Question.questionID FROM BayiDenetim.Question where formID = (Select Form_has_CompanyOfficer.formID from BayiDenetim.Form_has_CompanyOfficer where Form_has_CompanyOfficer.companyOffID='"+ companyOffID +"'));";
                
            Statement statement3 = connection.createStatement();
             ResultSet resultSet3 = statement3.executeQuery(query3);

                System.out.println(query2);
          
          
           
            %>
            <table border="2" align="center">
                <tr>
                   
                    <td>Sorular</td>
                    <td></td>
                </tr>
        <%
            
            while(resultSet2.next()){
              
             question=resultSet2.getString("question");
              %>
              <tr>
                 
                  <td><%out.println(question);%> </td>
                  
                  <%
                  int i=0;
                   while(resultSet3.next() && i<=2){
                    answer1=resultSet3.getString("answer");
                    i++;
                  %>
                 
                   <td><%out.println(answer1);%> </td>
                  
                  <%
                   }
                   %>
                  
                  <td><input type="submit" name="sil" value ="sil"></td>
              </tr>
              
                
                <%
              
            }
            
            %>
            <form action="profile.jsp">
            <tr>  
                <td><input type="submit" name="anasayfa" value ="Anasayfa" action="profil.jsp"></td>
          </tr>
          </form>
            </table>
                <%
        }catch(Exception e){
                    
                    }
            
            
            
            %>




    </body>
</html>
