<%-- 
    Document   : disciplinas
    Created on : Oct 4, 2020, 6:43:19 PM
    Author     : Cristiano
--%>

<%@page import="com.mycompany.avaliacao.Disciplina"%>
<%@page import="java.util.ArrayList"%>
<%@include file="./WEB-INF/jspf/header.jspf"%>
<%
  ArrayList<Disciplina> disciplinas = new ArrayList<>();
  disciplinas = Disciplina.getList();
  boolean editar = false;
    ArrayList<String> mensagensErro = new ArrayList<>();
  
  if (disciplinas.isEmpty()) {
      disciplinas.add(new Disciplina("Programação orientada a objetos", "Conceitos e evolução da tecnologia de orientação a objetos.", 4));
      disciplinas.add(new Disciplina("Banco de dados", "Conceitos de Base de Dados. Modelos conceituais de informações. Modelos de Dados..", 4));
      disciplinas.add(new Disciplina("Segurança da informação", "Requisitos de segurança de aplicações, de base de dados e de comunicações.", 4));
      disciplinas.add(new Disciplina("Engenharia de software III", "Conceitos, evolução e importância de arquitetura de software. Padrões de Arquitetura.", 4));
      disciplinas.add(new Disciplina("Sistemas operacionais II", "Apresentação de um sistema operacional específico utilizado em ambiente corporativo.", 4));
      disciplinas.add(new Disciplina("Metodologia de pesquisa Científico-tecnologica", "O Papel da ciência e da tecnologia. Tipos de conhecimento. Método e técnica.", 4));
      disciplinas.add(new Disciplina("Linguagem de programação IV", "Comandos de linguagens usadas na construção e estruturação de sites para a Web.", 4));
  }
  
  if(request.getParameter("editar") != null) {
      editar = true;
  }
  
  if (request.getParameter("salvar") != null) {
      String[] notas = request.getParameterValues("nota");
      for (int i=0; i<notas.length; i++) {
          try {
              float nota = Float.parseFloat(notas[i]);
              disciplinas.get(i).setNota(nota);
          } catch(NumberFormatException e) {
              mensagensErro.add("A disciplina " + disciplinas.get(i).getNome() + " Tem o valor  da nota invalido, tente novamente");
          }
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
    <% if (mensagensErro.size() > 0) { %>
        <% for (String mensagem : mensagensErro) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <span><%= mensagem %></span>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
            </div>
        <% } %>
    <% } %>
    <div class="row">
        <div class="col-12">
            <form action="disciplinas.jsp">
                <table class="table table-striped table-dark">
                    <thead>
                      <tr>
                        <th scope="col">Código</th>
                        <th scope="col">Nome</th>
                        <th scope="col">Ementa</th>
                        <th scope="col">Nota</th>
                      </tr>
                    </thead>
                    <tbody>
                    <% for(int i=0; i<disciplinas.size(); i++) { %>
                        <tr>
                          <td scope="row"><%= i+1 %></td>
                          <td scope="row"><%= disciplinas.get(i).getNome() %></td>
                          <td scope="row"><%= disciplinas.get(i).getEmenta() %></td>
                          <td scope="row">
                              <% if(editar) { %>
                                <input type="number" name="nota" value=<%=disciplinas.get(i).getNota()%> 
                                       max=10 min="0" maxFractionDigits="2" step="0.5">
                              <% } else { %>
                                <%= disciplinas.get(i).getNota() %>
                              <% } %>
                          </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
                <% if(!editar) { %>
                    <input type="submit" class="btn btn-secondary" name="editar" value="Editar notas">
                <% } else { %>
                    <input type="submit" class="btn btn-success" name="salvar" value="Salvar alterações">
                <% } %>
            </form>
        </div>
    </div>
</div>

<%@include file="./WEB-INF/jspf/footer.jspf"%>
</html>

