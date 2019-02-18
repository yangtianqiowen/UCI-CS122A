DROP DATABASE IF EXISTS cs122a;
CREATE DATABASE cs122a;
USE cs122a;

CREATE TABLE People(
   id	VARCHAR(20),
   first_name	VARCHAR(20),
   last_name	VARCHAR(20),
   PRIMARY KEY (id)
  );

CREATE TABLE User(
    id	VARCHAR(20),
    email	VARCHAR(30),
    zipcode	VARCHAR(11),
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES People (id) ON DELETE CASCADE 
  );  
  CREATE TABLE Interests(
    id	VARCHAR(20),
    interest ENUM( 'rock', 'pop', 'r&b', 'classical', 'country', 'jazz', 'heavy', 'metal', 'other'),
    PRIMARY KEY (id, interest),
    FOREIGN KEY (id) REFERENCES User (id) ON DELETE CASCADE 
  ); 

  CREATE TABLE Artist(
    id	VARCHAR(20),
    bio	VARCHAR(100),
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES People (id) ON DELETE CASCADE 
  );  
  
  CREATE TABLE Free(
    id	VARCHAR(20),
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES User (id) ON DELETE CASCADE 
  );  
  
CREATE TABLE Premium(
    id	VARCHAR(20),
    security_code VARCHAR(3) NOT NULL,
    type	ENUM('Visa', 'Master','Amex','Discover') NOT NULL,
    number VARCHAR(16) NOT NULL,
    exp_date DATE NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES User (id) ON DELETE CASCADE 
  );  

  CREATE TABLE Ads(
   company_name	VARCHAR(20),
   id	VARCHAR(20),
   PRIMARY KEY (company_name,id)
  );

CREATE TABLE Images(
   company_name	VARCHAR(20),
   id	VARCHAR(20),
   images VARCHAR(20),	
#   images  blob,	  # other reasonable data types acceptable
   PRIMARY KEY (company_name,id, images),
   FOREIGN Key (company_name,id) REFERENCES Ads(company_name,id) ON DELETE CASCADE
);
  
  CREATE TABLE Content(
   cid	VARCHAR(20),
   length	float,
   title	VARCHAR(20),
   PRIMARY KEY (cid)
  );
  
  CREATE TABLE Song(
   cid	VARCHAR(20),
   genre	ENUM('rock', 'pop', 'r&b', 'classical', 'country','jazz', 'heavy', 'metal', 'other'),
   PRIMARY KEY (cid),
   FOREIGN KEY (cid) REFERENCES Content (cid) ON DELETE CASCADE 
  );
  
  CREATE TABLE Video(
   cid	VARCHAR(20),
   rating	ENUM('G','PG13','PG','R','E'),
   PRIMARY KEY (cid),
   FOREIGN KEY (cid) REFERENCES Content (cid) ON DELETE CASCADE 
  );
    
 CREATE TABLE Playlist(
   id	VARCHAR(20),
   pid VARCHAR(20),
   duration float,
   type ENUM('public','private') NOT NULL,
   PRIMARY KEY (id,pid),
   FOREIGN KEY (id) REFERENCES User(id) ON DELETE CASCADE 
  );
 
 CREATE TABLE React(
   id	VARCHAR(20),
   cid	VARCHAR(20),
   type ENUM('like', 'dislike') NOT NULL,
   PRIMARY KEY (id,cid),
   FOREIGN KEY (id) REFERENCES User (id) ON DELETE CASCADE,
   FOREIGN KEY (cid) REFERENCES Content (cid) ON DELETE CASCADE 
 );
  
 CREATE TABLE Produce(
   id	VARCHAR(20),
   cid	VARCHAR(20),
   PRIMARY KEY (id,cid),
   FOREIGN KEY (id) REFERENCES Artist (id) ON DELETE CASCADE,
   FOREIGN KEY (cid) REFERENCES Content (cid) ON DELETE CASCADE 
  );
  
CREATE TABLE Skip(
   id	VARCHAR(20),
   cid	VARCHAR(20),
   PRIMARY KEY (id,cid),
   FOREIGN KEY (id) REFERENCES Premium(id) ON DELETE CASCADE,
   FOREIGN KEY (cid) REFERENCES Song (cid) ON DELETE CASCADE 
  );
  
CREATE TABLE Contain(
   id	VARCHAR(20),
   pid VARCHAR(20),
   cid	VARCHAR(20),
   PRIMARY KEY (pid,id,cid),
   FOREIGN KEY (id,pid) REFERENCES Playlist(id,pid) ON DELETE CASCADE,
   FOREIGN KEY (cid) REFERENCES Content (cid) ON DELETE CASCADE 
  );
  
 CREATE TABLE Follow(
   follower_id	VARCHAR(20),
   followee_id	VARCHAR(20),
   since DATE,
   PRIMARY KEY (follower_id, followee_id),
   FOREIGN KEY (follower_id) REFERENCES User(id) ON DELETE CASCADE,
   FOREIGN KEY (followee_id) REFERENCES User(id) ON DELETE CASCADE
  );

CREATE TABLE Watch(
   uid  VARCHAR(20),
   company_name	VARCHAR(20),
   aid	VARCHAR(20),
   PRIMARY KEY(uid,company_name,aid),
   FOREIGN KEY (uid) References Free(id) ON DELETE CASCADE,
   FOREIGN KEY (company_name,aid) References Ads(company_name,id) ON DELETE CASCADE
);