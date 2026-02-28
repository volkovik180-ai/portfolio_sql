--Запрос "Аптеки от 1.8 млн оборота"
--Вывести аптеки, имеющие более 1.8 млн оборота (HAVING)
SELECT pharmacy_name,
       SUM (price*COUNT) AS sum_sale
FROM pharm.pharma_orders
GROUP BY pharmacy_name
HAVING SUM (price*COUNT) > 1800000;