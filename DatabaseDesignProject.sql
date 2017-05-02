-- Database Design for the Marist Athletic Department --
-- Brought to you by: Mark Rajovic --



DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS Coaches;
DROP TABLE IF EXISTS Hometown;
DROP TABLE IF EXISTS Trainers;
DROP TABLE IF EXISTS Team;
DROP TABLE IF EXISTS Competition;
DROP TABLE IF EXISTS MedicalHistory;
DROP TABLE IF EXISTS Injuries;



Drop Role if exists administrator;
create role administrator;
grant all on all tables in schema public to administrator;

Drop Role if exists trainer;
create role trainer;
revoke all on all tables in schema public to trainer;
grant select on all tables in schema public to trainer;
grant update on MedicalHistory, Injuries to trainer;
grant insert on MedicalHistory, Injuries to trainer;
grant delete on MedicalHistory, Injuries to trainer;

Drop Role if exists coach;
create role coach;
revoke all on all tables in schema public from coach;
grant select on all tables in schema public to coach;
grant insert on Players, Team, Competition to coach;
grant update on Players, Team, Competition to coach;
grant delete on Players to coach;

Drop Role if exists player;
create role player;
revoke all on all tables in schema public from player;
grant select on Team, Competition to player;

-- CREATE ALL TABLES --

-- People --
CREATE TABLE People (
  Pid      char(4) not null,
  firstName     text not null,
  lastName     text  not null,
  ZipCode       char(5)  not null references Hometown(ZipCode),
 primary key(Pid)
 );
 

-- Hometown --
CREATE TABLE Hometown (
  ZipCode      char(5) not null,
  City     text not null,
  State     text  not null,
 primary key(ZipCode)
);


-- Players --
CREATE TABLE Players (
  PLid           char(4) not null references People(Pid),
  DoB            date not null,
  ParentInfo       char(15),
  Gender          text,
  Sport         text not null,
  Position    text not null, 
  Tid      char(4) not null references Team(Tid),
  CONSTRAINT check_gender CHECK (gender = 'M' OR gender = 'F'), 
 primary key(PLid)
);        



-- Coaches --
CREATE TABLE Coaches (
  Cid           char(4) not null references People(Pid),
  ExpInYears       int not null,
  Role         text not null,
  Tid      char(4) not null references Team(Tid),
 primary key(Cid)
);     


-- Trainers --
CREATE TABLE Trainers (
  TRid           char(4) not null references People(Pid),
  DateHired       date not null,
  AlmaMater         text not null,
  Tid      char(4) not null references Team(Tid),
 primary key(TRid)
);


-- Team --
CREATE TABLE Team (
  Tid      char(4) not null,
  TeamName     text not null,
 primary key(Tid)
);


-- Injuries --
CREATE TABLE  Injuries(
  PatientID           char(4) not null,
  InjuryType         text,
  InjuryDate         date,
 primary key(PatientID)
); 

select *
from injuries


-- MedicalHistory --
CREATE TABLE MedicalHistory(
    PLid     char(4) not null references Players(PLid),
    PatientID   char(4) not null references Injuries(PatientID),
  primary key (PatientID, PLid)
);


-- Competition --
CREATE TABLE Competition(
    GameID  char(4) not null references Team(Tid),
    Season  text not null,
    Conference  text not null,
  primary key (GameID)
);



DROP TABLE IF EXISTS People CASCADE;
DROP TABLE IF EXISTS Players CASCADE;
DROP TABLE IF EXISTS Coaches CASCADE;
DROP TABLE IF EXISTS Hometown CASCADE;
DROP TABLE IF EXISTS Trainers CASCADE;
DROP TABLE IF EXISTS Team CASCADE;
DROP TABLE IF EXISTS Competition CASCADE;
DROP TABLE IF EXISTS MedicalHistory CASCADE;
DROP TABLE IF EXISTS Injuries CASCADE;




-- INSERTS INTO TABLES --

INSERT INTO Hometown (ZipCode, City, State)
values
	('10536', 'Katonah', 'NY'),
	('11798', 'Mobile', 'AL'),
	('06830', 'Greenwich', 'CT'),
	('12601', 'Poughkeepsie', 'NY'),
	('11456', 'Pittsburgh', 'PA'),
	('45632', 'Chicago', 'IL'),
	('10560', 'Croton', 'NY'),
    ('90098', 'Los Angeles', 'CA');

     
INSERT INTO People (Pid, firstName, lastName, ZipCode)
 values
    ('1', 'Mark', 'Rajovic', '10536'),
    ('2', 'Blaise', 'Spinelli', '11798'),
    ('3', 'Zack', 'Reed', '10536'),
    ('4', 'Drew', 'Sullivan', '06830'),
    ('5', 'Mike', 'White', '12601'),
    ('6', 'Christina', 'Lampasi', '11456'),
    ('7', 'Mackenzie', 'Obrien', '45632'),
    ('8', 'Beau', 'Hornberger', '11456'),
    ('9', 'Steven', 'Rizzo', '12601'),
    ('10', 'Amanda', 'Greco', '12601'),
    ('11', 'Matt', 'Viggiano', '12601'),
    ('12', 'Brandon', 'Curtis', '45632'),
    ('13', 'Hope', 'Quinonez', '10536'),
    ('14', 'James', 'Parady', '12601'),
    ('15', 'Keith', 'Detelj', '45632'),
    ('16', 'Krystian', 'Witkowski', '11456'),
    ('17', 'Gene', 'Smith', '06830'),
    ('18', 'Mary', 'DiChiara', '10560'),
    ('19', 'Christian', 'Keenan', '12601'),
    ('20', 'Devon', 'Cummings', '11456'),
    ('21', 'Sarah', 'Cannon', '45632'),
    ('22', 'Justin', 'Giuliano', '12601'),
    ('23', 'Ryan', 'Spaulding', '06830'),
    ('24', 'Libby', 'Adams', '90098'),
    ('25', 'Brianna', 'Galleazzi', '12601'),
    ('26', 'Jake', 'Connors', '12601'),
    ('27', 'Laura', 'Brugnatelli', '90098'),
    ('28', 'Harry', 'Heffernan', '10560'),
    ('29', 'Lisa', 'Smith', '90098'),
    ('30', 'Meredith', 'Wertz', '45632'),
    ('31', 'Shannon', 'Gordon', '10536'),
    ('32', 'Georgia', 'Goldman', '11456'),
    ('33', 'Dierdre', 'Newton', '12601'),
    ('34', 'Jack', 'Ryan', '11456'),
    ('35', 'Mitch', 'Standera', '11456'),
    ('36', 'Dave', 'Meyer', '10560'),
    ('37', 'Kyle', 'Quinn', '45632'),
    ('38', 'Jack', 'Monnes', '90098'),
    ('39', 'Cam', 'Harr', '10536'),
    ('40', 'Taylor', 'Swift', '10560'),
    ('41', 'Lauren', 'Amundson', '12601'),
    ('42', 'Mark', 'Jackson', '11456'),
    ('43', 'Alex', 'Rajovic', '10536'),
    ('44', 'Daniel', 'Chung', '10560'),
    ('45', 'Peter', 'Yeung', '90098'),
    ('46', 'Brock', 'Lesnar', '45632'),
    ('47', 'John', 'Cena', '11798'),
    ('48', 'Nicole', 'Ficano', '11798'),
    ('49', 'Todd', 'Gurley', '11456'),
    ('50', 'Jared', 'Goff', '06830');
    
insert into people
values ('0', 'Alan', 'Labouseur', '12601');


 INSERT INTO Injuries (PatientID, InjuryType, InjuryDate)
 	values
    ('1','Back', '11/11/2015'),
    ('2','Left Knee', '10/23/2016'),
    ('3','Right Ankle', '09/01/2016'),
    ('4','Hip', '06/04/2016'),
    ('5','Torn ACL', '08/08/2015'),
    ('6','Broken Toe', '01/01/2017'),
    ('7','Separated Shoulder', '02/11/2016'),
    ('8','Concussion', '07/04/2016'),
    ('9','Concussion', '11/30/2016'),
    ('10','Hip', '03/25/2016');
    
 INSERT INTO MedicalHistory (PLid, PatientID)
 	values
    ('2','1'),
    ('7','2'),
    ('12','3'),
    ('18','4'),
    ('21','5'),
    ('28','6'),
    ('36','7'),
    ('38','8'),
    ('47','9'),
    ('50','10');

INSERT INTO Players (PLid, DoB, ParentInfo, Gender, Sport, Position, Tid)
    values
    ('1','11/10/1995','9147032779','M','Soccer', 'Goalie','1'),
    ('2','12/04/1997','9147032743','M','Football', 'Safety','2'),
    ('3','04/06/1995','9144532779','M','Soccer', 'Defense','1'),
    ('4','11/10/1996','2047032779','M','Soccer', 'Midfield','1'),
    ('5','09/13/1998','9147032479','M','Football', 'Quarterback','2'),
    ('6','11/15/1994','9147032774','F','Soccer', 'Defense','4'),
    ('7','08/10/1996','9147032771','F','Swim', 'Backstroke','5'),
    ('8','05/05/1995','9147032321','M','Soccer', 'Defense','1'),
    ('9','02/02/1996','9147032889','M','Lacrosse', 'Attack','3'),
    ('12','05/23/1996','9198543079','M','Soccer', 'Forward','1'),
    ('13','12/31/1997','1029302779','F','Soccer', 'Forward','4'),
    ('18','04/09/1997','9142752590','F','Swim', 'Butterfly','5'),
    ('19','11/10/1995','4548989434','M','Football', 'Wide Receiver','2'),
    ('20','03/19/1998','9147052779','F','Soccer', 'Defense','4'),
    ('21','03/03/1995','9347032779','F','Soccer', 'Defense','4'),
    ('23','03/09/1995','9198032779','M','Football', 'Kicker','2'),
    ('24','06/05/1995','9847032779','F','Soccer', 'Goalie','4'),
    ('28','09/30/1996','0347032779','M','Lacrosse', 'Goalie','3'),
    ('29','12/20/1996','9147035439','F','Swim', 'Free','5'),
    ('30','07/22/1995','5347032779','F','Swim', 'Butterfly','5'),
    ('31','07/11/1998','9137032779','F','Swim', 'Backstroke','5'),
    ('32','07/23/1995','2547032779','F','Swim', 'Free','5'),
    ('33','08/14/1998','9147030079','F','Swim', 'Free','5'),
    ('34','04/12/1997','9147032769','M','Lacrosse', 'Attack','3'),
    ('35','12/08/1995','9147032779','M','Lacrosse', 'Defense','3'),
    ('36','02/04/1997','9147042779','M','Lacrosse', 'Goalie','3'),
    ('38','08/09/1998','9134032779','M','Soccer', 'Defense','1'),
    ('39','06/10/1998','9127032779','M','Soccer', 'Forward','1'),
    ('40','11/13/1999','0047032779','F','Swim', 'Free','4'),
    ('41','12/01/1996','8047032779','F','Swim', 'Backstroke','4'),
    ('42','03/10/1996','9147372779','M','Football', 'Corner Back','2'),
    ('43','11/09/1994','9146532779','M','Football', 'Running Back','2'),
    ('45','11/10/1998','9147035579','M','Lacrosse', 'Midfield','3'),
    ('46','09/09/1996','1290834779','M','Football', 'Offensive Line','2'),
    ('47','12/30/1995','9156782779','M','Football', 'Linebacker','2'),
    ('50','05/10/1995','9147039809','M','Football', 'Quarterback','2');
 
 delete from players where plid = '40'
      
INSERT INTO Team (Tid, TeamName)
	values
    ('1','MensSoccer'),
    ('2','Football'),
    ('3','MensLacrosse'),
    ('4','WomensSoccer'),
    ('5','WomensSwim');

INSERT INTO Competition (GameID, Season, Conference)
    values
    ('1', 'Fall', 'MAAC'),
    ('2', 'Fall', 'PFL'),
    ('3', 'Spring', 'MAAC'),
    ('4', 'Fall', 'MAAC'),
    ('5', 'Winter', 'MAAC');
    
INSERT INTO Coaches (Cid, ExpInYears, Role, Tid)
    values
    ('11', '10', 'Head Coach', '1'),
    ('14', '27', 'Head Coach', '2'),
    ('15', '2', 'Assistant', '1'),
    ('16', '4', 'Director of Operations', '1'),
    ('17', '1', 'Head Coach', '4'),
    ('26', '10', 'Head Coach', '3'),
    ('27', '3', 'Head Coach', '5'),
    ('37', '5', 'Assistant', '3'),
    ('40', '1', 'Director of Operations', '2'),
    ('49', '2', 'Offensive Coordinator', '2');

INSERT INTO Trainers (TRid, DateHired, AlmaMater, Tid)
    values
    ('10', '06/06/2009', 'Sacred Heart University', '1'),
    ('22', '11/05/2011', 'UMass-Amherst', '2'),
    ('25', '05/30/2012', 'Rhode Island', '3'),
    ('44', '05/05/1996', 'Union College', '4'),
    ('48', '07/23/2013', 'Syracuse University', '5');


-- VIEWS --


-- Views- LAX ROSTER --
CREATE VIEW MensLaxRoster as
select people.firstName, people.lastName, players.position
from people
inner join players on players.plid = people.pid
inner join team on team.tid = players.tid
where team.tid ='3'
;

 
select * 
from MensLaxRoster
order by position ASC


-- View -FOOTBALL COACHES --
CREATE VIEW FootballCoaches as
select people.firstName, 
       people.lastName, 
       coaches.ExpInYears, 
       coaches.role
from people
inner join coaches on coaches.cid = people.pid
inner join team on team.tid = coaches.tid
where team.tid ='2'
;

select *
from FootballCoaches
order by ExpInYears DESC

-- REPORTS --

-- Reports Male MAAC athletes --
select people.firstName,
       people.lastName,
       players.sport
from people
inner join players on players.plid = people.pid
inner join team on team.tid = players.tid
inner join competition on competition.gameid = team.tid 
where competition.conference = 'MAAC' AND
players.gender ='M'
order by players.sport
;

-- Reports Number of Coaches on Each Team Counted --
select team.teamname, 
       count (coaches.cid) as NumCoaches
from coaches
inner join Team on team.tid = coaches.tid
group by team.TeamName
order by count (coaches.cid) DESC;

-- Reports Athletes injured after june 1 2016 --
select people.firstName, 
       people.lastName, 
       injuries.InjuryType, 
       injuries.InjuryDate
from people
inner join players on players.plid = people.pid
inner join medicalhistory on medicalhistory.plid = players.plid
full outer join injuries on injuries.PatientID = medicalhistory.PatientID
where injurydate >= '06/01/2016'

-- STORED PROCEDURES --

-- Stored Procedure age of an athlete --
CREATE	OR	REPLACE	FUNCTION AthleteAge (Playerid char (4))
RETURNS	INTERVAL as	
$$
 DECLARE
  birthday date :=	(select players.DoB	
					 from players
                     where players.PLid=Playerid
                    );
BEGIN
	RETURN	age (birthday);
END;
$$
LANGUAGE	plpgsql;

select AthleteAge ('1')

-- Stored Procedure New Team Fielded --
CREATE	OR	REPLACE	FUNCTION NewTeam ()
RETURNS	TRIGGER as	
$$
	
BEGIN
    INSERT INTO Competition (GameID, Season, Conference)
    values
    (NEW.tid, 'Fall', 'MAAC');
    RETURN NEW;
     
END;
$$
LANGUAGE plpgsql;

-- Trigger to update competition table --

drop TRIGGER compete
on team

CREATE TRIGGER Compete
AFTER INSERT ON Team
FOR EACH ROW
EXECUTE PROCEDURE NewTeam();

INSERT INTO Team (Tid, TeamName)
	values
    ('7','MensVolleyball');

update competition 
set season = 'Spring'
where GameID = '7'

select *
from competition

select * from people where Pid = '0'

