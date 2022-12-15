create table Lop(
MaLop char(5) not null primary key,
TenLop nvarchar(20),
SiSo int)
create table Sinhvien(
MaSV char(5) not null primary key,
Hoten nvarchar(20),
Ngaysinh date,
MaLop char(5) constraint fk_malop references lop(malop))
create table MonHoc(
MaMH char(5) not null primary key,
TenMH nvarchar(20))
create table KetQua(
MaSV char(5) not null,
MaMH char(5) not null,
Diemthi float,
constraint fk_Masv foreign key(MaSV) references sinhvien(MaSV),
constraint fk_Mamh foreign key(MaMH) references Monhoc(MaMH),
constraint pk_Masv_Mamh primary key(Masv, mamh))
insert lop values
('a1','CNTT01',30),
('a2','CNTT02',32),
('a3','CNTT03',31),
('a4','CNTT04',28)
insert sinhvien values
('SV1','Thao Quyen','2002-4-12','a4'),
('SV2','Que Tran','2001-12-12','a4'),
('SV3','Phuong Trinh','2002-12-12','a4')
insert monhoc values
('TCC','Toan cao cap'),
('CSDL','Co so du lieu'),
('PPT','Phuong phap tinh'),
('LTW','Lap trinh Web')
insert KetQua values
('SV1','TCC',8),
('SV2','PPT',8),
('SV3','LTW',8),
('SV1','CSDL',10),
('SV2','TCC',9)
--Cau1--
go
create function diemtb (@msv char(5))
returns float
as
begin
 declare @tb float
 set @tb = (select avg(Diemthi)
 from KetQua
where MaSV=@msv)
 return @tb
end
go
select dbo.diemtb ('SV1')
--Cau2--
go
create function tdtb(@malop char(5))
returns table
as
return
 select s.masv, Hoten, trungbinh=dbo.diemtb(s.MaSV)
 from Sinhvien s join KetQua k on s.MaSV=k.MaSV
 where MaLop=@malop
 group by s.masv, Hoten
--cách 2
go
create function tdtb1(@malop char(5))
returns @dsdiemtb table (masv char(5), tensv nvarchar(20), dtb float)
as
begin
 insert @dsdiemtb
 select s.masv, Hoten, trungbinh=dbo.diemtb(s.MaSV)
 from Sinhvien s join KetQua k on s.MaSV=k.MaSV
 where MaLop=@malop
 group by s.masv, Hoten
 return
end
go
select*from tdtb1('SV2')
--Cau3

go
create proc svt @msv char(5)
as
begin
 declare @n int
 set @n=(select count(*) from ketqua where Masv=@msv)
 if @n=0
 print 'sinh vien '+@msv + 'khong co thi'
 else
 print 'sinh vien '+ @msv+ 'thi '+cast(@n as char(2))+ 'mon'
end
go
exec svt 'SV1'

--Cau4
go
create trigger capnhatsiso
on Sinhvien
for insert
as
begin
 declare @cn int
 set @cn=(select count(*) from sinhvien s
 where malop in(select malop from inserted))
 if @cn>10
 begin
 print 'Lop du '
 rollback tran
 end
 else
 begin
 update lop
 set SiSo=@cn
 where malop in (select malop from inserted)
 end
 go