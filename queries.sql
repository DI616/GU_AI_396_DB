-- Подсчитать общее количество лайков десяти самым молодым пользователям 
-- (сколько лайков получили 10 самых молодых пользователей)

SELECT COUNT(target_id) FROM likes
  RIGHT JOIN (
    SELECT * FROM profiles 
      ORDER BY birthday DESC 
      LIMIT 10) AS profiles
    ON likes.target_id = profiles.user_id 
      AND likes.target_type_id = 2;

     
-- Определить кто больше поставил лайков (всего) - мужчины или женщины?
     
SELECT gender FROM (
  SELECT 
    COUNT(*) AS `count`, 
    IF (profiles.gender = 'm', 'men', 'women') AS gender
      FROM likes 
        INNER JOIN profiles
          ON likes.user_id = profiles.user_id
      GROUP BY profiles.gender
      ORDER BY `count` DESC) AS tbl 
    LIMIT 1;
  
   
-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
   
SELECT DISTINCT
  u.id AS 'id',
  CONCAT(u.first_name, ' ', u.last_name) AS 'name',
  (
    0.5 * COUNT(DISTINCT m.id) +
    0.5 * COUNT(DISTINCT l.id) +
    COUNT(DISTINCT p.id) +
    COUNT(DISTINCT media.id) +
    COUNT(DISTINCT f1.friend_id) +
    COUNT(DISTINCT f2.user_id)
  ) AS activity
  FROM users AS u
    LEFT JOIN messages AS m 
      ON m.from_user_id = u.id
    LEFT JOIN likes AS l 
      ON l.user_id = u.id
    LEFT JOIN publications AS p
      ON p.user_id = u.id
    LEFT JOIN media
      ON media.user_id = u.id
    LEFT JOIN friendship AS f1
      ON f1.user_id = u.id AND f1.status_id =1
    LEFT JOIN friendship AS f2
      ON f2.friend_id = u.id AND f2.status_id =1
  GROUP BY u.id
  ORDER BY activity


/* Проанализировать какие запросы могут выполняться наиболее часто 
 * в процессе работы приложения и добавить необходимые индексы*/

CREATE INDEX users_name_idx ON users(name);
CREATE INDEX users_city_idx ON users(city);
CREATE INDEX profiles_birthday_idx ON profiles(birthday);
CREATE INDEX puplications_created_at_idx ON publications(created_at);
CREATE INDEX messages_created_at_idx ON messages(created_at);
CREATE INDEX messages_from_user_id_idx ON messages(from_user_id);
CREATE INDEX messages_to_user_id_idx ON messages(to_user_id);


/* Построить запрос, который будет выводить следующие столбцы:
 * имя группы
 * среднее количество пользователей в группах
 * самый молодой пользователь в группе
 * самый старший пользователь в группе
 * общее количество пользователей в группе
 * всего пользователей в системе
 * отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100*/
       
SELECT DISTINCT communities.name,
  COUNT(communities_users.user_id) OVER () / (SELECT COUNT(*) FROM communities) AS average,
  MAX(profiles.birthday) OVER w AS yongest_user,
  MIN(profiles.birthday) OVER w AS oldest_user,
  COUNT(communities_users.user_id) OVER () AS total,
  COUNT(communities_users.user_id) OVER w AS total_in_group,
  COUNT(communities_users.user_id) OVER w / COUNT(profiles.user_id) OVER () * 100 AS "%"
    FROM communities 
      JOIN communities_users 
        ON communities.id = communities_users.community_id
      JOIN users 
        ON users.id = communities_users.user_id
      JOIN profiles 
        ON profiles.user_id = users.id
    WINDOW w AS (PARTITION BY communities.name);



/* Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
 * catalogs и products в таблицу logs помещается время и дата создания записи, 
 * название таблицы, идентификатор первичного ключа и содержимое поля name.*/

CREATE TABLE logs (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  table_name VARCHAR(50) NOT NULL,
  row_id INT UNSIGNED NOT NULL,
  row_name VARCHAR(50) NOT NULL
) ENGINE=Archive;

CREATE TRIGGER users_inserts AFTER INSERT ON users
FOR EACH ROW 
BEGIN
  INSERT INTO logs(id, created_at, table_name, row_id, row_name) VALUES (
    NULL, NULL, 'users', NEW.id, NEW.name
  );
END;

CREATE TRIGGER users_inserts AFTER INSERT ON catalogs
FOR EACH ROW 
BEGIN
  INSERT INTO logs(id, created_at, table_name, row_id, row_name) VALUES (
    NULL, NULL, 'catalogs', NEW.id, NEW.name
  );
END;

CREATE TRIGGER users_inserts AFTER INSERT ON products
FOR EACH ROW 
BEGIN
  INSERT INTO logs(id, created_at, table_name, row_id, row_name) VALUES (
    NULL, NULL, 'products', NEW.id, NEW.name
  );
END;


/*Создайте SQL-запрос, который помещает в таблицу users миллион записей.*/

CREATE TABLE some_table (i INT);


CREATE PROCEDURE one_million_inserts ()
BEGIN
	DECLARE i INT;
    SET i = 1000000;
	
    WHILE i > 0 DO
      INSERT INTO some_table VALUES (i);
      SET i = i - 1;
   END WHILE;
END;

CALL one_million_inserts();
