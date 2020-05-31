-- Получение текста статьи по id и языку

SELECT current_bodies.body FROM articles 
  JOIN current_bodies
    ON current_bodies.article_id = articles.id  
  JOIN languages 
    ON current_bodies.language_id = languages.id
WHERE articles.id = 309 
  AND languages.id = 1;
 
 
-- Выбор списка статей по категории

SELECT articles.id FROM articles 
  JOIN categories_articles 
    ON articles.id = categories_articles.article_id 
  JOIN categories 
    ON categories.id = categories_articles.category_id 
  WHERE categories.id = 1;


 -- Подборка медиа по категории
 
 SELECT media.id, media.filename FROM media
   JOIN articles 
     ON media.article_id = articles.id 
   JOIN categories_articles 
     ON categories_articles.article_id = articles.id 
   JOIN categories 
     ON categories.id = categories_articles.category_id 
   WHERE categories.name = 'enim';
