/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;
import java.sql.*;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import model.Disciplina;

/**
 * Web application lifecycle listener.
 *
 * @author Cristiano
 */
public class DbListener implements ServletContextListener {
    private static final String CLASS_NAME = "org.sqlite.JDBC";
    private static final String DB_URL = "jdbc:sqlite:fatec.db";
    
    public static String exceptionMessage = null;
    
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL);
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        Connection con = null;
        Statement stmt = null;
        
        try{
            Class.forName(CLASS_NAME);
            con = DriverManager.getConnection(DB_URL);
            stmt = con.createStatement();
            stmt.execute(Disciplina.getCreateStatement());
            if (Disciplina.getList().isEmpty()) {
                stmt.execute("INSERT INTO disciplinas VALUES ("
                        + "'Programação orientada a objetos',"
                        + "'Conceitos e evolução da tecnologia de orientação a objetos.',"
                        + "4,"
                        + "0"
                        + ")");
                stmt.execute("INSERT INTO disciplinas VALUES ("
                        + "'Banco de dados',"
                        + "'Conceitos de Base de Dados. Modelos conceituais de informações. Modelos de Dados.',"
                        + "4,"
                        + "0"
                        + ")");
                stmt.execute("INSERT INTO disciplinas VALUES ("
                        + "'Segurança da informação',"
                        + "'Requisitos de segurança de aplicações, de base de dados e de comunicações.',"
                        + "4,"
                        + "0"
                        + ")");
                stmt.execute("INSERT INTO disciplinas VALUES ("
                        + "'Engenharia de software III',"
                        + "'Conceitos, evolução e importância de arquitetura de software. Padrões de Arquitetura.',"
                        + "4,"
                        + "0"
                        + ")");
                stmt.execute("INSERT INTO disciplinas VALUES ("
                        + "'Sistemas operacionais II',"
                        + "'Apresentação de um sistema operacional específico utilizado em ambiente corporativo.',"
                        + "4,"
                        + "0"
                        + ")");
                stmt.execute("INSERT INTO disciplinas VALUES ("
                        + "'Metodologia de pesquisa Científico-tecnologica',"
                        + "'O Papel da ciência e da tecnologia. Tipos de conhecimento. Método e técnica.',"
                        + "4,"
                        + "0"
                        + ")");
            }
        } catch(Exception ex) {
            exceptionMessage = ex.getLocalizedMessage();
        } finally {
            try{stmt.close();}catch(Exception ex2){}
            try{con.close();}catch(Exception ex2){}
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
