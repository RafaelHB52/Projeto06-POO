<%@page import="br.com.fatecpg.locadora.Leased"%>
<%@page import="java.util.Date"%>
<%@page import="br.com.fatecpg.locadora.Price"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String error = null;
    String date = null;
    String name = null;
    String client = null;
    if(request.getParameter("formFilter") != null){
        date = request.getParameter("date");  
        if(date.isEmpty()) date = null;
        name = request.getParameter("name");  
        if(name.isEmpty()) name = null;
        client = request.getParameter("client");  
        if(client.isEmpty()) client = null;
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MovieBuster</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <h1>Histórico</h1>
        <% if(session.getAttribute("user") == null){ %>
            <h2>É preciso estar autenticado para acessar este recurso</h2>
        <% }else{ %>
            <% User user = (User) session.getAttribute("user"); %>
            <% if(error != null){ %>
                 <h3><%= error%></h3>
            <% } %>
            <fieldset>
                <legend>Filtro</legend>
                <form>
                    Nome do Filme: <input type="text" name="name"/>
                    Nome do Cliente: <input type="text" name="client"/>
                    Data: <input type="date" name="date"/>
                    <input type="submit" name="formFilter" value="Filtrar"/>
                </form>
            </fieldset>
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Nome do filme</th>
                    <th>Nome do cliente</th>
                    <th>Data de locação</th>
                    <th>Data de devolução</th>
                    <th>Preço</th>
                </tr>
                <% for(Leased l: Leased.getHistory(date, name, client)){ %>
                <tr>
                    <td><%= l.getId() %></td>
                    <td><%= l.getName() %></td>
                    <td><%= l.getClient() %></td>
                    <td><%= l.getBegins() %></td>
                    <td><%= l.getEnd() %></td>
                    <td><%= l.getPrice() %></td>
                </tr>
                <% } %>
            </table>
        <% } %>
    </body>
</html>