<%@page import="br.com.fatecpg.locadora.Movie"%>
<%@page import="br.com.fatecpg.locadora.Leased"%>
<%@page import="java.util.Date"%>
<%@page import="br.com.fatecpg.locadora.Price"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String error = null;
    if(request.getParameter("formNewLeased") != null){
        try{
            String name = request.getParameter("name");
            String client = request.getParameter("client");
            Leased.addLeased(name, client);
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
        <h2 align="center">Alugar filme</h2><hr/>
        <% if(session.getAttribute("user") == null){ %>
            <script> alert("É preciso estar autenticado para acessar este recurso");</script>
        <% }else{ %>
            <% User user = (User) session.getAttribute("user"); %>
            <% if(error != null){ %>
                 <h3><%= error%></h3>
            <% } %>
            <fieldset>
                <legend align="center">Cadastro de aluguel</legend>
                <div class="container" align="center">
                    <form>
                        <div class="form-row">
                            <div class="col-3">
                                <select name="name" class="form-control">
                                    <%for(Movie u: Movie.getMovies()){%>
                                        <option value="<%=u.getName()%>"><%=u.getName()%></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="col-3">
                                <input type="text" class="form-control" name="client" placeholder="Nome do cliente"/>
                            </div>
                            <input type="submit" name="formNewLeased" value="Registrar Aluguel" class="btn btn-light btn-sm"/>
                        </div>
                    </form>
                </div>
            </fieldset>
            
            <br/><h2 align="center">Filmes Alugados</h2>
            <div class="container">
            <table class="table table-dark" border="1">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nome do filme</th>
                        <th>Nome do clinte</th>
                        <th>Data de locação</th>
                        <th>Preço</th>
                        <th>Comando</th>
                    </tr>
                </thead>
                <% for(Leased l: Leased.getLeaseds()){%>
                <tr>
                    <td><%= l.getId() %></td>
                    <td><%= l.getName() %></td>
                    <td><%= l.getClient() %></td>
                    <td><%= l.getBegins() %></td>
                    <td><%= l.getPrice() %></td>
                    <td>
                        <a href="finish-leased.jsp?id=<%= l.getId() %>"><h5 class="btn btn-outline-light">Registrar Devolução</h5></a>
                    </td>
                </tr>
                <% } %>
            </table>
        <% } %>
        
        <%@include file="../WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>
