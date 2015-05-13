/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author mcsahin
 */
public class DatabaseHandlerTest {
    
    Connection conn;
    
    public DatabaseHandlerTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
        conn = DatabaseHandler.getConnection();
    }
    
    
    
    @After
    public void tearDown() {
    }

    /**
     * Test of getConnection method, of class DatabaseHandler.
     */
    @Test
    public void testGetConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");//Mysql Connection
        } catch (ClassNotFoundException ex) {
            
        }
        try {
            con = DriverManager.getConnection("jdbc:mysql://mysql03.turhost.com:3306/BayiDenetim", "se302", "SE302");//mysql database
 
        } catch (SQLException ex) {
            
        }
        System.out.println("getConnection");
        Connection expResult = conn;
        Connection result = con;
        assertEquals(expResult.toString().contains("com.mysql.jdbc.JDBC4Connection@"), result.toString().contains("com.mysql.jdbc.JDBC4Connection@"));
        // TODO review the generated test code and remove the default call to fail.
    }
    
}
