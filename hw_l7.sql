-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT
  u.id, u.name, o.id
FROM
  users AS u
JOIN
  orders AS o
ON
  u.id = o.user_id;

-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT
  p.id, p.name, c.name
FROM
  products AS p
LEFT JOIN
  catalogs AS c
ON
  p.catalog_id = c.id;

-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское.
-- Выведите список рейсов flights с русскими названиями городов.

SELECT
  c1.name AS 'from', c2.name AS 'to'
FROM
  flights AS f
LEFT JOIN
  cities AS c1 ON f._from = c1.label
LEFT JOIN
  cities AS c2 ON f._to = c2.label
ORDER BY f.id;
