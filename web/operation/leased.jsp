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
        <title>MovieBuster</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <h1>Alugar filme</h1>
        <% if(session.getAttribute("user") == null){ %>
            <h2>É preciso estar autenticado para acessar este recurso</h2>
        <% }else{ %>
            <% User user = (User) session.getAttribute("user"); %>
            <% if(error != null){ %>
                 <h3><%= error%></h3>
            <% } %>
            <fieldset>
                <legend>Cadastro de aluguel</legend>
                <form>
                    Nome do filme: <input type="text" name="name"/>
                    Nome do client: <input type="text" name="client"/>
                    <input type="submit" name="formNewLeased" value="Registrar Aluguel"/>
                </form>
            </fieldset>
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Nome do filme</th>
                    <th>Nome do clinte</th>
                    <th>Data de locação</th>
                    <th>Comando</th>
                </tr>
                <% for(Leased l: Leased.getLeaseds()){%>
                <tr>
                    <td><%= l.getId() %></td>
                    <td><%= l.getName() %></td>
                    <td><%= l.getClient() %></td>
                    <td><%= l.getBegins() %></td>
                    <td>
                        <a href="finish-leased.jsp?id=<%=l.getId()%>">Registrar Devolução</a>
                    </td>
                </tr>
                <% } %>
            </table>
        <% } %>
    </body>
</html>
