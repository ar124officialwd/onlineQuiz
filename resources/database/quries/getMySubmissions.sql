USE [onlineQuiz-bsef17m35]
GO

/****** Object:  StoredProcedure [dbo].[getMySubmissions]    Script Date: 02/05/2020 03:10:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getMySubmissions]
	@studentId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT submission.content, submission.quizId,
		submission.studentId, submission.teacherId,
		endUser.email as teacherEmail,
		(endUser.firstName + ' ' + endUser.secondName) as teacherName,
		quiz.title as quizTitle
	
	FROM Submission as submission

	INNER JOIN EndUser as endUser
		ON submission.teacherId = endUser.id

	INNER JOIN Quiz as quiz
		ON quiz.id = submission.quizId AND quiz.teacherId = submission.teacherId

	WHERE
		NOT EXISTS(SELECT quizId FROM Result as result
			WHERE result.teacherId = submission.teacherId
				AND result.studentId = @studentId)

		AND

		submission.studentId = @studentId;
END

GO

