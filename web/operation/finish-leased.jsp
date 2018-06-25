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
      //verificar erro aqui > price = hours * Movie.getPrice();
        
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
        <%@include file="../WEB-INF/jspf/links.jspf"%>
        <title>MovieBuster</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <h2 align="center">Registrar Devolução</h2><hr/>
        <% if(error != null){ %>
            <h3><%= error%></h3>
        <% } %>
        <% if(session.getAttribute("user") == null){ %>
            <script> alert("É preciso estar autenticado para acessar este recurso");</script>
        <% }else if(leased != null){ %>
            <% User user = (User) session.getAttribute("user"); %>
            <div class="container" align="center">
                <form>
                    <h4>ID: <%= id %></h4>
                    <h4>Nome do Filme: <%= leased.getName() %></h4>
                    <h4>Nome do cliente:  <%= leased.getClient() %></h4>
                    <h4>Horas:  <%= hours %></h4>
                    <h4>Preço:  <%= price %></h4>
                    <input type="hidden" value="<%= id %>" name="id"/><br/>
                    <a href="leased.jsp" class="btn btn-light btn">Voltar</a>&nbsp;
                    &nbsp;<input type="submit" class="btn btn-light btn" name="formFinishLeased" value="Registrar Devolução"/>
                </form>
            </div>
        <% } %>
        
        <%@include file="../WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>
