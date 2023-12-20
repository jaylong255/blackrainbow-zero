-- Execute a statement to create a database named 'testing' if it doesn't exist

CREATE DATABASE IF NOT EXISTS `testing`;
GRANT ALL PRIVILEGES ON *.* TO 'laravel'@'%';