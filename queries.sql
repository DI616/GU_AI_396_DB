-- Подсчитать общее количество лайков десяти самых молодых пользователей.

-- Тут дваварианта, так как не совсем понял задание. В певом варианте 
-- подсчитывается количесво лайков для каждого отдельного пользователя,
-- причем не учитываются те, кто вообще не ставил лайков, во втором же 
-- подсчитывается общее количество с учетом не ставивших лайки.

-- Первый варианрт
SELECT 
  user_id AS 'id', 
  count(*) AS 'total',
  (
    SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE users.id = likes.user_id
  ) AS 'user',
  (
    SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM profiles WHERE profiles.user_id = likes.user_id
  ) AS 'age',
  (
    SELECT birthday FROM profiles WHERE profiles.user_id = likes.user_id
  ) AS 'birthday'
  FROM likes 
  GROUP BY user_id
  ORDER BY birthday DESC
  LIMIT 10;
  
-- Второй вариант
SELECT COUNT(*) AS total FROM likes WHERE likes.user_id IN(
  SELECT * FROM (
	SELECT user_id FROM profiles
    ORDER BY birthday DESC
    LIMIT 10
  ) AS T
);

-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT (
  SELECT COUNT(*) FROM likes WHERE user_id IN(
    SELECT * FROM (
      SELECT user_id FROM profiles WHERE gender = 'm'   
    ) AS T 
  )
) AS 'male',
(
  SELECT COUNT(*) FROM likes WHERE user_id IN(
    SELECT * FROM (
      SELECT user_id FROM profiles WHERE gender = 'f'   
    ) AS T 
  )
) AS 'female';

-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети

-- Коэффициенты активности: 
-- сообщение - 0.5, лайк - 0.5, пост - 1, отправленная заявка - 0.75, друг - 1.5, фото профиля - 2, загруженное медиа - 1

SELECT * FROM messages WHERE from_user_id = 130 OR to_user_id = 130;
SELECT * FROM likes WHERE user_id = 130;
SELECT * FROM publications WHERE user_id = 130;
SELECT * FROM friendship WHERE (user_id = 130 OR friend_id = 130) AND status_id = 2;
SELECT * FROM friendship WHERE (user_id = 130 OR friend_id = 130) AND status_id = 1;
SELECT * FROM profiles WHERE user_id = 130;
SELECT * FROM media WHERE user_id = 130;

desc friendship;
select * from friendship_statuses;

SELECT users.id AS 'id',
  CONCAT(users.first_name, ' ', users.last_name) AS 'name',
  (
    (SELECT 0.5 * (SELECT COUNT(*) FROM messages WHERE from_user_id = users.id OR to_user_id = users.id)) +
    (SELECT 0.5 * (SELECT COUNT(*) FROM likes WHERE user_id = users.id)) +
    (SELECT COUNT(*) FROM publications WHERE user_id = users.id) +
    (SELECT 0.75 * (SELECT COUNT(*) FROM friendship WHERE (user_id = users.id OR friend_id = users.id) AND status_id = 2)) +
    (SELECT 1.5 * (SELECT COUNT(*) FROM friendship WHERE (user_id = users.id OR friend_id = users.id) AND status_id = 1)) +
    (SELECT COUNT(*) FROM media WHERE user_id = users.id) +
    (SELECT COUNT(*) FROM profiles WHERE user_id = users.id AND profiles.photo_id IS NOT NULL)
  ) AS 'activity' 
  FROM users
  GROUP BY id
  ORDER BY activity
  LIMIT 10;

