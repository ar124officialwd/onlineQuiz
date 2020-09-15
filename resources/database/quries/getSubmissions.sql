USE [onlineQuiz-bsef17m35]
GO

/****** Object:  StoredProcedure [dbo].[getSubmissions]    Script Date: 02/05/2020 03:11:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getSubmissions]
	@teacherId	int,
	@quizId	int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT teacherId, quizId, studentId,
		endUser.email as studentEmail, 
		(endUser.firstName + ' ' + endUser.secondName) as studentName
	FROM Submission as submission

	LEFT JOIN EndUser as endUser ON submission.studentId = endUser.id

	WHERE
		NOT EXISTS(SELECT quizId FROM Result as result
			WHERE result.quizId = submission.quizId AND 
				result.teacherId = submission.teacherId AND
				result.studentId = submission.studentId)

		AND

		teacherId = @teacherId AND quizId = @quizId;
END

GO

