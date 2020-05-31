-- Функция, определяющая наличие определенной статьи на определенной языке.
-- Используется в одном из представлений.

DROP FUNCTION IF EXISTS language_article;

DELIMITER //

CREATE FUNCTION language_article (art_id INT, lang_id INT)
RETURNS VARCHAR(3) READS SQL DATA
BEGIN
	SET @r = (SELECT editing_id FROM current_bodies WHERE
	           language_id = lang_id 
	           AND article_id  = art_id LIMIT 1);
	          
    IF(@r IS NOT NULL) THEN
      RETURN 'YES';
    ELSE
      RETURN 'NO';
    END IF;
END//

DELIMITER ;
