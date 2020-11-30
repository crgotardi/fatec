/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.*;
import web.DbListener;
import java.util.ArrayList;

/**
 *
 * @author Cristiano
 */
public class Disciplina {
    private long rowid;
    private String nome;
    private String ementa;
    private int ciclo;
    private float nota;
    
    public Disciplina(long rowid, String nome, String ementa, int ciclo, float nota) {
        this.rowid = rowid;
        this.nome = nome;
        this.ementa = ementa;
        this.ciclo = ciclo;
        this.nota = nota;
    }
    
    public static ArrayList<Disciplina> getList() throws Exception {
        ArrayList<Disciplina> list = new ArrayList<>();
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try{
            con = DbListener.getConnection();
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT rowid, * from disciplinas");
            while(rs.next()) {
                list.add(new Disciplina(
                        rs.getLong("rowid"),
                        rs.getString("nome"),
                        rs.getString("ementa"),
                        rs.getInt("ciclo"),
                        rs.getFloat("nota")
                ));
            }
        } catch(Exception ex) {
            throw ex;
        } finally{
            try{rs.close();}catch(Exception ex2){}
            try{stmt.close();}catch(Exception ex2){}
            try{con.close();}catch(Exception ex2){}
        }
        return list;
    }
    
    public static void insert(String nome, String ementa, int ciclo, float nota) throws Exception {
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try{
            con = DbListener.getConnection();
            stmt = con.prepareStatement("INSERT INTO disciplinas(nome, ementa, ciclo, nota) VALUES(?,?,?,?)");
            stmt.setString(1, nome);
            stmt.setString(2, ementa);
            stmt.setInt(3, ciclo);
            stmt.setFloat(4, nota);
        } catch(Exception ex) {
            throw ex;
        } finally{
            try{rs.close();}catch(Exception ex2){}
            try{stmt.close();}catch(Exception ex2){}
            try{con.close();}catch(Exception ex2){}
        }
    }
    
    public static void delete(long rowid) throws Exception {
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try{
            con = DbListener.getConnection();
            stmt = con.prepareStatement("DELETE FROM disciplinas WHERE rowid=?");
            stmt.setLong(1, rowid);
        } catch(Exception ex) {
            throw ex;
        } finally{
            try{rs.close();}catch(Exception ex2){}
            try{stmt.close();}catch(Exception ex2){}
            try{con.close();}catch(Exception ex2){}
        }
    }
    
    public long getRowId() {
        return rowid;
    }

    public void setRowId(long rowid) {
        this.rowid = rowid;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmenta() {
        return ementa;
    }

    public void setEmenta(String ementa) {
        this.ementa = ementa;
    }

    public int getCiclo() {
        return ciclo;
    }

    public void setCiclo(int ciclo) {
        this.ciclo = ciclo;
    }

    public float getNota() {
        return nota;
    }

    public void setNota(float nota) {
        this.nota = nota;
    }
    
    public static String getCreateStatement() {
        return "CREATE TABLE IF NOT EXISTS disciplinas("
                + "nome VARCHAR(60) NOT NULL,"
                + "ementa VARCHAR(200),"
                + "ciclo numeric(2,1) NOT NULL,"
                + "nota numeric(3,2) NOT NULL"
                + ")";
    }
}
