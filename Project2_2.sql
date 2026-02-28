/*Лекарства от насморка. Выделяем препараты, начинающиеся со слова “аква” (с использованием оператора LIKE). 
 Приводим данные к нижнему регистру, группируем и подсчитываем общий объем продаж для каждого препарата, 
 ранжируем по убыванию объема продаж и подсчитываем долю продаж каждого лекарства в общем объеме.
 */

SELECT
  drug,
  sum_sales,
  rank_sum,
  ROUND(sum_sales / total_sales * 100, 2) perc
FROM
  (
    SELECT
      drug,
      SUM(price * COUNT) AS sum_sales,
      RANK() OVER (
        ORDER BY
          sum_sales DESC
      ) rank_sum
    FROM
      pharm.pharma_orders
    WHERE
      LOWER(drug) LIKE '%аква%'
    GROUP BY
      drug
  )
  CROSS JOIN (
    SELECT
      SUM(price * COUNT) AS total_sales
    FROM
      pharm.pharma_orders
  );