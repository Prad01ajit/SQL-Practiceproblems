-- 1
-- Suggest a better way if any.

WITH Agg1 AS( 
SELECT product_id,MIN(year) AS first_year
 FROM c_sales
 GROUP BY product_id)
 
 SELECT Agg1.product_id,Agg1.first_year, c.quantity,c.price
 FROM agg1 JOIN 
 c_sales AS c ON c.product_id = agg1.product_id AND c.year = agg1.first_year
 ORDER BY product_id;
 
 
 -- 2
 WITH agg2 AS(SELECT student_id, MAX(grade) AS max_grade
 FROM students
 GROUP BY student_id)
 
 SELECT c.student_id,MIN(c.course_id), agg2.max_grade
 FROM agg2
 JOIN students c ON c.student_id = agg2.student_id AND c.grade = agg2.max_grade
 GROUP BY c.student_id,agg2.max_grade
 ORDER BY c.student_id;
 
 -- 3
 SELECT event_day,emp_id, SUM(out_time) - SUM(in_time) AS total_time
 FROM empattendance
 GROUP BY event_day,emp_id;
 
 -- 4 
 SELECT d_name,emp_name, salary FROM
 (
 SELECT d.name AS d_name,e.name AS emp_name,e.salary as salary,
 ROW_NUMBER() OVER(PARTITION BY e.departmentid ORDER BY e.salary DESC) AS row_no
 FROM empdetails e
 JOIN deptdetails d ON d.id = e.departmentid)sq
 WHERE row_no < 4;
 
 -- 5
 SELECT day,rental_count, SUM(rental_count) OVER(ORDER BY day) AS cumulative_sum
 FROM rental_count;
 
 -- 6
 SELECT COUNT(*)
 FROM joina
 JOIN joinb ON joina.Id = joinb.Id;
 SELECT COUNT(*)
 FROM joina
 LEFT JOIN joinb ON joina.Id = joinb.Id;
 SELECT COUNT(*)
 FROM joina
 RIGHT JOIN joinb ON joina.Id = joinb.Id;
 SELECT COUNT(*)
 FROM joina
 FULL JOIN joinb ON joina.Id = joinb.Id;
 
 
 -- 7  
 SELECT a.id AS ID,a.name,a.salary,a.managerId
 FROM emp_manager a
 JOIN emp_manager b ON a.managerId = b.id
 WHERE a.salary > b.salary;
 
 -- 8
 SELECT first_name,Date_of_Birth,CONCAT(first_name, ' ', last_name) AS full_name, 
 LOWER(CONCAT(first_name, last_name,'@gmail.com')) AS email,
 CONCAT(SUBSTR(first_name,1,4),DATE_FORMAT(STR_TO_DATE(Date_of_Birth,'%d-%m-%Y'),'%d%c%Y')) AS pswd
 FROM User_bio;
 
 -- 9 (How to simplify it)
SELECT emp_id, CASE WHEN COUNT(*) > 1 THEN 'TRUE' ELSE 'FALSE' END AS is_hike
FROM
(SELECT emp_id,salary, COUNT(*) AS countofsalries
FROM hike
GROUP BY emp_id, salary)sq
GROUP BY emp_id;

-- 10
SELECT product,
SUM(CASE WHEN country = 'USA' THEN Amount ELSE 0 END) AS usa,
SUM(CASE WHEN country = 'China' THEN Amount ELSE 0 END) AS China,
SUM(CASE WHEN country = 'Canada' THEN Amount ELSE 0 END) AS Canada,
SUM(CASE WHEN country = 'Mexico' THEN Amount ELSE 0 END) AS Mexico
FROM products
GROUP BY product
ORDER BY product;

-- 11(might need optimization)
SELECT userID,productID, COUNT(*) totalpurchase
FROM
(SELECT userID,productID,purchaseDate,COUNT(*) AS no_of_purchase
FROM purchase
GROUP BY 1,2,3
HAVING no_of_purchase < 2)sq
GROUP BY 1,2
HAVING totalpurchase > 1;

-- 12(How to modify the query if the there are non symmentric rows for a single customer_Id or if there are more than two transit)

SELECT customer_id,origin,dest FROM 
(SELECT customer_id,flight_id,origin,destination,LEAD(destination) OVER(PARTITION BY customer_id ORDER BY flight_id) AS dest
FROM org_dest)sq
WHERE dest IS NOT NULL;

 
 
 
 

 

 
