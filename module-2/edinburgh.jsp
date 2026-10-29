<%--
  Name: Fernando Contreras
  Date: October 28, 2026
  Assignment: CSD 430 Module 2.2 - Dynamic JSP Page with Scriptlets and External CSS
  Purpose: Display places I loved visiting in Edinburgh, Scotland in HTML tables grouped by category, using JSP scriptlets and an external CSS file.
  Source: Written with help from Claude (Anthropic), then reviewed and tested by me.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Data: each record has a category, a place name, a type of place, and a short description
    String[][] places = {
        {"Historic Landmarks", "Edinburgh Castle", "Castle", "Sits on an extinct volcanic rock above the city and is home to the Scottish crown jewels."},
        {"Historic Landmarks", "Palace of Holyroodhouse", "Royal palace", "The official residence of the monarch in Scotland, at the bottom of the Royal Mile."},
        {"Historic Landmarks", "The Royal Mile", "Historic street", "Runs through the Old Town from Edinburgh Castle down to the Palace of Holyroodhouse."},
        {"Nature and Views", "Arthur's Seat", "Hill", "A hill in Holyrood Park with wide views across the city."},
        {"Nature and Views", "Calton Hill", "Hill and viewpoint", "An easy walk from the city centre with views of the skyline and several monuments."},
        {"Nature and Views", "Royal Botanic Garden Edinburgh", "Garden", "A large botanic garden just north of the city centre."},
        {"Museums and Culture", "National Museum of Scotland", "Museum", "Covers Scottish history, science, and the natural world, and is free to enter."},
        {"Museums and Culture", "Scott Monument", "Monument", "A gothic tower on Princes Street honoring the author Sir Walter Scott that visitors can climb."}
    };

    // Categories used to group the records into separate tables
    String[] categories = {"Historic Landmarks", "Nature and Views", "Museums and Culture"};

    // Field names and descriptions shown in the description section
    String[] fieldNames = {"Place", "Type", "Description"};
    String[] fieldDescriptions = {
        "The name of the place.",
        "What kind of place it is, such as a castle, hill, or museum.",
        "A short note about what makes the place worth visiting."
    };
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edinburgh, Scotland</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="page">
        <h1>Edinburgh, Scotland: Places I Loved</h1>

        <p class="description">
            Edinburgh was one of my favorite places to visit. This page lists
            <%= places.length %> places from the city, grouped into
            <%= categories.length %> categories. Each record has three fields:
            the place, its type, and a short description.
        </p>

        <h2>Field Descriptions</h2>
        <ul class="fields">
            <% for (int f = 0; f < fieldNames.length; f++) { %>
                <li><strong><%= fieldNames[f] %>:</strong> <%= fieldDescriptions[f] %></li>
            <% } %>
        </ul>

        <h2>Record Descriptions</h2>
        <p>
            Each row in a table is one record. It describes a single place
            by its name, what type of place it is, and a short description.
        </p>

        <% for (int c = 0; c < categories.length; c++) { %>
            <h2 class="genre"><%= categories[c] %></h2>
            <table>
                <thead>
                    <tr>
                        <th>Place</th>
                        <th>Type</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (int p = 0; p < places.length; p++) {
                           // Only show the places that belong to the current category
                           if (places[p][0].equals(categories[c])) { %>
                        <tr>
                            <td><%= places[p][1] %></td>
                            <td><%= places[p][2] %></td>
                            <td><%= places[p][3] %></td>
                        </tr>
                    <%     }
                       } %>
                </tbody>
            </table>
        <% } %>

        <p class="footer">CSD 430 - Module 2.2 - Fernando Contreras</p>
    </div>
</body>
</html>
