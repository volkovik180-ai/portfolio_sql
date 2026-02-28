--Запрос "Самые частые клиенты аптек Горздрав и Здравсити"
--Сделать две временные таблицы: для аптеки горздрав и здравсити (WITH)
--Внутри каждой соединить таблицы заказов и клиентов (JOIN)
--Внутри каждой привести данные в формат "клиент - кол-во заказов в аптеке"
--Внутри каждой оставить топ 10 клиентов каждой аптеки
--Объединить клиентов с помощью UNION

WITH Gorzdrav AS
  (SELECT customer_id,
          count(order_id) AS count_orders,
          customer_id || ' - ' || count(order_id) customer_count_orders
   FROM pharm.pharma_orders
   INNER JOIN pharm.customers USING (customer_id)
   WHERE pharmacy_name like 'Горздрав'
   GROUP BY customer_id
   ORDER BY 2 DESC
   LIMIT 10),
     Zdavcity AS
  (SELECT customer_id,
          count(order_id) AS count_orders,
          customer_id || ' - ' || count(order_id) customer_count_orders
   FROM pharm.pharma_orders
   INNER JOIN pharm.customers USING (customer_id)
   WHERE pharmacy_name like 'Здравсити'
   GROUP BY customer_id
   ORDER BY 2 DESC
   LIMIT 10)
SELECT customer_count_orders
FROM Gorzdrav
UNION ALL
SELECT customer_count_orders
FROM Zdavcity ;