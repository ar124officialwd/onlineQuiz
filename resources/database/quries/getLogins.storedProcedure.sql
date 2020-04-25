use [onlineQuiz-bsef17m35];

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE getLogins
	@email	varchar(128),
	@password	varchar(16)
AS
BEGIN
	SELECT id, firstName, type FROM EndUser
		WHERE email = @email AND password = @password;
END
GO
