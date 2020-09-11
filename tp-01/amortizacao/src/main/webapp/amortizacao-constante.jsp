<%-- 
    Document   : amortizacao-constante
    Created on : Sep 11, 2020, 1:35:04 AM
    Author     : Cristiano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat" %>
<%
    DecimalFormat currency = new DecimalFormat("R$#,##0.00");
    Exception requestException = null;
    float valor = 0;
    float meses = 0;
    float taxa = 0;
    float saldo = 0;
    float juros = 0;
    float parcelas = 0;
    float totalJuros = 0;
    float totalParcelas = 0;
    String periodo = null;

    try{
        valor = Float.parseFloat(request.getParameter("valor"));
        meses = Float.parseFloat(request.getParameter("meses"));
        taxa = Float.parseFloat(request.getParameter("taxa"));
        periodo = request.getParameter("periodo");
    } catch(Exception ex){
        requestException = ex;
    }  
%> 

<!DOCTYPE html>
<%@include file="./WEB-INF/jspf/header.jspf" %>
<div class="container-fluid text-white bg-dark">
    <div class="row">
        <div class="col text-center m-5">
            <h2>Amortização Constante</h2>
            <p>O sistema de amortização constante (SAC) é uma forma de amortização
                de um empréstimo por prestações que incluem os juros, amortizando 
                assim partes iguais do valor total do empréstimo.<br> Fonte: 
                <a href="https://pt.wikipedia.org/wiki/Sistema_de_amortiza%C3%A7%C3%A3o_constante">Wikipédia</a>
            </p>
        </div>
    </div>
</div>

<div class="container my-5">
    <div class="row">
        <div class="col-12">
            <div class="wrapper p-4 mb-5 bg-light">
                <h3>Simulação</h3>
                <form>
                    <div class="form-row">
                            <div class="form-group col-md-6">
                                <label>Valor financiado</label>
                                <input type="number" step="0.01" maxFractionDigits="2" class="form-control" placeholder="R$ 0,00" name="valor" value=<%=valor%> required>
                            </div>
                             <div class="form-group col-md-6">
                                 <label>Número de meses</label>
                                <input type="number" step="0.01" maxFractionDigits="2" class="form-control" placeholder="0 meses" name="meses" value=<%=meses%> required>
                            </div>
                    </div>
                    <div class="form-row">
                            <div class="form-group col-md-6">
                                <label>Taxa de juros</label>
                                <input type="number" step="0.01" maxFractionDigits="2" class="form-control" placeholder="0.0%" name="taxa" value=<%=taxa%> required>
                            </div>
                            <div class="form-group col-md-6">
                                <label>Período</label>
                                <select class="form-control" name="periodo">
                                    <option value="m">Ao mês</option>
                                    <option value="a">Ao ano</option>
                                </select>
                            </div>
                    </div>
                    <div class="text-right">
                        <input class="btn btn-primary" type="submit" value="Calcular">
                    </div>
                </form>
            </div>
        </div>
        
        <%
            if (request.getParameter("valor") == null || 
                request.getParameter("meses") == null ||
                request.getParameter("taxa") == null ||
                request.getParameter("periodo") == null) { 
        %>
            <p>Informe os valores, o resultado aparecerá aqui</p>
        <%  }  else if (requestException != null) { %>
                <p>Parâmetros inválidos</p>
        <%  } else { 
            float amortizacao = valor/meses;
            taxa = periodo.equals("m") ? taxa/100 : (taxa/100)/12;
            float somaJuros = 0;
            float somaParcelas = 0;
        %>
            <div class="col-md-12">
                <table class="table table-striped">
                    <thead>
                        <tr>
                          <th scope="col">#</th>
                          <th scope="col">Parcelas</th>
                          <th scope="col">Amortizações</th>
                          <th scope="col">Juros</th>
                          <th scope="col">Saldo devedor</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% for (int i = 0; i < meses; i++) { %>
                        <%  parcelas = amortizacao + (taxa * saldo);
                            saldo = valor - (amortizacao * i); 
                            juros = taxa * saldo;
                        %>
                        <tr>
                            <th scope="row"><%= i + 1 %></th>
                            <td><%= currency.format(parcelas) %></td>
                            <td><%= currency.format(amortizacao) %></td>
                            <td><%= currency.format(juros) %></td>
                            <td><%= currency.format(saldo - amortizacao) %></td>
                        </tr>
                        <% 
                            totalJuros += juros; 
                            totalParcelas += parcelas; 
                        %>
                    <% } %>
                        <tr>
                            <th scope="row">Total</th>
                            <td><strong><%= currency.format(totalJuros) %></strong></td>
                            <td><strong><%= currency.format(amortizacao * meses) %></strong></td>
                            <td><strong><%= currency.format(totalParcelas) %></strong></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        <%  } %>
    </div>
</div>
<%@include file="./WEB-INF/jspf/footer.jspf" %>