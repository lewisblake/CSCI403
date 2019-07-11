/*
 *  csci403_project4.sql
 * 
 *  author: Lewis Blake
 *
 */

 /* How many Slytherin students are there?*/
 SELECT COUNT(*) FROM hogwarts_students WHERE house = 'Slytherin';

 /* What is the earliest start date of any student in our data?*/
 SELECT MIN(start) FROM hogwarts_students;

 /* How many students have some missing information?*/
 SELECT COUNT(*) FROM hogwarts_students WHERE first ISNULL OR last ISNULL OR house ISNULL OR start ISNULL OR finish ISNULL;

 /* How many students have all information?*/
 SELECT COUNT(*) FROM hogwarts_students WHERE first IS NOT NULL AND last IS NOT NULL AND house IS NOT NULL AND start IS NOT NULL AND finish IS NOT NULL;

 /* How many students are listed in each house (include the number who have no house listed as well; order by greatest number first)?*/
SELECT COUNT(house), house FROM hogwarts_students
GROUP BY house
ORDER BY house ASC; 

/* Who is the earliest known student, and what year did he or she start?*/
SELECT first, last, start from hogwarts_students WHERE start IN (SELECT MIN(start) FROM hogwarts_students);

/* How many students of each house are known to have started the year that Alastor Moody was the appointed DADA teacher?*/
SELECT COUNT(students), students.house FROM hogwarts_students AS students, hogwarts_dada AS dada
WHERE students.start IN (SELECT dada.start FROM hogwarts_dada WHERE first = 'Alastor' AND last = 'Moody')
GROUP BY students.house;

/*What are the names, houses, and house colors of the defense against the dark arts teachers (you only need to worry about the teachers who also have student records)? */
SELECT DISTINCT student.first, student.last, student.house, houses.colors 
FROM hogwarts_students AS student, hogwarts_dada AS dada, hogwarts_houses AS houses
WHERE student.first IN
(SELECT DISTINCT dada.first FROM hogwarts_dada AS dada, hogwarts_students AS students
WHERE students.last = dada.last)
AND houses.house = student.house;

/*Who were the Gryffindors who would have had Gilderoy Lockhart as DADA teacher (assume all students take DADA, and all students are at school for the entire school year starting in Fall and ending in Spring)? */
SELECT DISTINCT student.first, student.last
FROM hogwarts_students AS student, hogwarts_dada AS dada
WHERE student.start <= 1992
AND student.finish >= 1993
AND student.start IS NOT NULL
AND student.finish IS NOT NUll;

/*Which students have had other family members attend Hogwarts (assume anyone with the same last name is a family member)? Order by last name and first name. */ 
SELECT first, last
FROM hogwarts_students
WHERE last IN
(SELECT last
FROM hogwarts_students
GROUP BY last
HAVING COUNT(*) > 1)
ORDER BY last, first;

/*Which family names (last names) appear exactly once in the hogwarts_students table? */
SELECT last
FROM hogwarts_students
GROUP BY last
HAVING COUNT(*) = 1
ORDER BY last;