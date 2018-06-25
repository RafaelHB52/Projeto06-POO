<%@page import="java.util.Date"%>
<%@page import="br.com.fatecpg.locadora.Movie"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    String error = null;
    String date = null;
    if(request.getParameter("formDeleteMovie")!= null){
        try{
            long id = Long.parseLong(request.getParameter("id"));
            Movie.removeMovie(id);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception e){
            error = e.getMessage();
        }
    }
    
    if(request.getParameter("formNewMovie") !=null){
        String name = request.getParameter("name");
        String genre = request.getParameter("genre");
        String stock = request.getParameter("stock");
        try{
            Movie.addMovie(name, genre, new Date(), stock);
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
        <%@include file="../WEB-INF/jspf/header.jspf"%>
        
        <h2 align="center">Cadastro de Filmes</h2><hr/>
        <%if(session.getAttribute("user") == null){%>
            <script> alert("É preciso estar autenticado para acessar este recurso");</script>
        <%}else{%>
            <% User user = (User) session.getAttribute("user"); %>
            <% if(!user.getRole().equals("ADMIN")){%>
                <script> alert("Você não tem permissão para acessar este recurso");</script>
            <%}else{%>
                <%if(error !=null){%>
                <h3><%= error %></h3>
                <%}%>          
                <fieldset>
                    <legend align="center">Novo filme</legend>
                    <div class="container" align="center">
                        <form>
                            <div class="form-row">
                                <div class="col-3">
                                    <input type="text" class="form-control" name="name" placeholder="Insira o nome">
                                </div>
                                <div class="col-2"> 
                                    <select name="genre" class="form-control">
                                        <option value="AÇÂO">AÇÃO</option>
                                        <option value="TERROR">TERROR</option>
                                        <option value="ANIMAÇÃO">ANIMAÇÃO</option>
                                        <option value="ROMANCE">ROMANCE</option>
                                    </select>
                                </div>
                                <div class="col-2"> 
                                    <select name="stock" class="form-control">
                                        <option value="SIM">SIM</option>
                                        <option value="NÃO">NÃO</option>
                                    </select>
                                </div>
                                <input type="submit" name="formNewMovie" value="Cadastrar" class="btn btn-light btn-sm">
                            </div>
                        </form>
                    </div>
                </fieldset>
                
            <br/><h2 align="center">Catálogo de Filmes</h2>
            <div class="container">
                <table class="table table-dark " border="1">
                    <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Gênero</th>
                        <th>Nome</th>
                        <th>Data</th>
                        <th>Disponível</th>
                        <th>Comando</th>
                    </tr>
                    </thead>
                    <%for(Movie u: Movie.getMovies()){%>
                    <tr>
                        <td><%=u.getId()%> </td>
                        <td><%=u.getGenre()%> </td>
                        <td><%=u.getName()%> </td>
                        <td><%=u.getRelease()%> </td>
                        <td><%=u.getStock()%> </td>
                        <td>
                            <form>
                                <input type="hidden" name="id" value="<%=u.getId()%>"/>
                                <input type="submit" class="btn btn-outline-light" name="formDeleteMovie" value="Remover"/>
                            </form>
                        </td>
                    </tr>
                    <%}%>
                </table>
            </div>
            
            <%}%>
        <%}%>
        <%@include file="../WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>
