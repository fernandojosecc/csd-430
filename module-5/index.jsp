<%--
  Name: Fernando Contreras
  Date: November 19, 2026
  Assignment: CSD 430 Modules 5 and 6 - Project Part 1 (index page)
  Purpose: Home page that holds links to the CRUD deliverables for each module.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String[][] deliverables = {
        {"Modules 5 and 6: CRUD Read",
         "Search for and display records from the fernando_movies_data table in the CSD430 database.",
         ""}
    };
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CSD 430 Project - Home</title>
    <%-- Fallback styles: keep the page readable if style.css cannot be found. The external sheet below adds the full design. --%>
    <style>
        body { font-family: Arial, sans-serif; background-color: #eef3f9; margin: 0; padding: 24px; }
        .page { max-width: 960px; margin: 0 auto; background-color: #ffffff; padding: 24px 32px; }
        h1, h2 { color: #1f4e79; }
    </style>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="page">
        <h1>CSD 430 Server-Side Development Project</h1>

        <p class="description">
            This project uses a MySQL database named CSD430 that holds a table of my favorite movies.
            Each module adds another CRUD feature, and this page links to all of them.
        </p>

        <h2>CRUD Deliverables</h2>
        <ul class="links">
            <% for (String[] deliverable : deliverables) { %>
                <li>
                    <% if (deliverable[2].isEmpty()) { %>
                        <strong><%= deliverable[0] %></strong>
                        <span class="note">(link coming soon)</span>
                    <% } else { %>
                        <a href="<%= deliverable[2] %>"><strong><%= deliverable[0] %></strong></a>
                    <% } %>
                    <br><%= deliverable[1] %>
                </li>
            <% } %>
        </ul>

        <p class="footer">CSD 430 - Modules 5 and 6 - Fernando Contreras</p>
    </div>
</body>
</html>
