--Запрос "Накопленная сумма продаж по каждой аптеке" (OVER)

SELECT pharmacy_name,
       report_date,
       SUM (price*COUNT) AS sum_sale,
           SUM (sum_sale) OVER (PARTITION BY pharmacy_name
                                ORDER BY report_date) cumm_sale
FROM pharm.pharma_orders
GROUP BY pharmacy_name,
         report_date
ORDER BY 1,
         2 ;