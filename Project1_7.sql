--Запрос "Накопленная сумма по клиентам"
--Соединить таблицы заказов и клиентов
--Соединить ФИО в одно поле
--Рассчитать накопленную сумму по каждому клиенту

SELECT customer_id,
       first_name || ' ' || second_name || ' ' || last_name AS FIO,
       SUM(price*COUNT) AS total_sum,
FROM pharm.pharma_orders
INNER JOIN pharm.customers USING (customer_id)
GROUP BY customer_id,
         first_name || ' ' || second_name || ' ' || last_name
ORDER BY 2 ;