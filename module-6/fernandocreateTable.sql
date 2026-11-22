-- Name: Fernando Contreras
-- Date: November 18, 2026
-- Assignment: CSD 430 Modules 5 and 6 - Project Part 1 (CRUD-READ database)
-- Purpose: Create the CSD430 database, the student1 user, and the fernando_movies_data table.
-- Note: Run this file as the MySQL root user because it creates a database and a user.

-- Create the database for the project
CREATE DATABASE IF NOT EXISTS CSD430;

-- Create the user that the Java web application will use to connect
CREATE USER IF NOT EXISTS 'student1'@'localhost' IDENTIFIED BY 'pass';

-- Let that user work with everything in the CSD430 database
GRANT ALL PRIVILEGES ON CSD430.* TO 'student1'@'localhost';
FLUSH PRIVILEGES;

-- Switch to the new database
USE CSD430;

-- Create the movies table: 6 fields, and movie_id is the primary key
CREATE TABLE fernando_movies_data (
    movie_id        INT          NOT NULL AUTO_INCREMENT,
    title           VARCHAR(100) NOT NULL,
    director        VARCHAR(100) NOT NULL,
    release_year    INT          NOT NULL,
    genre           VARCHAR(50)  NOT NULL,
    runtime_minutes INT          NOT NULL,
    PRIMARY KEY (movie_id)
);
