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

insert into patient values ('Diana','Wong', 'diana.wong@gmail.com','1990-03-13','2017-12-12','123456789');
insert into patient values ('Katy','Perry', 'katyperry@gmail.com','1991-03-13','2017-12-12','223456789');
insert into patient values ('Krista','Steward', 'krista@gmail.com','1980-03-13','2017-12-12','323456789');

/* Populate appointment table with mock data */

insert into appointment values ('Dr David Lee', '2018-03-03', '2018-10-10', 'A', 'B', '1234554321', '123456789');
insert into appointment values ('Dr Happy Lee', '2018-04-03', '2018-09-10', 'B', 'D', '1234554320', '223456789');
insert into appointment values ('Dr Happy Lee', '2018-05-03', '2018-11-10', 'A', 'D', '1234554329', '323456789');

/* View all appointment information from a patient using their ID*/

select * from patient where patientID = 'patientID'

/* Patient views next appointment using this command */

select nextAppointmentDate from appointment where patientID = 'patientID' 

/* Patient updates their next appointment date */

update appointment set nextAppointmentDate = 'date' where patientID = 'patientID'

/* Set next appointment as current appointment, and update next appointment 
with new appointment date */

update appointment 
set currentStage = 
(
select nextStage 
from (select * from appointment) as tempAppointment 
where patientID = 123456789
), 
nextStage = 'C' where patientID = '123456789';



