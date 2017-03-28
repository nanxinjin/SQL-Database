ALTER SESSION SET NLS_DATE_FORMAT = 'HH24:MI:SS';
drop table Interviewers;
drop table Bonus;
drop table Refer;
drop table Apply;
drop table Interviews;
drop table Employees;
drop table Groups;
drop table Positions;
drop table Candidates;

create table Candidates(
	candidateID int CHECK (candidateID > 0),
	candidateName varchar2(30) NOT NULL,
	primary key(candidateID)
	);

create table Positions(
	positionID int CHECK (positionID > 0),
	positionName varchar2(30) NOT NULL,
	primary key(positionID)
	);


create table Groups(
	groupID int CHECK (groupID > 0),
	groupName varchar2(30) NOT NULL,
	primary key(groupID)
);

create table Employees(
	employeeID int CHECK (employeeID > 0),
	employeeName varchar2(30) NOT NULL,
	primary key(employeeID)
	);

create table Interviews(
	interviewID int CHECK (interviewID > 0),
	/*candidateID int NOT NULL,
	positionID int NOT NULL,
	primary key(interviewID,candidateID,positionID),
	foreign key(candidateID) references Candidates(candidateID),
	foreign key(positionID) references Positions(positionID)
	*/
	primary key(interviewID)
	);

create table Apply(
	applyID int CHECK (applyID > 0),
	candidateID int NOT NULL,
	interviewID int NOT NULL,
	positionID int NOT NULL,
	pass char(1) default 'N',
	accept char(1) default 'N',
	primary key(applyID,candidateID,interviewID,positionID),
	foreign key(candidateID) references Candidates(candidateID),
	foreign key(positionID) references Positions(positionID)
	);


create table Refer(
	employeeID int CHECK (employeeID > 0),
	candidateID int NOT NULL,
	positionID int NOT NULL,
	primary key(employeeID,candidateID,positionID),
	foreign key(candidateID) references Candidates(candidateID),
	foreign key(positionID) references Positions(positionID),
	foreign key(employeeID) references Employees(employeeID)
	);
	


create table Bonus(
	employeeID int CHECK (employeeID > 0),
	candidateID int NOT NULL,
	amount int NOT NULL,
	primary key(employeeID,candidateID),
	foreign key(candidateID) references Candidates(candidateID),
	foreign key(employeeID) references Employees(employeeID)
	);

create table Interviewers(
	employeeID int CHECK (employeeID > 0),
	interviewID int NOT NULL,
	candidateID int NOT NULL,
	feedback varchar2(30) NOT NULL,
	primary key(candidateID,employeeID,interviewID),
	foreign key(candidateID) references Candidates(candidateID),
	foreign key(employeeID) references Employees(employeeID),
	foreign key(interviewID) references Interviews(interviewID)
	);


