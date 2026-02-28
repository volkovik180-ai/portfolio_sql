
/* Кто наши клиенты. 
Вычисляем возраст клиентов на основе даты рождения с использованием функции для работы с датами; 
затем используем оператор CASE WHEN для расчета, кто наши клиенты. 
Описываем каждую группу: мужчины младше 30, мужчины от 30 до 45 и так далее. 
Подсчитываем долю продаж на каждую группу.
*/

WITH customer_ages AS
  (SELECT customer_id,
          gender,
          EXTRACT(YEAR
                  FROM AGE(date_of_birth)) AS age,
          CASE
              WHEN gender = 'жен'
                   AND EXTRACT(YEAR
                               FROM AGE(date_of_birth)) < 30 THEN 'Женщины младше 30'
              WHEN gender = 'жен'
                   AND EXTRACT(YEAR
                               FROM AGE(date_of_birth)) BETWEEN 30 AND 45 THEN 'Женщины 30-45'
              WHEN gender = 'жен'
                   AND EXTRACT(YEAR
                               FROM AGE(date_of_birth)) > 45 THEN 'Женщины 45+'
              WHEN gender = 'муж'
                   AND EXTRACT(YEAR
                               FROM AGE(date_of_birth)) < 30 THEN 'Мужчины младше 30'
              WHEN gender = 'муж'
                   AND EXTRACT(YEAR
                               FROM AGE(date_of_birth)) BETWEEN 30 AND 45 THEN 'Мужчины 30-45'
              WHEN gender = 'муж'
                   AND EXTRACT(YEAR
                               FROM AGE(date_of_birth)) > 45 THEN 'Мужчины 45+'
          END AS customer_group
   FROM pharm.customers)
SELECT customer_group,
       COUNT(DISTINCT customer_id) cnt,
       SUM(COUNT*price) sum_sale,
       ROUND(SUM(COUNT*price)/total_sum*100, 1) perc
FROM customer_ages
INNER JOIN pharm.pharma_orders USING(customer_id)
CROSS JOIN
  (SELECT SUM(COUNT*price) AS total_sum
   FROM pharm.pharma_orders)
GROUP BY customer_group,
         total_sum
ORDER BY 3 DESC ;
    
    