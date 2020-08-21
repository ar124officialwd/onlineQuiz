
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 05/02/2020 03:13:12
-- Generated from EDMX file: D:\EAD\onlineQuiz-bsef17m35\onlineQuiz-bsef17m35\Model.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [onlineQuiz-bsef17m35];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Blacklist_Quiz]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Blacklist] DROP CONSTRAINT [FK_Blacklist_Quiz];
GO
IF OBJECT_ID(N'[dbo].[FK_Country_User1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EndUser] DROP CONSTRAINT [FK_Country_User1];
GO
IF OBJECT_ID(N'[dbo].[FK_EndUserTypeEndUser]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EndUser] DROP CONSTRAINT [FK_EndUserTypeEndUser];
GO
IF OBJECT_ID(N'[dbo].[FK_Gender_User1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EndUser] DROP CONSTRAINT [FK_Gender_User1];
GO
IF OBJECT_ID(N'[dbo].[FK_Question_QuestionType]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Question] DROP CONSTRAINT [FK_Question_QuestionType];
GO
IF OBJECT_ID(N'[dbo].[FK_Question_Quiz]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Question] DROP CONSTRAINT [FK_Question_Quiz];
GO
IF OBJECT_ID(N'[dbo].[FK_QuestionOption_Question]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[QuestionOption] DROP CONSTRAINT [FK_QuestionOption_Question];
GO
IF OBJECT_ID(N'[dbo].[FK_Quiz_Teacher1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Quiz] DROP CONSTRAINT [FK_Quiz_Teacher1];
GO
IF OBJECT_ID(N'[dbo].[FK_Quiz_Visibility1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Quiz] DROP CONSTRAINT [FK_Quiz_Visibility1];
GO
IF OBJECT_ID(N'[dbo].[FK_Result_ResultStatus]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Result] DROP CONSTRAINT [FK_Result_ResultStatus];
GO
IF OBJECT_ID(N'[dbo].[FK_Result_Submission]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Result] DROP CONSTRAINT [FK_Result_Submission];
GO
IF OBJECT_ID(N'[dbo].[FK_Student_User1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Student] DROP CONSTRAINT [FK_Student_User1];
GO
IF OBJECT_ID(N'[dbo].[FK_Submission_Quiz]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Submission] DROP CONSTRAINT [FK_Submission_Quiz];
GO
IF OBJECT_ID(N'[dbo].[FK_Teacher_User1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Teacher] DROP CONSTRAINT [FK_Teacher_User1];
GO
IF OBJECT_ID(N'[dbo].[FK_Whitelist_Quiz]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Whitelist] DROP CONSTRAINT [FK_Whitelist_Quiz];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Blacklist]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Blacklist];
GO
IF OBJECT_ID(N'[dbo].[Country]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Country];
GO
IF OBJECT_ID(N'[dbo].[EndUser]', 'U') IS NOT NULL
    DROP TABLE [dbo].[EndUser];
GO
IF OBJECT_ID(N'[dbo].[EndUserType]', 'U') IS NOT NULL
    DROP TABLE [dbo].[EndUserType];
GO
IF OBJECT_ID(N'[dbo].[Gender]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Gender];
GO
IF OBJECT_ID(N'[dbo].[Question]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Question];
GO
IF OBJECT_ID(N'[dbo].[QuestionOption]', 'U') IS NOT NULL
    DROP TABLE [dbo].[QuestionOption];
GO
IF OBJECT_ID(N'[dbo].[QuestionType]', 'U') IS NOT NULL
    DROP TABLE [dbo].[QuestionType];
GO
IF OBJECT_ID(N'[dbo].[Quiz]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Quiz];
GO
IF OBJECT_ID(N'[dbo].[Result]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Result];
GO
IF OBJECT_ID(N'[dbo].[ResultStatus]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ResultStatus];
GO
IF OBJECT_ID(N'[dbo].[Student]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Student];
GO
IF OBJECT_ID(N'[dbo].[Submission]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Submission];
GO
IF OBJECT_ID(N'[dbo].[sysdiagrams]', 'U') IS NOT NULL
    DROP TABLE [dbo].[sysdiagrams];
GO
IF OBJECT_ID(N'[dbo].[Teacher]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Teacher];
GO
IF OBJECT_ID(N'[dbo].[Visibility]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Visibility];
GO
IF OBJECT_ID(N'[dbo].[Whitelist]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Whitelist];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Blacklist'
CREATE TABLE [dbo].[Blacklist] (
    [quizId] int  NOT NULL,
    [teacherId] int  NOT NULL,
    [email] varchar(128)  NOT NULL
);
GO

-- Creating table 'Country'
CREATE TABLE [dbo].[Country] (
    [code] varchar(3)  NOT NULL,
    [name] varchar(128)  NOT NULL
);
GO

-- Creating table 'EndUser'
CREATE TABLE [dbo].[EndUser] (
    [id] int IDENTITY(1,1) NOT NULL,
    [email] varchar(128)  NOT NULL,
    [password] varchar(32)  NOT NULL,
    [firstName] varchar(64)  NOT NULL,
    [secondName] varchar(64)  NULL,
    [countryCode] varchar(3)  NOT NULL,
    [city] varchar(64)  NOT NULL,
    [type] varchar(32)  NOT NULL,
    [gender] varchar(16)  NOT NULL,
    [profilePicturePath] varchar(256)  NOT NULL,
    [active] bit DEFAULT 1 NOT NULL
);
GO

-- Creating table 'EndUserType'
CREATE TABLE [dbo].[EndUserType] (
    [type] varchar(32)  NOT NULL
);
GO

-- Creating table 'Gender'
CREATE TABLE [dbo].[Gender] (
    [name] varchar(16)  NOT NULL
);
GO

-- Creating table 'Question'
CREATE TABLE [dbo].[Question] (
    [title] varchar(128)  NOT NULL,
    [description] varchar(128)  NULL,
    [type] varchar(32)  NOT NULL,
    [quizId] int  NOT NULL,
    [teacherId] int  NOT NULL,
    [id] int IDENTITY(1,1) NOT NULL,
    [marks] int  NOT NULL
);
GO

-- Creating table 'QuestionOption'
CREATE TABLE [dbo].[QuestionOption] (
    [value] varchar(64)  NOT NULL,
    [valid] bit  NOT NULL,
    [questionId] int  NOT NULL,
    [quizId] int  NOT NULL,
    [teacherId] int  NOT NULL,
    [id] int IDENTITY(1,1) NOT NULL
);
GO

-- Creating table 'QuestionType'
CREATE TABLE [dbo].[QuestionType] (
    [type] varchar(32)  NOT NULL
);
GO

-- Creating table 'Quiz'
CREATE TABLE [dbo].[Quiz] (
    [id] int IDENTITY(1,1) NOT NULL,
    [teacherId] int  NOT NULL,
    [visibility] varchar(16)  NOT NULL,
    [title] varchar(64)  NOT NULL,
    [description] varchar(128)  NULL,
    [totalMarks] int  NOT NULL,
    [passingMarks] int  NOT NULL
);
GO

-- Creating table 'Result'
CREATE TABLE [dbo].[Result] (
    [quizId] int  NOT NULL,
    [teacherId] int  NOT NULL,
    [studentId] int  NOT NULL,
    [obtainedMarks] int  NOT NULL,
    [status] varchar(10)  NOT NULL,
    [questions] varchar(max)  NOT NULL
);
GO

-- Creating table 'ResultStatus'
CREATE TABLE [dbo].[ResultStatus] (
    [name] varchar(10)  NOT NULL
);
GO

-- Creating table 'Student'
CREATE TABLE [dbo].[Student] (
    [userId] int  NOT NULL
);
GO

-- Creating table 'Submission'
CREATE TABLE [dbo].[Submission] (
    [quizId] int  NOT NULL,
    [teacherId] int  NOT NULL,
    [studentId] int  NOT NULL,
    [content] varchar(max)  NOT NULL
);
GO

-- Creating table 'Teacher'
CREATE TABLE [dbo].[Teacher] (
    [userId] int  NOT NULL,
    [speciality] varchar(128)  NOT NULL
);
GO

-- Creating table 'Visibility'
CREATE TABLE [dbo].[Visibility] (
    [value] varchar(16)  NOT NULL
);
GO

-- Creating table 'Whitelist'
CREATE TABLE [dbo].[Whitelist] (
    [quizId] int  NOT NULL,
    [teacherId] int  NOT NULL,
    [email] varchar(128)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [quizId], [teacherId], [email] in table 'Blacklist'
ALTER TABLE [dbo].[Blacklist]
ADD CONSTRAINT [PK_Blacklist]
    PRIMARY KEY CLUSTERED ([quizId], [teacherId], [email] ASC);
GO

-- Creating primary key on [code] in table 'Country'
ALTER TABLE [dbo].[Country]
ADD CONSTRAINT [PK_Country]
    PRIMARY KEY CLUSTERED ([code] ASC);
GO

-- Creating primary key on [id] in table 'EndUser'
ALTER TABLE [dbo].[EndUser]
ADD CONSTRAINT [PK_EndUser]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [type] in table 'EndUserType'
ALTER TABLE [dbo].[EndUserType]
ADD CONSTRAINT [PK_EndUserType]
    PRIMARY KEY CLUSTERED ([type] ASC);
GO

-- Creating primary key on [name] in table 'Gender'
ALTER TABLE [dbo].[Gender]
ADD CONSTRAINT [PK_Gender]
    PRIMARY KEY CLUSTERED ([name] ASC);
GO

-- Creating primary key on [quizId], [teacherId], [id] in table 'Question'
ALTER TABLE [dbo].[Question]
ADD CONSTRAINT [PK_Question]
    PRIMARY KEY CLUSTERED ([quizId], [teacherId], [id] ASC);
GO

-- Creating primary key on [questionId], [quizId], [teacherId], [id] in table 'QuestionOption'
ALTER TABLE [dbo].[QuestionOption]
ADD CONSTRAINT [PK_QuestionOption]
    PRIMARY KEY CLUSTERED ([questionId], [quizId], [teacherId], [id] ASC);
GO

-- Creating primary key on [type] in table 'QuestionType'
ALTER TABLE [dbo].[QuestionType]
ADD CONSTRAINT [PK_QuestionType]
    PRIMARY KEY CLUSTERED ([type] ASC);
GO

-- Creating primary key on [id], [teacherId] in table 'Quiz'
ALTER TABLE [dbo].[Quiz]
ADD CONSTRAINT [PK_Quiz]
    PRIMARY KEY CLUSTERED ([id], [teacherId] ASC);
GO

-- Creating primary key on [quizId], [teacherId], [studentId] in table 'Result'
ALTER TABLE [dbo].[Result]
ADD CONSTRAINT [PK_Result]
    PRIMARY KEY CLUSTERED ([quizId], [teacherId], [studentId] ASC);
GO

-- Creating primary key on [name] in table 'ResultStatus'
ALTER TABLE [dbo].[ResultStatus]
ADD CONSTRAINT [PK_ResultStatus]
    PRIMARY KEY CLUSTERED ([name] ASC);
GO

-- Creating primary key on [userId] in table 'Student'
ALTER TABLE [dbo].[Student]
ADD CONSTRAINT [PK_Student]
    PRIMARY KEY CLUSTERED ([userId] ASC);
GO

-- Creating primary key on [quizId], [teacherId], [studentId] in table 'Submission'
ALTER TABLE [dbo].[Submission]
ADD CONSTRAINT [PK_Submission]
    PRIMARY KEY CLUSTERED ([quizId], [teacherId], [studentId] ASC);
GO

-- Creating primary key on [userId] in table 'Teacher'
ALTER TABLE [dbo].[Teacher]
ADD CONSTRAINT [PK_Teacher]
    PRIMARY KEY CLUSTERED ([userId] ASC);
GO

-- Creating primary key on [value] in table 'Visibility'
ALTER TABLE [dbo].[Visibility]
ADD CONSTRAINT [PK_Visibility]
    PRIMARY KEY CLUSTERED ([value] ASC);
GO

-- Creating primary key on [quizId], [teacherId], [email] in table 'Whitelist'
ALTER TABLE [dbo].[Whitelist]
ADD CONSTRAINT [PK_Whitelist]
    PRIMARY KEY CLUSTERED ([quizId], [teacherId], [email] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [quizId], [teacherId] in table 'Blacklist'
ALTER TABLE [dbo].[Blacklist]
ADD CONSTRAINT [FK_Blacklist_Quiz]
    FOREIGN KEY ([quizId], [teacherId])
    REFERENCES [dbo].[Quiz]
        ([id], [teacherId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [countryCode] in table 'EndUser'
ALTER TABLE [dbo].[EndUser]
ADD CONSTRAINT [FK_Country_User1]
    FOREIGN KEY ([countryCode])
    REFERENCES [dbo].[Country]
        ([code])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Country_User1'
CREATE INDEX [IX_FK_Country_User1]
ON [dbo].[EndUser]
    ([countryCode]);
GO

-- Creating foreign key on [type] in table 'EndUser'
ALTER TABLE [dbo].[EndUser]
ADD CONSTRAINT [FK_EndUserTypeEndUser]
    FOREIGN KEY ([type])
    REFERENCES [dbo].[EndUserType]
        ([type])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_EndUserTypeEndUser'
CREATE INDEX [IX_FK_EndUserTypeEndUser]
ON [dbo].[EndUser]
    ([type]);
GO

-- Creating foreign key on [gender] in table 'EndUser'
ALTER TABLE [dbo].[EndUser]
ADD CONSTRAINT [FK_Gender_User1]
    FOREIGN KEY ([gender])
    REFERENCES [dbo].[Gender]
        ([name])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Gender_User1'
CREATE INDEX [IX_FK_Gender_User1]
ON [dbo].[EndUser]
    ([gender]);
GO

-- Creating foreign key on [userId] in table 'Student'
ALTER TABLE [dbo].[Student]
ADD CONSTRAINT [FK_Student_User1]
    FOREIGN KEY ([userId])
    REFERENCES [dbo].[EndUser]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [userId] in table 'Teacher'
ALTER TABLE [dbo].[Teacher]
ADD CONSTRAINT [FK_Teacher_User1]
    FOREIGN KEY ([userId])
    REFERENCES [dbo].[EndUser]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [type] in table 'Question'
ALTER TABLE [dbo].[Question]
ADD CONSTRAINT [FK_Question_QuestionType]
    FOREIGN KEY ([type])
    REFERENCES [dbo].[QuestionType]
        ([type])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Question_QuestionType'
CREATE INDEX [IX_FK_Question_QuestionType]
ON [dbo].[Question]
    ([type]);
GO

-- Creating foreign key on [quizId], [teacherId] in table 'Question'
ALTER TABLE [dbo].[Question]
ADD CONSTRAINT [FK_Question_Quiz]
    FOREIGN KEY ([quizId], [teacherId])
    REFERENCES [dbo].[Quiz]
        ([id], [teacherId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [quizId], [teacherId], [questionId] in table 'QuestionOption'
ALTER TABLE [dbo].[QuestionOption]
ADD CONSTRAINT [FK_QuestionOption_Question]
    FOREIGN KEY ([quizId], [teacherId], [questionId])
    REFERENCES [dbo].[Question]
        ([quizId], [teacherId], [id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [teacherId] in table 'Quiz'
ALTER TABLE [dbo].[Quiz]
ADD CONSTRAINT [FK_Quiz_Teacher1]
    FOREIGN KEY ([teacherId])
    REFERENCES [dbo].[Teacher]
        ([userId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Quiz_Teacher1'
CREATE INDEX [IX_FK_Quiz_Teacher1]
ON [dbo].[Quiz]
    ([teacherId]);
GO

-- Creating foreign key on [visibility] in table 'Quiz'
ALTER TABLE [dbo].[Quiz]
ADD CONSTRAINT [FK_Quiz_Visibility1]
    FOREIGN KEY ([visibility])
    REFERENCES [dbo].[Visibility]
        ([value])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Quiz_Visibility1'
CREATE INDEX [IX_FK_Quiz_Visibility1]
ON [dbo].[Quiz]
    ([visibility]);
GO

-- Creating foreign key on [quizId], [teacherId] in table 'Submission'
ALTER TABLE [dbo].[Submission]
ADD CONSTRAINT [FK_Submission_Quiz]
    FOREIGN KEY ([quizId], [teacherId])
    REFERENCES [dbo].[Quiz]
        ([id], [teacherId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [quizId], [teacherId] in table 'Whitelist'
ALTER TABLE [dbo].[Whitelist]
ADD CONSTRAINT [FK_Whitelist_Quiz]
    FOREIGN KEY ([quizId], [teacherId])
    REFERENCES [dbo].[Quiz]
        ([id], [teacherId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [status] in table 'Result'
ALTER TABLE [dbo].[Result]
ADD CONSTRAINT [FK_Result_ResultStatus]
    FOREIGN KEY ([status])
    REFERENCES [dbo].[ResultStatus]
        ([name])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Result_ResultStatus'
CREATE INDEX [IX_FK_Result_ResultStatus]
ON [dbo].[Result]
    ([status]);
GO

-- Creating foreign key on [quizId], [teacherId], [studentId] in table 'Result'
ALTER TABLE [dbo].[Result]
ADD CONSTRAINT [FK_Result_Submission]
    FOREIGN KEY ([quizId], [teacherId], [studentId])
    REFERENCES [dbo].[Submission]
        ([quizId], [teacherId], [studentId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------