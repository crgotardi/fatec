/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.util.ArrayList;

/**
 *
 * @author Cristiano
 */
public class DisciplinasConnector {
    private static final String CLASS_NAME = "org.sqlite.JDBC";
    private static final String URL = "C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0_Fatec\\lib\\sqlite-jdbc-3.32.3.2.jar";
    
    public static ArrayList<String> select() throws Exception {
        ArrayList<String> list = new ArrayList<>();
        Class.forName(CLASS_NAME);
        Connection conn = DriverManager.getConnection(URL);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM disciplinas;");
        while (rs.next()) {
            list.add(rs.getString("name"));
        }
        rs.close();
        stmt.close();
        conn.close();
        return list;
    }
    
    public static void insert(String name) throws Exception {
        Class.forName(CLASS_NAME);
        Connection conn = DriverManager.getConnection(URL);
        Statement stmt = conn.createStatement();
        stmt.execute("INSERT INTO disciplinas VALUES('"+name+"')");
        stmt.close();
        conn.close();
    }
    
    public static void delete(String name) throws Exception {
        Class.forName(CLASS_NAME);
        Connection conn = DriverManager.getConnection(URL);
        Statement stmt = conn.createStatement();
        stmt.execute("DELETE FROM disciplinas WHERE name='"+name+"'");
        stmt.close();
        conn.close();
    }
}
