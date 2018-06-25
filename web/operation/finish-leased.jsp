<%@page import="br.com.fatecpg.locadora.Movie"%>
<%@page import="br.com.fatecpg.locadora.Leased"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String error = null;
    Long id = null;
    Leased leased = null;
    int hours = 0;
    double price = 0;
    try{
        id = Long.parseLong(request.getParameter("id"));
        leased = Leased.getLeased(id);
        Date now = new Date();
        hours = now.getHours() - leased.getBegins().getHours();
        price = hours * Movie.getPrice();
        
        if(request.getParameter("formFinishLeased") != null){
            try{
                Leased.finishLeased(id, price);
                response.sendRedirect(request.getContextPath()+"/operation/leased.jsp");
            }catch(Exception e){
                error = e.getMessage();
            }
        }
        }catch(Exception ex){
            error = "Erro na leitura do registro da locação do filme: " + ex.getMessage();
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MovieBuster</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <h1>Registrar Devolução</h1>
        <% if(error != null){ %>
            <h3><%= error%></h3>
        <% } %>
        <% if(session.getAttribute("user") == null){ %>
            <h2>É preciso estar autenticado para acessar este recurso</h2>
        <% }else if(leased != null){ %>
            <% User user = (User) session.getAttribute("user"); %>
            <form>
                <h3>ID: <%= id %></h3>
                <h3>Nome do Filme: <%= leased.getName() %></h3>
                <h3>Nome do cliente:  <%= leased.getClient() %></h3>
                <h3>Horas:  <%= hours %></h3>
                <h3>Preço:  <%= price %></h3>
                <input type="hidden" value="<%= id %>" name="id"/>
                <h3><input type="submit" name="formFinishLeased" value="Registrar Devolução"/>&nbsp;&nbsp;<a href="leased.jsp">Voltar</a></h3>
            </form>
        <% } %>
    </body>
</html>
