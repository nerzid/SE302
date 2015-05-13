/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author nerzid
 */
public class SendForms extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    public static boolean isProcessRequestErrorTest;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject json = new JSONObject(); 
        JSONArray jarray = new JSONArray();
        //ObjectOutputStream out = new ObjectOutputStream(response.getOutputStream());
        String dTabletKey = request.getParameter("dTabletKey");

        String sql = "SELECT fk_cID FROM Dealer where dTabletKey = ? ";
        Connection con = database.DatabaseHandler.getConnection();

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, dTabletKey);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                int fk_cID;
                
                fk_cID = rs.getInt("fk_cID");
                ps.close();
                
                sql = "SELECT fID, fName FROM Form WHERE fk_cID = ?";
                ps = con.prepareStatement(sql);
                ps.setInt(1, fk_cID);
                
                ResultSet rs_forms = ps.executeQuery();
                
                while(rs_forms.next())
                {
                    json = new JSONObject();
                    
                    int fID = rs_forms.getInt("fID");
                    String fName = rs_forms.getString("fName");
                    
                    
                    
                    String sql_question = "SELECT qID, qText FROM Question WHERE fk_fID = ?";
                    PreparedStatement ps_question = con.prepareStatement(sql_question);
                    
                    ps_question.setInt(1, fID);
                    
                    ResultSet rs_questions = ps_question.executeQuery();

                    while(rs_questions.next())
                    {
                        json = new JSONObject();
                        
                        json.put("fID", fID);
                        json.put("fName", fName);

                        
                        int qID = rs_questions.getInt("qID");
                        String qText = rs_questions.getString("qText");
                        
                        json.put("qText", qText);
                        
                        String sql_answer = "SELECT aText FROM Answer WHERE fk_qID = ?";
                        PreparedStatement ps_answer = con.prepareStatement(sql_answer);
                        
                        ps_answer.setInt(1, qID);
                        
                        ResultSet rs_answers = ps_answer.executeQuery();
                        int count_answers = 0;
                        while(rs_answers.next())
                        {
                            count_answers++;
                            String aText = rs_answers.getString("aText");
                            
                            json.put("aText" + count_answers, aText);
                        }
                        jarray.add(json);
                    } 
                }
                
            }
            else
            {
                json.put("message", "fail");
                isProcessRequestErrorTest = true;
            }
        } catch (Exception e) {
            json.put("error", e.getMessage());
            isProcessRequestErrorTest = true;
        }
        //System.out.println(json);
        isProcessRequestErrorTest = false;
        response.getWriter().write(jarray.toString());
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
