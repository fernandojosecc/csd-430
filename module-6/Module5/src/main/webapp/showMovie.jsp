<%--
  Name: Fernando Contreras
  Date: November 19, 2026
  Assignment: CSD 430 Modules 5 and 6 - Project Part 2 (CRUD-READ)
  Purpose: Receive the selected movie ID, read that record through the JavaBean, and display it in a table.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.SQLException, beans.MovieBean" %>
<%
    request.setCharacterEncoding("UTF-8");

    MovieBean movieBean = new MovieBean();
    String selectedId = request.getParameter("movieId");
    boolean found = false;
    String errorMessage = "";

    // Check the submitted ID, then ask the bean to read that record
    if (selectedId == null || selectedId.trim().isEmpty()) {
        errorMessage = "No movie was selected. Please go back and choose an ID from the list.";
    } else {
        try {
            int movieId = Integer.parseInt(selectedId.trim());
            found = movieBean.loadMovie(movieId);
            if (!found) {
                errorMessage = "There is no movie with that ID in the database.";
            }
        } catch (NumberFormatException e) {
            errorMessage = "The selected ID was not a number. Please go back and choose an ID from the list.";
        } catch (SQLException e) {
            application.log("Could not read the selected movie from the database", e);
            errorMessage = "The movie could not be loaded. Make sure MySQL is running and that "
                         + "the CSD430 database and its table exist.";
        }
    }

    // Field titles and descriptions come from the bean so every page uses the same wording
    String[] fieldTitles = movieBean.getFieldTitles();
    String[] fieldDescriptions = movieBean.getFieldDescriptions();

    // The values for the table row, in the same order as the field titles
    String[] values = new String[fieldTitles.length];
    if (found) {
        values[0] = String.valueOf(movieBean.getMovieId());
        values[1] = movieBean.getTitle();
        values[2] = movieBean.getDirector();
        values[3] = String.valueOf(movieBean.getReleaseYear());
        values[4] = movieBean.getGenre();
        values[5] = String.valueOf(movieBean.getRuntimeMinutes());

        // Escape special characters so the data is always shown as text and never runs as HTML
        for (int v = 0; v < values.length; v++) {
            values[v] = values[v].replace("&", "&amp;")
                                 .replace("<", "&lt;")
                                 .replace(">", "&gt;")
                                 .replace("\"", "&quot;")
                                 .replace("'", "&#39;");
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Movie Record</title>
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
        <h1>Movie Record</h1>

        <% if (!found) { %>
            <p class="error"><%= errorMessage %></p>
        <% } else { %>
            <p class="description">
                This is the record for movie ID <strong><%= values[0] %></strong>, read from the
                <strong>fernando_movies_data</strong> table in the CSD430 database through a JavaBean.
            </p>

            <h2>Record Description</h2>
            <p>
                The table below shows one record. Each column is one field, and the column
                headings are the field titles.
            </p>

            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <% for (int h = 0; h < fieldTitles.length; h++) { %>
                                <th><%= fieldTitles[h] %></th>
                            <% } %>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <% for (int c = 0; c < values.length; c++) { %>
                                <td><%= values[c] %></td>
                            <% } %>
                        </tr>
                    </tbody>
                </table>
            </div>

            <h2>Field Descriptions</h2>
            <ul class="fields">
                <% for (int f = 0; f < fieldTitles.length; f++) { %>
                    <li><strong><%= fieldTitles[f] %>:</strong> <%= fieldDescriptions[f] %></li>
                <% } %>
            </ul>
        <% } %>

        <p>
            <a href="selectMovie.jsp">Choose another movie</a> |
            <a href="index.jsp">Back to the home page</a>
        </p>

        <p class="footer">CSD 430 - Modules 5 and 6 - Fernando Contreras</p>
    </div>
</body>
</html>
