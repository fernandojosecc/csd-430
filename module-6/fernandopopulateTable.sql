-- Name: Fernando Contreras
-- Date: November 18, 2026
-- Assignment: CSD 430 Modules 5 and 6 - Project Part 1 (CRUD-READ database)
-- Purpose: Add 10 movie records to the fernando_movies_data table.

-- Use the project database
USE CSD430;

-- Insert 10 records (movie_id is filled in automatically)
INSERT INTO fernando_movies_data (title, director, release_year, genre, runtime_minutes) VALUES
    ('Interstellar', 'Christopher Nolan', 2014, 'Science Fiction', 169),
    ('Inception', 'Christopher Nolan', 2010, 'Science Fiction', 148),
    ('The Matrix', 'Lana Wachowski and Lilly Wachowski', 1999, 'Science Fiction', 136),
    ('Arrival', 'Denis Villeneuve', 2016, 'Science Fiction', 116),
    ('Spirited Away', 'Hayao Miyazaki', 2001, 'Animation', 125),
    ('Coco', 'Lee Unkrich', 2017, 'Animation', 105),
    ('Spider-Man: Into the Spider-Verse', 'Bob Persichetti, Peter Ramsey, and Rodney Rothman', 2018, 'Animation', 117),
    ('The Lord of the Rings: The Fellowship of the Ring', 'Peter Jackson', 2001, 'Fantasy', 178),
    ('The Dark Knight', 'Christopher Nolan', 2008, 'Action', 152),
    ('Parasite', 'Bong Joon-ho', 2019, 'Thriller', 132);
