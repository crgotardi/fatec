<%-- 
    Document   : index
    Created on : Oct 20, 2020, 1:32:35 PM
    Author     : Cristiano
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="db.DisciplinasConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String error = null;
    
    if (request.getParameter("insert") != null) {
        try {
        String disciplina = request.getParameter("name");
        DisciplinasConnector.insert(disciplina);
        response.sendRedirect(request.getRequestURI());
        } catch (Exception ex) {
            error = ex.toString();
        }
    }
    
    if (request.getParameter("delete") != null) {
        try {
        String disciplina = request.getParameter("name");
        DisciplinasConnector.delete(disciplina);
        response.sendRedirect(request.getRequestURI());
        } catch (Exception ex) {
            error = ex.toString();
        }
    }
    
    ArrayList<String> list = new ArrayList<>();
    try {
        list = DisciplinasConnector.select();
    } catch (Exception ex) {
        error = ex.toString();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Disciplinas</h1>
        <form>
            <input type="text" name="name">
            <input type="submit" name="insert" value="inserir">
        </form>
        <% if (error != null) { %>
        <p> <%= error %> </p>
        <% } %>
        <table>
            <tr>
                <th>Nome</th>
                <th>Acoes</th>
            </tr>
            <% for (String disciplina: list) { %>
            <tr>
                <td><%= disciplina %></td>
                <td>
                    <input type="hidden" name="name" value="<%=disciplina%>">
                    <input type="submit" name="delete" value="Excluir">
                </td>
                <td> <input type="submit" name="delete" value="Excluir"> </td>
            </tr>
            <% } %> 
        </table>
    </body>
</html>
