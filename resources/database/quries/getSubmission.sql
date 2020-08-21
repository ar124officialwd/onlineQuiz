USE [onlineQuiz-bsef17m35]
GO

/****** Object:  StoredProcedure [dbo].[getSubmission]    Script Date: 02/05/2020 03:11:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getSubmission]
	@teacherId int,
	@quizId int,
	@studentId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT submission.content, endUser.email as studentEmail,
		(endUser.firstName + ' ' + endUser.secondName) as studentName
	FROM Submission as submission
	
	INNER JOIN EndUser as endUser ON submission.studentId = endUser.id

	WHERE submission.teacherId = @teacherId AND submission.quizId = @quizId
		AND submission.studentId = @studentId;
END


GO

