<%--
  Name: Fernando Contreras
  Date: October 22, 2026
  Assignment: CSD 430 Module 1.3 - First JSP File
  Purpose: Show that Java, Tomcat, and Eclipse work together by mixing Java code with HTML in a JSP page.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CSD 430 - Module 1 JSP</title>
</head>
<body>
    <h1>CSD 430 Server-Side Development</h1>
    <h2>Module 1: My First JSP</h2>

    <%
        // Build a greeting and today's date using plain Java
        String studentName = "Fernando Contreras";
        String todayText = LocalDate.now().format(DateTimeFormatter.ofPattern("MMMM d, yyyy"));

        // Add up the numbers 1 through 5 with a loop
        int total = 0;
        for (int number = 1; number <= 5; number++) {
            total += number;
        }
    %>

    <p>Hello, <%= studentName %>! Tomcat is serving this page.</p>
    <p>Today's date (from the server): <%= todayText %></p>
    <p>Java version running on the server: <%= System.getProperty("java.version") %></p>
    <p>The sum of 1 through 5 is: <%= total %></p>
</body>
</html>
