-- Create a new database for testing Localazy out
CREATE DATABASE localazy_test;

-- Connect to the newly created database
\c localazy_test;

-- Create a new table for translations
CREATE TABLE translations( 
	id VARCHAR(256), 
	locale VARCHAR(12),
	content VARCHAR (4096),
	PRIMARY KEY (id, locale)
);

-- Populate translations table with some content
INSERT INTO translations (id, locale, content) VALUES 
	('settings', 'en', 'Settings'),
	('main_menu', 'en', 'Main Menu'),
	('share', 'en', 'Share'),
	('error_connection', 'en', 'Connection error occurred!');

-- We can easily verify the content of the table
SELECT * FROM translations;
