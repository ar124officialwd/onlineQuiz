USE [onlineQuiz-bsef17m35]
GO

/****** Object:  StoredProcedure [dbo].[getResults]    Script Date: 02/05/2020 03:10:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getResults]
	@studentId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT result.obtainedMarks, result.status,
		quiz.totalMarks, quiz.title, quiz.passingMarks,
		teacher.email as teacherEmail,
		(teacher.firstName + ' ' + teacher.secondName) as teacherName
	FROM Result as result

	INNER Join EndUser as teacher ON result.teacherId = teacher.id

	INNER JOIN Quiz as quiz ON result.quizId = quiz.id AND
		result.teacherId = quiz.teacherId

	WHERE result.studentId = @studentId;
END

GO

