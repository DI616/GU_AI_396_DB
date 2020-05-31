-- Статистика по проведенным в статьях правкам

CREATE VIEW edit_makers AS
  SELECT editings.id AS 'id', 
         editings.is_confirmed AS 'confirmed',
         editings.created_at AS 'created at',
         editors.id AS 'editor', 
         editors.is_registred AS 'editor is registred',
         users.name AS 'name', 
         articles.id AS 'article' 
  FROM editings
    JOIN editors 
      ON editors.id = editings.editor_id 
    LEFT JOIN users
      ON users.editor_id = editors.id 
    JOIN current_bodies 
      ON current_bodies.editing_id  = editings.id 
    JOIN articles 
      ON articles.id = current_bodies.article_id;
  
     
-- Статисика наличия текств статей на разных языках

CREATE VIEW articles_languages AS
  SELECT articles.id,
         language_article(articles.id, 1) AS 'EN',
         language_article(articles.id, 2) AS 'CN',
         language_article(articles.id, 3) AS 'DE',
         language_article(articles.id, 4) AS 'ES',
         language_article(articles.id, 5) AS 'FR',
         language_article(articles.id, 6) AS 'IT',
         language_article(articles.id, 7) AS 'RU'
  FROM articles;
  