/* Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность
 * в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.*/

DROP FUNCTION IF EXISTS FIBONACCI;
DELIMITER //
CREATE FUNCTION FIBONACCI (num INT)
RETURNS INT DETERMINISTIC
BEGIN
	SET @n = num;
    SET @c1 = 1;
    SET @c2 = 0;
    SET @buf = 0;
    WHILE @n > 1 DO
     SET @buf = @c1;
     SET @c1 = @c1 + @c2;
     SET @c2 = @buf;
     SET @n = @n - 1;
    END WHILE;
    RETURN @c1;
END//
DELIMITER ;