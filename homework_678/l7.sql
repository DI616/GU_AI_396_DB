/* Создайте двух пользователей которые имеют доступ к базе данных shop. 
 * Первому пользователю shop_read должны быть доступны только запросы на 
 * чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.*/

GRANT SELECT ON shop.* TO 'shop_read'@'localhost' IDENTIFIED WITH mysql_native_password  BY 'qwerty';

GRANT ALL ON shop.* TO 'shop_all'@'localhost' IDENTIFIED WITH mysql_native_password BY 'qwerty';


/* Пусть имеется таблица accounts содержащая три столбца id, name, password, 
 * содержащие первичный ключ, имя пользователя и его пароль. Создайте представление 
 * username таблицы accounts, предоставляющий доступ к столбца id и name. Создайте 
 * пользователя user_read, который бы не имел доступа к таблице accounts, однако, 
 * мог бы извлекать записи из представления username.*/

CREATE VIEW username AS SELECT id, name FROM accounts;

REVOKE ALL ON shop.* TO 'shop_read'@'localhost';
GRANT ALL ON shop.username TO 'shop_read'@'localhost';

