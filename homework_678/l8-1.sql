/* Создайте хранимую функцию hello(), которая будет возвращать приветствие,
 * в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна
 * возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать
 * фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер",
 * с 00:00 до 6:00 — "Доброй ночи".*/

DROP FUNCTION IF EXISTS greeting;
DELIMITER //
CREATE FUNCTION greeting ()
RETURNS TEXT DETERMINISTIC
BEGIN
  DECLARE day_period TIME;
  DECLARE res TEXT;
  SET day_period = TIME(NOW());
  SET res = 
	CASE  
	  WHEN day_period BETWEEN TIME('06:00:00') AND TIME('11:59:59') THEN 'Good morning'
	  WHEN day_period BETWEEN TIME('12:00:00') AND TIME('17:59:59') THEN 'Good day'
	  WHEN day_period BETWEEN TIME('18:00:00') AND TIME('23:59:59') THEN 'Good evening'
	  ELSE 'Good night'
    END;
  RETURN res;
END//
DELIMITER ;

SELECT greeting();