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
    
    if(request.getParameter("formUpdateMovie")!= null){
        try{
            long id = Long.parseLong(request.getParameter("id"));
            String name = request.getParameter("name");
            String genre = request.getParameter("genre");
            String stock = request.getParameter("stock");
            double price = Double.parseDouble(request.getParameter("price"));
            Movie.updateMovie(id, name, genre, stock, price);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception e){
            error = e.getMessage();
        }
    }
    
    if(request.getParameter("formCancelUpdate") != null){
        response.sendRedirect(request.getContextPath()+"/operation/movies.jsp");
    }
    
    if(request.getParameter("formNewMovie") !=null){
        try{
            String name = request.getParameter("name");
            String genre = request.getParameter("genre");
            String stock = request.getParameter("stock");
            double price = Double.parseDouble(request.getParameter("price"));
            Movie.addMovie(name, genre, new Date(), stock, price);
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
                        <% if(request.getParameter("formUpdateMovie") == null){ %>
                        <form>
                            <div class="form-row">
                                <div class="col-3">
                                    <input type="text" class="form-control" name="name" placeholder="Insira o nome"required>
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
                                <div class="col-2">
                                    <input type="text" class="form-control" name="price" placeholder="Insira o preço"required>
                                </div>
                                <input type="submit" name="formNewMovie" value="Cadastrar" class="btn btn-light btn-sm">
                        <% }else{ 
                        int f = Integer.parseInt(request.getParameter("id"));%>
                            <form>
                            <div class="form-row">
                                <div class="col-3">
                                    <input type="text" class="form-control" name="name" value="<%= Movie.getMovies().get(f-1).getName() %>"required>
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
                                <div class="col-2">
                                    <input type="text" class="form-control" name="price" value="<%= Movie.getMovies().get(f-1).getPrice() %>"required>
                                </div>
                                <input type="hidden" name="id" value="<%= f %>"/>
                                <input type="submit" name="formUpdateMovie" value="Salvar Alteração" class="btn btn-light btn-sm">
                                <a href="movies.jsp" class="btn btn-light btn"><input type="submit" class="btn btn-light btn" name="formCancelUpdate" value="Cancelar"/></a>
                                <% } %>
                            </div>
                        </form>
                    </div>
                </fieldset>
                
            <br/><h2 align="center">Catálogo de Filmes</h2>
            <div class="container">
                <table class="table table-dark" border="1">
                    <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Gênero</th>
                        <th>Nome</th>
                        <th>Data</th>
                        <th>Disponível</th>
                        <th>Preço</th>
                        <th>Comando</th>
                    </tr>
                    </thead>
                    <%for(Movie m: Movie.getMovies()){%>
                    <tr>
                        <td><%=m.getId()%> </td>
                        <td><%=m.getGenre()%> </td>
                        <td><%=m.getName()%> </td>
                        <td><%=m.getRelease()%> </td>
                        <td><%=m.getStock()%> </td>
                        <td><%=m.getPrice()%> </td>
                        <td>
                            <form>
                                <input type="hidden" name="id" value="<%=m.getId()%>"/>
                                <input type="submit" class="btn btn-outline-light" name="formUpdateMovie" value="Alterar">
                                <input type="submit" class="btn btn-outline-light" name="formDeleteMovie" value="Remover"/>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                <% } %>
                </table>
            </div>
        <% } %>
        <%@include file="../WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>
