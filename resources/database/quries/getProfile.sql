USE [onlineQuiz-bsef17m35]
GO

/****** Object:  StoredProcedure [dbo].[getProfile]    Script Date: 02/05/2020 03:10:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getProfile]
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT endUser.city, endUser.email, endUser.gender, endUser.profilePicturePath,
		endUser.firstName, endUser.secondName, endUser.countryCode,
	    (endUser.firstName + ' ' + endUser.secondName) AS fullName,
		teacher.speciality AS speciality,
		country.name as country

	FROM EndUser AS endUser

	-- FETCH Speciality column too if @email refer to a Teacher
	LEFT JOIN Teacher AS teacher ON endUser.id = teacher.userId
	
	-- Fetch Counry Real Name -------------------------------------------------
	LEFT JOIN Country AS country ON endUser.countryCode = country.code

	WHERE endUser.id = @id
END

GO

