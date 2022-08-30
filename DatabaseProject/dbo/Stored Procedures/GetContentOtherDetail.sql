--Develop 19 10 2021
--IF ID OTher Wise It will Check contentID And If Not Then It Will Default Setting.
CREATE PROCEDURE [dbo].[GetContentOtherDetail]
(
 @ChnID Dbo.ChnID,
 @ContentID Dbo.PID
)
As
SET NOCOUNT ON;
BEGIN
	
	If Exists(Select 1 From ChnContentOtherInfo With(NoLock) Where ChnID=@ChnID And ContentID=@ContentID)
		Select Top(1) VideoFormat,AudioFormat,Language,CCType,CCSource
		From ChnContentOtherInfo Where ChnID=@ChnID And ContentID=@ContentID
	Else If Exists(Select 1 From ChnContentOtherInfo With(NoLock) Where ContentID=@ContentID)
		Select Top(1) VideoFormat,AudioFormat,Language,CCType,CCSource
		From ChnContentOtherInfo Where ContentID=@ContentID
END
