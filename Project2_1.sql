/*Сравнение динамики продаж между Москвой и Санкт-Петербургом. 
 * Подсчитываем продажи лекарств по аптекам и месяцам для Москвы и проделываем то же самое для Санкт-Петербурга, 
 * соединяем таблицы и вычисляем разницу по месяцам в процентах. 
 * Пишем короткие выводы в комментариях.
 */
WITH mos AS
  (SELECT pharmacy_name, --(month FROM report_date) extract_m,
 LEFT (DATE_TRUNC('month', report_date::date)::string,
       7) extract_m,
      Sum(price*COUNT) AS sum_sales,
   FROM pharm.pharma_orders
   WHERE city like 'Москва'
   GROUP BY city,
            pharmacy_name,
            LEFT (DATE_TRUNC('month', report_date::date)::string,
                  7)
   ORDER BY 1,
            2),
     pet AS
  (SELECT pharmacy_name, 
 LEFT (DATE_TRUNC('month', report_date::date)::string,
       7) extract_m,
      Sum(price*COUNT) AS sum_sales,
   FROM pharm.pharma_orders
   WHERE city like 'Санкт_Петербург'
   GROUP BY pharmacy_name,
            city,
            LEFT (DATE_TRUNC('month', report_date::date)::string,
                  7)
   ORDER BY 1,
            2),
     sum_pharmacy_month AS
  (SELECT mos.pharmacy_name,
          mos.extract_m,
          mos.sum_sales AS mos_sales,
          pet.sum_sales AS pet_sales,
          ROUND((mos.sum_sales - pet.sum_sales)/mos.sum_sales*100, 2) perc
   FROM MOS
   INNER JOIN pet USING (pharmacy_name,
                         extract_m)),
     sum_month AS
  (SELECT 'По всем аптекам' AS pharmacy_name,
          extract_m,
          SUM(mos_sales) AS mos_sales,
          SUM(pet_sales) AS pet_sales,
          ROUND((SUM(mos_sales) - SUM(pet_sales))/SUM(mos_sales)*100, 2) perc
   FROM sum_pharmacy_month
   GROUP BY extract_m
   ORDER BY 2),
     sum_all AS
  (SELECT 'Все аптеки' AS pharmacy_name,
          'за период' AS extract_m,
          SUM(mos_sales) AS mos_sales,
          SUM(pet_sales) AS pet_sales,
          ROUND((SUM(mos_sales) - SUM(pet_sales))/SUM(mos_sales)*100, 2) perc
   FROM sum_pharmacy_month),
     sum_pharmacy AS
  (SELECT pharmacy_name,
          'за период' AS extract_m,
          SUM(mos_sales) AS mos_sales,
          SUM(pet_sales) AS pet_sales,
          ROUND((SUM(mos_sales) - SUM(pet_sales))/SUM(mos_sales)*100, 2) perc
   FROM sum_pharmacy_month
   GROUP BY pharmacy_name --order by 2
)
SELECT *
FROM sum_all
UNION ALL
SELECT *
FROM sum_pharmacy
UNION ALL
SELECT *
FROM sum_month
WHERE extract_m != '2024-06'
UNION ALL
SELECT *
FROM sum_pharmacy_month
WHERE extract_m != '2024-06' ;
--Июнь не берём в расчёт, так как имеются данные только за один день.
select EXTRACT(month FROM report_date), Count(distinct report_date)
from pharm.pharma_orders 
Group by EXTRACT(month FROM report_date)
order by 1;


/* 
За анализируемый период (с февраля по май 2024 года) продажи лекарств демонстрируют умеренный рост.
В Москве продажи за период на 2.75% ниже чем в Санкт-Петербурге.

Наиболее высокие продажи зафиксированы мае, 
при этом самые высокие продажи за месяц показала торговая сеть Доктор Айболит.
В Москве продажи через торговую сеть Доктор Айболит в мае были на 2.61% выше чем в Санкт-Петербурге.

Наиболее низкие продажи зафиксированы в феврале, 
при этом самые низкие продажи за месяц показала торговая сеть Аптека.ру.
В Москве продажи через торговую сеть Аптека.ру в феврале были на 35.3% ниже чем в Санкт-Петербурге.
*/