-- Begin of the script 
DROP DATABASE IF EXISTS cs122a;
CREATE DATABASE cs122a;
USE cs122a;

--
-- Table structure for table People
-- 

CREATE TABLE People (
	id	VARCHAR(40),
    name_firstname	VARCHAR(40),
    name_lastname VARCHAR(40),
    PRIMARY KEY (id)
    );
    
--
-- Table structure for table User 
--

CREATE TABLE User (
	user_id VARCHAR(40),
	email VARCHAR(40), 
    zipcode VARCHAR(10),
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES People(id) ON DELETE CASCADE
    );
    
-- 
-- Table structure for Table Interest 
--

CREATE TABLE Insterest(
	interest ENUM('rock', 'pop', 'r&b', 'classical', 'country', 'jazz', 'heavy metal', 'other') NOT NULL,
    interest_user_id VARCHAR(40),
    PRIMARY KEY(interest,interest_user_id),
    FOREIGN KEY (interest_user_id) REFERENCES User(user_id) ON DELETE CASCADE
    );
--
-- Table structure for Table Artist 
-- 

CREATE TABLE Artist (
	artist_id VARCHAR(40) ,
	bio TEXT,
    PRIMARY KEY (artist_id),
    FOREIGN KEY (artist_id) REFERENCES User(user_id) ON DELETE CASCADE
    );
 
 --
 -- Table Structure for Table Free
 --
 
 CREATE TABLE Free(
	free_user_id VARCHAR(40) ,
    PRIMARY KEY (free_user_id),
    FOREIGN KEY (free_user_id) REFERENCES User(user_id) ON DELETE CASCADE
    );
    
-- 
-- Table structure for Premium 
-- 

CREATE TABLE Premium(
	premium_id VARCHAR(40) ,
	ccnumber VARCHAR(16), 
    ctype ENUM('Amex', 'VISA', 'Mastercard', 'Discover') ,
    security_code VARCHAR(4),
    exp_date CHAR(7),
    PRIMARY KEY (premium_id),
    FOREIGN KEY (premium_id) REFERENCES User(user_id) ON DELETE CASCADE
    );
    
--
-- Table structure for Ads
--

CREATE TABLE Ads(
	ads_id VARCHAR(40) ,
    company_name VARCHAR(40) ,
    ads_free_id VARCHAR(40),
    PRIMARY KEY (ads_id, company_name),
    FOREIGN KEY (ads_free_id) REFERENCES Free(free_user_id) ON DELETE CASCADE
    );
    
--
-- Table structure for table Image
--
CREATE TABLE Image(
	image BLOB,
    company_name VARCHAR(40),
    image_ads_id VARCHAR(40),
    PRIMARY KEY( image(30),image_ads_id,company_name),
    FOREIGN KEY (image_ads_id) REFERENCES Ads(ads_id) ,
	FOREIGN KEY(company_name) REFERENCES Ads(company_name) 
    );
    
    
--
-- Table structure for Playlist
--
CREATE TABLE Playlist(
	pid VARCHAR(40),
    ptype ENUM('public', 'private') NOT NULL,
    playlist_user_id VARCHAR(40),
    duration TIME, 
	PRIMARY KEY (pid, playlist_user_id),
    FOREIGN KEY (playlist_user_id) REFERENCES User(user_id) ON DELETE CASCADE
    );
    
-- 
-- Table structure for Content 
--

CREATE TABLE Content(
	cid VARCHAR(40),
    cid_user_id VARCHAR(40),
    cid_playlist_id VARCHAR(40),
    cid_artist_id VARCHAR(40),
    length TIME, 
    title VARCHAR(10),
    PRIMARY KEY (cid),
    FOREIGN KEY (cid_user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY(cid_artist_id) REFERENCES Artist(artist_id) ON DELETE NO ACTION,
    FOREIGN KEY(cid) REFERENCES Content(cid) ON DELETE CASCADE,
	FOREIGN KEY(cid_playlist_id) REFERENCES Playlist(pid) ON DELETE CASCADE
    );
    
--
-- Table structure for Song
--

CREATE TABLE Song(
	song_cid VARCHAR(40),
	genre ENUM('rock', 'pop', 'r&b', 'classical', 'country', 'jazz', 'heavy metal', 'other') NOT NULL,
    PRIMARY KEY(song_cid),
    FOREIGN KEY(song_cid) REFERENCES Content(cid) ON DELETE CASCADE
    );

--
-- Table structure for Video 
--

CREATE TABLE Video(
	video_cid VARCHAR(40),
	rating ENUM('G', 'PG13', 'PG', 'R', 'E') NOT NULL,
    PRIMARY KEY(video_cid),
    FOREIGN KEY(video_cid) REFERENCES Content(cid) ON DELETE CASCADE
    );



-- Part 2 

--
-- Table Structure for Follow
--
CREATE TABLE Follow(
	since DATE,
	follower   varchar(40),
	followee  varchar(40),
	PRIMARY KEY(follower,followee),
	FOREIGN KEY (follower,followee) REFERENCES User(user_id,user_id) ON DELETE CASCADE
);

--
-- Table structure for Table Watch
--
CREATE TABLE Watch(
	free_user_id VARCHAR(40),
    company_name VARCHAR(40),
    ads_id  VARCHAR(40) NOT NULL,
    PRIMARY KEY(user_id,ads_id,company_name),
    FOREIGN KEY(free_user_id) REFERENCES Free(free_user_id) ON DELETE CASCADE,
    FOREIGN KEY(ads_id,company_name) REFERENCES Ads(ads_id, company_name)ON DELETE CASCADE
    );
    
--
-- Table Structure for Table Create
--
CREATE TABLE Creates(
	user_id VARCHAR(40),
    pid VARCHAR(40) NOT NULL,
    PRIMARY KEY(user_id,pid),
    FOREIGN KEY(user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY(pid) REFERENCES Playlist(pid) ON DELETE CASCADE,
    UNIQUE (pid)
    );
    
--
-- Table structure for Table Produce 
--

CREATE TABLE Produce(
	artist_id VARCHAR(40),
    cid VARCHAR(40) NOT NULL,
    PRIMARY KEY (cid),
    FOREIGN KEY (cid) REFERENCES Content(cid) ON DELETE CASCADE,
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id) ON DELETE CASCADE
    );
    
--
-- Table structure for Table React 
--

CREATE TABLE React(
	user_id VARCHAR (40),
    cid VARCHAR(40),
    rtype VARCHAR(20),
    PRIMARY KEY (user_id, cid),
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (cid) REFERENCES Content(cid) ON DELETE CASCADE
    );
    
--
-- Table structure for Table Skip
--

CREATE TABLE Skip(
	premium_id VARCHAR(40),
    song_cid VARCHAR(40),
    PRIMARY KEY(premium_id,song_id),
    FOREIGN KEY (premium_id) REFERENCES Premium(premium_id) ON DELETE CASCADE,
    FOREIGN KEY(song_cid) REFERENCES Song(cid) ON DELETE CASCADE
    );
    
--
-- Table structure for Table Contain
-- 
 CREATE TABLE Contain(
	pid VARCHAR(40),
    cid VARCHAR(40),
    PRIMARY KEY (pid,cid),
    FOREIGN KEY(pid) REFERENCES Playlist(pid) ON DELETE CASCADE,
    FOREIGN KEY(cid) REFERENCES Contenet(cid) ON DELETE CASCADE
    );






	