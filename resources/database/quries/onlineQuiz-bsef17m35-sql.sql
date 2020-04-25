USE [onlineQuiz-bsef17m35];

DROP TABLE Submission;
DROP TABLE Blacklist;
DROP TABLE Whitelist;
DROP TABLE QuestionOption;
DROP TABLE Question;
DROP TABLE Quiz;
DROP TABLE Teacher;
DROP TABLE Student;
DROP TABLE EndUser;
DROP TABLE Visibility;
DROP TABLE Blacklist;
DROP TABLE Country;
DROP TABLE QuestionType;
DROP TABLE Gender;
DROP TABLE EndUserType;


-- Creating table 'Blacklists'
CREATE TABLE [dbo].[Blacklist] (
    [quizId] int  NOT NULL,
    [teacherId] int NOT NULL,
    [email] varchar(128)  NOT NULL
);
GO

-- Creating table 'Gender'
CREATE TABLE [dbo].[Gender] (
	[name] [varchar](16) NOT NULL
);
GO

-- Creating table 'Countries'
CREATE TABLE [dbo].[Country] (
    [code] varchar(3)  NOT NULL,
    [name] varchar(128)  NOT NULL
);
GO

-- Creating table 'EndUsers'
CREATE TABLE [dbo].[EndUser] (
	[id] int IDENTITY(1,1) NOT NULL,
    [email] varchar(128)  NOT NULL,
    [password] varchar(32)  NOT NULL,
    [firstName] varchar(64)  NOT NULL,
    [secondName] varchar(64)  NULL,
    [countryCode] varchar(3)  NOT NULL,
    [city] varchar(64)  NOT NULL,
    [type] varchar(32)  NOT NULL,
	[gender] varchar(16) NOT NULL,
	[profilePicturePath] varchar(256) NOT NULL
);
GO

-- Creating table 'EndUserTypes'
CREATE TABLE [dbo].[EndUserType] (
    [type] varchar(32)  NOT NULL
);
GO

-- Creating table 'QuestionOption'
CREATE TABLE [dbo].[QuestionOption] (
    [value] varchar(64)  NOT NULL,
    [valid] bit  NOT NULL,
    [questionId] int  NOT NULL,
    [quizId] int  NOT NULL,
    [teacherId] int NOT NULL,
    [id] int IDENTITY(1,1) NOT NULL
);
GO

-- Creating table 'Questions'
CREATE TABLE [dbo].[Question] (
    [title] varchar(128)  NOT NULL,
    [description] varchar(128)  NULL,
    [type] varchar(32)  NOT NULL,
    [quizId] int  NOT NULL,
    [teacherId] int NOT NULL,
    [id] int IDENTITY(1,1) NOT NULL,
	marks int NOT NULL
);
GO

-- Creating table 'QuestionTypes'
CREATE TABLE [dbo].[QuestionType] (
    [type] varchar(32)  NOT NULL
);
GO

-- Creating table 'Quizs'
CREATE TABLE [dbo].[Quiz] (
    [id] int IDENTITY(1,1) NOT NULL,
    [teacherId] int NOT NULL,
    [visibility] varchar(16)  NOT NULL,
    [title] varchar(64)  NOT NULL,
    [description] varchar(128),
    [totalMarks] int  NOT NULL,
    [passingMarks] int  NOT NULL
);
GO

-- Creating table 'Students'
CREATE TABLE [dbo].[Student] (
	[userId] int NOT NULL
);
GO

-- Creating table 'Submissions'
CREATE TABLE [dbo].[Submission] (
    [quizId] int  NOT NULL,
    [teacherId] int NOT NULL,
    [studentId] int NOT NULL,
    [content] varchar(max)  NOT NULL
);
GO

-- Creating table 'Teachers'
CREATE TABLE [dbo].[Teacher] (
    [userId] int NOT NULL,
    [speciality] varchar(128)  NOT NULL
);
GO

-- Creating table 'Visibilities'
CREATE TABLE [dbo].[Visibility] (
    [value] varchar(16)  NOT NULL
);
GO

-- Creating table 'Whitelists'
CREATE TABLE [dbo].[Whitelist] (
    [quizId] int  NOT NULL,
    [teacherId] int NOT NULL,
    [email] [varchar](128) NOT NULL,
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [quizId], [teacherId], [studentId] in table 'Blacklists'
ALTER TABLE [dbo].[Blacklist]
ADD CONSTRAINT [PK_Blacklists]
    PRIMARY KEY CLUSTERED ([quizId], [teacherId], [email] ASC);
GO

-- Creating primary key on [code] in table 'Country'
ALTER TABLE [dbo].[Country]
ADD CONSTRAINT [PK_Country]
    PRIMARY KEY CLUSTERED ([code] ASC);
GO

-- Creating primary key on [code] in table 'Gender'
ALTER TABLE [dbo].[Gender]
ADD CONSTRAINT [PK_Gender]
    PRIMARY KEY CLUSTERED ([name] ASC);
GO

-- Creating primary key on [email] in table 'EndUsers'
ALTER TABLE [dbo].[EndUser]
ADD CONSTRAINT [PK_EndUsers]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [type] in table 'EndUserTypes'
ALTER TABLE [dbo].[EndUserType]
ADD CONSTRAINT [PK_EndUserType]
    PRIMARY KEY CLUSTERED ([type] ASC);
GO

-- Creating primary key on [questionId], [quizId], [teacherId], [id] in table 'QuestionOption'
ALTER TABLE [dbo].[QuestionOption]
ADD CONSTRAINT [PK_QuestionOption]
    PRIMARY KEY CLUSTERED ([questionId], [quizId], [teacherId], [id] ASC);
GO

-- Creating primary key on [quizId], [teacherId], [id] in table 'Questions'
ALTER TABLE [dbo].[Question]
ADD CONSTRAINT [PK_Questions]
    PRIMARY KEY CLUSTERED ([quizId], [teacherId], [id] ASC);
GO

-- Creating primary key on [type] in table 'QuestionTypes'
ALTER TABLE [dbo].[QuestionType]
ADD CONSTRAINT [PK_QuestionType]
    PRIMARY KEY CLUSTERED ([type] ASC);
GO

-- Creating primary key on [id], [teacherId] in table 'Quizs'
ALTER TABLE [dbo].[Quiz]
ADD CONSTRAINT [PK_Quizs]
    PRIMARY KEY CLUSTERED ([id], [teacherId] ASC);
GO

-- Creating primary key on [email] in table 'Students'
ALTER TABLE [dbo].[Student]
ADD CONSTRAINT [PK_Students]
    PRIMARY KEY CLUSTERED ([userId] ASC);
GO

-- Creating primary key on [id], [quizId], [teacherId], [studentId] in table 'Submissions'
ALTER TABLE [dbo].[Submission]
ADD CONSTRAINT [PK_Submissions]
    PRIMARY KEY CLUSTERED ([quizId], [teacherId], [studentId] ASC);
GO

-- Creating primary key on [email] in table 'Teachers'
ALTER TABLE [dbo].[Teacher]
ADD CONSTRAINT [PK_Teachers]
    PRIMARY KEY CLUSTERED ([userId] ASC);
GO

-- Creating primary key on [value] in table 'Visibilities'
ALTER TABLE [dbo].[Visibility]
ADD CONSTRAINT [PK_Visibilities]
    PRIMARY KEY CLUSTERED ([value] ASC);
GO

-- Creating primary key on [quizId], [teacherId], [studentId] in table 'Whitelists'
ALTER TABLE [dbo].[Whitelist]
ADD CONSTRAINT [PK_Whitelists]
    PRIMARY KEY CLUSTERED ([quizId], [teacherId], [email] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [quizId], [teacherId] in table 'Blacklists'
ALTER TABLE [dbo].[Blacklist]
ADD CONSTRAINT [FK_Blacklist_Quiz]
    FOREIGN KEY ([quizId], [teacherId])
    REFERENCES [dbo].[Quiz]
        ([id], [teacherId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [countryCode] in table 'EndUsers'
ALTER TABLE [dbo].[EndUser]
ADD CONSTRAINT [FK_Country_User1]
    FOREIGN KEY ([countryCode])
    REFERENCES [dbo].[Country]
        ([code])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [gender] in table 'EndUsers'
ALTER TABLE [dbo].[EndUser]
ADD CONSTRAINT [FK_Gender_User1]
    FOREIGN KEY ([gender])
    REFERENCES [dbo].[Gender]
        ([name])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Country_User1'
CREATE INDEX [IX_FK_Country_User1]
ON [dbo].[EndUser]
    ([countryCode]);
GO

-- Creating foreign key on [EndUserType_type] in table 'EndUsers'
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

-- Creating foreign key on [userId] in table 'Students'
ALTER TABLE [dbo].[Student]
ADD CONSTRAINT [FK_Student_User1]
    FOREIGN KEY ([userId])
    REFERENCES [dbo].[EndUser]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [userId] in table 'Teachers'
ALTER TABLE [dbo].[Teacher]
ADD CONSTRAINT [FK_Teacher_User1]
    FOREIGN KEY ([userId])
    REFERENCES [dbo].[EndUser]
        ([id])
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

-- Creating foreign key on [type] in table 'Questions'
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

-- Creating foreign key on [quizId], [teacherId] in table 'Questions'
ALTER TABLE [dbo].[Question]
ADD CONSTRAINT [FK_Question_Quiz]
    FOREIGN KEY ([quizId], [teacherId])
    REFERENCES [dbo].[Quiz]
        ([id], [teacherId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [teacherId] in table 'Quizs'
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

-- Creating foreign key on [visibility] in table 'Quizs'
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

-- Creating foreign key on [quizId], [teacherId] in table 'Submissions'
ALTER TABLE [dbo].[Submission]
ADD CONSTRAINT [FK_Submission_Quiz]
    FOREIGN KEY ([quizId], [teacherId])
    REFERENCES [dbo].[Quiz]
        ([id], [teacherId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Submission_Quiz'
CREATE INDEX [IX_FK_Submission_Quiz]
ON [dbo].[Submission]
    ([quizId], [teacherId]);
GO

-- Creating foreign key on [quizId], [teacherId] in table 'Whitelists'
ALTER TABLE [dbo].[Whitelist]
ADD CONSTRAINT [FK_Whitelist_Quiz]
    FOREIGN KEY ([quizId], [teacherId])
    REFERENCES [dbo].[Quiz]
        ([id], [teacherId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- --------------------------------------------------
-- Insert necessary data
-- --------------------------------------------------
INSERT INTO [onlineQuiz-bsef17m35].[dbo].[Country]
           ([code]
           ,[name])
     VALUES
           ('AF','Afghanistan'), ('AL','Albania'), ('DZ','Algeria'), ('AS','American Samoa'), ('AD','Andorra'), ('AO','Angola'), ('AI','Anguilla'), ('AQ','Antarctica'), ('AG','Antigua And Barbuda'), ('AR','Argentina'), ('AM','Armenia'), ('AW','Aruba'), ('AU','Australia'), ('AT','Austria'), ('AZ','Azerbaijan'), ('BS','Bahamas'), ('BH','Bahrain'), ('BD','Bangladesh'), ('BB','Barbados'), ('BY','Belarus'), ('BE','Belgium'), ('BZ','Belize'), ('BJ','Benin'), ('BM','Bermuda'), ('BT','Bhutan'), ('BO','Bolivia'), ('BA','Bosnia And Herzegovina'), ('BW','Botswana'), ('BV','Bouvet Island'), ('BR','Brazil'), ('IO','British Indian Ocean Territory'), ('BN','Brunei Darussalam'), ('BG','Bulgaria'), ('BF','Burkina Faso'), ('BI','Burundi'), ('KH','Cambodia'), ('CM','Cameroon'), ('CA','Canada'), ('CV','Cape Verde'), ('KY','Cayman Islands'), ('CF','Central African Republic'), ('TD','Chad'), ('CL','Chile'), ('CN','China'), ('CX','Christmas Island'), ('CC','Cocos (keeling) Islands'), ('CO','Colombia'), ('KM','Comoros'), ('CG','Congo'), ('CD','Congo, The Democratic Republic Of The'), ('CK','Cook Islands'), ('CR','Costa Rica'), ('CI','Cote Divoire'), ('HR','Croatia'), ('CU','Cuba'), ('CY','Cyprus'), ('CZ','Czech Republic'), ('DK','Denmark'), ('DJ','Djibouti'), ('DM','Dominica'), ('DO','Dominican Republic'), ('TP','East Timor'), ('EC','Ecuador'), ('EG','Egypt'), ('SV','El Salvador'), ('GQ','Equatorial Guinea'), ('ER','Eritrea'), ('EE','Estonia'), ('ET','Ethiopia'), ('FK','Falkland Islands (malvinas)'), ('FO','Faroe Islands'), ('FJ','Fiji'), ('FI','Finland'), ('FR','France'), ('GF','French Guiana'), ('PF','French Polynesia'), ('TF','French Southern Territories'), ('GA','Gabon'), ('GM','Gambia'), ('GE','Georgia'), ('DE','Germany'), ('GH','Ghana'), ('GI','Gibraltar'), ('GR','Greece'), ('GL','Greenland'), ('GD','Grenada'), ('GP','Guadeloupe'), ('GU','Guam'), ('GT','Guatemala'), ('GN','Guinea'), ('GW','Guinea-bissau'), ('GY','Guyana'), ('HT','Haiti'), ('HM','Heard Island And Mcdonald Islands'), ('VA','Holy See (vatican City State)'), ('HN','Honduras'), ('HK','Hong Kong'), ('HU','Hungary'), ('IS','Iceland'), ('IN','India'), ('ID','Indonesia'), ('IR','Iran, Islamic Republic Of'), ('IQ','Iraq'), ('IE','Ireland'), ('IL','Israel'), ('IT','Italy'), ('JM','Jamaica'), ('JP','Japan'), ('JO','Jordan'), ('KZ','Kazakstan'), ('KE','Kenya'), ('KI','Kiribati'), ('KP','Korea, Democratic Peoples Republic Of'), ('KR','Korea, Republic Of'), ('KV','Kosovo'), ('KW','Kuwait'), ('KG','Kyrgyzstan'), ('LA','Lao Peoples Democratic Republic'), ('LV','Latvia'), ('LB','Lebanon'), ('LS','Lesotho'), ('LR','Liberia'), ('LY','Libyan Arab Jamahiriya'), ('LI','Liechtenstein'), ('LT','Lithuania'), ('LU','Luxembourg'), ('MO','Macau'), ('MK','Macedonia, The Former Yugoslav Republic Of'), ('MG','Madagascar'), ('MW','Malawi'), ('MY','Malaysia'), ('MV','Maldives'), ('ML','Mali'), ('MT','Malta'), ('MH','Marshall Islands'), ('MQ','Martinique'), ('MR','Mauritania'), ('MU','Mauritius'), ('YT','Mayotte'), ('MX','Mexico'), ('FM','Micronesia, Federated States Of'), ('MD','Moldova, Republic Of'), ('MC','Monaco'), ('MN','Mongolia'), ('MS','Montserrat'), ('ME','Montenegro'), ('MA','Morocco'), ('MZ','Mozambique'), ('MM','Myanmar'), ('NA','Namibia'), ('NR','Nauru'), ('NP','Nepal'), ('NL','Netherlands'), ('AN','Netherlands Antilles'), ('NC','New Caledonia'), ('NZ','New Zealand'), ('NI','Nicaragua'), ('NE','Niger'), ('NG','Nigeria'), ('NU','Niue'), ('NF','Norfolk Island'), ('MP','Northern Mariana Islands'), ('NO','Norway'), ('OM','Oman'), ('PK','Pakistan'), ('PW','Palau'), ('PS','Palestinian Territory, Occupied'), ('PA','Panama'), ('PG','Papua New Guinea'), ('PY','Paraguay'), ('PE','Peru'), ('PH','Philippines'), ('PN','Pitcairn'), ('PL','Poland'), ('PT','Portugal'), ('PR','Puerto Rico'), ('QA','Qatar'), ('RE','Reunion'), ('RO','Romania'), ('RU','Russian Federation'), ('RW','Rwanda'), ('SH','Saint Helena'), ('KN','Saint Kitts And Nevis'), ('LC','Saint Lucia'), ('PM','Saint Pierre And Miquelon'), ('VC','Saint Vincent And The Grenadines'), ('WS','Samoa'), ('SM','San Marino'), ('ST','Sao Tome And Principe'), ('SA','Saudi Arabia'), ('SN','Senegal'), ('RS','Serbia'), ('SC','Seychelles'), ('SL','Sierra Leone'), ('SG','Singapore'), ('SK','Slovakia'), ('SI','Slovenia'), ('SB','Solomon Islands'), ('SO','Somalia'), ('ZA','South Africa'), ('GS','South Georgia And The South Sandwich Islands'), ('ES','Spain'), ('LK','Sri Lanka'), ('SD','Sudan'), ('SR','Suriname'), ('SJ','Svalbard And Jan Mayen'), ('SZ','Swaziland'), ('SE','Sweden'), ('CH','Switzerland'), ('SY','Syrian Arab Republic'), ('TW','Taiwan, Province Of China'), ('TJ','Tajikistan'), ('TZ','Tanzania, United Republic Of'), ('TH','Thailand'), ('TG','Togo'), ('TK','Tokelau'), ('TO','Tonga'), ('TT','Trinidad And Tobago'), ('TN','Tunisia'), ('TR','Turkey'), ('TM','Turkmenistan'), ('TC','Turks And Caicos Islands'), ('TV','Tuvalu'), ('UG','Uganda'), ('UA','Ukraine'), ('AE','United Arab Emirates'), ('GB','United Kingdom'), ('US','United States'), ('UM','United States Minor Outlying Islands'), ('UY','Uruguay'), ('UZ','Uzbekistan'), ('VU','Vanuatu'), ('VE','Venezuela'), ('VN','Viet Nam'), ('VG','Virgin Islands, British'), ('VI','Virgin Islands, U.s.'), ('WF','Wallis And Futuna'), ('EH','Western Sahara'), ('YE','Yemen'), ('ZM','Zambia'), ('ZW','Zimbabwe');
GO


INSERT INTO [onlineQuiz-bsef17m35].[dbo].[EndUserType]
           ([type])
     VALUES
			('teacher'), ('student')
GO


INSERT INTO [onlineQuiz-bsef17m35].[dbo].[Visibility]
			([value])
		VALUES
			('Public'), ('Private');
GO

INSERT INTO [onlineQuiz-bsef17m35].[dbo].[QuestionType]
			([type])
		VALUES
			('Brief'), ('Descriptive'), ('Multiple Choice');
GO

INSERT INTO Gender
	VALUES
		('Male'), ('Female'), ('Unspecified');
GO

INSERT INTO EndUser
	(firstName, secondName, email, password, countryCode, city, type, 
		profilePicturePath, gender)
VALUES
	('Faisal', 'Zia', 'teacher@d.oq', 'asdfjkl;', 'PK', 'Sargodha', 'teacher',
		'/resources/images/profile_pictures/default/teacher_male.png', 'Male'),
	('Ahmad', 'Raza', 'student@d.oq', 'jkl;asdf', 'PK', 'Sargodha', 'student',
		'/resources/images/profile_pictures/default/student_male.png', 'Male');

INSERT INTO Teacher
	(userId, speciality)
VALUES
	(1, 'Computer Science');

INSERT INTO Student
	(userId)
VALUES
	(2);

-- CREATE A SAMPLE QUIZ--------------------------------------------------------
INSERT INTO Quiz(teacherId, visibility, title, totalMarks, passingMarks)
	VALUES(1, 'Public', 'Ead Quiz for Mid Term', 10, 10);

INSERT INTO Question(teacherId, quizId, title, marks, type)
	VALUES
		(1, 1, 'Describe entity framework and 3 methods to hanlde database',
			5, 'Descriptive'),
		(1, 1, 'Write a query to retieve all records in table Quiz',
			2, 'Brief'),
		(1, 1, 'Which propery is check to detect if request came from control',
			1, 'Multiple Choice');

INSERT INTO QuestionOption(questionId, teacherId, quizId, value, valid)
	VALUES
		(3, 1, 1, 'IsPostBack', 1),
		(3, 1, 1, 'Session', 0),
		(3, 1, 1, 'Request', 0),
		(3, 1, 1, 'Response', 0);
-------------------------------------------------------------------------------