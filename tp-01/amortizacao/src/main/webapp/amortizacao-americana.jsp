<%-- 
    Document   : tabela-price
    Created on : Sep 11, 2020, 1:35:12 AM
    Author     : Cristiano
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Exception requestException = null;
    double juros = 0, parcela = 0, divida = 0, totalParcelas= 0, totalJuros=0, amortizacao = 0, valorJuros=0;
    int meses = 0;
    DecimalFormat formato = new DecimalFormat("#.##");
    divida = 0;
    String periodo = null;
%>
<%
    try {
        meses = Integer.parseInt(request.getParameter("meses"));
        juros = Double.parseDouble(request.getParameter("juros"));
        divida = Double.parseDouble(request.getParameter("emprestimo"));
        parcela = juros * divida;
        periodo = request.getParameter("periodo");

    } catch (Exception e) {

    }


%>
<!DOCTYPE html>
<%@include file="./WEB-INF/jspf/header.jspf" %>
<div class="container my-5">
    <div class="row">
        <div class="col-12">
            <div class="wrapper p-4 mb-5 bg-light">
                <h3>Simulação</h3>
                <form>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label>Valor financiado</label>
                            <input type="number" step="0.01" maxFractionDigits="2" class="form-control" placeholder="R$ 0,00" name="emprestimo" value=<%=divida%> required>
                        </div>
                        <div class="form-group col-md-6">
                            <label>Número de meses</label>
                            <input type="number" step="0.01" maxFractionDigits="2" class="form-control" placeholder="0" name="meses" value=<%=meses%> required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label>Taxa de juros</label>
                            <input type="number" step="0.01" maxFractionDigits="2" class="form-control" placeholder="0.0%" name="juros" value=<%=juros%> required>
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

        <%            if (request.getParameter("emprestimo") == null
                    || request.getParameter("meses") == null
                    || request.getParameter("juros") == null
                    || request.getParameter("periodo") == null) {
        %>
        <p>Informe os valores, o resultado aparecerá aqui</p>
        <%  } else if (requestException != null) { %>
        <p>Parâmetros inválidos</p>
        <%  } else {
            juros = periodo.equals("m") ? juros/100 : (juros/100)/12;
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
                    <%
                        if (i == meses - 1) {
                            parcela = divida + (juros * divida);
                            valorJuros = divida * juros;
                            amortizacao = divida;
                            divida = divida - amortizacao;
                        } else {
                            parcela = juros * divida;
                            valorJuros = divida * juros;
                            divida = divida - amortizacao;
                        }
                    %>
                    <tr>
                        <th scope="row"><%= i + 1%></th>
                        <td><%= formato.format(parcela)%></td>
                        <td><%= formato.format(amortizacao)%></td>
                        <td><%= formato.format(valorJuros)%></td>
                        <td><%= formato.format(divida)%></td>
                    </tr>
                    <%
                        totalJuros += valorJuros;
                        totalParcelas += parcela;
                    %>
                    <% }%>
                    <tr>
                        <th scope="row">Total</th>
                        <td><strong><%= formato.format(totalParcelas)%></strong></td>
                        <td><strong><%= formato.format(amortizacao)%></strong></td>
                        <td><strong><%= formato.format(totalJuros)%></strong></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <%  }%>
    </div>
</div>
<%@include file="./WEB-INF/jspf/footer.jspf" %>