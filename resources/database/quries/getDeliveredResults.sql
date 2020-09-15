USE [onlineQuiz-bsef17m35]
GO

/****** Object:  StoredProcedure [dbo].[getDeliveredResults]    Script Date: 02/05/2020 03:09:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getDeliveredResults]
	@teacherId	int,
	@quizId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT result.obtainedMarks, result.status,
		endUser.email as studentEmail,
		(endUser.firstName + ' ' + endUser.secondName) as studentName
	
	FROM Result as result

	INNER JOIN EndUser as endUser ON result.studentId = endUser.id

	WHERE result.teacherId = @teacherId AND result.quizId = @quizId;
END

GO

