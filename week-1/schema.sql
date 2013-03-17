CREATE DATABASE EventsMapServer;
use EventsMapServer;

-- Tables

CREATE TABLE Login (
	loginId		VARCHAR(40) PRIMARY KEY,
	-- SHA2-512 hash
	passwdHash	VARCHAR(512) NOT NULL,
	-- need to give it a thought
	-- deleted for the time being
	-- salt		VARCHAR(20) NOT NULL,
	email		VARCHAR(100) NOT NULL,

	-- not used for now
	attemptCount	INT,
	post		VARCHAR(40) NOT NULL
);

-- ENUM('HOSTEL', 'ACADEMIC', 'SPORTS', 'CULTURAL', 'TECHNICAL', 'ALCHER', 'TECHNICHE') NOT NULL,
CREATE TABLE Category (
	categoryId	INT PRIMARY KEY,
	category	VARCHAR(50) NOT NULL UNIQUE
);

-- ENUM('SAC','LT', 'MCOM', 'NAC', 'HOSTEL') NOT NULL,
CREATE TABLE MainLand (
	mainLandId	INT PRIMARY KEY,
	mainLand	VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Location (
	locationId	INT AUTO_INCREMENT PRIMARY KEY,
	mainLandId	INT,
	subLand		VARCHAR(40),
	FOREIGN KEY(mainLandId) REFERENCES MainLand(mainLandId)
);

CREATE TABLE Event (
	eventId 	BIGINT AUTO_INCREMENT PRIMARY KEY,
	startTime 	TIMESTAMP NOT NULL,
	endTime 	TIMESTAMP NOT NULL,
	title		VARCHAR(100) NOT NULL,
	content		VARCHAR(500),
	locationId	INT NOT NULL,
	categoryId	INT, 
	postedBy	VARCHAR(40) NOT NULL,	
	status		ENUM('ONGOING', 'SCHEDULED', 'CANCELLED', 'COMPLETED') NOT NULL,
	FOREIGN KEY(postedBy) REFERENCES Login(loginId),
	FOREIGN KEY(locationId) REFERENCES Location(locationId),
	FOREIGN KEY(categoryId) REFERENCES Category(categoryId)
);


-- on client side
-- Event table is same except that it includes one more field
-- 	isRead	BOOL

CREATE TABLE Remainder (
	time		TIMESTAMP NOT NULL,
	eventId		LONGINT,
	category	ENUM('HOSTEL', 'ACADEMIC', 'SPORTS', 'CULTURAL', 'TECHNICAL', 'ALCHER', 'TECHNICHE') NOT NULL,
	FOREIGN KEY (eventId) REFERENCES Event(eventId)
);


