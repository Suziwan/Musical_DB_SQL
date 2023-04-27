# Musical_DB_SQL
Week 1 Day 4 - Project : Musical database using SQL

## Introduction
For the following exercise, the database was given, it gives various data related to music.  
The tables analysed in this project were: albums, artists and tracks.  
Source: https://drive.google.com/file/d/1XG-s84jEJINSnLUgw5TYBCFsuyUX_Ll4/view  
The language of used for queries was SQLite3, using SQLiteStudio software.

## a) Get all albums of the database
```sql
SELECT Title FROM albums;
```

## b) Get all albums where the title contains "Great"
```sql
SELECT Title FROM albums WHERE Title LIKE '%Great%';
```

## c) Give the total number of albums in the database
```sql
SELECT COUNT (*) FROM albums;
```

## d) Delete all albums where the title contains "Music"
```sql
PRAGMA foreign_keys = 'OFF';

DELETE FROM albums WHERE Title LIKE '%Music%';
```

## e) Get all albums written/composed by AC/DC
```sql
SELECT DISTINCT albums.Title,
                tracks.Composer
  FROM albums
       INNER JOIN
       tracks ON albums.AlbumId = tracks.AlbumId
 WHERE tracks.Composer LIKE '%AC/DC%';
```

## f) Get all tracks from AC/DC's albums
```sql
SELECT albums.Title,
       artists.Name
  FROM albums
       INNER JOIN
       artists ON albums.ArtistId = artists.ArtistId
 WHERE artists.Name = 'AC/DC';
```

## g) Get the list of tracks in the album "Let There Be Rock"
```sql
SELECT tracks.Name,
       albums.Title
  FROM tracks
       INNER JOIN
       albums ON tracks.AlbumId = albums.AlbumId
 WHERE albums.Title = 'Let There Be Rock';
```

## h) Display the total price of this album and its total duration
```sql
SELECT albums.Title,
       SUM(UnitPrice) AS TotalPrice,
       SUM(Milliseconds) AS TotalDuration
  FROM tracks
       INNER JOIN
       albums ON tracks.AlbumId = albums.AlbumId
 WHERE albums.Title = 'Let There Be Rock';
```

## i) Display the total price of the discography from "Deep Purple"
```sql
SELECT artists.Name,
       SUM(UnitPrice) AS TotalPrice
  FROM tracks
       INNER JOIN
       albums ON tracks.AlbumId = albums.AlbumId
       INNER JOIN
       artists ON albums.ArtistId = artists.ArtistId
 WHERE artists.Name = 'Deep Purple';
```

## j) Create your favorite album in the database, filling up correctly the three tables albums, artists and tracks
```sql
INSERT INTO artists (Name) VALUES ('Bob Marley and the Wailers');

INSERT INTO albums (Title, ArtistId)
VALUES ('Legend', (SELECT ArtistId FROM artists WHERE Name = 'Bob Marley and the Wailers'));

SELECT last_insert_rowid() AS AlbumId;

INSERT INTO tracks (Name, AlbumId, Composer, Milliseconds, UnitPrice, MediaTypeId)
VALUES
('Is This Love', 348, 'Bob Marley', 234567, 0.99, 1),
('No Woman No Cry', 348, 'Bob Marley', 356789, 0.99, 1),
('Could You Be Loved', 348, 'Bob Marley', 290123, 0.99, 1),
('Three Little Birds', 348, 'Bob Marley', 194567, 0.99, 1),
('Buffalo Soldier', 348, 'Bob Marley', 325678, 0.99, 1),
('Get Up, Stand Up', 348, 'Bob Marley', 267890, 0.99, 1),
('Stir It Up', 348, 'Bob Marley', 283456, 0.99, 1),
('One Love / People Get Ready', 348, 'Bob Marley', 183456, 0.99, 1),
('I Shot The Sheriff', 348, 'Bob Marley', 337890, 0.99, 1),
('Waiting In Vain', 348, 'Bob Marley', 278901, 0.99, 1),
('Redemption Song', 348, 'Bob Marley', 203456, 0.99, 1),
('Satisfy My Soul', 348, 'Bob Marley', 312345, 0.99, 1);

SELECT Name, Composer, Milliseconds, UnitPrice FROM tracks WHERE AlbumId = 348;
```
