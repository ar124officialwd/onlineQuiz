USE [onlineQuiz-bsef17m35]
GO

/****** Object:  StoredProcedure [dbo].[getLogins]    Script Date: 02/05/2020 03:09:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[getLogins]
	@email	varchar(128),
	@password	varchar(16)
AS
BEGIN
	SELECT id, firstName, type FROM EndUser
		WHERE email = @email AND password = @password
			AND active != 0;
END

GO


