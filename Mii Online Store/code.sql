create table Employees(
  EmpID int primary key,
  EmpName varchar(20),
  city varchar (20)
);

create table Departments(
  DepID int primary key,
  DepName varchar(20),
  Budget int
);

create table Assignments (
  AssignID int primary key,
  EmpID int,
  DepID int,
  Quater varchar(100) default 'Q1-25',
  hours int
  
);

insert into Employees (EmpID, EmpName, city)
values (1, 'h', 'abc'), (2, 'n', 'def'), (3, 'm', 'ghi'), (4, 'a', 'jkl');

alter table Employees
add email varchar(100);

alter table Departments
modify Budget int not null;

alter table Assignments
add constraint fk_assignments
foreign key (EmpID) references Employees(EmpID);


select * from Employees