-- Пусть в таблице users поля created_at и updated_at оказались незаполненными.
-- Заполните их текущими датой и временем.

INSERT INTO `users` (created_at, updated_at) VALUES (NOW(), NOW());

-- Таблица users была неудачно спроектирована. Записи created_at и updated_at
-- были заданы типом VARCHAR и в них долгое время помещались значения в формате
-- "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME,
-- сохранив введеные ранее значения.

UPDATE `users` SET 
  created_at = STR_TO_DATE(created_at, "%d.%m.%Y %h:%i"),
  updated_at = STR_TO_DATE(updated_at, "%d.%m.%Y %h:%i");
 
ALTER TABLE `users` CHANGE
  created_at created_at DATETIME DEFAULT NOW(),
  updated_at updated_at DATETIME DEFAULT NOW() ON UPDATE NOW();

-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
-- 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом,
-- чтобы они выводились в порядке увеличения значения value.
-- Однако, нулевые запасы должны выводиться в конце, после всех записей.

SELECT * FROM `storehouses_products` ORDER BY IF(value > 0, 0, 1), value;

-- Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
-- Месяцы заданы в виде списка английских названий ('may', 'august')

SELECT * FROM users WHERE DATE_FORMAT(birthday_at, '%M') IN ('may', 'august');

-- Из таблицы catalogs извлекаются записи при помощи запроса.
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);

-- Подсчитайте средний возраст пользователей в таблице users

SELECT ROUND(
  AVG(
   TIMESTAMPDIFF(YEAR, birthday_at, NOW())
  )
 ) FROM users;

-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT COUNT(*), DATE_FORMAT(
  DATE(
   CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))
  ),
  '%W') AS day 
FROM users 
GROUP BY day;

-- Подсчитайте произведение чисел в столбце таблицы

SELECT EXP(SUM(LOG(id))) FROM users;
