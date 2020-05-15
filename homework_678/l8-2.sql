/* В таблице products есть два текстовых поля:
 * name с названием товара и description с его описанием. 
 * Допустимо присутствие обоих полей или одно из них. 
 * Ситуация, когда оба поля принимают неопределенное значение NULL 
 * неприемлема. Используя триггеры, добейтесь того, чтобы одно 
 * из этих полей или оба поля были заполнены. При попытке 
 * присвоить полям NULL-значение необходимо отменить операцию.*/

DROP TRIGGER IF EXISTS products_inserts;
DELIMITER //
CREATE TRIGGER products_inserts BEFORE INSERT ON products
FOR EACH ROW
BEGIN 
	DECLARE _name, _description VARCHAR(255);
    SELECT NEW.name INTO _name;
    SELECT NEW.description INTO _description;
    IF _name IS NULL AND _description IS NULL THEN 
      SIGNAL SQLSTATE '45000' SET message_text = 'Name and description should not be empty';
    END IF;
END//
DELIMITER ;