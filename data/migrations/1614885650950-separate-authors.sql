-- Database Setup: https://codefellows.github.io/code-301-guide/curriculum/class-14/lab/

-- Creating a copy of the database so that we don't break the production db
CREATE DATABASE lab14_normal WITH TEMPLATE lab14;
-- \c lab_14normal; will connect your table to your database
-- Next, you will have to connect your file and your database. NOTES: When you do this, the file location will be relative to where you currently are located in your terminal.

--The following commands happen inside of psql
-- make the authors table
CREATE TABLE authors (id SERIAL PRIMARY KEY, name VARCHAR(255));

-- selects all of the authors that are unique in books
INSERT INTO authors(name) SELECT DISTINCT author FROM books;

--------------------------------
-- create a column author_id which will be used to relate to the author table
ALTER TABLE books ADD COLUMN author_id INT;

-- insert the id into the book table from the author table where the author name matches the authore column 
UPDATE books SET author_id=author.id FROM (SELECT * FROM authors) AS author WHERE books.author = author.name;

-- drop the column author. This deletes the author column from book since we no longer need it
ALTER TABLE books DROP COLUMN author;

-- Constraint is like a funciton that ties two tables together permenantly. Adds a function that requires the column of author_id to always be set to a real id from the authors table and permanently ties them together. 
ALTER TABLE books ADD CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(id);

-- For innter join command, watch front row at 11:45