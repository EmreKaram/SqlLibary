---�al��ma sorular�:

--Brazil'de bulunan m��terilerin �irket ad�,temsilciad�,adres,�ehir,�lke bilgilerini  d�nd�r�r�n. 
select CompanyName,ContactName,[address],City,Country
from 
Customers
where Country='Brazil'
order by  CompanyName

select CompanyName,ContactName,[address],city,Country
from 
Customers
where 
Country !='Brazil'
order by  CompanyName

Select CompanyName,Country
from Customers
where Country='Spain' or Country ='France'or Country ='Germany'
order by Country

select  CompanyName
from 
Customers 
where Fax is null 
order by CompanyName

--Londra yada parsite bulunan m��terilerimi bulun ... 
select CompanyName,ContactName,City,Country
from 
Customers
where City ='London' or City ='Paris'
--hem mexico d.f  'de ikamet edecek. Hmde ContactTitle Bilgisi 'owner'olan m��terileri getirin.

--C ile ba�layan �r�nlerin fiyatlar�  ve isimlerini .
Select CompanyName,ContactName,Address,City,Country
from 
Customers
where  City ='M�xico D.F.' and  ContactTitle='Owner'

--Ad� (FirstName )' a' harfi ile ba�layan �al��anlar�m�n ad�,soyad, do�umtarihini .
select FirstName,LastName,BirthDate
from 
Employees 
where 
FirstName like 'A%'

--�sminde 'Resturant'ge�en mi�terilermin �irket isimleri 
select CompanyName 
from 
Customers
where  CompanyName like '%restaurant%' 

--50$ dolar ile 100$ dolara araqs�nda bulunan �r�nlerin adlar� ve fiyatlar� ... .. 
select ProductName,UnitPrice
from 
Products 
where 
UnitPrice between 50 and 100

--1Temmuz1996 ile 31 aral�k 1996 tarhileri aras�ndaki sipari�lerin siparis_.id ve sipari�tarhilerini g�sterin .... 
select OrderID,OrderDate
from Orders
where OrderDate between '1996-07-01' and'1996-12-31'

--M��terilermizi �lkeye g�re s�ral�yal�m ...
select distinct Country ,CompanyName
from 
Customers
order by Country asc

select ProductName,UnitPrice
from Products
order by UnitPrice desc

--�r�nlerimi en pahal�dan en ucuza do�ru s�lay�n�z.Ama stoklar�n� k���kten b�y��e do�ru g�steriniz .�r�n ad� vefiyat� bas�n�z. 
select ProductName,UnitPrice,UnitsInStock
from
Products
order by UnitPrice desc ,UnitsInStock asc;

--1Numaral� kategoride ka� �r�n vard�r. 
select  COUNT(*)  ProductName
from 
Products 
where CategoryID =1 

--En pahal� 5 �r�n 
select top 5 productName,UnitPrice
from 
products
order by unitprice

--�r�nlerin toplam maliyetini 
Select Sum (unitprice*Quantity)
from
[Order Details]

--�irketim nekadar  cirosu vard�r. 
select  sum (unitprice*quantity*(1-Discount)) as totalCiro
from [Order Details]

--Ortalama �r�n fiyat�n� 
select Avg(unitPrice) ortalamaurunfiyat
from
Products

--EN UCUZ �R�N ADI  GELS�N  (i�-i�e)
Select ProductName,UnitPrice
from Products
where UnitPrice=(select Min(unitprice)
from Products)

--En az kazand�ran sipari� 
select top 1  OrderID,sum(UnitPrice*Quantity) as [en az getirisi olan sipari� ]
from 
[Order Details]
group by OrderID 
order by [en az getirisi olan sipari� ] asc

--M��terilerin i�inde en uzun isme sahip olan m��teri (harf say�s�n�.)
--Len()
select 
top 1 CompanyName, len(CompanyName) as isimunzunlu
from
Customers
order by isimunzunlu

--�AI�ANLARIN AD SOYAD VE YA�LARINI G�STER�N 
select 
FirstName as isim,LastName as soyad,DATEDIFF(Year,BirthDate,GETDATE()) as Yas
from Employees

--Hangi �R�NDEN TOPLAM KA� ADET ALINMI� 
select OrderId,Sum(Quantity) as [Toplam siparis Tutar]
from [Order Details]
group by OrderID 
order by [Toplam siparis Tutar] desc

--Hangi sipari�te toplam nekadar kazanm���m.
select  OrderID ,Sum(Quantity*UnitPrice) as maliyet
from [Order Details]
group by OrderID
order by  maliyet desc

--Hangi kategoride toplam ka� adet �rn bulunuyor..
select CategoryID ,COUNT(CategoryId) as ToplamUrunsayisi
from 
Products
group by CategoryID

--1000 Adetten fazla sat�lan �r�nler?
select ProductID,Sum(Quantity) as toplamsiparismiktari 
from  [Order Details]
group by  ProductID
having sum (Quantity)>1000 

--Hangi M��terilerim hi� sipari� vermemi�dir?
select   CompanyName
from Customers
where CustomerID not in (select distinct  CustomerID from 
Orders)

--Hangi �r�n hangi kategoride.
select CategoryName,ProductName
from
Categories c inner join Products p 
on 
c.CategoryID=p.CategoryID

--Hangi tedarik�i hangi �r�n�n� sa�l�yor.
select CompanyName as supplier ,ProductName as product 
from 
Suppliers s inner join Products p 
on s.SupplierID = p.SupplierID

--Hangi sipari� hangi kargo �irketi ile ne zaman g�nderildi�inin bilgisini veren sql c�mleci�iniz yaz�n�z?
select CompanyName as firma ,OrderID as siparis ,ShippedDate as tarih 
from Shippers s inner join  Orders o 
on 
s.ShipperID=o.ShipVia

--sql trigger �al��ma sorular�--

--Hangi sipari�i hangi m��teri vermi� hangi �al��an alm�� hangi tarihte ,hangi kargo �irketi taraf�ndan g�nderilmi� hangi �r�ndenka� adet al�nm��,hangi fiyattan al�nm�� �r�n hangi kategoride,bu �r�n� hangi tedarik�i sa�lam��

use Northwind
select * from Customers c inner join Orders o
on c.CustomerID=o.CustomerID
inner join Employees e on o.EmployeeID=e.EmployeeID
inner join Shippers sh on sh.ShipperID=o.ShipVia
inner join [Order Details] od on od.OrderID=o.OrderID
inner join Products p on od.ProductID=p.ProductID
inner join Categories ct on p.CategoryID=ct.CategoryID
inner join Suppliers sp on sp.SupplierID=p.SupplierID
order by o.OrderID asc








