(1) Events Map
(2) Logins for different admins who can post the news on the group

Server in JSP 
Client in Java

Tables
CREATE TABLE Event (
	eventId 	LONGINT AUTO_INCREMENT PRIMARY KEY,
	startTime 	TIMESTAMP,
	endTime 	TIMESTAMP,
	title		VARCHAR(100),
	content		VARCHAR(500),
	locationId	INT NOT NULL,
	category	ENUM,			// club associated
	postedBy	VARCHAR(40) NOT NULL,	// userId
	status		ENUM,			// completed, ongoing, scheduled or Cancelled

	FOREIGN KEY(postedBy) REFERENCES Login(loginId),
	FOREIGN KEY(locationId) REFERENCES Location(locationId)

	-- Create view for mapping locationId easily to eventId

	-- TODOs
	1 HitCount
	2 Attending
);

CREATE TABLE Location (
	locationId	INT AUTO_INCREMENT PRIMARY KEY,
	mainLand	ENUM,
	subLand		VARCHAR(40)
);

CREATE TABLE Login (
	loginId		VARCHAR(40) PRIMARY KEY,
	passwd		VARCHAR(40),
	post		VARCHAR(40),
);

-- Client Side Data
-- SQLite Database 
(1) User Preferences
(2) Sync News [From current time onwards(either starting or ending)]
(3) Remainder DB
	- EventId
	- RemainderTime

Preferences
	- sync_manually 	// or auto sync
	- 
-- Sync the local DB when phone gets connected to internet
--	or if connected forever, then poll or update the DB
--	every hour [user preferred]

-- Class Modules in Application

-- Server
(1) Logins
	- createLogin ()
	- updateLogin ()
	- deleteLogin ()

(2) News[Events] DataBase 
	- addEvent ()
	- editEvent ()

-- Client
	- addRemainder ()
	- udpateRemainder ()
	- deleteRemainder ()
	- showMap ()
	- showMapGroupByCategory ()
	- setPreferences ()
	
	
