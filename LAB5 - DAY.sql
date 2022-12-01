/**a**/
go
create procedure ThongtinNV2 @MANV nvarchar(9)
as 
begin 
select * from NHANVIEN where MANV=@MANV
end
go
exec ThongtinNV2 '005'
/**b**/
go
create procedure soluong1234 @MADA nvarchar(9)
as 
begin 
select MADA,COUNT(*) AS SOLUONG
from DEAN ,NHANVIEN
where MADA=@MADA and PHG=PHONG 
GROUP BY MADA
end
go
exec soluong1234 '20'
/**c**/
go
create procedure slvd12 @MADA nvarchar(9), @Ddiem_DA nvarchar(20)
as 
begin 
select MADA,COUNT(*) AS SOLUONG,DIADIEM
from DEAN ,NHANVIEN,DIADIEM_PHG
where MADA=@MADA and PHG=PHONG and DIADIEM=@Ddiem_DA AND MAPHG=PHONG
GROUP BY MADA,DIADIEM
end
go
exec slvd12 '20','%TPHCM%'
/**d**/
GO
create procedure nhanvien12345 @trphg nvarchar(9)
as 
begin 
select TENNV
from NHANVIEN, PHONGBAN
WHERE @trphg=MANV AND PHG=MAPHG
END
GO
EXEC nhanvien12345 '006'
/**E**/
GO
create procedure nhanvien123456 @MANV nvarchar(9),@MAPB nvarchar(9)
as 
begin 
select TENNV
from NHANVIEN, PHONGBAN
WHERE @MANV=MANV AND PHG=MAPHG
END
GO
EXEC nhanvien123456'001','4'
go
/**3**/
CREATE PROC PHONGBAN1 @TenPHG NVARCHAR(15),
	@MaPHG INT, @TRPHG NVARCHAR(9), @NG_NHANCHUC date
AS
BEGIN
	IF EXISTS(SELECT * FROM PHONGBAN WHERE MAPHG = @MaPHG)
		PRINT 'Da ton tai, khong them vao duoc';
	ELSE
		INSERT INTO PHONGBAN
		VALUES(@TenPHG, @MaPHG,@TRPHG,@NG_NHANCHUC)
END




