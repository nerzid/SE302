<%-- 
    Document   : register1
    Created on : 14.May.2015, 23:13:51
    Author     : nerzid
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <title>TODO supply a title</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../layout/styles/layout.css" type="text/css" />

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
            <form  method="get" action="../CompanyOfficer/logIn.jsp">
                <fieldset>
                    <legend>NewsLetter</legend>
                    <input type="text" name="email" required="required"/>
                    <input type="text" name="password" required="required"/>
                    <input type="submit" name="login" value="login" />
                </fieldset>
            </form>
        </div>
    </div>
</div>

<div class="wrapper col2">
    <div id="topbar">
        <div id="topnav">
            <ul>
                <li class="active"><a href="../index.html">Anasayfa</a></li>
                <li><a href="../hakkimizda.html">Hakkimizda</a></li>
                <li><a href="../Home/registerCompany.html">Ücretsiz Üye Ol</a></li>
                <li><a href="../iletisim.html">Iletisim</a></li>

                <li class="last"><a href="../bayidenetim.html">Bayi Denetim Sistemi</a></li>
            </ul>
        </div>

        <br class="clear" />
    </div>
</div>

<div class="wrapper col3">
    <div id="intro">
        <div class="fl_left">


            <form method="post" action="register.jsp">

                <table>
                    <caption>Company Officer Register</caption>  
                    <tr>
                        <td> Company Officer Name: </td> <td> <input type="text" name="CompanyOffName" required="required"><br>  </td>
                        </tr>
                        <tr>
                            <td> Password: </td> <td> <input type="text" name="password" required="required"><br>  </td>
                            </tr>
                            <tr>
                                <td> Email </td> <td> <input type="text" name="email" required="required" ><br>  </td>
                                </tr>
                                <tr>
                                    <td> Company Name </td>
                                    <td> 
                                    <select name="CompanyName" required="required">
                                        <%

                                            request.setCharacterEncoding("UTF-8");
                                            boolean connect = false;
                                            try {
                                                Class.forName("com.mysql.jdbc.Driver");
                                                Connection connection = DriverManager.getConnection("jdbc:mysql://mysql03.turhost.com:3306/BayiDenetim", "se302", "SE302");
                                                connect = true;
                                                String sql = "SELECT cName, cID FROM Company";
                                                PreparedStatement psmt = connection.prepareStatement(sql);
                                                ResultSet rs = psmt.executeQuery();
                                                while(rs.next())
                                                {
                                                    out.println("<option value=\"" + rs.getString("cName") + "\">" + rs.getString("cName") + "</option>");
                                                }

                                            } catch (Exception e) {

                                            }
                                        %>
                                    </select>
                                    </td>
                                    </tr>

                                    <tr>
                                        <td></td><td><input type="submit" name="register" value ="register"><br><br></td>
                                        </tr>
                                        </table>
                                        </form>




                                        <form method="post" action="../CompanyOfficer/register.html">

                                            <input type="submit" name="register" value ="Register for Company Officer">

                                        </form>


                                        </div>
                                        <div class="fl_right"><img src="../images/demo/p1.jpg" width="350" height="350"/></div>
                                        </div>
                                        </div>




                                        </body>
                                        </html>
