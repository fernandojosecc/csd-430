/*
  Name: Fernando Contreras
  Date: November 19, 2026
  Assignment: CSD 430 Modules 5 and 6 - Project Part 2 (CRUD-READ with JDBC and a JavaBean)
  Purpose: JavaBean that reads movie records from the CSD430 database using JDBC.
*/
package beans;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// A JavaBean: public no-argument constructor, private fields, getters and setters, and Serializable.
// It also holds the code that reads from the database (the READ part of CRUD).
public class MovieBean implements Serializable {

    private static final long serialVersionUID = 1L;

    // Database connection settings. The student1 user gets its permissions in SQL
    // (see fernandocreateTable.sql), not through this bean.
    private static final String DATABASE_URL =
            "jdbc:mysql://localhost:3306/CSD430?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String DATABASE_USER = "student1";
    private static final String DATABASE_PASSWORD = "pass";
    private static final String TABLE_NAME = "fernando_movies_data";

    // The six fields of one movie record
    private int movieId;
    private String title;
    private String director;
    private int releaseYear;
    private String genre;
    private int runtimeMinutes;

    // Public no-argument constructor (required for a JavaBean)
    public MovieBean() {
    }

    // Getters and setters for each field
    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public int getReleaseYear() {
        return releaseYear;
    }

    public void setReleaseYear(int releaseYear) {
        this.releaseYear = releaseYear;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public int getRuntimeMinutes() {
        return runtimeMinutes;
    }

    public void setRuntimeMinutes(int runtimeMinutes) {
        this.runtimeMinutes = runtimeMinutes;
    }

    // Field titles for the table headings, kept here so every page uses the same wording
    public String[] getFieldTitles() {
        return new String[] {"Movie ID", "Title", "Director", "Release Year", "Genre", "Runtime (Minutes)"};
    }

    // Description of each field, in the same order as the titles
    public String[] getFieldDescriptions() {
        return new String[] {
            "The unique key for the movie. This is the primary key of the table.",
            "The name of the movie.",
            "The person or people who directed the movie.",
            "The year the movie was first released.",
            "The category the movie belongs to.",
            "How long the movie runs, in minutes."
        };
    }

    // Opens a connection to the CSD430 database
    private Connection openConnection() throws SQLException {
        try {
            // Load the MySQL driver (the Connector/J jar must be in WEB-INF/lib)
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL driver not found. Add the Connector/J jar to WEB-INF/lib.", e);
        }
        return DriverManager.getConnection(DATABASE_URL, DATABASE_USER, DATABASE_PASSWORD);
    }

    // READ: returns every movie_id (the key values) in the table, in order
    public List<Integer> getAllMovieIds() throws SQLException {
        List<Integer> movieIds = new ArrayList<Integer>();
        String sql = "SELECT movie_id FROM " + TABLE_NAME + " ORDER BY movie_id";

        // try-with-resources closes the connection, statement, and results automatically
        try (Connection connection = openConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet results = statement.executeQuery()) {

            while (results.next()) {
                movieIds.add(results.getInt("movie_id"));
            }
        }
        return movieIds;
    }

    // READ: finds one movie by its key and fills this bean's fields with it.
    // Returns true if the movie was found and false if there is no movie with that key.
    public boolean loadMovie(int id) throws SQLException {
        // The ? is filled in by the PreparedStatement, which keeps user input out of the SQL text
        String sql = "SELECT movie_id, title, director, release_year, genre, runtime_minutes "
                   + "FROM " + TABLE_NAME + " WHERE movie_id = ?";

        try (Connection connection = openConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            try (ResultSet results = statement.executeQuery()) {
                if (results.next()) {
                    setMovieId(results.getInt("movie_id"));
                    setTitle(results.getString("title"));
                    setDirector(results.getString("director"));
                    setReleaseYear(results.getInt("release_year"));
                    setGenre(results.getString("genre"));
                    setRuntimeMinutes(results.getInt("runtime_minutes"));
                    return true;
                }
            }
        }
        return false;
    }
}
