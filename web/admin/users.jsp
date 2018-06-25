<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    String error = null;
    if(request.getParameter("formDeleteUser")!= null){
        try{
            long id = Long.parseLong(request.getParameter("id"));
            User.removeUser(id);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception e){
            error = e.getMessage();
        }
    }
    
    if(request.getParameter("formUpdateUser")!= null){
        try{
            long id = Long.parseLong(request.getParameter("id"));
            String name = request.getParameter("name");
            String role = request.getParameter("role");
            String login = request.getParameter("login");
            long passwordHash = request.getParameter("pass").hashCode();
            User.updateUser(id, name, role, login, passwordHash);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception e){
            error = e.getMessage();
        }
    }
    
    if(request.getParameter("formCancelUpdate") != null){
        response.sendRedirect(request.getContextPath()+"/operation/users.jsp");
    }
    
    if(request.getParameter("formNewUser") !=null){
        String name = request.getParameter("name");
        String role = request.getParameter("role");
        String login = request.getParameter("login");
        long passwordHash = request.getParameter("pass").hashCode();
        try{
            User.addUser(name, role, login, passwordHash);
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
        
        <h2 align="center">Página Usuários</h2><hr/>
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
                    <legend align="center">Novo usuário</legend>
                    <div class="container" align="center">
                        <% if(request.getParameter("formUpdateUser") == null){ %>
                        <form>
                            <div class="form-row">
                                <div class="col-3">
                                    <input type="text" class="form-control" name="name" placeholder="Insira o nome"required>
                                </div>
                                <div class="col-2"> 
                                    <select name="role" class="form-control">
                                        <option value="ADMIN">ADMIN</option>
                                        <option value="OPERADOR">OPERADOR</option>
                                    </select>
                                </div>
                                <div class="col-3">
                                    <input type="text" class="form-control" name="login" placeholder="Insira o login" required>
                                </div>
                                <div class="col-3">
                                    <input type="password" class="form-control" name="pass" placeholder="Insira a senha" required>
                                </div>
                                <input type="submit" name="formNewUser" value="Cadastrar" class="btn btn-light btn-sm">
                                <% }else{ 
                                int f = Integer.parseInt(request.getParameter("id"));%>
                                <form>
                            <div class="form-row">
                                <div class="col-3">
                                    <input type="text" class="form-control" name="name" value="<%= User.getUsers().get(f-1).getName() %>" required>
                                </div>
                                <div class="col-2"> 
                                    <select name="role" class="form-control">
                                        <option value="ADMIN">ADMIN</option>
                                        <option value="OPERADOR">OPERADOR</option>
                                    </select>
                                </div>
                                <div class="col-2">
                                    <input type="text" class="form-control" name="login" value="<%= User.getUsers().get(f-1).getLogin() %>" required>
                                </div>
                                <div class="col-2">
                                    <input type="password" class="form-control" name="pass" value="<%= User.getUsers().get(f-1).getPasswordHash() %>" required>
                                </div>
                                <input type="hidden" name="id" value="<%= f %>"/>
                                <input type="submit" name="formUpdateUser" value="Salvar Alteração" class="btn btn-light btn-sm">
                                | <a href="users.jsp"><input type="submit" class="btn btn-light btn" name="formCancelUpdate" value="Cancelar"/></a>
                                <% } %>
                            </div>
                        </form>
                    </div>
                </fieldset>
                
            <br/><h2 align="center">Tabela de Usuários</h2>
            <div class="container">
                <table class="table table-dark" border="1">
                    <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Papel</th>
                        <th>Nome</th>
                        <th>Login</th>
                        <th>Comandos</th>
                    </tr>
                    </thead>
                    <%for(User u: User.getUsers()){%>
                    <tr>
                        <td><%=u.getId()%> </td>
                        <td><%=u.getRole()%> </td>
                        <td><%=u.getName()%> </td>
                        <td><%=u.getLogin()%> </td>
                        <td>
                            <form align="center">
                                <input type="hidden" name="id" value="<%=u.getId()%>"/>
                                <input type="submit" class="btn btn-outline-light" name="formUpdateUser" value="Alterar">
                                <input type="submit" class="btn btn-outline-light" name="formDeleteUser" value="Remover"/>
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
