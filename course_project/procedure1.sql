-- Процедура для получения количества статей в определенной категории

DROP PROCEDURE IF EXISTS articles_count;

DELIMITER //

CREATE PROCEDURE articles_count (IN category_name VARCHAR(45))

BEGIN
	SET @cat_id = (SELECT id FROM categories WHERE name = category_name);

    IF(@cat_id IS NOT NULL) THEN
      SELECT COUNT(article_id) FROM categories_articles WHERE category_id = @cat_id;
    ELSE
      SELECT 'No articles in this category';
    END IF;
END//

DELIMITER ;
