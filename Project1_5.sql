--Запрос "Количество клиентов в аптеках"
--Соединить таблицы заказов и клиентов (JOIN)
--Посчитать кол-во уникальных клиентов на каждую аптеку (DISTINCT)
--Отсортировать аптеки по убыванию кол-ва клиентов (ORDER BY)

SELECT pharmacy_name,
       count(DISTINCT customer_id) AS uniq_cust
FROM pharm.pharma_orders
INNER JOIN pharm.customers USING (customer_id)
GROUP BY pharmacy_name
ORDER BY 2 DESC ;