USE [onlineQuiz-bsef17m35]
GO

/****** Object:  StoredProcedure [dbo].[getOpenQuizzes]    Script Date: 17/04/2020 23:47:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getOpenQuizzes]
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT quiz.*, (endUser.firstName + ' ' + endUser.secondName) as teacherName
	FROM Quiz AS quiz

	INNER JOIN EndUser AS endUser ON quiz.teacherId = endUser.id
		WHERE
			-- DON'T CONSIDER ALREADY SUBMITTED QUIZES --
			NOT EXISTS (SELECT quizId FROM Submission as submission
				WHERE submission.quizId = quiz.id 
					AND submission.studentId != @id)

			AND
			-- RETRIEVE BOTH 'Public' AND 'Private' BUT APPLICABLE
			(
				-- RETRIEVE ONLY THOSE 'Public' WHICH DON'T BLACKLIST CURRENT 'email'
				(
				 quiz.visibility = 'Public' 
					AND 
				 NOT EXISTS (SELECT quizId FROM Blacklist 
							WHERE email = (SELECT email FROM endUser WHERE endUser.id = @id)
								AND quizId = quiz.id)
				)

					OR

				-- RETRIEVE ONLY THOSE 'Private' WHICH WHITELIST CURRENT 'email'
				(
				 quiz.visibility = 'Private'
					AND
				 EXISTS (SELECT quizId FROM Whitelist 
					WHERE email = (SELECT email FROM endUser WHERE endUser.id = @id)
						AND teacherId = quiz.teacherId)
				)
		 )
END

GO

