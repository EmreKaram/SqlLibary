
--Not:Sorgular�m�z� yazarken k���k b�y�k harfe dikkat etmenize gerek yoktur.
--E�er ba�lang��ta server ayarlar�nda belirtilmi� ise.

--DML =>> Data Manipulation Language
use Northwind --Northwind veritaban� �zerinde �al���ca��m�z� ve bu veritaban� �zerinde sorgular ataca��m�z� ifade eder .
--Nortwind veritaban� �zerinde  sorgulamalar yapmak i�in bu �ekilde veritaban� se�ilebilir. 
--�steyen yukardaki combobox'� da kullanabilir. 

--Tablo Sorgulama
--select <Sutun_adlar�> (S�t�m adlar� aras�nda virg�l oldu�unu unutmay�n�z.)
--from  <Tabloadi>

--Employess tablosundaki t�m kay�tlar� getrin ....
select * 
from
Employees

--Employes tablosu �zerinde  , �al��anlara ait ,ad,soyad,g�rev,do�um_tarihi bilgisini getirelim. 
select FirstName,LastName,Title,BirthDate
from Employees

select FirstName,LastName,Title,TitleOfCourtesy 
from 
Employees
--St�n isimleri intelisense �zerinden gelmektedir .Bu alandan yard�m alabilrisiniz.  
--Employees tablosu �zerinde st�tunlar� s�r�kle b�rak ile  ekleyebirisin.
--Select (bu alanda intelinsedan destek alabilrisiniz.)  from <tablo ad�> 
--intelisence k�sa yok (ctrl +space) 

select [EmployeeID], [LastName], [FirstName], [Title], [TitleOfCourtesy], [BirthDate], [HireDate], [Address], [City], [Region], [Country], [HomePhone], [Extension], [Photo], [Notes], [ReportsTo], [PhotoPath] 
from
Employees

select  
FirstName as Ad,LastName as soyad,Title as G�rev
from 
Employees 

--Sorgu sonucunda olu�acak olan sonu� k�mesindeki (result set) s�tun isimleri de�i�tirilecektir,
---tablodaki orjinal s�t�n isimlerin de�i�tirilmesi s�z konusu de�ildir. 

--Birden fazla kelimeden olu�an bir s�tun ismi oldu�unda bunu k��eli parantez veya  tek t�rnak i�erisinde  belirtmemiz gerekmektedir. 
--Sql'de metinsel ifadeler tek t�rna i�erisinde belirtilirler. 

--2.Yol
select Ad=FirstName ,soyad=LastName,g�rev=Title,[Do�um Tarihi]=BirthDate
from
Employees
--Tekil kay�t listeleme 
select ad=FirstName ,soyad=LastName,g�rev=Title,'Do�rum tarihi'=BirthDate
from Employees

select city
from 
Employees  --Ayn� �ehirler listelenir. 

select DISTINCT City
from
Employees

select 
City ,FirstName
from
Employees

select distinct
City ,FirstName
from
Employees

--�steki ile ayn� sonucu getirir. Sebebi ise ayn� ad ve �ehir de�erine sahip kay�tlar�n olmamas�d�r.
--E�er FirstName "Steven" ,city =London olan bir ba�ka kay�t daha  girilirse tabloya, bu kay�ttan sadece biri listelenir. 

---Metin Birle�tirmme 

select (TitleOfCourtesy+''+FirstName+''+LastName) as isim
from 
Employees
--(+) Operet�r� ile metinler, birle�tirebiliririz. ...' 'ile araya bo�luk karakteri ekleyebirisin.  E�er as ile isimlendirmeseydim .Tablo ad� NoColomnName olarak g�r�necektir. 

---De�i�kenler--
---1.DE�ER ATAMA Y�NTEM� ...

--declare @Ad nvarchar(70) ,@yas int
--set @Ad='BilgeAdam'
--set @yas =20

--select @Ad ad ,@yas yas

--2.De�er atama y�ntemi 
declare @AdSoyad nvarchar(50) ,@yas int 
select @AdSoyad ='BilgeAdam',@yas =50
select @AdSoyad adsoyad,@yas yas

--print @AdSoyad
--Print Message k�sm�ndan  verir .Select ise tablo d�nd�r�r. 
--aralar�ndaki fark set ile de�er atamada ayn� anda birden fazla de�i�kene de�er atamazken select ile de�er atamas�n� ayn� anda yapan m�mk�nd�r. 

--go 
--S��rama yapmak i�in kullan�l�r .
go 
--Hata verir 
declare @Urunad nvarchar(50)
set  @Urunad = (select ProductName  from Products )
select @Urunad

--Hata vermez 
declare @urunAdi1 nvarchar (50)
set @urunAdi1 =(select ProductName from Products where ProductID =1)
select @urunAdi1

---Hata vermez. Where kullanmazsan�z anlams�z de�erler alm�� olursunuz .   
declare @urunadi2 nvarchar (50)
select @urunadi2=ProductName  from Products
select @urunadi2

declare @urunadi3 nvarchar (50)
select @urunadi3 = ProductName  from Products where UnitsInStock>50
select  @urunadi3

--Sorgular� filitreleme where
--Yazd���m�z sorgular� belirli ko�ullara g�re filitreliyebilmek i�in where c�mleci�inden faydalan�r�z .

--�nvani Mr. olanlar�n listelenmesi 
select FirstName,LastName,TitleOfCourtesy 
from 
Employees
where TitleOfCourtesy ='Mr.'-- Metinsel ifadeler tek t�rnak i�erisnde yaz�l�rlar.

--EmpoyeeId de�eri 5'den b�y�k olanlar� getirin . 

Select EmployeeID ,FirstName,LastName
from
Employees
where EmployeeID>5
-- 1960 y�l�nda do�anlar� listeleyin .
select FirstName,LastName,BirthDate
from
Employees
where YEAR(BirthDate)=1960

--Year (datetime parametre) fonksiyonu bizden datetime tipinde de�er al�r ve geriye int tipinde y�l bilgisini d�nd�r�r.

--1950 ile 1961 y�llar� aras�nda do�anlar� kimler?
select FirstName ,LastName ,BirthDate
from
Employees
where 
 YEAR(BirthDate)>=1950
 and
 YEAR(BirthDate)<=1961

--�ngiltere 'de oturan bayanlar�n adi,soyadi mesle�i,�nvan�, �lkesi  ve do�um tarhini listeleyiniz. (emp)
select (TitleOfCourtesy+' '+FirstName+''+LastName) as isim ,Title as g�rev, [Do�um tarihi]=BirthDate, Country as �lke 
 from 
 Employees
 where Country = 'UK'
 and 
 (TitleOfCourtesy='Mrs.'
 or
 TitleOfCourtesy='Ms.'
 )

 --�nvani Mr. olanlar veya ya�� 60'dan b�y�k olanlar� getiriniz. 
 select(TitleOfCourtesy+' '+FirstName+' '+LastName) as isim  ,YEAR( GETDATE())-YEAR(Birthdate) as yas
 from
 Employees
 where 
 TitleOfCourtesy='Mr.'
or
 YEAR(GETDATE())-YEAR(BirthDate)  >60
--Getdate () fonksiyonu g�ncel tarih bilgisini verir. Year fonksiyonu ile birlikte o tarihe ait olan y�l bilgisini al�yoruz.
--Where ifadesi ile birlikte as ile kendi isimlendirdi�imiz kolon isimleri asla kullan�lmazlar.
--�rne�i yukar�da ya� olarak isimlendird�imiz s�t�n isimini where ile birlikte kullanamay�z.

select Region
from
Employees
--B�lgesi belirtilmeyen �al��anlar� listelenmesi 
select 
TitleOfCourtesy,FirstName,LastName,Region
from Employees 

where  Region IS NULL -- NULL OLAN S�T�NLARI BU �EK�LDE SORGULAYAB�LR�S�N�Z.
--B�LGES� BEL�RT�LEN �ALI�ANLARIN L�STELENMES� 
select TitleOfCourtesy,FirstName,LastName,Region
from 
Employees 
where Region is  not  null
--Null de�er i�ermeyen s�t�nlar�n listelenmesi 
--Not:Null degerler sorgulan�rken  = veya <> operat�rler kullan�lmaz bunu yerine is null veya is not null ifadeleri kullan�l�r. 

--S�ralama i�lemlerine  
select  *
from 
Employees
where 
EmployeeID>2 
and
EmployeeID<=8
order by FirstName asc -- Ascending (artan s�ralama) 

select  FirstName,LastName,BirthDate
from
Employees
order by BirthDate --E�er asc  iafedeisni belirtmezsinizde default olarak artan s�ralama yapacakt�r.Bu sorguda Birthdate kolonuna g�re artan s�ralama yapt�k .

select FirstName,LastName,BirthDate,HireDate
from 
Employees
order by LastName desc --Descending (azalan s�ralama)
--Asc ifadesi say�sal s�t�nlarda k���kten b�y��e ,metinsel ifadelerde a-z  ye do�ru  i�lem yaparken desc 'de ise tam tersi olacak �ekilde i�lem yapacakt�r.
select 
FirstName,LastName
from 
Employees
order by FirstName ,LastName
--Elde etti�imiz sonu� k�mesi ada g�re artan s�rada s�ralnad� . 
--E�er ayn� ada sahip  birden fazla ki�i varsa s�ralamay� vermi� oldu�unuz ikinci kolona g�re yapar.

select  FirstName,LastName,BirthDate,HireDate,Title,TitleOfCourtesy
from 
Employees 
order by 6,4 desc ;
--Soruguda yazd���m�z s�t�nlar�n s�ras�na g�re s�ralama i�lemi yapabilrisiniz. 
--Burada ilk �nce 6.s�radaki s�t�na (titleofCour) artan sirada s�ralama i�lemi ,daha sonrada �nvan de�erine sahip kay�tlar i�in 4.s�radaki (hiredate) s�tununa g�re azalan s�rada s�ralama yap�yoruz. 
--Sql'de indekleme  1'den ba�lar  titleofCourTESY S�T�N� 5.DE��L 6.SIRADADIR. 

--�al��anlar� unvanlar�na(titleofcourtesy) g�re ve �nvanlar� ayn� ise ya�lar�na g�re b�y�kten k����e do�ru s�ralay�n�z.
select  FirstName,LastName,TitleOfCourtesy,(YEAR(getdate())-YEAR(BirthDate)) AS YAS 
from Employees 
where TitleOfCourtesy is not null   
Order by TitleOfCourtesy,YAS desc
--Order By ifadesi ile st�nlara vermi� oldu�unuz takma isimleri kullanbilrisiniz. 
--�rne�in burdaki ya� s�t�ndaki gibi.

--Between-And Kullan�m�:
--Aral�k bildrimek i�in kullan�ca��m�z bir yap� sunar.
---1952-ile 1960 aras�nda do�anlar� listeleyiniz. 
--1.yol
select FirstName,LastName,year(BirthDate) as [Do�um y�l� ]
from
Employees
where YEAR (BirthDate)>=1952
and 
YEAR(BirthDate)<=1960
order by [Do�um y�l� ] desc

---2.yol
select FirstName,LastName,YEAR(BirthDate) as [Do�um y�l ]
from 
Employees
where YEAR(BirthDate) between 1952 and 1960
order by [Do�um y�l ] desc

--Alfabetik olarak janet ile robert aras�nda olanlar� listeleyiniz. 

---1.yol 
select FirstName,LastName
from 
Employees
where 
FirstName between 'Janet' and 'Robert'
order by FirstName  
--2.yol 
select FirstName,LastName
from  Employees
where FirstName>='Janet'
and 
FirstName<='Robert'
order by FirstName

--IN Operat�r� Kullan�m�.
--�nvan� Mr. veya Dr. olanlar�n listelenmesi
-----1.yol
Select  TitleOfCourtesy+' '+FirstName +' '+LastName as isim
from Employees
where TitleOfCourtesy ='Mr.'
or
TitleOfCourtesy ='Dr.'

select TitleOfCourtesy+ ' '+ FirstName+' '+ LastName as isim
from Employees
where TitleOfCourtesy IN('Dr.','Mr.')

--1950,1955 ve 1960 y�llar�nda do�anlar�  listeleyiniz. 
select  FirstName,LastName, year(BirthDate) as Do�umYili 
from Employees
where  YEAR(BirthDate) in (1950,1955,1960)

--Top Kullan�m�

Select * from Employees
--ilk �� kay�t gelsin

select top 3 * from 
Employees

select top 5 FirstName,LastName,TitleOfCourtesy
 from 
 Employees 
 order by TitleOfCourtesy desc

 --Top k�sm� bir sorguda en son �al��an k�s�md�r. 
 --Yani �ncelikle sorgumuz �al��t�ralabilir ve olu�acak olan sonuc k�mesinin (result set) ilk 5 kayd� al�n�r. 
 --�r�nler tablosunu tersten s�rala ilk 10 gelsin.
 --�al��anlar�n ya�lar�na g�re azalan sirada s�ralama yapt�kdan sonra ,olu�acak olan sonuc k�mesinin %25 ' lik k�sm�n� listeleyelim. 

select top 25 percent  FirstName ,LastName ,Title ,(YEAR(Getdate())-YEAR(BirthDate))as Age
from
Employees 
order by Age desc
--E�er  belitti�iniz oran sonucu 3.3 gibi bir say� ��karsa ,bu durumda bize ilk d�rt kayd� getirecektir. Yani Yukar� y�nl� yuvarlama yapacakt�r. 


--Like kullan�m�:
--1.yol
select FirstName,LastName,Title 
from Employees
where 
FirstName ='Michael'

--2.yol
select FirstName,LastName,Title
from 
Employees
where
 FirstName like 'Michael'

--Ad�n�n ilk harfi A ile ba�layanlar� getirin.
select FirstName,LastName,Title
from  Employees
where FirstName like 'A%'

--Ad�  Son harfi N olanlar. 
select FirstName,LastName,Title
from 
Employees
where  FirstName like '%N'

--Ad�n�n i�erisinde e harfi ge�enleri listeleyiniz.
select FirstName,LastName,Title
from 
Employees
where FirstName  like '%E%'
order by 1 desc

--Ad�n�n ilk harfi a veya l olanlar.
select FirstName ,LastName,Title
from Employees 
where 
FirstName like 'A%'
OR
FirstName like 'L%'

--2.yol
SELECT FirstName,LastName,Title
FROM 
Employees
WHERE 
FirstName like '[AL]%'

--Ad�n�n i�erisinde r veya t bulunanlar.

select FirstName,LastName,Title
from 
Employees
where 
FirstName like '%[RT]%'

--Ad�n�n ilk harfi j  ile r aral���nda olanlar. 

select FirstName ,LastName,Title
from 
Employees 
where  FirstName like '[J-R]%'
ORDER BY FirstName 

--Ad� �u �ekilde olanlar: tamer ,yasemin taner (A ile E aras�nda tek karakter olanlar)
select FirstName,LastName,Title
from 
Employees 
where 
FirstName like '%A_E%'

--(A ile E aras�nda iki  karakter olanlar)
select FirstName,LastName,Title
from Employees 
where 
FirstName like '%A__E%' --Alt tire say�s� artar.

--Ad�n�n ilk harfi M olmayanlar...
--1.yol
select FirstName,LastName,Title
from
Employees
where 
FirstName not like 'M%'
--2.yol
select FirstName,LastName,Title
from 
Employees 
where  FirstName like '[^M]%'
ORDER BY 1

--Ad� T ile bitmeyeneler. 

select FirstName,LastName,Title
from 
Employees
where FirstName like '%[^T]'

--Ad�n�n ilk harfinde A ile I arala��n� bulunmayanlar.
--1.Yol
select FirstName,LastName,Title
from 
Employees 
where 
FirstName not like '[A-I]%'

--2.Yol 
select FirstName,LastName,Title
from 
Employees
where 
FirstName like '[^A-I]%'
ORDER BY 1;

use Northwind

--Ad�n�n 2.harfi a veya t olmayanalar.
select FirstName,LastName,Title
from 
Employees
where FirstName like '_[^AT]%'
order by 2

--Ad�n�n ilk iki harfi LA,LN,AA VEYA AN olanlar.

SELECT FirstName,LastName,Title

FROM 
Employees

where  FirstName like '[LA][AN]%'

--�lk karakter i�in  l veya a'dan birisini , 2.karakter i�in  a veya n'den birini se�ece�iz.la,ln,aa ve an olur.

--i�ER�S�NDE _GE�EN �S�MLER�N L�STELENEMES� : 
--NORMALDE _ KARAKTER�N �ZEL B�R ANLAMI VARDIR.  VE  TEK B�R KARAKTER YER�NE GE�ER , ANCAK [] ���NDE BEL�RTMEYE KALKARSAM SIRADAN B�R KARATERDEN FARKI YOKTUR .

SELECT FirstName,LastName,Title
FROM 
Employees
where FirstName like '%[_]%'

select FirstName ,LastName,Title
from 
Employees
where FirstName like '%\_%' escape '\'

--Customers tablosundaki customer�d'sinin 2 harfi A ,4.harfi t olanlar�n % 10 'luk k�sm�n� getiren sorguyu yaz�n�z.
select TOP 10  PERCENT CustomerID,CompanyName,ContactName
from 
Customers 
where CustomerID like '_A_T%'

--VeriTaban� i�lemleri 
--1)�nsert : Bir veritaban�ndaki tablolardan birine kay�t eklemek i�in kullan�lan komut. 
/*
�nsert into <tablo adi> (<S�tun_�simleri>) 
values <S�t�n_De�erleri >
*/
Use Northwind 

go 

insert into Categories (CategoryName,Description)
values('Baklagiller' ,'K�ymetlidir bunlardaki vitamin.')


select * from Categories
--A�a��daki insert i�lemi ba�ar�s�z olacak. 
--��nk� categories tablosundaki null ge�ilemeyen categoryName s�tn�  i�in bir de�er atamas�nda bulunmad�k. 
--Bir tablonun null de�er i�ermeyen stunlar�nda insert i�lemi s�ras�nda mutlaka de�er atamas�nda bulunmmal�y�z.
--(E�er identiy �zelli�i aktif ise  . buraya kar��madan devam edebiliririz.)
--Otomatik artan �zelli�i bizim yerimize ilgli kolona de�erini g�nderecektir. 

insert into Categories (Description)
values ('kategori ad� girilmeli ')

--E�er bir balo st�nlar�r�n hepsine veri gireceksek tablo ad�ndan sonra st�n adlar�n� a��ktan belirtmenize gerek yoktur. Direkt values ile stunlar�n i�ine de�erleri atayabilirsiniz. 
--Ancak dikkat etmeniz gereken stunlar�n verilerini girerken yap�lar�na dikkat etmeni gerekmektedir. 
--(DATA TYPE) TABLONUN YAPISINA UYGUNLU�A D�KKAT ETMEK LAZIM .
--(Yani CompanyName s�t�nu  phone s�t�undan �nce oldu�u i�in values k�sm�nda ilk belirtice�imiz de�er companyname  s�tununa ait  olmal� aksi halde sutunlar� veri tiplerinin uyu�lu oldu�u bir durum denk gelirse i�ste busefer yanl�� datalar girersiniz. 
insert into Shippers values
('MNG KARGO' ,'(212) 556 32 89')

select * from Shippers

--E�er stun isimlerini belitirsek verileri belirtti�imiz s�rada girmeliyiz. 
 insert into Shippers (Phone,CompanyName)
 
 values ('(216) 459 12 41','Aras Kargo')

--Customer Tablosuna 'Bilge Adam �irketini ekleyiniz'.

 insert into Customers (CustomerID,CompanyName)

 values ('BLGDM','Bilge Adam') 
--Update 
--2) Update : Bir tablodaki kay�tlar�n g�ncellemek i�in kullan�l�r. 
--Dikkat edilmesi gerekn hangi kaydu g�ncelliyece�imizi a��ktan ifade etmeniz gerekiyor.
--Aksi Halde t�m kay�tlar� g�ncellerisin.

 select *
 into Cal�sanlar
 from 
 Employees

select * from Cal�sanlar
 /*
 Update <TabloAdi> 
 set <s�tun_adi> = <yenide�er> ,<s�tun_adi> = <yenide�er> ,<s�tun_adi> = <yenide�er> ,<s�tun_adi> = <yenide�er>
 */

--Customers tablosundaki customerId s�t�nun tipi nchar(5)' tir.
--Yani ,bu st�n  identity olarak belirtilemez ,Dolay�s� ile bu tabloya bir kay�t girerken customerId s�tutuna da kendimzi veri girmeliyiz. 
select * from Customers

Update Cal�sanlar
set  LastName ='O�uz';
--�ALI�ANLAR TABLOSUNDAK� B�T�N KAYITLARIN SOYADI B�LG�S� DE���T�R�LECEKD�R.��NK� G�NCELLEME ��LEM�N� YAPARKEN HANG� KAYIT G�NCELLENECEK A�IKTAN BEL�RTMED�K (�stenmeyen durumdur.)

SELECT * FROM Cal�sanlar

update Employees 
set FirstName ='Ali' ,LastName ='Mehmet'
where EmployeeID=11
--Sadece �d de�eri 11 olan kayd�n bilgisini g�ncelledik .Bir kay�t g�ncellenirken en g�zel yol �d �zeriden yapmakt�r. E�er firstName yapsayd�m ,ayn�  ada sahip ki�iler hepsi g�ncellenecektir. 
--Tekillik sa�lanmas� i�in �d �zerinden i�lem yap�l�r. 
select * from Employees
where EmployeeID =11

--Product tablosu alt�ndaki �rnleri �r�nler ad� alt�ndaki urunler tablosuna kopyalay�n.
--Her bir �r�n�n birim fiyat� �zerinden %5 zam yapal�m.
select * 
into 
urunler
from Products
--Products tablosundaki veriler,Urunler tablosuna kopyaland�. 
Update urunler
set UnitPrice = UnitPrice+ (UnitPrice*0.05)
select * from  urunler

--3)Delete :Bir tabloddan kay�t silmek i�in kullanaca��m�z komuttur. 
--Ayn� update i�lemi gibi dikkat etmeniz gerekir.
--��nk� birden fazla kay�t yanl��l�kla silinebilir. 

/*
Delete from <Tablo_Adi>
*/
Select * from Cal�sanlar

delete from Employees where EmployeeID =11 --TEK KAYIT S�L�NECEKT�R. 

drop table Cal�sanlar

select * into cal�sanlar from Employees

delete from cal�sanlar 
where FirstName ='Michael'

---�nvan� Mr. ve Dr. olanlar� siliniz
--(yok ise �al��anlar tablosunu olui�tur.)

delete  from cal�sanlar
where TitleOfCourtesy in('Dr.','Mr.')
-------------------------Dml Bitis-----------------------------------

--Aggregate Functions 

--1)Tarih Fonksiyonlar� 
--DatePart () Kullan�m�: Bir tarih bilgisinden istedi�imiz k�sm� elde etmemiz sa�l�yor .
Select  FirstName,LastName,DATEPART(YY,BirthDate) as [y�l]
from 
Employees 
order by y�l desc --Y�l bilgisini al�r.

select FirstName,LastName ,DATEPART(DY,BirthDate) as [Day of Year] 
from 
Employees
order by [Day of Year] desc --Y�l�n Ka��nc� g�n� 

---Y�l�n Ka��nc� ay� .
select  FirstName,LastName,DATEPART(M,BirthDate) as [Mouth]
from 
Employees
order by Mouth desc

select  FirstName,LastName ,DATEPART(WK,BirthDate)as [week of year]
from  Employees
order by [week of year] desc ; --Y�l�n Ka��nc� haftas� 

select  FirstName ,LastName,DATEPART(DW,BirthDate) as [day of week]
from 
Employees --Haftan�n ka��nc� g�n�.
ORDER BY [day of week] DESC

select FirstName,LastName,DATEPART(HH,GETDATE()) AS SAAT  
from
Employees 
ORDER BY SAAT DESC --Saat getirir. 

SELECT  FirstName,LastName,DATEPART(MI,GETDATE()) as dakika
FROM 
Employees 
ORDER BY [dakika] desc--Dakika getirir. 

select  FirstName,LastName, DATEPART(SS,GETDATE())AS SAN�YE
from 
Employees
ORDER BY SAN�YE DESC--SAN�YE GET�R�R.

select FirstName,LastName ,datepart (MS,getdate())SAL�SE
from 
Employees
ORDER BY SAL�SE DESC
--DateDiff() kullan�m�: iki tarih aras�ndaki fark� verir. 
select (FirstName+' '+LastName) as  isim ,DATEDIFF(YEAR ,BirthDate,GETDATE())as yas,
DATEDIFF(DAY , HireDate ,GETDATE()) as [�denen prim g�n]
from 
Employees

select 
FirstName,LastName,DATEDIFF(hour,BirthDate ,GETDATE()) as  [ka� saat ge�ti]
from 
Employees

--String Function 
select 5+9 as toplam ,5-9  as fark ,5*9 as �arp�m,5/3 as bolum ,5%2 as  [mod]
--Not : Select ile mutlaka from kullan�m� zorunlu de�il.

select 'Bilge adam' as mesaj
print 'Bilge adama ho�geldin';

select ASCII('A') AS [ASCII Kodu] --ascii kodunu verir. 65

Select char(65) as [Karakter]

select CHARINDEX(',','umit.vatansever@bilgeadam.com')as Konum ;  
--�ndexler 1 'den ba�l�yor ..
--Aratmak istedi�iniz  karakteri ve metin bulundu�u yeri verir. 
--E�er Bulamazsa 0 d�nd�r�r.

select LEFT('Bilge Adam',4) as [Soldan karakter say�s�]

select RIGHT('Bilge Adam',6) as [sa�dan karakter say�s� ]

select LEN('Bilge Adam') as [Karakter adeti ]

select LOWER('B�LGE ADAM') AS [HEPS�KUCUK]

SELECT UPPER('Bilge adam') as [Hepsi b�y�k]

SELECT LTRIM ('                             Bilge Adam')as [Soldaki bo�luklar� silecek]
select RTRIM('Bilge Adam                            ') as [Sa�daki Bo�luklar� siler];

select LEN ( LTRIM(RTRIM('                   Bilge Adam                            '))) as [T�m bo�luklar� siler]

--Trim ile alabilirsin.

select  replace ('birbirlerinine','bir','uc') as [metinlerin yerine yenisini atar]

select SUBSTRING('Bilge adam yaz�l�m kursuna ho�geldiniz.',4,6) as 'Alt string''leri olu�turulur.'
--Yanyana iki tane  tek t�rnak yazd���m�zda ,bu ifade tek t�rnak yerine ge�er.
--(Tek t�rnak �zel bir anlam ifade etti�inden dolay�.)

select REVERSE('Bilge Adam Akamdemi') as 'Tersine �evir'; --Reverse Ters �evirir.
select 'Bilge Adam'+SPACE(30)+'Akademi' as [Belirtilen miktarda bo�uk koyar. ...]

select  REPLICATE('Bilge',5) AS 'Belirtilen metin ,belirtilen miktarda �o�alt�l�r. ';

--Aggeragete Fonksiyonlar� - (Toplam ,matematiksel Func.GRUPLAMALI fUNC;) 

SELECT COUNT(*) 
FROM 
Employees --B�R TABLODAK� TOPLAM KAYDI ��RENEB�LR�S�N�Z. 

SELECT COUNT (EmployeeID)
FROM 
Employees

SELECT COUNT (REG�ON )
FROM
Employees
--Region s�tunundaki kay�t say�s� (region s�tunu null ge�ilebilece�i i�in bir tablodaki kay�t say�s�n� bu sutundan yola ��karak ��renmek yanl�� sonu�lar ��karabilir. 
--��nk� aggaregte func null de�ere i�eren kay�tlar� dikkate almaz. 
--Bu neden ile kay�t say�s�n� ��renebilmek i�in ya * karakterini yada null ge�ilemeyen stunlardan birinin ad�n� kullanman�z gerekir. 

select count (city)
from
Employees 
--9  adet var g�r�rn�r .Fakat baz� �ehirler birden fazla kez tekrarlam��t�r. 

select COUNT (distinct  City)
from 
Employees
--Farkl� olan �ehirlerin say�s�n� verir. 

select SUM(EmployeeID)
from 
Employees
--EmployeeId Kolonundaki b�t�n de�erleri toplad� 

--�al��anlar�n ya�lar�n�n toplam�.

--1.Yol
select Sum (Year(getdate())-Year(BirthDate))as yaslaruntoplam�
FROM
employees

--2.yol
select sum(DATEDIFF(Year,Birthdate,getdate())) as [yaslar�n toplam�]
from Employees

--select sum(FirstName) as [yaslar�n toplam�]
--from Employees

--Sum fonksiyonu say�sal stunlarda kullan�l�rlar. 

--AVG(S�t�nAdi): Bir s�t�ndaki de�erin ortalamas�n� sizlere d�ner. 

select AVG(EmployeeId)
from
Employees

--�al��anlar�n ya�lar�n�n ortalamas�.

select avg (DateDiff(YEAR,BirthDate,GETDATE()))
from 
Employees

--Null olanlar i�leme kat�lmayaca�� i�in ortalama hesaplan�rken b�t�n ki�ilerin say�s�na b�l�nmez ,null olmayan ki�ilerin say�s�na b�l�n�r.

--Select avg (lastname )
--from 
--Employees
--Avg Fonk say�sal sutunlar kullan�l�r .
select max (EmployeeID)
from
Employees

select max(Firstname ) --Stunda say�sal stun olmasan gerek yok .Alfabetik olrak en b�y�k de�eri verir. 
from 
employees ;

Select Min(employeeId) 
from
Employees

select min(firstname)
from
Employees

--Say�sal de�er i�lemleri.
select 3+2 
select 3*3
select 4/2
select 9-2

--P� :Pi say�s�n� verir. 

select PI() AS [PI]

--S�N :Sin�s al�r.
SELECT Sin( PI())

--power : �st� Al�r.
select power(2,3)

--Abs : Mutalk de�er al�r.
select abs (-12)

select Rand()  -- 0 ile 1 aras�nda rasgele de�er �retiyor. 

select floor (RAND()*100)

--Case When -Then : 
select FirstName ad  ,soyad=LastName ,Title as g�rev ,Country as Ulke 
from 
Employees

select FirstName,LastName ,
			case (Country)
				when 'USA'
				THEN 'AMER�KA B�RLE��K DEVLETLER�'
				WHEN 'UK'
				THEN 'iNG�LTERE B�RLE��K KRALLLI�I'

				ELSE '�LKES� BEL�RT�LMED�.'

				END AS Country
from Employees


--Employyeidde�eri be�den b�y�k ise ''�d de�eri be�'den buyuk  k���k ise id de�eri 5'k�c�k �d 5'de�erine e�it.

select FirstName,LastName,
			case 
			when EmployeeId>5
			then 'Id de�eri be�ten b�y�kt�r.'
			when EmployeeID<5 
			then 'Id de�eri be�''den k���kt�r '
			else 'Id de�eri 5 de�erine e�ittir. '
			end as Durum 
from Employees;


select  RegionId,
			case (RegionDescription)
				when 'Eastern'
				THEN 'Do�u'
				when 'Western'
				THEN 'Bat�'
				when 'Northern'
				THEN 'Kuzey'
				when 'Southern'
				THEN 'G�ney'

				ELSE 'B�lge Belirtilmedi.'

				END AS Country
from Region
 
 --GroupBy

--�al��anlar�n �lkelerine g�re grupland�r�lmas�.
 select Country as �lke, COUNT(*) as kisisay�s� from
 Employees 
 where  Country is not null 
 group by Country

--�al��anlar�n yapm�� oldu�u sipari� adeti.

 select EmployeeID , COUNT(*) as [Siparis adeti]

 from 
 Orders
 Group By EmployeeID
 order by [Siparis adeti] desc ;

--�r�nlerin bedeli 35 Dolar 'dan az olan �r�nlerin kategorilerine g�re grupland�r�lmas�.
select 

 CategoryID,COUNT(*) as Adet
 from 
 Products
 where UnitPrice<=35  
 group by CategoryID 
 order by Adet

--Ba� harfi A-K aral���nda olan ve stok miktar� 5 ile 50 aras�nda olan �r�nlerin kategorilerinie g�re gruplay�n�z.
 select CategoryID ,COUNT(*) as adet
 from
 Products
 where 
 (ProductName like '[A-K]%')
 And 
 (UnitsInStock between 5 and 50)
 group by CategoryID
 order by adet desc 
--Her bir sipari�teki toplam �r�n say�s�n� bulunuz.S
 Select OrderID,Sum(Quantity) as 'Sat�lan �r�nler'
 from  [Order Details]
 group by OrderID

select
 OrderID,Sum(UnitPrice*Quantity*(1-Discount)) As toplamTutar
 from 
 [Order Details]
 group by OrderID 
 order by  toplamTutar desc;
---Having Kullan�m� 
--Sorgu Sonucu gelen sonu� K�mesi �zerinde  Aggregate  gonksiyonlar�n ba�l� olacak �ekilde bir filitreleme i�lemi yapacaksak where yerine having anahtar kelimesini  kullan�r�z.
--Bu sayade aggregate function flitreleme i�lemine kat�l�rlar.
---E�er Aggregate function sorgunuzda yok ise  having kullanimi where ile ayn� filitreleme i�lemini yapacakt�r.
--Toplam tutar�  2500-3500 aras�nda olan sipar�lerin listelenmesi.
 select OrderID  as SiparisKodu ,Sum(Quantity*UnitPrice*(1-Discount)) as ToplamTutar
 from
 [Order Details]
 --where Sum(Quantity*UnitPrice*(1-Discount))  between 2500 and 3500 
 group by OrderID 
 having  Sum(Quantity*UnitPrice*(1-Discount))  between 2500 and 3500 
 order by ToplamTutar desc

--Herbir Sipari�teki toplam �r�n say�s�200'den az olanlar� 

 select OrderID, SUM(Quantity) as adet 
 from [Order Details]
 group by  OrderID
 having  Sum(Quantity)< 200
 order by adet;

--Toplam sipari� miktar� 1300 adetten fazla olan �r�nkodlar�n� listeleyiniz. 
 select ProductID ,Sum(quantity) as toplamadet
 
from  [Order Details]
 group by ProductID 
 having sum (quantity) >1300

--Toplam Sipari� Miktar� 500'den k���k olanlar� getirin.
 select ProductID as urunid,Sum(Quantity) as [toplam siparis] 
 from [Order Details]
 group by ProductID 
 having  sum (Quantity)<500

--1000 adetten fazla sat�lan �r�nlerin product �d g�re grupland�r�lmas�.
select ProductID ,Sum(quantity) as 'Sat�� ADET�'
from [Order Details]
 group by ProductID
 having SUM(Quantity)>1000

--Normal data silmek  i�in delete komutunu kullan�r�z .Fakat tablodaki identiy olan kolon de�erleri artm�� ve gitmi� oluyor.

Truncate Table test
--�DENT�TY S�f�rlanmak istiyorsak  "TRUNCATE KULLANILMALI"

--�� i�e sorgular (Subquery)

declare @MaxFiyat money = (select max (UnitPrice) from Products)

select * from Products where UnitPrice =@MaxFiyat

select * from Products where UnitPrice = (select max (UnitPrice) from Products)

--Fiyat� Ortalama fiyat�n�n �zerinde olan  �r�nleri getirin.
select * from Products 
where UnitPrice
>(select  
Avg(UnitPrice)
from 
Products )

--�r�nler tablosundaki sat�lan �r�nlerin listesi.

select * from 
Products
where ProductID in (select 
ProductID
from 
[Order Details] )

--�r�nler tablosundaki sat�lmayan �r�nlerin listesi.

select * from 
Products
where ProductID  not in (select 
ProductID
from 
[Order Details] )
--Subquery'lere herzaman tek st�n �zerinde �a�r�labilir. 

select 
p.ProductName,p.UnitPrice,p.UnitsInStock,
(select CategoryName
from
Categories c where c.CategoryID=p.CategoryId) as KategoriName
from Products p

select FirstName,LastName
from
Employees where title in (select Title
from Employees where Title is not null)

--Kargo �irketlerinin ta��d�klar� sipari� say�lar�n� gelsin.

select 
(select CompanyName from Shippers s
where s.ShipperID=o.ShipVia) as [Kargo],
ShipVia,COUNT(*)
from Orders o
group by ShipVia

--En pahal� �r�n�n ad� nedir ? 
select ProductName
from 
Products
where UnitPrice=
(select MAX(UnitPrice)from Products)

--Exists Fonksiyonu

--Tablonun dolu yada bo� oldu�unu d�nd�r�r.

if exists (select * from Employees)
	print 'Dolu'
else
print 'Bos'

--Sipari� alan �al��anlar�m.

select * from Employees e1
where exists (select EmployeeID  from Orders e2
where e1.EmployeeID=e2.EmployeeID)

--Sipari� almayan �al��anlar�m.

--Not exists
select * from Employees e1
where not exists (select EmployeeID  from Orders e2
where e1.EmployeeID=e2.EmployeeID)

---�� i�e yaz�lan subqquery'den d�nen t�m kay�tlar i�inde e�le�me yap�ld�ktan  sonra ana query �al��mas�n� tamamlar. 
--exists ise subquery yi e�leme yap�lan kay�tlara g�re sonu�land�r�r. 
--ve ilave olarak gelen kay�tlar i�inde e�le�me yapmas�na gerek kalmaz.Exists zaten subquery'den ihtiyac� olan kay�tlar� getirmi� olacakt�r.
--Exists condition (if-else) i�erisinde de kullan�labilir.

---Join ��lemi 
--1)�nner Join :B�r tablodaki her bir kayd�n di�er tabloda bir kar��l���  olan kay�tlar listelenir.
--(inner join) =>> join  inner c�mleci�ini yazmasada  yine inner join demekdir. 


select ProductName,CategoryName, 
from Products inner join Categories on Products.CategoryID=Categories.CategoryID

--Products tablosundan Product_�d ProductName,Category�d,
--categories tablosundan da cateName,Description

select Products.CategoryId,Products.ProductID,Products.ProductName,Categories.CategoryName,Categories.Description

from 
Products inner join Categories on Products.CategoryID=Categories.CategoryID
--:Not: E�er se�ti�i�imiz st�nlar her iki tabloda da bulunuyorsa , o t�r�n� hangi tablodan se�ti�iniz a��k�a belirtiniz. 

--Hangi sipari� ,hangi �al��an taraf�ndan ,hangi m��teriye yap�lm��t�r.

select OrderID as [Siparis no],OrderDate as [Siparis Tarihi],CompanyName as [�irket adi],ContactName as [Yetkili ki�i],(FirstName+' '+LastName) as [cal�san], Title as g�rev 
from Customers as c inner join Orders as o on  c.CustomerID=o.CustomerID
					inner join Employees as e on e.EmployeeID=o.EmployeeID
--Sorguyu k�satmak amac� ile tablo da takma isim verilebilir. Ancak dikkat edilmesi gereken  k�s�m tabloya takma isim verdikten sonra  art�k heryerde o ismi kullanaca��n�z.

--Suppliers tablosundan  companyName,ContactName. 
--Product Tablosundan  ProductName,UnitPrice.
--Categories Tablosundan  categoryName.
--CompanyName s�t�ndan g�re artan bir �ekikde s�ralay�n.

select CompanyName,ContactName,ProductName,UnitPrice,CategoryName
from  Categories as C inner join Products as p  on c.CategoryID=p.CategoryID
					  inner join Suppliers as S on s.SupplierID=p.SupplierID
order by CompanyName asc
--Not: From'dan sonra sorguda ge�en herhangi bir tabloyu baliertebilirisin , di�erlerini de daha sonra join i�lemleri ile birle�tiriyoruz. 

--Kategorilere g�re toplam stok miktar�n� bulunuz.

Select CategoryName,SUM(UnitsInStock) as Stok
from Categories  as c inner join Products as p on c.CategoryID=p.CategoryID
group by CategoryName 
order by  Stok desc

--Her bir �al��an toplamda ne kadar sat�� yapm��t�r (UnitPrice*Qunatity*(1-Discount))

select (FirstName+' '+LastName) as Cal�san,
Cast(CAST( Sum(UnitPrice*Quantity*(1-Discount)) AS decimal (15,3))as nvarchar(15))+' TL' as Toplam

from Employees as E inner join Orders as o on e.EmployeeID=o.EmployeeID
					inner join [Order Details] as OD ON O.OrderID=OD.OrderID

Group by (FirstName+' '+LastName)
order by TOPLAM DESC

--Not: CAST( Sum(UnitPrice*Quantity*(1-Discount)) AS decimal(15,3) ) AS TOPLAM =>>
--Virg�lden �nce 15 ,Virg�lden sonra 3 haneye kadar �stte elde edilen de�eri g�sterir. 
--�stte elde etti�imiz ondal�kl� de�eri stringe �evirdik.
--Sql 'de tip d�n���mleri i�in 2 tip d�n��t�rme fonksiyonu var.Cast ve Convert

--Herbir Kategori i�in ortalama �r�n fiyat�n� bulunuz. Fakat ortalama fiyat� 10 'dan b�y�k olanlar� getiriniz. 

select Categories.CategoryName ,AVG(UnitPrice)
from 
 Products inner join Categories on Categories.CategoryID=Products.CategoryID
 group by Categories.CategoryName
 having  AVG(UnitPrice)>10
 
--2)Outer Join
--2.1) Left outer join
--Sorguda kat�lan tablolardan soldakiniin t�m kay�tlar�n� getirirken ,sa�daki tabloda sadece ili�kisi olan kay�tlar getirilir. 

 select ProductName,CategoryName 

 from 
 Products as p left outer join  Categories as c 
 --Left outer join ifadesinin solunda kalan (Products) tablosundaki t�m kay�tlar� getirken ,sa�daki (categories tablosundaki  ili�kili kayd� getirecektir.)

 on p.CategoryID=c.CategoryID;


--Her bir �al��an�n  rapor verdi�i ki�siyle birlikte  listeleyin.

 select (e1.FirstName+' '+e1.LastName) as cal�sanlar ,(e2.FirstName+' '+e2.LastName) as y�netici 
 from Employees  as e1  inner Join Employees as e2 on  e1.ReportsTo=e2.EmployeeID 

 --T�m �al��anlar ve e�er varsa m�d�rleri ile birlikte listelenemsi.

select 
(e1.FirstName+''+e1.LastName) as �al��anlar , (e2.FirstName+' '+e2.LastName) as Y�netici
from 
Employees as e1  left join Employees as e2  ---Left Outer Join yerine k�saca left join kullanabilrsin .
on e1.ReportsTo=e2.EmployeeID;


--2.2)Right Join :Sorguda kat�lan tablolardan sa�dakini t�m kay�tlar�n� getirken ,soldaki tabloda sadece ili�kli olan kay�tlar gelecektir.
select ProductName, CategoryName

from  Categories right join Products on Categories.CategoryID=Products.CategoryID

--Her bir �al��an�  m�d�r�yle birlikte listeleyin .
select 
e1.FirstName as M�d�rad,e1.LastName as M�d�rSoyad ,e2.FirstName as cal�sanad ,e2.LastName as cal�sansoyad
from 
Employees as e1 right join  Employees as e2 on 
e2.ReportsTo=e1.EmployeeID

select ProductName,CategoryName

from  Products right join Categories on Products.CategoryID=Categories.CategoryID

---3)Full Join :Her iki tablodaki t�m kay�tlar getirlir. left ve right join 'nin birle�imidir.

select Products.ProductName,Categories.CategoryName

from Categories full join Products on Categories.CategoryID=Products.CategoryID;


---4.))Cross Join : Bir tablodaki bir kayd�n di�er tablodaki t�m kay�tlar ile e�lemesi gerekir. 
select  COUNT(*)
from
Categories --10

select COUNT (*)
from
Products --77

select CategoryName,ProductName
from  Categories cross Join Products

--View Yap�s�
--==Kullan�m amac� ==> 
---Genellikle karma��k sorular� tek bir sorgu �zerinden �al��t�r�labilmesidir..
--Bu ama� ile raporlama i�lemlerinde kullan�l�r. 
--Ayn� zamanda g�venlik ihtiyac� oldu�u durumlarda  herhangi bir sorgunun 2 .ve 3. �ah�slara gizlenmesini sa�lar.

--Genel �zellikeler:
--Herhangi bir sorgunun sonucunda tablo olarak ele al�p ,ondan sorgu �ekebilmesini sa�lar..
--insert ,update ,delete ,fizziksel olarak tablolara etki yapar 
--Bu yap�lar fiziksel yap�lar�d�r. 
--view yap�lar� norm�al sorulardan yava� �al���rlar.

use Northwind 
Create VIEW PrdCtgSup
as 
select 
p.ProductName,p.UnitsInStock,c.CategoryName,s.CompanyName
from Products p inner join Categories c on p.CategoryID=c.CategoryID
inner join Suppliers s on p.SupplierID =s.SupplierID

select * from PrdCtgSup

select   CategoryName,CompanyName
from PrdCtgSup

select * from PrdCtgSup 
where CategoryName ='Beverages'

select  ProductName,UnitsInStock
from PrdCtgSup where ProductName>'C'
order by 1 

--Sat�s yapan �al��anlar�n numaralar�yla birlikte ad ve soyad bilgilerini getiren bir view yaz�n�z.

Create VIEW SipVerCal
As
select OrderID,Employees.FirstName+' '+Employees.LastName as [Ad Soyad]

from Orders 
inner Join 
Employees
on
Orders.EmployeeID=Employees.EmployeeID
Go
select * from SipVerCal

--With Encryption Komutu ile �ifreleme yap�l�r ..

--E�er yazd���n�z view 'in kaynak kodlar�n� ,object exloper pencersinden "views "kategorisininde sa� t�klaraya desing modu a��p g��rntelemek istemiyorsak. "With Enrtyption"komutunu kullanamk yeterli olacakt�r. 
--"With encryiption" i�leminden sonra view olu�turan ki�ide dahil olmak �zre kimse komutlar� g�remez .Geri d��n��� yoktur. .

--Ancak view olu�turan �ahs�n komutlar�n yede�ini bulundurmas� gerekmektedir. 

--Dikkat etmemiz gereken bir ba�ka husus ise as dan �nce bu keyword kullan�l�r.

Create View OrnekViewPersoneller 
with encryption 
as 
select FirstName,LastName,Title  from Employees

--Bu i�lemden sonra desing modu kapanm��t�r.
