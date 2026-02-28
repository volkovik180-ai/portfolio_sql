--Запрос "Топ-3 лекарства"
--Вывести топ 3 лекарства по объему продаж
SELECT drug,
       SUM (price*COUNT) AS sum_sale
FROM pharm.pharma_orders
GROUP BY drug
ORDER BY 2 DESC
LIMIT 3;