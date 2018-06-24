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
        <title>Usuários</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf"%>
        <h1>LOCADORA - Página Usuários</h1>
        <%if(session.getAttribute("user")== null){%>
            <h2>É preciso estar autenticado para acessar este recurso</h2>
        <%}else{%>
            <% User user = (User) session.getAttribute("user"); %>
            <% if(!user.getRole().equals("ADMIN")){%>
                <h2>Você não tem permissão para acessar este recurso</h2>
            <%}else{%>
            <%if(error !=null){%>
            <h3><%= error%></h3>
            <%}%>          
            <fieldset>
                <legend>Novo usuário</legend>
                <form>
                    Nome: <input type="text" name="name">
                    Papel: 
                    <select name="role">
                        <option value="ADMIN">ADMIN</option>
                        <option value="OPERADOR">OPERADOR</option>
                    </select>
                    Login: <input type="text" name="login">
                    Pass: <input type="password" name="pass">
                    <input type="submit" name="formNewUser" value="Add">
                </form>
            </fieldset>
            <h2>TODO: Tabela de usuários</h2>
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Papel</th>
                    <th>Nome</th>
                    <th>Login</th>
                    <th>Comando</th>
                </tr>
                <%for(User u: User.getUsers()){%>
                <tr>
                    <td><%=u.getId()%> </td>
                    <td><%=u.getRole()%> </td>
                    <td><%=u.getName()%> </td>
                    <td><%=u.getLogin()%> </td>
                    <td>
                        <form>
                            <input type="hidden" name="id" value="<%=u.getId()%>"/>
                            <input type="submit" name="formDeleteUser" value="Remover"/>
                        </form>
                    </td>
                </tr>
                <%}%>
            </table>
            
            <%}%>
        <%}%>
        
    </body>
</html>
