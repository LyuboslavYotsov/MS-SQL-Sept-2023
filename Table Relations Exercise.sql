CREATE DATABASE [TableRelationsDB];
USE [TableRelationsDB];


--Task 01
CREATE TABLE [Passports](
[PassportID] INT PRIMARY KEY IDENTITY(101,1),
[PassportNumber] NVARCHAR(8));

INSERT INTO [Passports]([PassportNumber])
VALUES 
('N34FG21B'),
('K65LO4R7'),
('ZE657QP2');

CREATE TABLE [Persons](
[PersonID] INT PRIMARY KEY IDENTITY,
[FirstName] NVARCHAR(50) NOT NULL,
[Salary] DECIMAL(8,2) NOT NULL,
[PassportID] INT UNIQUE FOREIGN KEY REFERENCES [Passports]([PassportID]) NOT NULL);

INSERT INTO [Persons]([FirstName], [Salary], [PassportID])
VALUES
('Roberto', 43330.00, 102),
('Tom', 56100.00, 103),
('Yana', 60200.00, 101);


--Task 02
CREATE TABLE [Manufacturers](
[ManufacturerID] INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50) NOT NULL,
[EstablishedOn] DATE);

INSERT INTO [Manufacturers]([Name],[EstablishedOn])
VALUES
('BMW','07/03/1916'),
('Tesla','01/01/2003'),
('Lada','01/05/1966');

CREATE TABLE [Models](
[ModelID] INT PRIMARY KEY IDENTITY(101,1),
[Name] NVARCHAR(50) NOT NULL,
[ManufacturerID] INT FOREIGN KEY REFERENCES [Manufacturers]([ManufacturerID]) NOT NULL);

INSERT INTO [Models]([Name], [ManufacturerID])
VALUES
('X1', 1),
('i6', 1),
('Model S', 2),
('Model X', 2),
('Model 3', 2),
('Nova', 3);

SELECT * FROM [Models];

--Task 03
CREATE TABLE [Students](
[StudentID] INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50) NOT NULL);

INSERT INTO [Students]([Name])
VALUES
('Mila'),
('Toni'),
('Ron');

CREATE TABLE [Exams](
[ExamID] INT PRIMARY KEY IDENTITY(101,1),
[Name] NVARCHAR(50) NOT NULL);

INSERT INTO [Exams]([Name])
VALUES
('SpringMVC'),
('Neo4j'),
('Oracle 11g');

CREATE TABLE [StudentsExams](
[StudentID] INT NOT NULL,
[ExamID] INT NOT NULL,
PRIMARY KEY(StudentID,ExamID),
FOREIGN KEY ([StudentID]) REFERENCES [Students]([StudentID]),
FOREIGN KEY ([ExamID]) REFERENCES [Exams]([ExamID]));

INSERT INTO [StudentsExams]([StudentID], [ExamID])
VALUES
 (1,101)
,(1,102)
,(2,101)
,(3,103)
,(2,102)
,(2,103);


--Task 04
CREATE TABLE [Teachers](
[TeacherID] INT PRIMARY KEY IDENTITY(101,1),
[Name] NVARCHAR(50) NOT NULL,
[ManagerID] INT REFERENCES [Teachers]([TeacherID]));

INSERT INTO [Teachers]([Name],ManagerID)
VALUES
('John', NULL),
('Maya', 106),
('Silvia', 106),
('Ted', 105),
('Mark', 101),
('Greta', 101);


--Task 05
CREATE TABLE [Cities](
[CityID] INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50) NOT NULL);

CREATE TABLE [Customers](
[CustomerID] INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50) NOT NULL,
[Birthday] DATE,
[CityID] INT FOREIGN KEY REFERENCES [Cities]([CityID]) NOT NULL);

CREATE TABLE [Orders](
[OrderID] INT PRIMARY KEY IDENTITY,
[CustomerID] INT FOREIGN KEY REFERENCES [Customers]([CustomerID]));

CREATE TABLE [ItemTypes](
[ItemTypeID] INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50) NOT NULL);

CREATE TABLE [Items](
[ItemID] INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50) NOT NULL,
[ItemTypeID] INT FOREIGN KEY REFERENCES [ItemTypes]([ItemTypeID]) NOT NULL);

CREATE TABLE [OrderItems](
[OrderID] INT NOT NULL,
[ItemID] INT NOT NULL,
PRIMARY KEY ([OrderID], [ItemID]),
FOREIGN KEY ([OrderID]) REFERENCES [Orders]([OrderID]),
FOREIGN KEY ([ItemID]) REFERENCES [Items]([ItemID])
);

--Task 06
CREATE TABLE [Majors](
[MajorID] INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50) NOT NULL);

CREATE TABLE [Students](
[StudentID] INT PRIMARY KEY IDENTITY,
[StudentNumber] NVARCHAR(20) UNIQUE NOT NULL,
[StudentName] NVARCHAR(50) NOT NULL,
[MajorID] INT FOREIGN KEY REFERENCES [Majors]([MajorID]) NOT NULL);

CREATE TABLE [Payments](
[PaymentID] INT PRIMARY KEY IDENTITY,
[PaymentDate] DATE NOT NULL,
[PaymentAmount] DECIMAL (8,2) NOT NULL,
[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]));

CREATE TABLE [Subjects](
[SubjectID] INT PRIMARY KEY IDENTITY,
[SubjectName] NVARCHAR(50) NOT NULL);

CREATE TABLE [Agenda](
[StudentID] INT NOT NULL,
[SubjectID] INT NOT NULL,
PRIMARY KEY([StudentID], [SubjectID]),
FOREIGN KEY ([StudentID]) REFERENCES [Students]([StudentID]),
FOREIGN KEY ([SubjectID]) REFERENCES [Subjects]([SubjectID]));

--Task 07
--ER DIAGRAM

--Task 08
--ER DIAGRAM

--Task 09
USE Geography;
SELECT * FROM Peaks;
SELECT * FROM Mountains;

SELECT m.MountainRange, p.PeakName, p.Elevation FROM [Peaks] AS p
JOIN [Mountains] AS m ON p.[MountainId] = m.[Id]
WHERE m.MountainRange = 'Rila'
ORDER BY p.Elevation DESC;