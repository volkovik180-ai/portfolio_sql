--create schema pharm;
--CREATE TABLE pharm.customers AS SELECT * FROM read_csv_auto('C:\Users\VVolkov\Python\ДЗ\SQL\customers.csv'); 
--CREATE TABLE pharm.pharma_orders AS SELECT * FROM read_csv_auto('C:\Users\VVolkov\Python\ДЗ\SQL\pharma_orders.csv'); 
--Select * from pharm.customers;
--Select * from pharm.pharma_orders;

--Запрос "Топ-3 аптеки"
--Вывести топ 3 аптеки по объему продаж (GROUP BY, LIMIT)
SELECT pharmacy_name,
       SUM (price*COUNT) AS sum_sale
FROM pharm.pharma_orders
GROUP BY pharmacy_name
ORDER BY 2 DESC
LIMIT 3;
