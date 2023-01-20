-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-01-19 21:55:55.634

-- tables
-- Table: Asset
CREATE TABLE Asset (
    Id integer NOT NULL CONSTRAINT Asset_pk PRIMARY KEY,
    AssetType_Id integer NOT NULL,
    Description varchar(250) NOT NULL,
    CONSTRAINT Asset_AssetType FOREIGN KEY (AssetType_Id)
    REFERENCES AssetType (Id)
);

-- Table: AssetType
CREATE TABLE AssetType (
    Id integer NOT NULL CONSTRAINT AssetType_pk PRIMARY KEY,
    Name varchar(50) NOT NULL
);

-- Table: AssetsPerLibrary
CREATE TABLE AssetsPerLibrary (
    Library_Id integer NOT NULL,
    Asset_Id integer NOT NULL,
    CONSTRAINT AssetsPerLibrary_pk PRIMARY KEY (Library_Id,Asset_Id),
    CONSTRAINT AssetsPerLibrary_Library FOREIGN KEY (Library_Id)
    REFERENCES Library (Id),
    CONSTRAINT AssetsPerLibrary_Asset FOREIGN KEY (Asset_Id)
    REFERENCES Asset (Id)
);

-- Table: AssetsinProject
CREATE TABLE AssetsinProject (
    Project_Id integer NOT NULL,
    Asset_Id integer NOT NULL,
    CONSTRAINT AssetsinProject_pk PRIMARY KEY (Project_Id,Asset_Id),
    CONSTRAINT AssetsinProject_Project FOREIGN KEY (Project_Id)
    REFERENCES Project (Id),
    CONSTRAINT AssetsinProject_Asset FOREIGN KEY (Asset_Id)
    REFERENCES Asset (Id)
);

-- Table: Library
CREATE TABLE Library (
    Id integer NOT NULL CONSTRAINT Library_pk PRIMARY KEY,
    Name varchar(50) NOT NULL
);

-- Table: Project
CREATE TABLE Project (
    Id integer NOT NULL CONSTRAINT Project_pk PRIMARY KEY,
    Name varchar(50) NOT NULL
);

-- Table: Skill
CREATE TABLE Skill (
    Id integer NOT NULL CONSTRAINT Skill_pk PRIMARY KEY,
    Name varchar(50) NOT NULL
);

-- Table: SkillsPerMember
CREATE TABLE SkillsPerMember (
    Skill_Id integer NOT NULL,
    TeamMember_Id integer NOT NULL,
    CONSTRAINT SkillsPerMember_pk PRIMARY KEY (Skill_Id,TeamMember_Id),
    CONSTRAINT SkillsPerMember_Skill FOREIGN KEY (Skill_Id)
    REFERENCES Skill (Id),
    CONSTRAINT SkillsPerMember_TeamMember FOREIGN KEY (TeamMember_Id)
    REFERENCES TeamMember (Id)
);

-- Table: Team
CREATE TABLE Team (
    Id integer NOT NULL CONSTRAINT Team_pk PRIMARY KEY,
    Name varchar(50) NOT NULL
);

-- Table: TeamMember
CREATE TABLE TeamMember (
    Id integer NOT NULL CONSTRAINT TeamMember_pk PRIMARY KEY,
    Team_Id integer NOT NULL,
    FirstName varchar(50) NOT NULL,
    LastName varchar(50) NOT NULL,
    MiddleName varchar(50) NOT NULL,
    CONSTRAINT TeamMember_Team FOREIGN KEY (Team_Id)
    REFERENCES Team (Id)
);

-- Table: TeamPerProject
CREATE TABLE TeamPerProject (
    Project_Id integer NOT NULL,
    Team_Id integer NOT NULL,
    CONSTRAINT TeamPerProject_pk PRIMARY KEY (Team_Id,Project_Id),
    CONSTRAINT TeamPerProject_Project FOREIGN KEY (Project_Id)
    REFERENCES Project (Id),
    CONSTRAINT TeamPerProject_Team FOREIGN KEY (Team_Id)
    REFERENCES Team (Id)
);

-- Table: WorkItem
CREATE TABLE WorkItem (
    Id integer NOT NULL CONSTRAINT WorkItem_pk PRIMARY KEY,
    Project_Id integer NOT NULL,
    Asset_Id integer NOT NULL,
    TeamMember_Id integer NOT NULL,
    Description varchar(250) NOT NULL,
    CONSTRAINT WorkItem_Project FOREIGN KEY (Project_Id)
    REFERENCES Project (Id),
    CONSTRAINT WorkItem_Asset FOREIGN KEY (Asset_Id)
    REFERENCES Asset (Id),
    CONSTRAINT WorkItem_TeamMember FOREIGN KEY (TeamMember_Id)
    REFERENCES TeamMember (Id)
);

-- views
-- View: TeamMembers
CREATE VIEW TeamMembers AS
SELECT
    Team.Name,
    TeamMember.FirstName,
    TeamMember.LastName
FROM
 Team
INNER JOIN TeamMember ON 
 Team.Id = TeamMember.Team_Id
ORDER BY
 Team.Name,
    TeamMember.LastName;

-- View: AssetPerProject
CREATE VIEW AssetPerProject AS
SELECT
 Project.Name AS Project_Name,
    Asset.Description,
    AssetType.Name
FROM
 Asset
INNER JOIN AssetType ON Asset.AssetType_Id = AssetType.Id
INNER JOIN AssetInProject ON Asset.Id = AssetsInProject.Asset_Id
INNER JOIN Project ON AssetsInProject.Id = Project.Id
ORDER BY
 Project.Name,
    Asset.Description;

-- View: AssetsInLibrary
CREATE VIEW AssetsInLibrary AS
SELECT
 Library.Name AS LibraryName,
    Asset.Description,
    AssetType.Name
FROM
 Asset
INNER JOIN AssetType ON Asset.AssetType_Id = AssetType.Id
INNER JOIN AssetsPerLibrary ON Asset.Id = AssetsPerLibrary.Asset_Id
INNER JOIN Library ON AssetsPerLibrary.Library_Id = Library.Id;

-- End of file.

