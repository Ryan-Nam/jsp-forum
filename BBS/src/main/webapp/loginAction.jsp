<%--
  Created by IntelliJ IDEA.
  User: ryanmu
  Date: 20/8/21
  Time: 5:41 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.User" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<%--in this page, user ID and password will be stored--%>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<!DOCTYPE html>
<html>
<head>

    <title>JSP forum</title>
</head>
<body>
<%
    UserDAO userDAO = new UserDAO();
    // from -2 ~ 1, all the result will be stored in result
    int result = userDAO.login(user.getUserID(), user.getUserPassword());
    // when login success
    if (result == 1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
    }
    // when the ps is wrong
    else if (result == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('Password is wrong')");
        script.println("history.back()"); // send user back to previous page
        script.println("</script>");
    }
    // when ID is not exist
    else if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('ID is not exising')");
        script.println("history.back()"); // send user back to previous page
        script.println("</script>");
    }
    // DB issue
    else if (result == -2) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('DB Issue')");
        script.println("history.back()"); // send user back to previous page
        script.println("</script>");
    }
%>

</body>
</html>
