/* В базе данных shop и sample присутствуют одни и те же таблицы,
 * учебной базы данных. Переместите запись id = 1 из таблицы 
 * shop.users в таблицу sample.users. Используйте транзакции.*/

START TRANSACTION;

SELECT * FROM shop.users WHERE id = 1;

INSERT INTO sample.users (name, birthday_at)
  SELECT name, birthday_at FROM shop.users WHERE id = 1;
 
DELETE FROM shop.users WHERE id = 1;
 
SELECT * FROM sample.users;
  
COMMIT;


/* Создайте представление, которое выводит название name товарной 
 * позиции из таблицы products и соответствующее название каталога 
 * name из таблицы catalogs.*/

CREATE VIEW products_catalogs AS
  SELECT p.name AS product, c.name AS `catalog`
    FROM products AS p
      LEFT JOIN catalogs AS c
        ON p.catalog_id = c.id;
        

/* Пусть имеется таблица с календарным полем created_at. 
 * В ней размещены разряженые календарные записи за август 
 * 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
 * Составьте запрос, который выводит полный список дат за август, 
 * выставляя в соседнем поле значение 1, если дата присутствует 
 * в исходной таблице и 0, если она отсутствует.*/

CREATE TABLE events (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  created_at DATE
);

INSERT INTO events (created_at, name) VALUES 
  (DATE('2018-08-01'), 'a'), 
  (DATE('2018-08-04'), 'b'), 
  (DATE('2018-08-16'), 'c'),
  (DATE('2018-08-17'), 'd');

SELECT selected_date , IF(events.created_at IS NOT NULL, 1, 0) AS events FROM 
 (SELECT adddate('1970-01-01',t4*10000 + t3*1000 + t2*100 + t1*10 + t0) AS selected_date FROM
 (SELECT 0 t0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t0,
 (SELECT 0 t1 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
 (SELECT 0 t2 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,
 (SELECT 0 t3 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t3,
 (SELECT 0 t4 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t4) v
   LEFT JOIN events ON created_at = selected_date
  WHERE selected_date BETWEEN '2018-08-01' AND '2018-08-31'
  ORDER BY selected_date;


/* Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, 
 * который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.*/

SELECT @created_at := created_at FROM test ORDER BY created_at DESC LIMIT 5, 1;
DELETE FROM test WHERE created_at <= @created_at;

/* Данный запрос также можно было бы проводить с выборкой по id, 
 * и тогда гарантированно не удалялись бы записи с одинаковой датой,
 * но в уловии не было id, так что оставил такой вариант*/













