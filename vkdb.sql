CREATE DATABASE vk;

USE vk;

-- Создаём таблицу пользователей
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(120) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

-- Таблица профилей
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY,
  gender CHAR(1) NOT NULL,
  birthday DATE,
  city VARCHAR(100),
  country VARCHAR(100),
  photo_id INT UNSIGNED,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

-- Таблица сообщений
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  from_user_id INT UNSIGNED NOT NULL,
  to_user_id INT UNSIGNED,
  community_id INT UNSIGNED,
  body TEXT NOT NULL,
  is_important BOOLEAN,
  is_delivered BOOLEAN,
  created_at DATETIME DEFAULT NOW()
);

-- Таблица дружбы
CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL,
  friend_id INT UNSIGNED NOT NULL,
  status_id INT UNSIGNED NOT NULL,
  requested_at DATETIME DEFAULT NOW(),
  confirmed_at DATETIME,
  PRIMARY KEY (user_id, friend_id)
);

-- Таблица статусов дружеских отношений
CREATE TABLE friendship_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);

-- Таблица публикаций
CREATE TABLE publications (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  community_id INT UNSIGNED, -- Пост может быть опубликован как в профиле, так и в группе
  title VARCHAR(128) NOT NULL,
  body TEXT NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

-- Таблица связи публикаций и медиафайлов
CREATE TABLE publications_media (
    publication_id INT UNSIGNED NOT NULL,
    media_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (publication_id, media_id)
);

-- Таблица групп
CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);

-- Таблица связи пользователей и групп
CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (community_id, user_id)
);

-- Таблица медиафайлов
-- Тип фала и расширение не согласованы, но тут я заморачиваться не стал
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  media_type_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  filename VARCHAR(255) NOT NULL,
  size INT NOT NULL,
  metadata JSON,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Таблица типов медиафайлов
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

/* Если проставлять лайки без привязки к пользователям, то достаточно добавить в таблицы сущностей,
   которые возможно лайкнуть, столбец liked, который инкрементировался бы при нажатии кнопки like.
   Если сохранять пользователей, которые поставили лайк, можно составить для каждого типа контента
   создать отдельную таблицу с лайками, или следующий вариант. */

-- Таблица лайков
CREATE TABLE likes (
  from_user_id INT UNSIGNED NOT NULL,
  entity_id INT UNSIGNED NOT NULL,
  entity_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  PRIMARY KEY (from_user_id, entity_id)
);

-- Таблица типов контента
CREATE TABLE entity_type (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE
);
