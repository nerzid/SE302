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
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

/**
 *
 * @author nerzid
 */
public class ReceiveForms extends HttpServlet {
JSONObject json ;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

public static boolean isProcessRequestErrorTest;
public static boolean isUpdateRowErrorTest;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        json= new JSONObject();

        int success_count = 0;//Must be 3 in order to succesfull. 3 stands for number of answers

        //ObjectOutputStream out = new ObjectOutputStream(response.getOutputStream());
        String fNo = request.getParameter("formNo");
        String dTabletKey = request.getParameter("dTabletKey");

        String qText = request.getParameter("qText");
        String aText1 = request.getParameter("aText1");
        String aText2 = request.getParameter("aText2");
        String aText3 = request.getParameter("aText3");

        String aCount1 = request.getParameter("aCount1");
        String aCount2 = request.getParameter("aCount2");
        String aCount3 = request.getParameter("aCount3");

        String sql = "SELECT * FROM Dealer where dTabletKey = ? ";
        Connection con = database.DatabaseHandler.getConnection();

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, dTabletKey);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String sql_qID = "SELECT qID FROM Question WHERE fk_fID = ? AND qText = ?";
                PreparedStatement ps_qID = con.prepareStatement(sql_qID);
                ps_qID.setInt(1, Integer.parseInt(fNo));
                ps_qID.setString(2, qText);
                
                ResultSet rs_qID = ps_qID.executeQuery();
                if (rs_qID.next()) {
                    success_count += update_row(rs_qID.getInt("qID"), aText1, Integer.parseInt(aCount1), con);
                    success_count += update_row(rs_qID.getInt("qID"), aText2, Integer.parseInt(aCount2), con);
                    success_count += update_row(rs_qID.getInt("qID"), aText3, Integer.parseInt(aCount3), con);
                }
            }

        } catch (Exception e) {
            json.put("error", e.getMessage());
        }finally{
            if(success_count > 0)
            {
                json.put("message", "success");
                isProcessRequestErrorTest = false;
            }
            else
            {
                json.put("message", "fail " + success_count + " " + aText2);
                isProcessRequestErrorTest = true;
            }
        }
        //System.out.println(json);
        response.getWriter().write(json.toString());
    }

    private int update_row(int qID, String aText, int newCount, Connection con) {
        int count = 0;
        try {
            
            String sql_aID = "SELECT aID, aCount FROM Answer WHERE fk_qID = ? AND aText = ?";
            PreparedStatement ps_answer = con.prepareStatement(sql_aID);
            ps_answer.setInt(1, qID);
            ps_answer.setString(2, aText);
            
            
            ResultSet rs_answer = ps_answer.executeQuery();
            
            if (rs_answer.next()) {
                int aID = rs_answer.getInt("aID");
                int aCount = rs_answer.getInt("aCount");
                
                aCount += newCount;
                String sql_update_count = "UPDATE Answer SET aCount = ? WHERE aID = ?";
                PreparedStatement ps_update_count = con.prepareStatement(sql_update_count);
                ps_update_count.setInt(1, aCount);
                ps_update_count.setInt(2, aID);
                
                count += ps_update_count.executeUpdate();
                ps_update_count.close();
                ps_answer.close();
            }
            isUpdateRowErrorTest = false;
        } catch (SQLException ex) {
            json.put("message2", ex.getMessage());
            isUpdateRowErrorTest = true;
        }
        return count;
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
