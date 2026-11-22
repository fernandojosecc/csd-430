-- Name: Fernando Contreras
-- Date: November 18, 2026
-- Assignment: CSD 430 Modules 5 and 6 - Project Part 1 (CRUD-READ database)
-- Purpose: Remove the fernando_movies_data table so the project can be rebuilt from scratch.

-- Use the project database
USE CSD430;

-- Delete the table and all of its records (no error if it does not exist)
DROP TABLE IF EXISTS fernando_movies_data;
