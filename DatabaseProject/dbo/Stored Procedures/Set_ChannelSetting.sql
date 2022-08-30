
-- exec Set_ChannelSetting @Type=3,@ChnID=2
CREATE PROCEDURE [dbo].[Set_ChannelSetting]
	@Type tinyint, -- 1 = New Channel Create Time 2=Version Update time Set Channel Setting 3= Get Channel wise Setting 4= Truncate ChannelSetting And Set AppSetting Value in All Channel
	@ChnID [Dbo].ChnID=0	
As

SET NOCOUNT ON;

Declare @ChannelID [Dbo].ChnID
declare @cols as nvarchar(max)
declare @query as nvarchar(max)

BEGIN
	If @Type=1
		Begin
			Insert Into ChannelSetting(ChnID,Particular,Value,Category,DefaultValue,DataType,Desp,TrnUserID,TrnDate)
			Select @ChnID,Particular,Value,Category,DefaultValue,DataType,Desp,TrnUserID,GETDATE() From AppSetting With(NoLock) where Type=2
		End
	IF @Type=2
		Begin		
			Declare Cur Cursor For Select ID From ChannelMst
			Open Cur
			Fetch Next From Cur Into @ChannelID
			While @@FETCH_STATUS = 0				
			Begin
					Insert Into ChannelSetting(ChnID,Particular,Value,Category,DefaultValue,DataType,Desp,TrnUserID,TrnDate)
					Select @ChannelID,Particular,Value,Category,DefaultValue,DataType,Desp,TrnUserID,GETDATE()
					From AppSetting With(NoLock)
					where Type=2
					And Particular Not In(Select Particular From ChannelSetting Where ChnID=@ChannelID )							

					Fetch Next From Cur Into @ChannelID
			End
			Close Cur
			DeAllocate Cur	

			Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'Set_ChannelSetting',0,'True',NULL)
		End
	IF @Type=3
		Begin
			Select @cols = STUFF((Select distinct ',' + QUOTENAME(particular)
			from ChannelSetting 
			FOR XML PATH(''),TYPE).value('.','NVARCHAR(MAX)'),1,1,'')
			Set @query='Select ' + @cols + ' 
			from 
			(
			Select particular,value 
			from ChannelSetting Where ChnID=@QChnID
			) x 
			pivot
			(max(value)
			for particular in (' + @cols +')
			) p'
			EXECUTE sp_executesql @query,  
						N' @QChnID bigint',     
						@QChnID =@ChnID			
		End
	IF @Type=4
		Begin
			Truncate Table ChannelSetting
			Exec Set_ChannelSetting @Type=2
		End
END
