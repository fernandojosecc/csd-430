<%--
  Name: Fernando Contreras
  Date: November 14, 2026
  Assignment: CSD 430 Module 4.2 - JavaBean and JSP Data Display
  Purpose: Fill Place JavaBeans with data about Edinburgh, Scotland and display them in an HTML table.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, java.util.List, beans.Place" %>
<%
    // Create a list of Place JavaBeans, one bean for each record
    List<Place> places = new ArrayList<Place>();
    places.add(new Place("Historic Landmarks", "Edinburgh Castle", "Castle",
        "Sits on an extinct volcanic rock above the city and is home to the Scottish crown jewels.", 5));
    places.add(new Place("Historic Landmarks", "Palace of Holyroodhouse", "Royal palace",
        "The official residence of the monarch in Scotland, at the bottom of the Royal Mile.", 4));
    places.add(new Place("Historic Landmarks", "The Royal Mile", "Historic street",
        "Runs through the Old Town from Edinburgh Castle down to the Palace of Holyroodhouse.", 5));
    places.add(new Place("Nature and Views", "Arthur's Seat", "Hill",
        "A hill in Holyrood Park with wide views across the city.", 5));
    places.add(new Place("Nature and Views", "Calton Hill", "Hill and viewpoint",
        "An easy walk from the city centre with views of the skyline and several monuments.", 4));
    places.add(new Place("Nature and Views", "Royal Botanic Garden Edinburgh", "Garden",
        "A large botanic garden just north of the city centre.", 4));
    places.add(new Place("Museums and Culture", "National Museum of Scotland", "Museum",
        "Covers Scottish history, science, and the natural world, and is free to enter.", 5));
    places.add(new Place("Museums and Culture", "Scott Monument", "Monument",
        "A gothic tower on Princes Street honoring the author Sir Walter Scott that visitors can climb.", 4));

    // Field names and descriptions shown in the description section
    String[] fieldNames = {"Category", "Place", "Type", "Description", "My Rating"};
    String[] fieldDescriptions = {
        "The group that the place belongs to.",
        "The name of the place.",
        "What kind of place it is, such as a castle, hill, or museum.",
        "A short note about what makes the place worth visiting.",
        "How much I enjoyed it, from 1 to 5."
    };

    // Use the getters on each bean to work out a few summary numbers
    int ratingTotal = 0;
    int fiveStarCount = 0;
    for (Place place : places) {
        ratingTotal += place.getRating();
        if (place.getRating() == 5) {
            fiveStarCount++;
        }
    }
    double averageRating = places.isEmpty() ? 0 : (double) ratingTotal / places.size();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edinburgh, Scotland - JavaBean Display</title>
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
        <h1>Edinburgh, Scotland: Places I Loved</h1>

        <p class="description">
            This page displays data stored in <%= places.size() %> JavaBeans. Each bean holds one
            place I enjoyed visiting in Edinburgh, and the page reads the data back with the
            bean's getter methods.
        </p>

        <div class="summary">
            <span>Average rating: <strong><%= String.format("%.1f", averageRating) %> out of 5</strong></span>
            <span>Five-star places: <strong><%= fiveStarCount %> of <%= places.size() %></strong></span>
        </div>

        <h2>Field Descriptions</h2>
        <ul class="fields">
            <% for (int f = 0; f < fieldNames.length; f++) { %>
                <li><strong><%= fieldNames[f] %>:</strong> <%= fieldDescriptions[f] %></li>
            <% } %>
        </ul>

        <h2>Record Descriptions</h2>
        <p>
            Each row in the table is one record, which is one Place bean. A record describes a
            single place using all <%= fieldNames.length %> fields.
        </p>

        <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <% for (int h = 0; h < fieldNames.length; h++) { %>
                        <th><%= fieldNames[h] %></th>
                    <% } %>
                </tr>
            </thead>
            <tbody>
                <% for (Place place : places) { %>
                    <tr>
                        <td><%= place.getCategory() %></td>
                        <td><%= place.getName() %></td>
                        <td><%= place.getType() %></td>
                        <td><%= place.getDescription() %></td>
                        <td class="rating"><%= place.getRating() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
        </div>

        <p class="footer">CSD 430 - Module 4.2 - Fernando Contreras</p>
    </div>
</body>
</html>
