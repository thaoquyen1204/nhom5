create function fsoluong_mnv1 (@ma_nhan_vien NVARCHAR(9))
returns int
as
begin 
return (select year(getDate())-(year(NGSINH)) AS TUOI
FROM NHANVIEN
where MANV like @ma_nhan_vien);
end
go
print 'so tuoi la:'+convert( varchar, dbo.fsoluong_mnv1('002'))

/**2**/
go
create function fsoluong_dean1 (@ma_nhan_vien nvarchar(9))
returns int
as
begin
return (select count(MADA)as soluong from PHANCONG
where MA_NVIEN LIKE @ma_nhan_vien
);
END
GO 
PRINT ' SO DE AN LA:'+CONVERT (VARCHAR, dbo.fsoluong_dean1('001'))
/**3**/
go
create function fgioi_tinh (@phai nvarchar(4))
returns int
as
begin
return (select count(MANV)as soluong from NHANVIEN
where PHAI LIKE @phai
);
END
GO 
PRINT ' SO LUONG NHAN VIEN LA:'+CONVERT (VARCHAR, dbo.fgioi_tinh('Nam'))
/**4**/
GO
GO
CREATE FUNCTION fMaNV_LTB (@TenPhong nvarchar(30))
RETURNS INT
BEGIN
RETURN (
	SELECT AVG(b.luong) 
	FROM PHONGBAN a
	INNER JOIN NHANVIEN b ON a .MAPHG = b.PHG
	WHERE TENPHG LIKE '%' + @TenPhong + '%'
)
END
GO
/**5**/
GO
CREATE FUNCTION fde_an(@MaPhg int)
RETURNS @dean TABLE (TenPhong nvarchar(15), TenTruongPhong nvarchar(30), SoLuongDeAn int)
AS
BEGIN
	INSERT INTO @dean
	SELECT a.TENPHG, b.HONV + ' ' + b.TENLOT + ' ' + B.TENNV, 
	(SELECT COUNT (c.MADA) FROM DEAN c WHERE c.PHONG = a.MAPHG)
	FROM PHONGBAN a
	INNER JOIN NHANVIEN b ON a.MAPHG = b.PHG;
	RETURN;
END
/**cau 2**/
/**1**/
go
create view NV_DD
as 
select HONV,TENLOT,TENNV,DIADIEM
FROM NHANVIEN inner join DIADIEM_PHG on NHANVIEN.PHG=DIADIEM_PHG.MAPHG
GO
SELECT*FROM NV_DD
/**2**/
go
create view TNV_TUOI
as 
select HONV,TENLOT,TENNV,LUONG, year(getDate())-(year(NGSINH)) AS TUOI
FROM NHANVIEN 
GO
SELECT*FROM TNV_TUOI
/**3**/
GO
CREATE VIEW VW_PB(TENPHONGBAN,HOTENTP,SLNV)
AS
SELECT  TENPHG, COUNT(NV.MANV),CONCAT(TP.HONV,'',TP.TENLOT, '',TP.TENNV)
FROM NHANVIEN AS NV INNER JOIN PHONGBAN  ON PHONGBAN.MAPHG=NV.PHG
INNER JOIN NHANVIEN AS TP ON TP.MANV=PHONGBAN.TRPHG
GROUP BY TENPHG,TP.TENNV,TP.HONV,TP.TENLOT
ORDER BY COUNT (NV.MANV) DESC
SELECT * FROM PHONGBAN 
SELECT * FROM NHANVIEN

SELECT * FROM VW_PB




