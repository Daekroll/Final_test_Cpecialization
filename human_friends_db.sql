CREATE  DATABASE human_friends;

USE human_friends;

CREATE TABLE animals
(
	Id INT AUTO_INCREMENT PRIMARY KEY,  
	Animal_class VARCHAR(50)
);

INSERT INTO animals (Animal_class)
	VALUES 
		('pets'),
		('pack animals');  

CREATE TABLE pets
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    Pet_class VARCHAR (50),
    Animal_id INT,
    FOREIGN KEY (Animal_id) REFERENCES animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO pets (Pet_class, Animal_id)
	VALUES 
		('Dog', 1),
		('Cat', 1),  
		('Hamster', 1); 

CREATE TABLE pack_animals
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    Pack_animal_class VARCHAR (50),
    Animal_id INT,
    FOREIGN KEY (Animal_id) REFERENCES animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO pack_animals (Pack_animal_class, Animal_id)
	VALUES 
		('Horse', 2),
		('Camel', 2),  
		('Donkey', 2); 
    

CREATE TABLE dogs
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(50), 
    Birthday DATE,
    Commands VARCHAR(50),
    Pet_id int,
    Foreign KEY (Pet_id) REFERENCES pets (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE cats
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(50), 
    Birthday DATE,
    Commands VARCHAR(50),
    Pet_id int,
    Foreign KEY (Pet_id) REFERENCES pets (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE hamsters
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(50), 
    Birthday DATE,
    Commands VARCHAR(50),
    Pet_id int,
    Foreign KEY (Pet_id) REFERENCES pets (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE horses
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(50), 
    Birthday DATE,
    Commands VARCHAR(50),
    Pack_animal_id int,
    Foreign KEY (Pack_animal_id) REFERENCES pack_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE camels
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(50), 
    Birthday DATE,
    Commands VARCHAR(50),
    Pack_animal_id int,
    Foreign KEY (Pack_animal_id) REFERENCES pack_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE donkeys
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(50), 
    Birthday DATE,
    Commands VARCHAR(50),
    Pack_animal_id int,
    Foreign KEY (Pack_animal_id) REFERENCES pack_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO dogs (Name, Birthday, Commands, Pet_id)
	VALUES 
		('Рэкс', '2024-20-21', 'фас, дай лапу, cидеть, голос', 1),
		('Мухтар', '2017-03-05', 'лежать, ко мне', 1),  
		('Лайка', '2019-07-29', 'сидеть, лежать, лапу, след', 1);

INSERT INTO cats (Name, Birthday, Commands, Pet_id)
	VALUES 
		('Муся', '2015-09-04', 'сюда', 2),
		('Мурзик', '2020-10-22', "кыш", 2),  
		('Кекс', '2020-03-03', NULL, 2); 

INSERT INTO hamsters (Name, Birthday, Commands, Pet_id)
	VALUES 
		('Фуфик', '2020-03-15', NULL, 3),
		('Шарик', '2022-08-12', "сюда", 3),  
		('Комок', '2023-01-11', NULL, 3);

INSERT INTO horses (Name, Birthday, Commands, Pack_animal_id)
	VALUES 
		('Зорька', '2018-11-01', 'рысь, хоп, шагом, тихо', 1),
		('Гром', '2019-06-19', 'хоп, тише', 1),  
		('Ветер', '2023-02-22', 'шагом, тише', 1); 

INSERT INTO camels (Name, Birthday, Commands, Pack_animal_id)
	VALUES 
		('Горб', '2021-12-16', NULL, 2),
		('Рокки', '2017-06-02', 'ко мне', 2),  
		('Кактус', '2013-02-22', 'ко мне', 2);

INSERT INTO donkeys (Name, Birthday, Commands, Pack_animal_id)
	VALUES 
		('Серый', '2016-04-30', NULL, 3),
		('Смелый', '2021-09-22', 'ко мне', 3),  
		('Малой', '2019-01-18', 'шагом', 3);

SET SQL_SAFE_UPDATES = 0;
DELETE FROM camels;

SELECT Name, Birthday, Commands FROM horses
UNION ALL SELECT  Name, Birthday, Commands FROM donkeys;

CREATE TEMPORARY TABLE all_animals AS
    SELECT *, 'Собаки' as class FROM dogs
    UNION SELECT *, 'Кошки' AS class FROM cats
    UNION SELECT *, 'Хомяки' AS class FROM hamsters
    UNION SELECT *, 'Лошади' AS class FROM horses
    UNION SELECT *, 'Ослы' AS class FROM donkeys;

CREATE TABLE young_animals AS
SELECT Name, Birthday, Commands, class, TIMESTAMPDIFF(MONTH, Birthday, CURDATE()) AS Age_in_month
FROM all_animals WHERE Birthday BETWEEN ADDDATE(curdate(), INTERVAL -3 YEAR) AND ADDDATE(CURDATE(), INTERVAL -1 YEAR);

SELECT h.Name, h.Birthday, h.Commands, pa.Pack_animal_class, ya.Age_in_month 
FROM horses h
LEFT JOIN young_animals ya ON ya.Name = h.Name
LEFT JOIN pack_animals pa ON pa.Id = h.Pack_animal_id
UNION 
SELECT d.Name, d.Birthday, d.Commands, pa.Pack_animal_class, ya.Age_in_month 
FROM donkeys d 
LEFT JOIN young_animals ya ON ya.Name = d.Name
LEFT JOIN pack_animals pa ON pa.Id = d.Pack_animal_id
UNION
SELECT c.Name, c.Birthday, c.Commands, p.Pet_class, ya.Age_in_month 
FROM cats c
LEFT JOIN young_animals ya ON ya.Name = c.Name
LEFT JOIN pets p ON p.Id = c.Pet_id
UNION
SELECT d.Name, d.Birthday, d.Commands, p.Pet_class, ya.Age_in_month 
FROM dogs d
LEFT JOIN young_animals ya ON ya.Name = d.Name
LEFT JOIN pets p ON p.Id = d.Pet_id
UNION
SELECT hm.Name, hm.Birthday, hm.Commands, p.Pet_class, ya.Age_in_month 
FROM hamsters hm
LEFT JOIN young_animals ya ON ya.Name = hm.Name
LEFT JOIN pets p ON p.Id = hm.Pet_id;