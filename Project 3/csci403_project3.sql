/*
 *  project3.sql
 * 
 *  author: Lewis Blake
 *
 */
 
 
/* DROP TABLE IF EXISTS books1; */

/*Step 1*/
CREATE TABLE books1 (
number SERIAL PRIMARY KEY, 
title text NOT NULL,
isbn varchar(17),
publicationdate date,
page_count integer
)

/*Step 2*/
INSERT INTO books1 (title, isbn, publicationdate, page_count)
VALUES
('Harry Potter and the Philosopher''s Stone', '0-7475-3269-9', '1997-06-26', 223),
('Harry Potter and the Chamber of Secrets', '0-7475-3849-2', '1998-07-02', 251),
('Harry Potter and the Prisoner of Azkaban', '0-7475-4215-5', '1999-07-08', 317),
('Harry Potter and the Goblet of Fire', '0-7475-4624-X', '2000-07-08', 636),
('Harry Potter and the Order of the Phoenix','0-7475-5100-6', '2003-06-21', 766),
('Harry Potter and the Half-Blood Prince', '0-7475-8108-8', '2005-07-16', 607),
('Harry Potter and the Deathly Hallows', '0-545-01022-5', '2007-07-21', 607),
('Harry Potter and the Bunnies of Doom', '1-234-56789-0', '2010-01-15', NULL);

/*Step 3*/
SELECT * FROM books1 WHERE title = 'Harry Potter and the Bunnies of Doom' AND number = 8;

DELETE FROM books1 WHERE title = 'Harry Potter and the Bunnies of Doom';

/*Step 4*/
/* Just messing around. */

/*Step 5*/
CREATE TABLE books2 AS SELECT * FROM public.project3_us_books;

/*Step 6*/
CREATE TABLE books (
number integer PRIMARY KEY,
title text NOT NULL,
isbn varchar(17) NOT NULL UNIQUE,
publicationdate date NOT NULL,
pages integer,
ustitle text,
uspublicationdate date,
uspages integer
)

/*Step 7*/
INSERT INTO books(number, title, isbn, publicationdate, pages, uspublicationdate, uspages)
SELECT number, title, isbn, publicationdate, pages, books2.publicationdate, books2.pages FROM books1, books2
WHERE books1.number = books2.number

/*Step 8*/
UPDATE books SET ustitle = books1.title FROM books1 WHERE books.number = books1.number;

/*Step 9*/
UPDATE books SET ustitle = 'Harry Potter and the Sorcerer''s Stone' WHERE books.number = 1;