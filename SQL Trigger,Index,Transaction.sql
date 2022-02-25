create proc ShipperInsert

(
@cn nvarchar (50),
@p nvarchar (20),
@shipperId int  output 
)
as 
insert Shippers(CompanyName,Phone)
values(@cn,@p)
SET @shipperId =@@IDENTITY
---1.y�NTEM 

DECLARE @shipper_Id int 
exec ShipperInsert 'AhmetKargo','5454235545',@shipperId=@shipper_Id output
select @shipper_Id

---2.Y�ntem 

Declare @shipper_Id int 
exec ShipperInsert 'MehmeTKargo','45235456423123',@shipper_Id output
select @shipper_Id

---Triggers (Tetikliyiciler)

--===Dml Triggers === 
---Bir tabloda insert ,update ve delete i�lemleri ger�ekle�ti�inde devreye giren yap�lar. ..

----�nserted Table 
---E�er bir tabloda insert i�lemi yap�l�yorsa arka planda i�lemler ilk �nce ram 'de olu�turulan  inserted  isimli bir  tabloya eklenir .E�er i�lemde   bir problem ��kmaz ise inserted tablosundaki verileri gidip,  ilgli tabloya insert eder. .... ��lem bitti�inde  olu�turulan inserted tablosu silinir. ...


---Deleted table 

--E�er bir tabloda delete i�lemi yap�l�yorsa  i�lemler ilk �nce ram'de olu�turulan deleted isimli bir tabloya yaz�l�r.E�er i�lemde herhangi bir problem olmaz ise fiziksel tabloda delete i�lmei ger�ekle�ir...Fiziksel silme eylemi ger�ekle�ti�inde ram �zerinde bulunan deleted tablosuda silinecektir...

---E�er bir tobloda update i�lemi yap�l�yor ise ramde updateed isimli tablo olu�turulmaz!!!!!....
--Sql serverda g�ncelleme mant��� �u �ekilde �al���r. .�nce silinir (delete) ,Sonra eklenir (�nserted)

--E�er bir tabloda update i�lemi ger�ekliyor ise iki tablo birden olu�turulur...
--Not: Update yaparken g�ncellenecek olan kayd�n orjinali deleted tablosunda ,g�ncelledendikten sonraki hali ise inserted tablosunda bulunur...
--��NK� G�NCELLEMEK DEMEK KAYDI �NCE S�LMEK SONRA EKLEMEK DEMEKT�R.. 

-----==Trigger Tan�mlama==-----
--Create Trigger [TriggerAd�] 
--on  [��lem yap�lak olan tabload�]
----After --- veya insert,update,delete 
--as 
--[Kodlar ]

--Dikkat 
--Tan�mlanan Triggerlara ilgili tablonun i�erisindeki tirggers sekmesi alt�ndan eri�ebilirisiniz. 

Create trigger OrnekTrigger
on employees
after insert 
as 
select * from Employees


insert Employees (FirstName ,LastName) values ('test1','test2') 


-----�rnek 
--Tedarik�iler tablosundan bir veri silindi�inde t�m �r�nlerin fiyat� otomatik olarak 10 arts�n..
create trigger triggertedarikciler
on suppliers
after delete 
as 
update urunler set UnitPrice = UnitPrice +10 
select * from Products
----
Delete from Suppliers where SupplierID=31
--�rnek2 
---Region tablosundaki bir veri g�ncellend�inde ,Kategoriler tablosunda "K�r�m�z� et " ad�nda bir kategori olusssun...

Create Trigger trgTedarikGuncellendig�nde
on Region 
for update

as 
insert  Categories(CategoryName) values ('K�r�m�z� et')




update Region set RegionDescription='G�ney' where RegionID=5


----------


Create Table LogTablosu 
(
Id int primary key identity (1,1),
Rapor nvarchar(max)

)


Alter Trigger triggerPersoneller 
on employees 
after delete 
as 
Declare @Adi nvarchar(max),@Soyadi nvarchar(max)
select @Adi =FirstName ,@Soyadi=LastName
from deleted
insert LogTablosu values ('Ad� +Soyad� '+ @Adi+'  '+@Soyadi+'Olan personel '+ SUSER_SNAME()+'Taraf�ndan'
+cast(GETDATE()as nvarchar(max) )+'Taraf�ndan silinmi�tir')



delete from Employees where EmployeeID =13
--suser_sname() =>>> O anki server �zerindeki aktif olan kullan�c�n bilgilerini getiren fuction�n ad� ..

----------------------------------------------------------------------------------------------------------
---Ornek 4 
--Personeller tablosunda ger�ekle�ti�i anda devreye giren  ve bir lof tablosuna "Ad�..... olan personel......yeni ad�yla de�i�tirilerek...kullanc�s� taraf�ndan..... tarhinde g�ncelenmi�tir..."


Create Trigger trgPersonellerRapor
on employees
after update 
as 
declare @eskiad nvarchar(max),@yeniad nvarchar(max)
select @eskiad= FirstName  from deleted
select @yeniad = FirstName from inserted
insert  LogTablosu values ('Ad�'+ @eskiad +'Olan personel'+@yeniad+ 'yeni ad� ile de�i�tirilecek '+SUSER_SNAME()+'Kullan�s� taraf�ndan '+ CAST (GETDATE() as nvarchar(max))+'tarhinde g�ncellendi')



update Employees set FirstName ='Mehmet'   where  EmployeeID =12





---==Multiple Actions Triggers==-----
--Birden fazla aksiyonu tetiklemek i�in kullan�l�r ...

Create Trigger MultiTrigger
on  employees 
after delete ,insert 
as 
print 'Trigger �al��ma i�lemini tamamlad� ...'



insert Employees (FirstName ,LastName) values ('test1','test2')
Delete  from Employees where  EmployeeID= 16


--Instead of trigger 
--�uana kadar insert ,update ,delete i�lemleri yap�l�rken  �u � i�lemleri yap mant��� ile �al��t�k (yan�nda da sunu yap.) 
--�nstead of triggerlar da ise insert update delete i�lmelerinin yerine �u i�lemleri yap diece�iz...(Yerine �unu yap) 


--Create Trigger (Tiriggerad�)
--on tabload�
--instead of delete,update,insert
--as 
--komutlar 

---Personller tablosunda update i�lemi ger�ekle�ti�i anda yap�lacak olan g�ncelle�itrme yerine bir log tablosuna "Ad� ..olan personel ... yeni ad� ile de�i�tirielecek.... kullan�s�s� taraf�ndan .... tarhiinde  g�ncellenmek istendi.." kal�b�nda rapor verin 

Create Trigger trgPresonellerRaporInstead
on 
employees 
instead of update

as

declare @eskiad nvarchar(max),@yeniad nvarchar(max)
select @eskiad= FirstName  from deleted
select @yeniad =FirstName  from inserted
insert  LogTablosu values ('Ad�'+@eskiad+'olan personel'+@yeniad+'Yeni adi ile de�i�tirilecek'+SUSER_NAME()+'Kullan�c�s� taraf�ndan '+CAST (GETDATE()as nvarchar(max))+'tarihinde g�ncellenmek istendi..' )

-----------------------------------
Update Employees set FirstName= 'Adam1Bilge' where EmployeeID =15


--�rnek 6 
--Personeller tablosunda  ad� "Andrew"olan kayd�n silinmesini engelleyen  ama di�erlerine izin veren trigger� yaz�n�z?

---DDL- Trigger
--Create ,alter ve drop i�lemleri sonucunda ve s�recinde devreye girmenizi sa�layan yap�d�r.

--triggerlar--

--personeller tablosunda ad� 'Andrew' olan kay�d�n silinmesini engelleyen 
--ama di�erlerine izn veren triggeri yaz�n�z

create trigger AndrewTrigger
on employees
after delete
as
declare @adi nvarchar (max)

select
@adi=FirstName
from deleted
if @adi='Andrew'
	begin	
		print 'Bu kay�d� silemezsin'
		rollback --yap�lan t�m i�lemleri geri al�r..
 end

 delete from Employees where EmployeeID=10

 --DDL-- Trigger

--create ,alter ve drop i�lemleri sonucunda ve s�recinde devreye girmenizi sa�layan yap�d�r.

create trigger DDL_Trigger
on Database
for drop_table ,alter_table,create_function,create_procedure --vs.
as print 'BLABLAB'
rollback

--programmability => DatabaseTriggers klas�r�nde olu�ur.

--Trigger devre d��� b�rakma:
disable trigger DDL_Trigger on database
--Trigger aktifle�tirme
enable trigger DDL_Trigger on database

--c# 'da event yap�s�na benzer

--Sipari� verdi�imde sipari� verdi�im miktar kadar stoktaki miktardan d���n.

create trigger StokGuncelleme 
on[Order Details]
after insert
as 
	declare @satilanurunid int,@satilanmiktar int
	select @satilanurunid=ProductID,@satilanmiktar=Quantity
	from inserted

		update Products set UnitsInStock-=@satilanmiktar
		where ProductID=@satilanurunid

		select * from Products

insert [Order Details]
(OrderID,ProductID,UnitPrice,Quantity,Discount)
values (10526,4,18,3,0)

alter trigger StokEkleC�kar
on [Order Details]
after update
as
declare @ProId int,@EskiMiktar smallint,@YeniMiktar smallint
select @ProId=ProductID, @EskiMiktar=Quantity
from 
deleted 
select @YeniMiktar=Quantity
from 
inserted

update Products set UnitsInStock +=(@EskiMiktar-@YeniMiktar)
where ProductID =@ProId


select * from Products
select * from [Order Details]

update [Order Details] set Quantity =19 
where OrderID=10248 and ProductID=1

create trigger mesajver
on [Order Details]
for insert ,update,delete
as 
	if (Exists(select * from inserted) and exists(select * from deleted))
	print 'Update i�lemi ba�ar� ile ger�ekle�ti'
	else if (Exists(select * from inserted) )
	print '�nsert i�lemi ba�ar�l�'
	else if (exists(select * from deleted) )
	print 'Delete i�lemi ba�ar�l�'

--shippers tablosunda silinen kay�tlar� yedek db'deki kargolar tablosuna yedeklemeye �al���n

create trigger kargoyedekle 
on shippers 
after delete
as 
	declare @cn nvarchar(50),@p nvarchar (50)
	select @cn=CompanyName,@p=Phone from deleted
	insert yedek.dbo.kargolar
	values (@cn,@p)

	select * from Shippers 
	
	delete from Shippers where ShipperID=8
    select * from yedek.dbo.Kargolar

create table logfile
(
Id int primary key identity,
Silenkisi nvarchar (50),
Tarih datetime constraint Dv_Tarih default (getdate())
)

create trigger urunkoruma 
on products
instead of delete
as 
	insert logfile values (SUSER_NAME(),DEFAULT)
	print 'iz kaydedildi'

delete from Products where ProductID=83
select * from Products where ProductID=83

create trigger viewolsuturdu
on database 
after drop_view 
as
	print'View silindi'


drop view Invoices
	--DLL TR�GGERLARDA �NSTEAD OF KULLANILMAZ
alter trigger tabloduzenlemeengel
on database 
after alter_view
AS
	Print 'tabloda de�i�iklik yapamazs�n'
	rollback --instead of'daki gibi geri i�lemi yapmaz.

	disable 

create trigger veritaban�olusturmaengeli
on all server 
for create_database
as
	raiserror('Yetkin yok malesef',16,2)
	rollback

	create database BilgeAdam

disable trigger veritaban�olusturmaengeli on all server
---------------------------Transaction------------------
create database BankaDB
go 
use bankadb
go 
create table Hesap
(
Id int primary key identity ,
Ad nvarchar (50) ,
Bakiye money ,
TcKimlikNo char (11)
)
insert  Hesap
values ('mehmet',100,'12341234'),
('baran',0,'534252345'),
('alper',1000,'123412341')

--transaction kullanmazsak neler olur

begin try
	update Hesap set Bakiye -=200 where TcKimlikNo='123412341'
	raiserror ('elektrikler kesildi',16,2)
	update Hesap set Bakiye +=200 where TcKimlikNo='534252345'

	end try

	begin catch 
	print 'Beklenmedik bir hata meydana gelmi� bulunmakta l�tfen daha sonra tekrar deneyiniz'
	end catch

	--transaction  kullan�larak bu hatan�n �n�ne nas�l ge�ilir inceleyelim.

	begin try
	begin tran --transaction i�lemi ba�lar
	update Hesap set Bakiye-=200 where TcKimlikNo='123412341'
	raiserror ('elektrikler kesildi',16,2) --hata olu�turmak i�in 
	update Hesap set Bakiye+=200 where TcKimlikNo='534252345'
	commit tran --transaciton ba�ar�l� bir �ekilde sonland�r�l�r.
	end try

	begin catch
	print 'Beklenmedik bri hata meydana geldi'

	rollback tran--transaction ba�ar�s�z bir �ekilde sonland�r�l�r.
	--ve yap�lan ba�ar�l� i�lemler geri al�n�r.

	end catch

	insert Hesap 
	values ('Yasin',500,'78987654')

	begin try
	begin tran --transaction i�lemi ba�lar
	update Hesap set Bakiye-=500 where TcKimlikNo='78987654'
	update Hesap set Bakiye+=200 where TcKimlikNo='534252345'
	commit tran --transaciton ba�ar�l� bir �ekilde sonland�r�l�r.
	end try

	begin catch
	print 'Beklenmedik bri hata meydana geldi'

	rollback tran--transaction ba�ar�s�z bir �ekilde sonland�r�l�r.
	--ve yap�lan ba�ar�l� i�lemler geri al�n�r.
	end catch


	------�ndex Yap�s�--------

--sql indexlemenin amac� i�lyen veririn dah azz veri okunarak sorgu sonuncunun dah ak�sa s�rede 
--getirebilmesini sa�lamak.�ndeksleme kullan�larak tablonun tamam�n� okumaktansa olu�turulacak olan index key arac�l��� ile
--okumak ve istedi�imiz kay�da ula�abilmemiz daha h�zl� bir �ekilde m�mk�n olacakt�r.
--bu sayede tamamlanmas� saatler s�ren sorgunu uygun idexler kullan�larak saniyler i�erisinde getirlemeisni a�layabilirsiniz.
--ancak tablomuzda bir g�ncelleme i�lemi uygularsan�z, bu g�ncelleme i�lemi index olmayan tabloya g�re biraz daha uzun s�recektir.

create database IndexDeneme1
go
use Index_deneme1
go
create table kisi
(
id int primary key identity,
ad nvarchar (50),
soyad nvarchar (50),
telno char (11)
)
