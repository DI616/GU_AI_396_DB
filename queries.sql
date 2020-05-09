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
