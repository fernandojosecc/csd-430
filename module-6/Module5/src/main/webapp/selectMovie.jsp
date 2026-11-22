<%--
  Name: Fernando Contreras
  Date: November 19, 2026
  Assignment: CSD 430 Modules 5 and 6 - Project Part 2 (CRUD-READ)
  Purpose: Show a drop-down list of all movie IDs from the database so the user can pick one to look up.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.SQLException, java.util.ArrayList, java.util.List, beans.MovieBean" %>
<%
    MovieBean movieBean = new MovieBean();
    List<Integer> movieIds = new ArrayList<Integer>();
    String errorMessage = "";

    try {
        movieIds = movieBean.getAllMovieIds();
    } catch (SQLException e) {
        // Write the details to the server log and show a friendly message on the page
        application.log("Could not read the movie IDs from the database", e);
        errorMessage = "The movie list could not be loaded. Make sure MySQL is running and that "
                     + "the CSD430 database and its table exist.";
    }

    // Field titles and descriptions come from the bean so every page uses the same wording
    String[] fieldTitles = movieBean.getFieldTitles();
    String[] fieldDescriptions = movieBean.getFieldDescriptions();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Movie Lookup</title>
    <%-- Fallback styles: keep the page readable if style.css cannot be found. The external sheet below adds the full design. --%>
    <style>
        body { font-family: Arial, sans-serif; background-color: #eef3f9; margin: 0; padding: 24px; }
        .page { max-width: 960px; margin: 0 auto; background-color: #ffffff; padding: 24px 32px; }
        h1, h2 { color: #1f4e79; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #c9d6e6; padding: 8px 12px; text-align: left; }
        th { background-color: #1f4e79; color: #ffffff; }
    </style>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="page">
        <h1>Movie Lookup</h1>

        <p class="description">
            This page reads from the <strong>fernando_movies_data</strong> table in the CSD430 database.
            Choose one movie ID from the list below and the next page will show the full record
            for that movie.
        </p>

        <h2>Field Descriptions</h2>
        <p>Each movie record in the table has <%= fieldTitles.length %> fields:</p>
        <ul class="fields">
            <% for (int f = 0; f < fieldTitles.length; f++) { %>
                <li><strong><%= fieldTitles[f] %>:</strong> <%= fieldDescriptions[f] %></li>
            <% } %>
        </ul>

        <h2>Choose a Movie</h2>

        <% if (!errorMessage.isEmpty()) { %>
            <p class="error"><%= errorMessage %></p>
        <% } else { %>
            <p>There are <strong><%= movieIds.size() %></strong> movies in the database.</p>

            <form action="showMovie.jsp" method="post">
                <div class="field">
                    <label for="movieId">Movie ID</label>
                    <select id="movieId" name="movieId" required>
                        <option value="">Choose an ID</option>
                        <% for (Integer movieId : movieIds) { %>
                            <option value="<%= movieId %>"><%= movieId %></option>
                        <% } %>
                    </select>
                </div>

                <div class="buttons">
                    <button type="submit">Show Movie</button>
                </div>
            </form>
        <% } %>

        <p><a href="index.jsp">Back to the home page</a></p>

        <p class="footer">CSD 430 - Modules 5 and 6 - Fernando Contreras</p>
    </div>
</body>
</html>
