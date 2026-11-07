<%--
  Name: Fernando Contreras
  Date: November 3, 2026
  Assignment: CSD 430 Module 3.2 - Restaurant Feedback Results
  Purpose: Receive the data from feedback.html and display it in an HTML table.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%
    // Read the form data as UTF-8 so special characters display correctly
    request.setCharacterEncoding("UTF-8");

    // A direct visit to this page has no form data, so check for it first
    boolean submitted = request.getParameter("customerName") != null;

    // Field names and descriptions shown in the results table
    String[] fieldNames = {
        "Name", "Restaurant", "Visit Date", "Meal", "Food Rating",
        "Service Rating", "What You Liked", "Would Recommend", "Comments"
    };
    String[] fieldDescriptions = {
        "The name of the person who filled out the form.",
        "The restaurant that the feedback is about.",
        "The day of the visit.",
        "The meal that was ordered.",
        "How good the food was, from 1 (poor) to 5 (excellent).",
        "How good the service was, from 1 (poor) to 5 (excellent).",
        "The things about the visit that the customer liked.",
        "Whether the customer would recommend the restaurant.",
        "Any extra thoughts from the customer."
    };

    // The matching names of the inputs in feedback.html
    String[] parameterNames = {
        "customerName", "restaurantName", "visitDate", "mealType", "foodRating",
        "serviceRating", "liked", "recommend", "comments"
    };

    String[] values = new String[fieldNames.length];
    String thankYouName = "guest";
    boolean hasAverage = false;
    double averageRating = 0;

    if (submitted) {

        // Clean up each answer before it is shown on the page
        for (int i = 0; i < parameterNames.length; i++) {
            String value;

            // The checkbox group can have several answers, so join them into one line
            if (parameterNames[i].equals("liked")) {
                String[] selected = request.getParameterValues("liked");
                value = (selected == null) ? "" : String.join(", ", selected);
            } else {
                value = request.getParameter(parameterNames[i]);
            }

            // Use a friendly message when an answer is blank
            if (value == null || value.trim().isEmpty()) {
                value = "Not provided";
            }

            // Escape special characters so user input is shown as text and never runs as HTML
            value = value.trim()
                         .replace("&", "&amp;")
                         .replace("<", "&lt;")
                         .replace(">", "&gt;")
                         .replace("\"", "&quot;")
                         .replace("'", "&#39;");
            values[i] = value;
        }

        // Turn the date into a friendlier format when it is valid
        try {
            LocalDate visit = LocalDate.parse(request.getParameter("visitDate"));
            values[2] = visit.format(DateTimeFormatter.ofPattern("MMMM d, yyyy"));
        } catch (Exception e) {
            // Keep the cleaned-up text if the date cannot be read
        }

        // Check that each rating is a number from 1 to 5
        int foodRating = 0;
        int serviceRating = 0;
        try {
            foodRating = Integer.parseInt(request.getParameter("foodRating"));
        } catch (NumberFormatException e) {
            foodRating = 0;
        }
        try {
            serviceRating = Integer.parseInt(request.getParameter("serviceRating"));
        } catch (NumberFormatException e) {
            serviceRating = 0;
        }

        values[4] = (foodRating >= 1 && foodRating <= 5) ? foodRating + " out of 5" : "Not provided";
        values[5] = (serviceRating >= 1 && serviceRating <= 5) ? serviceRating + " out of 5" : "Not provided";

        // Work out the average rating when both ratings are valid
        if (foodRating >= 1 && foodRating <= 5 && serviceRating >= 1 && serviceRating <= 5) {
            averageRating = (foodRating + serviceRating) / 2.0;
            hasAverage = true;
        }

        // Use the customer's name in the thank-you message if there is one
        if (!values[0].equals("Not provided")) {
            thankYouName = values[0];
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Restaurant Feedback Results</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="page">
        <h1>Restaurant Feedback Results</h1>

        <% if (!submitted) { %>
            <p class="description">
                No feedback was received. Please
                <a href="feedback.html">fill out the feedback form</a> first.
            </p>
        <% } else { %>
            <p class="description">
                Thank you, <%= thankYouName %>! Your feedback was received. The table below
                shows each question, what it asks, and the answer you gave.
            </p>

            <% if (hasAverage) { %>
                <p class="summary">
                    Your average rating: <strong><%= String.format("%.1f", averageRating) %> out of 5</strong>
                </p>
            <% } %>

            <h2>Field and Record Descriptions</h2>
            <p>
                Each row is one field from the form. The record is the complete set of
                <%= fieldNames.length %> answers from this one visit.
            </p>

            <table>
                <thead>
                    <tr>
                        <th>Field</th>
                        <th>Description</th>
                        <th>Your Response</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (int r = 0; r < fieldNames.length; r++) { %>
                        <tr>
                            <td><strong><%= fieldNames[r] %></strong></td>
                            <td><%= fieldDescriptions[r] %></td>
                            <td><%= values[r] %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>

            <p><a href="feedback.html">Submit another response</a></p>
        <% } %>

        <p class="footer">CSD 430 - Module 3.2 - Fernando Contreras</p>
    </div>
</body>
</html>
