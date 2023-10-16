CREATE DATABASE [Minions];


CREATE TABLE [Minions]
	([Id] INT PRIMARY KEY,
	[Name] VARCHAR(50),
	[Age] INT
	);

CREATE TABLE [Towns] (
[Id] INT PRIMARY KEY,
[Name] VARCHAR(50)
);


ALTER TABLE [Minions]
ALTER COLUMN [Name] VARCHAR(50) NOT NULL;


ALTER TABLE [Minions]
ADD [TownId] INT FOREIGN KEY REFERENCES [Towns] ([Id]);


INSERT INTO [Towns]([Id], [Name])
VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');


INSERT INTO [Minions]([Id], [Name], [Age], [TownId])
VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2);


TRUNCATE TABLE [Minions];


DROP TABLE [Minions]
DROP TABLE [Towns];


CREATE TABLE [People] (
[Id] INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(200) NOT NULL,
[Picture] VARBINARY(MAX),
CHECK (DATALENGTH([Picture]) <= 2000000),
[Height] DECIMAL (3,2),
[Weight] DECIMAL(5,2),
[Gender] CHAR(1) NOT NULL,
CHECK ([Gender] = 'f' OR [Gender] = 'm'),
[Birthdate] DATE NOT NULL,
[Biography] NTEXT
);

INSERT INTO [People]([Name], [Gender], [Birthdate])
VALUES
('Kevin2', 'm', '1997-05-18'),
('Kevin3', 'm', '1997-05-18'),
('Kevin4', 'm', '1997-05-18'),
('Kevin5', 'm', '1997-05-18'),
('Kevin6', 'm', '1997-05-18');

SELECT * FROM [People];


CREATE TABLE [Users](
	[Id] BIGINT PRIMARY KEY IDENTITY,
	[Username] VARCHAR(30) NOT NULL,
	CHECK (DATALENGTH([Username]) >= 3),
	[Password]  VARCHAR(26) NOT NULL,
	CHECK (DATALENGTH([Password]) >= 5),
	[ProfilePicture] VARBINARY(MAX),
	CHECK (DATALENGTH([ProfilePicture]) <= 900000),
	[LastLoginTime] DATETIME2 DEFAULT GETDATE(),
	[IsDeleted] BIT DEFAULT 0
);

INSERT INTO [Users]([Username], [Password])
VALUES
('Pesho1', 'password'),
('Pesho2', 'password'),
('Pesho3', 'password'),
('Pesho4', 'password'),
('Pesho5', 'password');

SELECT * FROM [Users];

TRUNCATE TABLE [Users];

DROP TABLE [Users];

ALTER TABLE [Users]
DROP CONSTRAINT PK__Users__3214EC071FA2C4B3;

ALTER TABLE [Users]
ADD CONSTRAINT [PK_UsernameAndId] PRIMARY KEY ([Id], [Username]);


ALTER TABLE [Users]
DROP CONSTRAINT [PK_UsernameAndId];

ALTER TABLE [Users]
ADD CONSTRAINT [PK_UsernameAndId] PRIMARY KEY ([Id]);

--TASK 13 Movies Database
CREATE DATABASE [Movies];
USE [Movies];

CREATE TABLE [Directors](
[Id] INT PRIMARY KEY IDENTITY,
[DirectorName] NVARCHAR(50) NOT NULL,
[Notes] NTEXT 
);

INSERT INTO [Directors]([DirectorName])
VALUES
('PeshoDirectora1'),
('PeshoDirectora2'),
('PeshoDirectora3'),
('PeshoDirectora4'),
('PeshoDirectora5');


CREATE TABLE [Genres](
[Id] INT PRIMARY KEY IDENTITY,
[GenreName] NVARCHAR(50) NOT NULL,
[Notes] NTEXT 
);

INSERT INTO [Genres]([GenreName])
VALUES
('CoolGenre1'),
('CoolGenre2'),
('CoolGenre3'),
('CoolGenre4'),
('CoolGenre5');


CREATE TABLE [Categories](
[Id] INT PRIMARY KEY IDENTITY,
[CategoryName] NVARCHAR(50) NOT NULL,
[Notes] NTEXT 
);

INSERT INTO [Categories]([CategoryName])
VALUES
('CategoryName1'),
('CategoryName2'),
('CategoryName3'),
('CategoryName4'),
('CategoryName5');


CREATE TABLE [Movies](
[Id] INT PRIMARY KEY IDENTITY,
[Title] NVARCHAR(50) NOT NULL,
[DirectorId] INT FOREIGN KEY REFERENCES [Directors]([Id]) NOT NULL,
[CopyrightYear] INT NOT NULL,
[Length] DECIMAL(3,2) NOT NULL,
[GenreId] INT FOREIGN KEY REFERENCES [Genres]([Id]) NOT NULL,
[CategoryId] INT FOREIGN KEY REFERENCES [Categories]([Id]) NOT NULL,
[Rating] DECIMAL(2,1) NOT NULL,
[Notes] TEXT
);

INSERT INTO [Movies]([Title], [DirectorId], [CopyrightYear], [Length], [GenreId], [CategoryId], [Rating])
VALUES
('CoolMovie1', 1, 1997, 2.33, 1, 1, 6.66),
('CoolMovie2', 2, 1997, 2.33, 2, 2, 6.66),
('CoolMovie3', 3, 1997, 2.33, 3, 3, 6.66),
('CoolMovie4', 4, 1997, 2.33, 4, 4, 6.66),
('CoolMovie5', 5, 1997, 2.33, 5, 5, 6.66);

SELECT * FROM [Directors];
SELECT * FROM [Genres];
SELECT * FROM [Categories];
SELECT * FROM [Movies];


--TASK-14 -CAR RENTAL DATABASE

CREATE DATABASE [CarRental];
USE [CarRental];

CREATE TABLE [Categories](
[Id] INT PRIMARY KEY IDENTITY,
[CategoryName] NVARCHAR(50) NOT NULL,
[DailyRate] DECIMAL(3,1) NOT NULL,
[WeeklyRate] DECIMAL(3,1) NOT NULL,
[MonthlyRate] DECIMAL(3,1) NOT NULL,
[WeekendRate] DECIMAL(3,1) NOT NULL
);

INSERT INTO [Categories]([CategoryName], [DailyRate], [WeeklyRate], [MonthlyRate], [WeekendRate])
VALUES
('CoolCategory1', 11.1, 11.1, 11.1, 11.1),
('CoolCategory2', 21.1, 21.1, 21.1, 21.1),
('CoolCategory3', 31.1, 31.1, 31.1, 31.1)
;

CREATE TABLE [Cars](
[Id] INT PRIMARY KEY IDENTITY,
[PlateNumber] VARCHAR(20) NOT NULL,
[Manufacturer] VARCHAR(50) NOT NULL,
[Model] VARCHAR(50) NOT NULL,
[CarYear] INT NOT NULL,
[CategoryId] INT FOREIGN KEY REFERENCES [Categories]([Id]) NOT NULL,
[Doors] INT NOT NULL,
[Picture] VARBINARY,
[Condition] VARCHAR(50) NOT NULL,
[Available] BIT NOT NULL
);

INSERT INTO [Cars]([PlateNumber], [Manufacturer], [Model], [CarYear], [CategoryId], [Doors], [Condition], [Available])
VALUES
('PA9994KK', 'VOLKSWAGEN', 'GOLF5', 2005, 1, 5, 'Pristine', 1),
('PA9995KK', 'VOLKSWAGEN', 'GOLF6', 2015, 1, 5, 'Crashed', 0),
('PA9996KK', 'VOLKSWAGEN', 'GOLF7', 2025, 1, 5, 'BrandNew', 1);

CREATE TABLE [Employees](
[Id] INT PRIMARY KEY IDENTITY,
[FirstName] NVARCHAR(50) NOT NULL,
[LastName] NVARCHAR(50) NOT NULL,
[Title] NVARCHAR(50) NOT NULL,
[Notes] NTEXT
);

INSERT INTO [Employees]([FirstName], [LastName], [Title])
VALUES
('Pesho', 'Pyrvi', 'BOSS'),
('Boro', 'Vtori', 'Cleaner'),
('Stamat', 'Treti', 'Skatavka');



CREATE TABLE [Customers](
[Id] INT PRIMARY KEY IDENTITY,
[DriverLicenceNumber] INT NOT NULL,
[FullName] NVARCHAR(80) NOT NULL,
[Adress] NVARCHAR(100),
[City] NVARCHAR(100) NOT NULL,
[ZIPCode] INT NOT NULL,
[Notes] NTEXT
);

INSERT INTO [Customers]([DriverLicenceNumber], [FullName], [City], [ZIPCode])
VALUES
(123321, 'Pesho Peshov', 'New York', 4433),
(555321, 'Gosho Gerov', 'Vraca', 4423),
(223321, 'Stan4o Nenoov', 'Pernik', 4413);


CREATE TABLE [RentalOrders](
[Id] INT PRIMARY KEY IDENTITY,
[EmployeeId] INT FOREIGN KEY REFERENCES [Employees]([Id]) NOT NULL,
[CustomerId] INT FOREIGN KEY REFERENCES [Customers]([Id]) NOT NULL,
[CarId] INT FOREIGN KEY REFERENCES [Cars]([Id]) NOT NULL,
[TankLevel] INT,
[KilometrageStart] INT,
[KilometrageEnd] INT,
[TotalKilometrage] INT,
[StartDate] DATE NOT NULL,
[EndDate] DATE NOT NULL,
[TotalDays] INT NOT NULL,
[RateApplied] NVARCHAR(50),
[TaxRate] DECIMAL(4,2),
[OrderStatus] BIT,
[Notes] NTEXT
);

INSERT INTO [RentalOrders]([EmployeeId], [CustomerId], [CarId],[StartDate], [EndDate], [TotalDays])
VALUES
(1, 1, 1, GETDATE(), GETDATE(), 1),
(2, 2, 2, GETDATE(), GETDATE(), 1),
(3, 3, 3, GETDATE(), GETDATE(), 1);


--Task-15 Hotel Database

CREATE DATABASE [Hotel];
USE [Hotel];

CREATE TABLE [Employees](
[Id] INT PRIMARY KEY IDENTITY,
[FirstName] NVARCHAR(50) NOT NULL,
[LastName] NVARCHAR(50) NOT NULL,
[Title] NVARCHAR(50) NOT NULL,
[Notes] NTEXT
);

INSERT INTO [Employees]([FirstName], [LastName], [Title])
VALUES
('Pesho', 'Peshov', 'Shefche'),
('Gosho', 'Goshov', 'Chistach'),
('Lenko', 'Petrov', 'Chef');



CREATE TABLE [Customers](
[AccountNumber] INT PRIMARY KEY IDENTITY,
[FirstName] NVARCHAR(50) NOT NULL,
[LastName] NVARCHAR(50) NOT NULL,
[PhoneNumber] INT,
[EmergencyName] NVARCHAR(50),
[EmergencyNumber] INT,
[Notes] NTEXT
);

INSERT INTO [Customers]([FirstName], [LastName])
VALUES
('Pesho', 'Customera'),
('Pesho2', 'Customera2'),
('Pesho3', 'Customera3');


CREATE TABLE [RoomStatus](
[RoomStatus] NVARCHAR(50) PRIMARY KEY NOT NULL,
[Notes] NTEXT);

INSERT INTO [RoomStatus]([RoomStatus])
VALUES
('Free'),
('Occupied'),
('Unavailable');



CREATE TABLE [RoomTypes](
[RoomType] NVARCHAR(50) PRIMARY KEY NOT NULL,
[Notes] NTEXT
);

INSERT INTO [RoomTypes]([RoomType])
VALUES
('Single Room'),
('Double Room'),
('Apartment');



CREATE TABLE [BedTypes](
[BedType] NVARCHAR(50) PRIMARY KEY NOT NULL,
[Notes] NTEXT
);

INSERT INTO [BedTypes]([BedType])
VALUES
('Single Bed'),
('Double Bed'),
('Extra Large Bed');



CREATE TABLE [Rooms](
[RoomNumber] INT IDENTITY PRIMARY KEY,
[RoomType] NVARCHAR(50) FOREIGN KEY REFERENCES [RoomTypes]([RoomType]) NOT NULL,
[BedType] NVARCHAR(50) FOREIGN KEY REFERENCES [BedTypes]([BedType]) NOT NULL,
[Rate] DECIMAL(3,2),
[RoomStatus] NVARCHAR(50) FOREIGN KEY REFERENCES [RoomStatus]([RoomStatus]) NOT NULL,
[Notes] NTEXT
);

INSERT INTO [Rooms]([RoomType], [BedType], [RoomStatus])
VALUES
('Single Room', 'Single Bed', 'Free'),
('Double Room', 'Double Bed', 'Free'),
('Apartment', 'Extra Large Bed', 'Free');



CREATE TABLE [Payments](
[Id] INT PRIMARY KEY IDENTITY,
[EmployeeId] INT FOREIGN KEY REFERENCES [Employees]([Id]) NOT NULL,
[PaymentDate] DATETIME2,
[AccountNumber] INT FOREIGN KEY REFERENCES [Customers]([AccountNumber]) NOT NULL,
[FirstDateOccupied] DATE NOT NULL,
[LastDateOccupied] DATE NOT NULL,
[TotalDays] INT NOT NULL,
[AmountCharged] DECIMAL(5,2) NOT NULL,
[TaxRate] DECIMAL(5,2) NOT NULL,
[TaxAmount] DECIMAL(5,2) NOT NULL,
[PaymentTotal] DECIMAL(5,2) NOT NULL,
[Notes] NTEXT
);

INSERT INTO [Payments]([EmployeeId], [AccountNumber], [FirstDateOccupied], [LastDateOccupied], [TotalDays], [AmountCharged],
[TaxRate], [TaxAmount], [PaymentTotal])
VALUES
(1, 1, GETDATE(), GETDATE(), 1, 12.50, 3.25, 5.12, 24.80),
(2, 2, GETDATE(), GETDATE(), 1, 12.50, 3.25, 5.12, 24.80),
(3, 3, GETDATE(), GETDATE(), 1, 12.50, 3.25, 5.12, 24.80)
;



CREATE TABLE [Occupancies](
[Id] INT PRIMARY KEY IDENTITY,
[EmployeeId] INT FOREIGN KEY REFERENCES [Employees]([Id]) NOT NULL,
[DateOccupied] DATE NOT NULL,
[AccountNumber] INT FOREIGN KEY REFERENCES [Customers]([AccountNumber]) NOT NULL,
[RoomNumber] INT FOREIGN KEY REFERENCES [Rooms]([RoomNumber]) NOT NULL,
[RateApplied] DECIMAL(5,2) NOT NULL,
[PhoneCharge] DECIMAL(5,2),
[Notes] NTEXT
);

INSERT INTO [Occupancies]([EmployeeId], [DateOccupied], [AccountNumber], [RoomNumber], [RateApplied])
VALUES
(1, GETDATE(), 1, 1, 12.50),
(2, GETDATE(), 2, 2, 12.50),
(3, GETDATE(), 3, 3, 12.50);



---TASK 16 Create SoftUni Database

CREATE DATABASE [SoftUni];
USE [SoftUni];

CREATE TABLE [Towns](
[Id] INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(80) NOT NULL);

CREATE TABLE [Addresses](
[Id] INT PRIMARY KEY IDENTITY,
[AddressText] NVARCHAR(100) NOT NULL,
[TownId] INT FOREIGN KEY REFERENCES [Towns]([Id]) NOT NULL);

CREATE TABLE [Departments](
[Id] INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50));

CREATE TABLE [Employees](
[Id] INT PRIMARY KEY IDENTITY,
[FirstName] NVARCHAR(50) NOT NULL,
[MiddleName] NVARCHAR(50),
[LastName] NVARCHAR(50) NOT NULL,
[JobTitle] NVARCHAR(50) NOT NULL,
[DepartmentId] INT FOREIGN KEY REFERENCES [Departments]([Id]) NOT NULL,
[HireDate] DATE NOT NULL,
[Salary] DECIMAL NOT NULL,
[AddressId] INT FOREIGN KEY REFERENCES [Addresses]([Id]));

--TASK 18 Basic Insert

INSERT INTO [Towns]([Name])
VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');

INSERT INTO [Departments]([Name])
VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');


INSERT INTO Employees([FirstName], [MiddleName], [LastName], [JobTitle], [DepartmentId], [HireDate], [Salary])
VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '02/01/2013', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '03/02/2004', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '08/28/2016', 525.25),
('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '12/09/2007', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '08/28/2016', 599.88);

TRUNCATE TABLE [Employees];


--TASK 19 Basic Select All Fields
SELECT * FROM [Towns];
SELECT * FROM [Departments];
SELECT * FROM [Employees];

--TASK 20 Basic Select and Order
SELECT * FROM [Towns]
ORDER BY [Name];
SELECT * FROM [Departments]
ORDER BY [Name];
SELECT * FROM [Employees]
ORDER BY [Salary] DESC;

--TASK 21 Basic Select Some Fields
SELECT [Name] FROM [Towns]
ORDER BY [Name];
SELECT [Name] FROM [Departments]
ORDER BY [Name];
SELECT [FirstName], [LastName], [JobTitle], [Salary] FROM [Employees]
ORDER BY [Salary] DESC;

--TASK 22 Increase Employees Salary
UPDATE [Employees]
SET [Salary] = [Salary] + [Salary] * 0.1;

SELECT [Salary] FROM [Employees];

--TASK 23 Decrease Tax Rate 

USE [Hotel];

UPDATE [Payments]
SET [TaxRate] -= [TaxRate] * 0.03;

SELECT [TaxRate] FROM [Payments];