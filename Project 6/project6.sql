/*
 *  project6.sql
 * 
 *  author: Lewis Blake
 *
 */
 
/* Part 1 */

/*Before we create tables, let's drop them incase they already exist */

DROP TABLE IF EXISTS album_track;
DROP TABLE IF EXISTS artist_artist_xref;
DROP TABLE IF EXISTS album_genre;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS label;
DROP TABLE IF EXISTS artist;

/* Now we create tables: */

CREATE TABLE artist(
artist_id SERIAL PRIMARY KEY,
name text,
type text
);

CREATE TABLE label(
id SERIAL PRIMARY KEY,
name text,
location text
);

CREATE TABLE album(
id  SERIAL PRIMARY KEY,
title text,
year integer,
fk_artist_id integer REFERENCES artist(artist_id),
fk_label_id integer REFERENCES label(id)
);

CREATE TABLE album_genre(
fk_album_id integer REFERENCES album(id),
genre text
);

CREATE TABLE album_track(
fk_album_id integer REFERENCES album(id),
name text,
number text,
PRIMARY KEY(fk_album_id, name, number)
);

CREATE TABLE artist_artist_xref(
group_artist_id integer REFERENCES artist(artist_id),
ind_artist_id integer REFERENCES artist(artist_id),
begin_year int,
end_year int
);

/* Part 2 */

/* Populating artist table */

INSERT INTO artist(name, type) 
(SELECT DISTINCT member_name, 'Person' FROM public.project6
UNION 
SELECT DISTINCT artist_name, artist_type FROM public.project6);

/* Populating label table */

INSERT INTO label(name, location)
SELECT DISTINCT label, headquarters FROM public.project6;

/* Populating album table */

INSERT INTO album(title, year, fk_artist_id, fk_label_id)
SELECT DISTINCT p.album_title, p.album_year, a.artist_id, l.id
FROM public.project6 AS p, artist AS a, label AS l
WHERE p.artist_name = a.name AND p.label = l.name;

/* Populating album_genre table */

INSERT INTO album_genre(fk_album_id, genre)
SELECT DISTINCT al.id, p.genre
FROM public.project6 AS p, album AS al
WHERE p.album_title = al.title;

/* Populating album_track table */

INSERT INTO album_track(fk_album_id, name, number)
SELECT DISTINCT al.id, p.track_name, p.track_number
FROM public.project6 AS p, album AS al
WHERE p.album_title = al.title;

/* Populating the artist-artist cross reference table*/

INSERT INTO artist_artist_xref(group_artist_id, ind_artist_id, begin_year, end_year)
SELECT DISTINCT g.artist_id, i.artist_id, p.member_begin_year, p.member_end_year
FROM artist AS g, artist AS i, public.project6 AS p
WHERE i.name = p.member_name AND g.name = p.artist_name;

/* Part 3 */

/* Question 1 */

SELECT DISTINCT a.name, aa.begin_year, aa.end_year
FROM artist AS a, artist_artist_xref AS aa
WHERE aa.group_artist_id IN (SELECT artist_id FROM artist WHERE name  = 'The Who')
AND aa.ind_artist_id = a.artist_id
ORDER BY aa.begin_year ASC;

/* Question 2 */

SELECT DISTINCT a.name
FROM artist AS a, artist_artist_xref AS aa
WHERE aa.ind_artist_id IN (SELECT artist_id FROM artist WHERE name = 'Chris Thile')
AND aa.group_artist_id = a.artist_id;

/* Question 3 */

SELECT DISTINCT al.title, al.year, l.name
FROM album AS al, label AS l
WHERE al.fk_artist_id IN (SELECT artist_id FROM artist WHERE name  = 'Talking Heads')
AND al.fk_label_id = l.id
ORDER BY al.year;

/* Question 4 */

SELECT DISTINCT al.title, al.year, a.name, l.name
FROM album AS al, artist AS a, label AS l, artist_artist_xref AS aa
WHERE aa.ind_artist_id IN (SELECT artist_id FROM artist WHERE name  = 'Chris Thile')
AND (aa.group_artist_id = a.artist_id OR aa.ind_artist_id = a.artist_id)
AND a.artist_id = al.fk_artist_id
AND al.fk_label_id = l.id
ORDER BY al.year;

/* Question 5 */

SELECT a.name, al.title, al.year
FROM artist AS a, album AS al, album_genre AS ag
WHERE ag.genre = 'electronica'
AND ag.fk_album_id = al.id
AND al.fk_artist_id = a.artist_id
ORDER BY al.year;

/* Question 6 */

SELECT DISTINCT at.name, at.number
FROM album_track AS at, album AS al, artist AS a
WHERE al.title = 'Houses of the Holy'
AND at.fk_album_id = al.id
ORDER BY at.number;

/* Question 7 */

SELECT DISTINCT ag.genre
FROM album_genre AS ag, artist AS a, album AS al
WHERE a.name  = 'James Taylor'
AND a.artist_id = al.fk_artist_id
AND al.id = ag.fk_album_id;

/* Question 8 */

SELECT DISTINCT a.name, al.title, al.year, l.name
FROM artist AS a, album AS al, label AS l
WHERE l.location = 'Hollywood'
AND l.id = al.fk_label_id
AND al.fk_artist_id  = a.artist_id;






















