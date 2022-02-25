--Sp (Stored Procedure) 


--Genel �zellikler: 

--Normal sorgulardan daha h�zl� �al���r.
--��nk� normal sorgular  execute edilerken "Execute plan "i�lemi yap�l�r. Bu i�lem s�ras�nda hangi tablodan veri �ekilce hangi kolondan veri �ekilcek ,hangi kolondan gelecek,bunlar nerden gelecek.
---Bir sorgu her �al��t�r�ld���nda bu i�lemler yukar�da bahsetti�im gibi devam eder.ve siz her her execute etti�inizde bu i�lemler tekrarlan�r.
---Fakat sorgular�n�z� store procedure olarak  �al��t�r�san�z. Bu execu�te plan denilen i�lem sadece bir kere yap�l�r ve buda ilk �al��ma zaman�nda olur.
--Di�er .al��malarda bu i�lemler yap�lmaz.
--Bundan dolay� h�z performans art��� sa�lan�r..
--��erisinde select ,insert ,update ,delete i�lemlerini yapabilirisiniz.
--i� i�e kullanabilirisiniz.
--i�lerinde function 'lar olu�turulabilir.
--Sorgular�m�z�n d��ardan alaca�� de�erler parametre olarak  store procedure'lere ge�irilebildi�inden dolay� sorgular�m�z�n "sql injection " yemelerinin �n�ne ge�ilmi� olur.Bu y�n�yle de g�venlidir. 
--Stored Procedure fiziksel bir veri taban� nesnesidir. Bu neden le create komutu ile olu�turulur.
--Fziksel olarak ilgli veri taban�na "Programmbility"=>>>>"Stored Procedure " kombinasyonu ile eri�ebilirsiniz.
--Taslak---
--Create  proc yada procedure [isim]
--(
--varsa parametreler. 

--)As
--Yaz�lacak sorgu,kodlar,�artlar,fonksiyonlar,komutlar

Create proc sp_ornek
(
@Id int --Aksi belirtilmedi s�rece bu yap�n�n parametre yap�s� inputtur.
)As

select * from Employees where EmployeeID =@Id

--Dikkat 
--Prosed�r�n parametrelerinin tan�mlarken parantez kullanmak zorunlu de�idlidr. 
--Ama ba�lag�n�ta okunabilirli�i artt�rmak i�in kullanman�z �nerilir. 

Create Proc sp_Ornek2
@Id int,
@Parametre2 int ,
@Parametre3  nvarchar(max)
as 
select * from Employees where EmployeeID =@Id

--Stored Procedures Kullan�m�

--Stored procedure yap�lar�n�n "exec" komutu ile �al��t�rabilrirsiniz.

exec sp_ornek 3

exec sp_Ornek2 5,80,'Bilge Adam '
----==Geriye de�er d�nd�ren Stored Procedure yap�s�.

Create proc  UrunGetir 
(
@Fiyat money 

)
As
select * from Products where UnitPrice>@Fiyat 

return @@Rowcount --Yukar�da yap�lan i�lemde ka� sat�r eklendi�ini bize d�nd�recek.

exec UrunGetir 90
---Bu �ekilde  geriye d�n�len de�eri elde etmeksiniz kullanabilisin.

Declare @sonuc int 
exec @sonuc= UrunGetir 50
print  cast(@sonuc as nvarchar(max))+'Adet kadar �r�n bu i�lemden etkilendi...' 
--Yukar�da  yap�lan i�lem neticeisnde d�nen de�eri  de�i�ken �zerine aktard�k print ile bast�k. Nvarchar cast ettik.

---==Output ile de�er d�nd�rme==
create proc sp_ornek3
(
@Id int,
@Adi nvarchar(Max)  output, --output parametere i�erisindeki de�eri d��ar� g�ndermek i�in kullan�l�r.
@Soyadi nvarchar(max) output

)
as 
select 
@Adi=FirstName, @Soyadi=LastName 
from 
Employees  where EmployeeID =@Id

--Kullan�m� 

Declare @Adi nvarchar (max),@Soyadi nvarchar(max)

exec sp_ornek3 3,@Adi output ,@Soyadi output

select @Adi+' '+@Soyadi

create proc sp_ornek4
(
@Fiyat money,
@Adi nvarchar(Max)  output --output parametere i�erisindeki de�eri d��ar� g�ndermek i�in kullan�l�r.
)
as 
select 
@Adi=ProductName
from 
Products  where UnitPrice >  @Fiyat
Declare @Adi nvarchar (max)
exec sp_ornek4 50,@Adi output 
select @Adi

create proc sp_category

(@unitPrice money, 
@categoryName nvarchar(max) output
)
as
select @categoryName = CategoryName 
from Products
join Categories C
on C.CategoryID = ProductID
where Products.UnitPrice > @unitPrice

declare @category nvarchar(max)
exec sp_category 50, @category output
select @category

--�rnek: 
--D��ar�dan ald�� isim soyisim ve sehir bilgilerini Personller tablosundaki ilgili kolonlara ekleyen  stored Procedure yaz�n�z.

create Proc sp_PersonelEkle
(
@Ad nvarchar (Max),
@Soyad nvarchar (max),
@sehir nvarchar(max)
)
as

insert Employees (FirstName,LastName,City) values ( @Ad,@Soyad,@sehir)

exec sp_PersonelEkle 'AHMET','DEN�Z','Ankara'

select * from Employees


--==Parametrelere Varsay�lan de�er atama==

Create Proc sp_personelEkle2
(
@Ad nvarchar (Max) ='test',
@Soyad nvarchar(Max)='test',
@Sehir nvarchar(Max)='test'
)
as 
insert Employees(FirstName,LastName,City)values (@Ad,@Soyad,@Sehir)

exec sp_PersonelEkle 

--PRODUCT TABLOSUNA �R�N ADI ,F�YATI _CATEGORY �D B�LG�LER�N� EKLEYEN B�R SP YAZINIZ.

CREATE PROCEDURE [Urunekle]
--create proc
(
@UrunAd nvarchar (20),
@BirimFiyat money ,
@KatId int 
)
as 

insert Products(ProductName,UnitPrice,CategoryID)
values (@UrunAd,@BirimFiyat,@KatId)
EXEC Urunekle 'Ananas',3,11
execute Urunekle 'portakal',5,11
Urunekle 'portakal',5,11
--Parametre isimlerini biliyorsan�z ,Bu �ekilde s�ray� �enmsemeden doldurabilirisiniz.
exec Urunekle @KatId=5,@UrunAd='test',@BirimFiyat=3 

--Ayn� parametreleri ve productId parametresini kullanarak �r�nleri update etmek i�in bir sp yaz�n�z.

Create proc UrunGuncelle

(
@UrunAd nvarchar(20),@BirimFiyat money,@KatId int ,@UrunId int
)
as

	Update Products
	set ProductName =@UrunAd ,UnitPrice =@BirimFiyat,CategoryID =@KatId
	where ProductID=@UrunId

exec UrunGuncelle 'Ceviz',4,8,82

select * from Categories

insert Categories (CategoryName) values('Others')

create Proc KategoriKontrolluUrunEkleme
(@Ad nvarchar(50),@fiyat money,@KatId int ,@Stok int)
as
declare @enBuyukKatId int
select  @enBuyukKatId= MAX(CategoryID) from Categories
if @enBuyukKatId<@KatId
	begin 
		print'Girdi�iniz de�erde kategori bulunmad��� i�in kategori idsi 12 olarak others adan�ndaki categori olarak d�zenlendi..'
		set @KatId=12
	end	

	insert Products (ProductName,UnitPrice,CategoryID,UnitsInStock) 
	values(@Ad,@fiyat,@KatId,@Stok)

--�al��t�rma K�sm� 

exec KategoriKontrolluUrunEkleme 'Bilgisayar',4,30,44
-----------------------------------------------------------------

---�r�n �d 'ye g�re Ad getiren sp yaz�n�z.
create  proc UrunIdyeGoreGetir 
(
@Id int 
)
with encryption
as
select ProductName from 
Products
where  ProductID=@Id

declare @urunAd nvarchar(50),@id int =4 
exec @urunAd = UrunIdyeGoreGetir @id

--print Cast(@id as nvarchar )+'numaral� arad���n  �r�n'+ @urunAd




























