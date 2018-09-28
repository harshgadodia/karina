drop table if exists patient;
drop table if exists appointment;

/* Create new instance of a patient table */

create table patient(
	first_name VARCHAR(64) NOT NULL,
	last_name VARCHAR(64) NOT NULL,
	email VARCHAR(64) UNIQUE NOT NULL,
	dob DATE NOT NULL,
	since DATE NOT NULL,
	patientID VARCHAR(16) NOT NULL PRIMARY KEY
);

/* Create new instance of an appointment table */

create table appointment(
	drName VARCHAR(64) NOT NULL REFERENCES doctor(name),
	lastAppointmentDate DATE NOT NULL,
	nextAppointmentDate DATE NOT NULL,
	currentStage ENUM('A','B','C','D','E','F','G','H','I','J'),
	nextStage varchar(64) NOT NULL,
	appointmentID varchar(64) NOT NULL PRIMARY KEY,
	patientID varchar(64) references patient(patientID)
);

/* Populate patient table with mock data */

insert into patient values ('Diana','Wong', 'diana.wong@gmail.com','1990-03-13','2017-12-12','p001');
insert into patient values ('Katy','Perry', 'katyperry@gmail.com','1991-03-13','2017-12-12','p002');
insert into patient values ('Krista','Steward', 'krista@gmail.com','1980-03-13','2017-12-12','p003');

/* Populate appointment table with mock data */

insert into appointment values ('Dr David Lee', '2018-03-03', '2018-10-10', 'A', 'B', 'a001', 'p001');
insert into appointment values ('Dr Happy Lee', '2018-04-03', '2018-09-10', 'B', 'D', 'a002', 'p002');
insert into appointment values ('Dr Happy Lee', '2018-05-03', '2018-11-10', 'A', 'D', 'a003', 'p003');

/* View all appointment information from a patient using their ID*/

select * from patient where patientID = 'p123';

/* Patient views next appointment using this command */

select nextAppointmentDate from appointment where patientID = 'p123';

/* Patient updates their next appointment date */

update appointment set nextAppointmentDate = '2020-12-12' where patientID = 'p123';

/* Set next appointment as current appointment, and update next appointment 
with new appointment date */

update appointment 
set currentStage = 
(
select nextStage 
from (select * from appointment) as tempAppointment 
where patientID = 'p123'
), 
nextStage = 'C' where patientID = 'p123';




