--Develop 11 03 2021, For Getting Uniformating Result.
-- Changes 10 01 2022, @RefID BigInt To NVarchr(MAx) Sometime Commseprated RefIDs Pass That Time Use It
CREATE Function [dbo].[Get_ProcResult]
(
	@Mode TinyInt,-- --1=Insert | 2=Update | 3=Delete | 99 -General Record.
	@ObjName Varchar(500),
	@RefID NVarchar(Max),
	@IsSuccess Bit,
	@Msg NVarchar(Max)=NULL --If Pass NULL Then It Will Display Default Message.
)
RETURNS @ReturnTable Table(ObjName Varchar(500),RefID NVarchar(Max),IsSuccess Bit,Msg NVarchar(Max))
As
Begin
	If @Mode=1
	   Insert Into @ReturnTable(ObjName,RefID,IsSuccess,Msg) 
	   Values(@ObjName,Isnull(@RefID,'0'),@IsSuccess,Case When Isnull(@Msg,'')='' Then 'A new record has been saved successfully.' Else @Msg End)
	Else IF @Mode=2 
	   Insert Into @ReturnTable(ObjName,RefID,IsSuccess,Msg) 
	   Values(@ObjName,Isnull(@RefID,'0'),@IsSuccess,Case When Isnull(@Msg,'')='' Then 'Record has been updated successfully.' Else @Msg End)
	Else IF @Mode=3
	   Insert Into @ReturnTable(ObjName,RefID,IsSuccess,Msg) 
	   Values(@ObjName,Isnull(@RefID,'0'),@IsSuccess,Case When Isnull(@Msg,'')='' Then 'Record has been deleted successfully.' Else @Msg End)
	Else if @Mode=99
		Insert Into @ReturnTable(ObjName,RefID,IsSuccess,Msg) Values(@ObjName,Isnull(@RefID,'0'),@IsSuccess,Case When Isnull(@Msg,'')='' Then 'Record has been saved successfully.' Else @Msg End)
	Return
End
