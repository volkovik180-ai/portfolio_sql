--Запрос "Лучшие клиенты"
--Соединить таблицы заказов и клиентов (JOIN)
--Посчитать тотал сумму заказов для каждого клиента
--Проранжировать клиентов по убыванию суммы заказа (row_number)
--Оставить топ-10 клиентов

SELECT customer_id,
       SUM(price*COUNT) AS total_sum,
       row_number() over(
                         ORDER BY total_sum DESC) num
FROM pharm.pharma_orders
INNER JOIN pharm.customers USING (customer_id)
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 10 ;