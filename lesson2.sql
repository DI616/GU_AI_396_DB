 
DROP DATABASE IF EXISTS `example`;
DROP DATABASE IF EXISTS `sample`;

CREATE DATABASE `example`;
CREATE DATABASE `sample`;

USE `example`;

CREATE TABLE `users` (
    `id` SERIAL PRIMARY KEY,
    `name` VARCHAR(255) 
    );
