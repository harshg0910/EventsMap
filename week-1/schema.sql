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
	email		VARCHAR(100) NOT NULL UNIQUE,

	-- not used for now
	attemptCount	INT,
	post		VARCHAR(40) NOT NULL
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
	mapId		VARCHAR(30) 
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


-- on client side
-- Event table is same except that it includes one more field
-- 	isRead	BOOL

-- CREATE TABLE Remainder (
-- 	time		TIMESTAMP NOT NULL,
-- 	eventId		LONGINT,
-- 	category	ENUM('HOSTEL', 'ACADEMIC', 'SPORTS', 'CULTURAL', 'TECHNICAL', 'ALCHER', 'TECHNICHE') NOT NULL,
-- 	FOREIGN KEY (eventId) REFERENCES Event(eventId)
-- );

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

INSERT INTO MainLand (mainLand) values('SAC');
INSERT INTO MainLand (mainLand) values('LT');
INSERT INTO MainLand (mainLand) values('NAC');


INSERT INTO Category (category) values('Coding Club');
INSERT INTO Category (category) values('CSEA');
INSERT INTO Category (category) values('Montage');

INSERT INTO Login (userName,passwdHash,email,post) VALUES ('ccAdmin',sha2('ccAdmin',256),'g.harsh@iitg.ernet.in','ccAdmin');
