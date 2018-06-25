<%@page import="br.com.fatecpg.locadora.Leased"%>
<%@page import="java.util.Date"%>

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
        <%@include file="../WEB-INF/jspf/links.jspf"%>
        <title>MovieBuster</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        
        <h2 align="center">Histórico</h2><hr/>
        <% if(session.getAttribute("user") == null){ %>
            <script> alert("É preciso estar autenticado para acessar este recurso");</script>
        <% }else{ %>
            <% User user = (User) session.getAttribute("user"); %>
            <% if(error != null){ %>
                 <h3><%= error%></h3>
            <% } %>
            <fieldset>
                <br/>
                <div class="container" align="center">
                    <form>
                        <div class="form-row">
                            <div class="col-3">
                                <input type="text" class="form-control" name="name" placeholder="Nome do filme"/>
                            </div>
                            <div class="col-3">
                                <input type="text" class="form-control" name="client" placeholder="Nome do cliente"/>
                            </div>
                            <div class="col-3">
                                <input type="date" class="form-control" name="date"/>
                            </div>
                            <input type="submit" name="formFilter" value="Filtrar"/>
                        </div>
                    </form>
                </div>
            </fieldset>
            
            <br/>
            <div class="container">
                <table class="table table-dark" border="1">
                    <thead class="thead-dark">
                        <tr>
                            <th>ID</th>
                            <th>Nome do filme</th>
                            <th>Nome do cliente</th>
                            <th>Data de locação</th>
                            <th>Data de devolução</th>
                            <th>Preço</th>
                        </tr>
                    </thead>
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
            </div>
        <% } %>
        
        <%@include file="../WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>
