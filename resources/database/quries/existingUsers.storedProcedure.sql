USE [onlineQuiz-bsef17m35];

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE existingUsers
	@email	varchar(128)
AS
BEGIN
	SELECT email FROM EndUser WHERE email = @email;
END
GO
