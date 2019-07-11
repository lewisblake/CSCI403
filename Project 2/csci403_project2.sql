/*
 *  project2.sql
 * 
 *  author: Lewis Blake
 *
 */

/* What year did Nymphadora Tonks start at Hogwarts? */
SELECT start FROM hogwarts_students WHERE first = 'Nymphadora' AND last = 'Tonks';

/* What records do we have for students who started at Hogwarts before 1900? */
SELECT * FROM hogwarts_students WHERE start < 1990;

/* What house did Padma Patil sort into? */
SELECT house FROM hogwarts_students WHERE first = 'Padma' AND last = 'Patil';

/* How many years was Percy Weasley at Hogwarts? */
SELECT finish - start FROM hogwarts_students WHERE first = 'Percy' AND last = 'Weasley';

/* What students have a last name starting with "Q" or a first name starting with "Ph"? */
SELECT * FROM hogwarts_students WHERE first LIKE 'Ph%' OR last LIKE 'Q%';

/* What students' houses are unknown? */
SELECT * FROM hogwarts_students WHERE house IS NULL;

/* Who founded the house whose crest displays a badger? */
SELECT founder FROM hogwarts_houses WHERE lower(animal) = 'badger';

/* What are the names of all Gryffindor students, given as "firstname lastname", without extra spaces, ordered by last name and first name? */
SELECT first ||' '|| last FROM hogwarts_students WHERE house = 'Gryffindor' ORDER BY last, first ASC;

/* I was unsure exactly what "no extra spaces" meant so this was my other attempt. Do with it what you will. */
/* SELECT first, last FROM hogwarts_students WHERE house = 'Gryffindor' ORDER BY last, first ASC;*/

/* What defense against the dark arts teacher's first name started with 'A' whose last name did not start with 'M'? */
SELECT first, last FROM hogwarts_dada WHERE first LIKE 'A%' AND last NOT LIKE 'M%';

/* What are the names of the Gryffindor students who started in 1991, sorted by last name then first name? */
SELECT first, last FROM hogwarts_students WHERE house = 'Gryffindor' AND start = 1991 ORDER BY last, first ASC;

/* What unique ending years do we have student records for, ordered by ending year? */
SELECT DISTINCT finish FROM hogwarts_students ORDER BY finish ASC;

/*What are the names and years of all the students whose houses are known, together with their house colors, ordered by starting year? */
SELECT student.first, student.last, student.start, home.colors FROM hogwarts_students AS student, hogwarts_houses AS home WHERE student.house = home.house AND home.house IS NOT NULL ORDER BY start ASC;

/* Who founded the house that Morag McDougal sorted into? */
SELECT home.founder FROM hogwarts_students AS student, hogwarts_houses AS home WHERE student.first  = 'Morag' AND student.last = 'McDougal' AND student.house = home.house;

/* What are the names and houses of the defense against the dark arts teachers (you only need worry about the teachers for whom we have student records)? */
SELECT dada.first, dada.last, student.house FROM hogwarts_dada AS dada, hogwarts_students AS student WHERE dada.first = student.first AND dada.last = student.last;