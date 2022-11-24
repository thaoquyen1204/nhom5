﻿
/** bai 1**/
DECLARE @AVGLUONG FLOAT
SELECT  @AVGLUONG=AVG(LUONG)
FROM NHANVIEN
SELECT IIF(LUONG<@AVGLUONG,'TANG LUONG','KHONG TANG LUONG')AS THUNHAP,TENNV,LUONG
FROM NHANVIEN
GO
DECLARE @AVGLUONG FLOAT
SELECT  @AVGLUONG=AVG(LUONG)
FROM NHANVIEN
SELECT IIF(LUONG>@AVGLUONG,'TRUONG PHONG','NHAN VIEN')AS CHUCVU,TENNV,LUONG
FROM NHANVIEN
GO

SELECT TENNV= case PHAI
WHEN N'Nam' then 'mr.'+[TENNV]
WHEN N'NỮ' then 'ms.'+[TENNV]
end
from NHANVIEN
go
select TENNV,LUONG,Thue=case
when LUONG between 0 and 25000 then (LUONG*0.1) 
when LUONG between 25000 and 30000 then LUONG*0.12
when LUONG between 30000 and 40000 then LUONG*0.15
when LUONG between 40000 and 50000 then LUONG*0.2
else luong*0.25
end
from NHANVIEN
/** cau 2**/
go
IF(SELECT COUNT(*) FROM NHANVIEN WHERE MANV%2 = 0)>0
BEGIN
SELECT HONV,TENLOT,TENNV,MANV
FROM NHANVIEN
where MANV%2=0
END


GO
IF(SELECT COUNT(*) FROM NHANVIEN WHERE MANV%2 = 0 AND MANV!=4)>0
BEGIN
SELECT TENNV,MANV
FROM NHANVIEN
where MANV%2=0 AND MANV!= 004
END 
/** cau 3**/
GO
BEGIN TRY
	INSERT PHONGBAN
	VALUES(799, 'ZXK - 799', '2008-07-01', '0179-05-22')
	PRINT 'SUCCESS: record was inserted.'
END TRY 
BEGIN CATCH 
PRINT 'FAILURE: record was not inserted.'
PRINT 'ERROR ' + CONVERT (VARCHAR , ERROR_NUMBER (), 1) + ': ' + ERROR_MESSAGE()
END CATCH
GO
BEGIN TRY
DECLARE @CHIA INT
SET @CHIA=59/0
END TRY
BEGIN CATCH
DECLARE 
@A NVARCHAR(2048),
@B INT,
@C INT
SELECT 
@A= ERROR_MESSAGE(),
@B=ERROR_SEVERITY(),
@C=ERROR_STATE()
RAISERROR (@A,@B,@C)
END CATCH


/** CAU 4**/
DECLARE @SO INT, @SUM INT
SET @SO = 1
SET @SUM=0
WHILE (@SO< = 10)
BEGIN
	IF(@SO %2=0) 
		BEGIN
			SELECT @SUM=@SUM+@SO
		END
	SET @SO=@SO+1
END
PRINT 'TONG LA:'+ STR(@SUM)
GO
DECLARE @SO INT, @SUM INT
SET @SO = 1
SET @SUM=0
WHILE (@SO< = 10)
BEGIN
	IF(@SO %2=0) AND (@SO!=4)
		BEGIN
			SELECT @SUM=@SUM+@SO
		END
	SET @SO=@SO+1
END
PRINT 'TONG LA:'+ STR(@SUM)
GO







