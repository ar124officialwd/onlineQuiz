USE [onlineQuiz-bsef17m35]
GO

/****** Object:  StoredProcedure [dbo].[getVisibility]    Script Date: 02/05/2020 03:11:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[getVisibility]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Visibility;
END

GO

