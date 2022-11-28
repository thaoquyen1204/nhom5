
/**nhapten**/
create procedure usp_XuatTen
@ten nvarchar (20)
as
begin
print N'Xin Chào ' + @ten;
end
go
exec usp_XuatTen N'Thảo Quyên'
/**tinh tong**/
go
create procedure tinh1 @s1 int,@s2 int
as
begin
declare @tong int;
set @tong=@s1+@s2;
print N'tong la:'+ str(@tong)
end
go
exec tinh1 5,4
/**tong so chan**/
go
create procedure tinhtong12 @n int
as
begin
declare @A int,@tong int
set @A=1
set @tong=0
while(@A<=@n)
	begin
		if(@A%2=0)
			begin
				select @tong=@tong+@A
			end
		set @A+=1
		end
	print 'tongla'+str(@tong)
	end
go
exec tinhtong12 4
/** cau 2**/
go
create procedure ThongtinNV1 @MANV nvarchar(9)
as 
begin 
select * from NHANVIEN where MANV=@MANV
end
go
exec ThongtinNV1 '005'
/**b**/
go
create procedure soluong123 @MADA nvarchar(9)
as 
begin 
select MADA,COUNT(*) AS SOLUONG
from DEAN ,NHANVIEN
where MADA=@MADA and PHG=PHONG 
GROUP BY MADA
end
go
exec soluong123 '20'
