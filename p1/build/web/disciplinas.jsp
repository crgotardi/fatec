<%-- 
    Document   : disciplinas
    Created on : Oct 4, 2020, 6:43:19 PM
    Author     : Cristiano
--%>

<%@page import="model.Disciplina"%>
<%@page import="java.util.ArrayList"%>
<%@include file="./WEB-INF/jspf/header.jspf"%>
<%
  String exceptionMessage = null;
  if(request.getParameter("formInsert") != null) {
      try{
          String nome = request.getParameter("nome");
          String ementa = request.getParameter("ementa");
          int ciclo = Integer.parseInt(request.getParameter("ciclo"));
          float nota = Float.parseFloat(request.getParameter("nota"));
          Disciplina.insert(nome, ementa, ciclo, nota);
          response.sendRedirect(request.getRequestURI());
      } catch(Exception ex) {
          exceptionMessage = ex.getLocalizedMessage();
      }
  }
  
if(request.getParameter("formDelete") != null) {
      try{
          long rowid = Long.parseLong(request.getParameter("rowid"));
          Disciplina.delete(rowid);
          response.sendRedirect(request.getRequestURI());
      } catch(Exception ex) {
          exceptionMessage = ex.getLocalizedMessage();
      }
  }
%>

<div class="container bg-light mt-5">
    <br><br>
    <div class="row">
        <div class="col-12">
            <h2>Disciplinas</h2>
        </div>
    </div>
    <% if (exceptionMessage != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <span><%= exceptionMessage %></span>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
        </div>
    <% } %>
    <% if(request.getParameter("prepareInsert") != null) { %>
    <div class="col-md-12 bg-light my-3 p-3">
        <h3>Cadastrar nova disciplina</h3>
        <form method="GET">
            <div class="form-row">
                <div class="col">
                    <label class="form-check-label">Nome</label>
                    <input type="text" name="nome" class="form-control">
                </div>
                <div class="col">
                    <label class="form-check-label">Ementa</label>
                    <input type="text" name="ementa" class="form-control">
                </div>
            </div>
            <div class="form-row">
                <div class="col">
                    <label class="form-check-label">Ciclo</label>
                    <input type="number" step="1" min="1" max="6" name="ciclo" class="form-control">
                </div>
                <div class="col">
                    <label class="form-check-label">Nota</label>
                    <input type="number" step="0.05" min="0" max="10" name="nota" class="form-control">
                </div>
            </div>
            <input type="submit" value="Salvar" name="formInsert" class="btn btn-primary">
        </form>
    </div>
    <% } else if(request.getParameter("prepareDelete") != null) { %>
    <div class="col-md-12 bg-light my-3 p-3">
        <h3>Excluir disciplina</h3>
        <form method="GET">
            <div class="form-row">
                <input type="hidden" name="rowid" value="<%=request.getParameter("rowid")%>">
                Você deseja realmente excluir o curso com id <%=request.getParameter("rowid")%> ?
                <div class="col">
                    <input type="submit" name="formDelete" value="Excluir" class="btn btn-danger">
                    <input type="submit" name="Cancelar" value="Cancelar" class="btn btn-secondary">
                </div>
            </div>
        </form>
    </div>
    <% } else { %>
        <form method="GET">
            <input type="submit" value="Cadastrar disciplina" name="prepareInsert" class="btn btn-primary my-2 mx-3">
        </form>
    <% } %>
    <div class="row">
        <div class="col-12">
            <form action="disciplinas.jsp">
                <table class="table table-striped table-dark">
                    <thead>
                      <tr>
                        <th scope="col">Código</th>
                        <th scope="col">Ciclo</th>
                        <th scope="col">Nome</th>
                        <th scope="col">Ementa</th>
                        <th scope="col">Nota</th>
                        <th scope="col">#</th>
                      </tr>
                    </thead>
                    <tbody>
                    <% for(Disciplina d: Disciplina.getList()) { %>
                        <tr>
                          <td scope="row"><%= d.getRowId()%></td>
                          <td scope="row"><%= d.getCiclo()%></td>
                          <td scope="row"><%= d.getNome()%></td>
                          <td scope="row"><%= d.getEmenta()%></td>
                          <td scope="row"><%= d.getNota()%></td>
                          <td scope="row">
                              <form method="GET">
                                  <input type="hidden" name="rowid" value="<%= d.getRowId()%>">
                                  <input type="submit" name="prepareDelete" value="Deletar" class="btn btn-danger">
                              </form>
                          </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
</div>

<%@include file="./WEB-INF/jspf/footer.jspf"%>
</html>

