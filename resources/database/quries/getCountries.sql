USE [onlineQuiz-bsef17m35]
GO

/****** Object:  StoredProcedure [dbo].[getCountries]    Script Date: 02/05/2020 03:08:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[getCountries]
AS
BEGIN
	SELECT * FROM Country;
END

GO

