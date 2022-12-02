create trigger kiem_tra_luong 
on NHANVIEN 
for insert,UPDATE
as
if(select LUONG from inserted)<15000
begin
print 'Tien luong toi thieu lon hon 15000'
rollback transaction ;
end;
go
DECLARE @TUOI INT
SET @TUOI=YEAR(GETDATE())-(SELECT YEAR(NGSINH) FROM INSERTED)
if(@TUOI<18 OR @TUOI>65)
begin
print 'DO TUOI PHAI NAM TRONG 18-65'
rollback transaction ;
end;
GO
create trigger kiem_tra_diadiem  
on NHANVIEN 
for UPDATE
as
if(select DCHI from inserted) like '%TP HCM%' 
begin
print 'khong duoc cap nhat nhan vien o hcm'
rollback transaction ;
end;
/** BAI 2**/
GO
create trigger DEM_NV 
on NHANVIEN 
AFTER INSERT
as
begin
DECLARE @NAM INT, @NU INT;
SELECT @NAM=COUNT(MANV) FROM NHANVIEN WHERE PHAI = N'NAM' 
SELECT @NU=COUNT(MANV) FROM NHANVIEN WHERE PHAI = N'NU'
print 'TONG NHAN VIEN NAM '  + cast(@NAM as varchar);
print 'TONG NHAN VIEN NU ' + cast(@NU as varchar);
end;

GO
create trigger NOUPDATE_PHAI 
on NHANVIEN 
AFTER UPDATE
as
if (select top 1 PHAI FROM deleted) != (select top 1 PHAI FROM inserted)
begin
DECLARE @NAM INT, @NU INT;
SELECT @NAM=COUNT(MANV) FROM NHANVIEN WHERE PHAI = N'NAM' 
SELECT @NU=COUNT(MANV) FROM NHANVIEN WHERE PHAI = N'NU'
print 'TONG NHAN VIEN NAM '  + cast(@NAM as varchar);
print 'TONG NHAN VIEN NU ' + cast(@NU as varchar);
end;

GO
create trigger DEM_DE_AN
on DEAN
AFTER DELETE
as
begin
SELECT MA_NVIEN, COUNT(MADA) AS ' TONG SO DE AN'
FROM PHANCONG
GROUP BY MA_NVIEN
end;
GO
 
 CREATE TRIGGER XOA_NV_THANNHAN
 ON NHANVIEN
 INSTEAD OF DELETE
 AS
 BEGIN
 DELETE FROM THANNHAN WHERE MA_NVIEN IN
 (SELECT MA_NVIEN FROM deleted)
DELETE FROM NHANVIEN WHERE MANV IN
(SELECT MANV FROM deleted)
end
go
CREATE TRIGGER them_nv_da1
 ON NHANVIEN
 INSTEAD OF insert 
 AS
 BEGIN
 insert into PHANCONG values ((select manv from inserted), 1,2,20)
END



