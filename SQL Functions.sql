--User Defiend Functions
--1)Sclar Func.
--2)In-Line table valued Func.
--3)Multistatment table valued Func.

--Return ve returns anahtar kelimleri kullan�l�r.
--Geriye mutlaka de�er d�nd�r�rler

--Functionlar'da bri database nesneleri olduklar�ndan dolay� DDL (ALTER,DROP,CREATE) Olarak y�neltilir.
--Functionlar parametre alabilir yada almayabilir.
--Functionlar subquery'ler i�erisinde kullan�labilir.Fakar stored procedure'de herhangi bir 
--Scalar ve Table valued functionlarda sadece select ile sorgu kullan�l�r.

--1.Scalar Function--

--Dbo'suz kullan�lamazlar.Scheabinding parametresi ile olu�turulan yap�lar kullan�lan tablo isimleri'de dbo'suz kullan�lmazlar.

--Dbo=> DataBase Owner
--Beggin - end scoplar� kulan�lmal�d�r.
--Tan�mlama 

Create function KDVliFiyatHesapla
(@Tutar money ,@oran float)
returns money
as
		begin
				return (@Tutar*(1+@oran))
		end

--Kullan�m�
select dbo.KDVliFiyatHesapla(124.12,0.18)

use Northwind
Select ProductID,UnitPrice,dbo.KDVliFiyatHesapla(UnitPrice,0.08) as 'Kdv''li Tutar '
from Products

--Bug�n� tarihini d�nen bir scalar fonksiyon yaz�n�z.

Create function BugunTarihi()
returns date
as
	begin
		return getdate()
	end

select dbo.BugunTarihi() as Tarih

--Kategori �d bilgisi alan ,ald��� bu kategoriden kar oran�n� g�steren functions yaz�n�z.
--()

create function KategorIdSat�lanUrunSay�s�(@cat�d int)
returns int
as

	begin
	return
	(
	select sum (od.Quantity)
	from [Order Details] od
	join Products p on p.ProductID=od.ProductID
	where p.CategoryID = @cat�d
	)
	end



--Test ��lemi.
	select dbo.KategorIdSat�lanUrunSay�s�(1)

--Urun eklenirken categoryid bilgisi girilmemi� ise default olarak others isimli kategoriye ekleyiniz.
insert table


--
create function DefautCategory()
returns int
as
	begin
	return
	(
		select CategoryID from Categories
		where CategoryName ='othersd'
	)
	end

select dbo.DefautCategory()


alter table Products 
add constraint dv_CategoryID default dbo.DefautCategory() for CategoryID

--inceleme i�in;
select CategoryID from Products where ProductName=' '

-----------
create function TarihFormatla --dmy,mdy,ymd
(
@tarih datetime,@ayrac char(1),@format char(3)
)
returns nchar(10)
as 
	begin
		declare @yil nchar(4)=year(@tarih)
		declare @ay nchar(2)=month(@tarih)
		declare @gun nchar(2)=day(@tarih)
		declare @formatlitarih nchar(10)

		if LEN (@gun)=1
			set @gun='0'+@gun
		if LEN (@ay)=1
			set @ay='0'+@ay
		if @format='dmy'
			set @formatlitarih=@gun+@ayrac+@ay+@ayrac+@yil
		else if @format='mdy'
			set @formatlitarih=@ay+@ayrac+@gun+@ayrac+@yil
		else if @format='ymd'
			set @formatlitarih=@yil+@ayrac+@ay+@ayrac+@gun
		return  @formatlitarih
	end

------------------TEST--------------------
SELECT dbo.TarihFormatla(GETDATE(),'&','dmy')
SELECT dbo.TarihFormatla(GETDATE(),',','mdy') 
SELECT dbo.TarihFormatla(GETDATE(),'/','ymd') as Tarih

--2.In-Line Table Valued Functions 
--Sadece select srogularda kullan�labilir.
--Geriye bir tablo d�nd�r�lce�inden dolay� returns table denir.
--Begin -end dbo part'na ihtiyac yok.

create function KatUrunler 
(
@catId int
)
returns table
as
	return(select ProductName,CategoryID from Products where CategoryID=@catId)

----------TEST-----------
select * from KatUrunler(1) WHERE ProductName Like 'c%'

--CategoryID sini alm�� oldu�unuz
--ProductName,CategoryName,CategoryID,SupplierID

Create function KatUrunler_2
(@catid int)
returns table
with encryption
as
		return
		(
		select ProductName,c.CategoryName,p.CategoryID,SupplierID
		from Products p
		join Categories c on c.CategoryID=p.CategoryID
		where c.CategoryID=@catid
		)
----Test----
select * from KatUrunler_2(1)

select 
k.ProductName,s.CompanyName
from KatUrunler_2(1) k
join Suppliers s on s.SupplierID=K.SupplierID

--MultiStatement table valued function----

-- Bu function lar i�erisnde insert,update,delete durumlar� kullan�labilir.
--Yine geriye bir tablo d�ner .fakat bu tabloyu tan�mlamam rame'e yere�tirmem.
--Tan�mlad���m tablom local yada global bir de�i�ken olabilir.

--Tan�mla 
Create function Kisilerim (@tip nvarchar(7))
returns @tablom table
(
Id int,
isim nvarchar(50)
)
as
	Begin 
		if @tip='ad'
			begin
				insert @tablom select EmployeeID,FirstName from Employees
			end

	else if @tip='adsoyad'
		begin
			insert @tablom select EmployeeID,FirstName+' '+LastName from Employees

		end

			return
					End

select * from Kisilerim('ad')

-----Pivot Sorgular----

select 
ShipVia,COUNT(*) as SiparisAdet
from Orders
group by ShipVia

---Pivotlu--
select * from 
(
select 
ShipVia,COUNT(*) as SiparisAdet
from Orders
group by ShipVia
)as tbl
pivot --->> Sat�r bazl� sonucu st�n bazl� yapar.
(
sum(SiparisAdet)
for ShipVia in ([1],[2],[3])
)as ptbl

--System Procedure 

--Sp_ExecuteSql =>> G�ndermi� oldu�unuz nvarchar,varchar,char(Strinler) sorgular�n� al�r �al��t�r�r.

declare @query nvarchar(50)='Select * from categories'
exec sp_executesql @query
--
declare @kolonadi nvarchar(max)
declare @sorgu nvarchar(max)
select @kolonadi = IIF (@kolonadi is null,'',@kolonadi+',')+QUOTENAME(ShipperID)from Shippers

--IIF :Mant�ksal ifade sonucunda d�necek olan duurmlardan birinin geriye d�nd�r�lmesini 
--sa�layan yap�.

set @sorgu = 'select * from (
select s.ShipperID,COUNT(*) as SiparisAdet
from Orders o inner join Shippers s
on s.ShipperID=o.ShipVia
group by s.ShipperID
)as tbl 
pivot
(
sum (SiparisAdet) for ShipperId in ('+@kolonAdi+')
)as ptbl
'
exec sp_executesql @sorgu

select QUOTENAME(ShipperID) from Shippers --K��eli Parantez

------Denemeler---
select * from (
select 
IIF (T�tle is null,'Departman belii degil',title) as Title,
COUNT(*) as Calisansayisi
from Employees
group by title 
)as nTable
pivot
(
sum(Calisansayisi)
for title in (
[Sales Representative],
[Vice President, Salese],
[Sales Manager],
[Inside Sales Coordinator],
[Bilgi Icermiyor])
)
as pvTable

