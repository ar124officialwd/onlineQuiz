USE [onlineQuiz-bsef17m35]
GO

/****** Object:  StoredProcedure [dbo].[getQuestionTypes]    Script Date: 02/05/2020 03:10:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[getQuestionTypes]
AS
BEGIN
	SELECT type FROM QuestionType;
END

GO

