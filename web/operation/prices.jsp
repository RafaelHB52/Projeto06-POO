<%@page import="java.util.Date"%>
<%@page import="br.com.fatecpg.locadora.Price"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String error = null;
    if(request.getParameter("formDeletePrice") != null){
        try{
            long id = Long.parseLong(request.getParameter("id"));
            Price.removePrice(id);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception e){
            error = e.getMessage();
        }
    }
    if(request.getParameter("formNewPrice") != null){
        try{
            double price = Double.parseDouble(request.getParameter("price"));
            Price.addPrice(new Date(), price);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception e){
            error = e.getMessage();
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../WEB-INF/jspf/links.jspf"%>
        <title>MovieBuster</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        
        <h2 align="center">Preços</h2><hr/>
        <% if(session.getAttribute("user") == null){ %>
            <script> alert("É preciso estar autenticado para acessar este recurso");</script>
        <% }else{ %>
            <% User user = (User) session.getAttribute("user"); %>
            <% if(error != null){ %>
                 <h3><%= error%></h3>
            <% } %>
            <fieldset>
                <legend align="center">Novo Preço</legend>
                <div class="container" align="center">
                    <form>
                        <div class="form-row">
                            <div class="col-3">
                                <input type="text" class="form-control" name="price" placeholder="Insira o preço"/>
                            </div>
                            <input type="submit" name="formNewPrice" value="Cadastrar" class="btn btn-light btn-sm"/>
                        </div>
                    </form>
                </div>
            </fieldset>
            
            <br/><h2 align="center">Tabela de Preços</h2>
            <div class="container">
                <table class="table table-dark" border="1">
                    <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Data/Hora</th>
                        <th>Preço</th>
                        <th>Comando</th>
                    </tr>
                    </thead>
                    <% for(Price p: Price.getPrices()){%>
                    <tr>
                        <td><%= p.getId() %></td>
                        <td><%= p.getTimestamp() %></td>
                        <td><%= p.getPrice() %></td>
                        <td>
                            <form>
                                <input type="hidden" name="id" value="<%= p.getId() %>"/>
                                <input type="submit" class="btn btn-outline-light" name="formDeletePrice" value="Remover"/>
                            </form>
                        </td>
                    </tr>
                    <%}%>
                </table>
            </div>
        <%}%>
        <%@include file="../WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>
