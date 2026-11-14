/*
  Name: Fernando Contreras
  Date: November 12, 2026
  Assignment: CSD 430 Module 4.2 - JavaBean and JSP Data Display
  Purpose: JavaBean that holds the data for one place I enjoyed visiting in Edinburgh, Scotland.
*/
package beans;

import java.io.Serializable;

// A JavaBean has a public no-argument constructor, private fields,
// public getters and setters, and implements Serializable
public class Place implements Serializable {

    // Version number used when the object is saved or sent somewhere (serialization)
    private static final long serialVersionUID = 1L;

    // The five fields of one record
    private String category;
    private String name;
    private String type;
    private String description;
    private int rating;

    // Public no-argument constructor (required for a JavaBean)
    public Place() {
    }

    // Convenience constructor that sets all five fields at once
    public Place(String category, String name, String type, String description, int rating) {
        this.category = category;
        this.name = name;
        this.type = type;
        this.description = description;
        this.rating = rating;
    }

    // Getter and setter for the category
    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    // Getter and setter for the place name
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // Getter and setter for the type of place
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    // Getter and setter for the description
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // Getter and setter for my rating (1 to 5)
    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }
}
