create table MonHoc(
MaMon char(5) not null primary key,
TenMon nvarchar(20),
SoTC int)
create table SinhVien(
MaSV char(5) not null primary key,
HoTen nvarchar(30),
NgaySinh smalldatetime)
create table Diem(
MaSV char(5) not null,
MaMon char(5) not null,
Diemthi float,
constraint fk_Masv foreign key(MaSV) references SinhVien(MaSV),
constraint fk_Mamh foreign key(MaMon) references Monhoc(MaMon),
constraint pk_Masv_Mamh primary key(MaSV, MaMon))
 
 go 
 insert into MonHoc values
 ('MM1','Toan Cao Cap',2),
 ('MM2','He Quan Tri Co So Du Lieu',3),
 ('MM3','BigData',3)
 insert into SinhVien values
 ('SV1','Thao Quyen','2002-12-4'),
 ('SV2','Phuong Trinh','2002-2-9'),
 ('SV3','Que Tran','2001-1-2')
 insert into Diem values
 ('SV1','MM1',9),
 ('SV2','MM2',8),
 ('SV3','MM3',10),
 ('SV1','MM2',10),
 ('SV2','MM3',9)
 go

 select *
 from MonHoc

 go

 select *
 from SinhVien

 go
 select *
 from Diem
 -- Cau2

 go
create function tksv (@tmh nvarchar(20))
returns int
as
begin
 declare @dem int
 set @dem = (select count(*)
 from Diem
where @dem<5)
 return @dem
end
go
select dbo.tksv ('Big Data')
--Cau 3
go
create procedure Diem(@MaSV char(5),@MaMon char(5), @DiemThi float)
as
insert into Diem(MaSV,MaMon,Diemthi) values(@MaSV,@MaMon,@DiemThi)
go
Diem 'SV1','MM3',9
--Cau 4
go
create trigger them_sua
on Diem
FOR  INSERT, UPDATE
AS
if(select DiemThi From inserted)>10 and (select DiemThi From inserted)<0
begin
print
'khong cho phep'
rollback transaction
end
insert into Diem
values ('SV1','MM3','2')

