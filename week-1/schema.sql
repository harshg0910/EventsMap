 -- Tables
CREATE TABLE Event (
	eventId 	LONGINT AUTO_INCREMENT PRIMARY KEY,
	startTime 	TIMESTAMP NOT NULL,
	endTime 	TIMESTAMP NOT NULL,
	title		VARCHAR(100) NOT NULL,
	content		VARCHAR(500),
	locationId	INT NOT NULL,
	category	ENUM('HOSTEL', 'ACADEMIC', 'SPORTS', 'CULTURAL', 'TECHNICAL', 'ALCHER', 'TECHNICHE') NOT NULL,
	postedBy	VARCHAR(40) NOT NULL,	
	status		ENUM('ONGOING', 'SCHEDULED', 'CANCELLED', 'COMPLETED') NOT NULL,
	FOREIGN KEY(postedBy) REFERENCES Login(loginId),
	FOREIGN KEY(locationId) REFERENCES Location(locationId)
);


CREATE TABLE Location (
	locationId	INT AUTO_INCREMENT PRIMARY KEY,
	mainLand	ENUM('SAC','LT', 'MCOM', 'NAC', 'HOSTEL') NOT NULL,
	subLand		VARCHAR(40)
);

CREATE TABLE Login (
	loginId		VARCHAR(40) PRIMARY KEY,
	-- SHA2-512 hash
	passwdHash	VARCHAR(512) NOT NULL,
	-- need to give it a thought
	salt		VARCHAR(20) NOT NULL,
	attemptCount	INT,
	post		VARCHAR(40) NOT NULL
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


