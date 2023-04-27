-- SQLite
-- a) Récupérer tous les albums

SELECT Title FROM albums;
  
-- b) Récupérer tous les albums dont le titre contient "Great"

SELECT Title FROM albums WHERE Title LIKE '%Great%';
 
-- c) Donner le nombre total d'albums contenus dans la base

SELECT COUNT (*) FROM albums;
  
-- d) Supprimer tous les albums dont le nom contient "music"

PRAGMA foreign_keys = 'OFF';

DELETE FROM albums WHERE Title LIKE '%Music%';
      
-- e) Récupérer tous les albums écrits par AC/DC

SELECT DISTINCT albums.Title,
                tracks.Composer
  FROM albums
       INNER JOIN
       tracks ON albums.AlbumId = tracks.AlbumId
 WHERE tracks.Composer LIKE '%AC/DC%';

-- f) Récupérer tous les titres des albums de AC/DC

SELECT albums.Title,
       artists.Name
  FROM albums
       INNER JOIN
       artists ON albums.ArtistId = artists.ArtistId
 WHERE artists.Name = 'AC/DC';
 
-- g) Récupérer la liste des titres de l'album "Let There Be Rock"

SELECT tracks.Name,
       albums.Title
  FROM tracks
       INNER JOIN
       albums ON tracks.AlbumId = albums.AlbumId
 WHERE albums.Title = 'Let There Be Rock';

-- h) Afficher le prix de cet album ainsi que sa durée totale

SELECT albums.Title,
       SUM(UnitPrice) AS TotalPrice,
       SUM(Milliseconds) AS TotalDuration
  FROM tracks
       INNER JOIN
       albums ON tracks.AlbumId = albums.AlbumId
 WHERE albums.Title = 'Let There Be Rock';

-- i) Afficher le coût de l'intégralité de la discographie de "Deep Purple"

SELECT artists.Name,
       SUM(UnitPrice) AS TotalPrice
  FROM tracks
       INNER JOIN
       albums ON tracks.AlbumId = albums.AlbumId
       INNER JOIN
       artists ON albums.ArtistId = artists.ArtistId
 WHERE artists.Name = 'Deep Purple';

-- j) Créer l'album de ton artiste favori en base, en renseignant correctement les trois tables albums, artists et tracks

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

