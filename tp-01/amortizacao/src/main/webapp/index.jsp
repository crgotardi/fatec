<%-- 
    Document   : newjsp
    Created on : Sep 10, 2020, 12:42:13 PM
    Author     : Cristiano
--%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
        <%@include file="./WEB-INF/jspf/header.jspf" %>
        <div class="container-fluid text-white bg-dark">
            <div class="row">
                <div class="col text-center m-5">
                    <h1>TP - POO</h1>
                    <h2>Fatec Praia Grande - SP</h2>
                </div>
            </div>
        </div>
        
        <div class="container my-5">
            <div class="row">
                <div class="col-12">
                    <div class="wrapper p-5 mb-3 bg-light text-center">
                        <h3><strong>Apresentação</strong></h3>
                        <p>O presente trabalho tem como objetivo a simulação de calculos de amortização, 
                        com a aplicação de conceitos da linguagem Java em um servidor localhost, utilizando bootstrap
                        como framework de CSS para o front-end
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="wrapper p-5 my-2 bg-light text-center">
                        <h3><strong>Amortização Constante</strong></h3>
                        <a class="btn btn-primary" href="amortizacao-constante.jsp">Simulação</a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="wrapper p-5 my-2 bg-light text-center">
                        <h3><strong>Amortização Americana</strong></h3>
                        <a class="btn btn-primary" href="amortizacao-americana.jsp">Simulação</a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="wrapper p-5 my-2 bg-light text-center">
                        <h3><strong>Tabela<br>Price</strong></h3>
                        <a class="btn btn-primary" href="tabela-price.jsp">Simulação</a>
                    </div>
                </div>
            </div>
        </div>
<%@include file="./WEB-INF/jspf/footer.jspf" %>