DROP DATABASE IF EXISTS EventsMapServer;
CREATE DATABASE EventsMapServer;
use EventsMapServer;

-- Tables

CREATE TABLE Login (
	loginId		INT AUTO_INCREMENT PRIMARY KEY,
	userName	VARCHAR(40) NOT NULL,
	-- SHA2-512 hash
	passwdHash	VARCHAR(512) NOT NULL,
	-- need to give it a thought
	-- deleted for the time being
	-- salt		VARCHAR(20) NOT NULL,
	email		VARCHAR(100) NOT NULL,

	-- not used for now
	attemptCount	INT,
	post		VARCHAR(40) NOT NULL,
	UNIQUE (email, post)
);

-- ENUM('HOSTEL', 'ACADEMIC', 'SPORTS', 'CULTURAL', 'TECHNICAL', 'ALCHER', 'TECHNICHE') NOT NULL,
CREATE TABLE Category (
	categoryId	INT AUTO_INCREMENT PRIMARY KEY,
	category	VARCHAR(50) NOT NULL UNIQUE
);

-- ENUM('SAC','LT', 'MCOM', 'NAC', 'HOSTEL') NOT NULL,
CREATE TABLE MainLand (
	mainLandId	INT AUTO_INCREMENT PRIMARY KEY,
	mainLand	VARCHAR(50) NOT NULL UNIQUE,
	mapId		VARCHAR(10) 
);

CREATE TABLE Location (
	locationId	INT AUTO_INCREMENT PRIMARY KEY,
	mainLandId	INT,
	subLand		VARCHAR(40),
	FOREIGN KEY(mainLandId) REFERENCES MainLand(mainLandId)
);

CREATE TABLE Event (
	eventId 	BIGINT AUTO_INCREMENT PRIMARY KEY,
	modifiedTime	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	startTime 	TIMESTAMP NOT NULL,
	endTime 	TIMESTAMP NOT NULL,
	title		VARCHAR(100) NOT NULL,
	content		VARCHAR(500),
	locationId	INT NOT NULL,
	categoryId	INT, 
	postedBy	INT,
	status		ENUM('ONGOING', 'SCHEDULED', 'CANCELLED', 'COMPLETED') NOT NULL,
	FOREIGN KEY(postedBy) REFERENCES Login(loginId),
	FOREIGN KEY(locationId) REFERENCES Location(locationId),
	FOREIGN KEY(categoryId) REFERENCES Category(categoryId)
);

-- Set triggers for updating modified time on update & insert events
-- on events table
DROP TRIGGER IF EXISTS `insert_Event_trigger`;
DELIMITER //
CREATE TRIGGER `insert_Event_trigger` BEFORE INSERT ON `Event`
 FOR EACH ROW SET NEW.`modifiedTime` = NOW()
//
DELIMITER ;

DROP TRIGGER IF EXISTS `update_Event_trigger`;
DELIMITER //
CREATE TRIGGER `update_Event_trigger` BEFORE UPDATE ON `Event`
 FOR EACH ROW SET NEW.`modifiedTime` = NOW()
//
DELIMITER ;

-- Insert queries for the different tables

INSERT INTO Login (userName,passwdHash,email,post) VALUES ('ccadmin',sha2('ccadmin',256),'g.harsh@iitg.ernet.in','ccadmin');
