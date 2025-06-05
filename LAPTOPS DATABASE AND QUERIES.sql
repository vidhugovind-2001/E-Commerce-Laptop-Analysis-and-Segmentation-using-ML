SELECT * FROM capstone.laptops_cleaned_copy;

ALTER TABLE laptops_cleaned_copy CHANGE `Rom Type` Rom_type varchar(50);
ALTER TABLE laptops_cleaned_copy CHANGE `Total Ratings` Total_Reviews int;

SELECT COUNT(*) AS total_rows FROM laptops_cleaned_copy;

SELECT *, COUNT(*) as cnt
FROM laptops_cleaned_copy
GROUP BY Laptop_name, Laptop_price, Rating, Total_Reviews, Category, Brand, Model, Ram, Rom, Rom_type, OS, Graphics
HAVING COUNT(*) > 1;

CREATE TABLE laptops_no_duplicates AS
SELECT DISTINCT *
FROM laptops_cleaned_copy;

SELECT distinct * FROM laptops_no_duplicates
WHERE Laptop_price > 100000
ORDER BY Laptop_price DESC;
SELECT Brand, ROUND(AVG(Laptop_price), 2) AS avg_price
FROM laptops_no_duplicates
GROUP BY Brand
ORDER BY avg_price DESC;

SELECT DISTINCT Brand, Laptop_name, Laptop_price
FROM laptops_no_duplicates l
WHERE Laptop_price = (
  SELECT MAX(Laptop_price)
  FROM laptops_no_duplicates l2
  WHERE l2.Brand = l.Brand
)
ORDER BY Laptop_price DESC;

SELECT
  SUM(CASE WHEN Laptop_name IS NULL THEN 1 ELSE 0 END) AS null_Laptop_name,
  SUM(CASE WHEN Laptop_price IS NULL THEN 1 ELSE 0 END) AS null_Laptop_price,
  SUM(CASE WHEN Rating IS NULL THEN 1 ELSE 0 END) AS null_Rating,
  SUM(CASE WHEN Total_Reviews IS NULL THEN 1 ELSE 0 END) AS null_Total_Ratings,
  SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS null_Category,
  SUM(CASE WHEN Brand IS NULL THEN 1 ELSE 0 END) AS null_Brand,
  SUM(CASE WHEN Model IS NULL THEN 1 ELSE 0 END) AS null_Model,
  SUM(CASE WHEN Ram IS NULL THEN 1 ELSE 0 END) AS null_Ram,
  SUM(CASE WHEN Rom IS NULL THEN 1 ELSE 0 END) AS null_Rom,
  SUM(CASE WHEN Rom_Type IS NULL THEN 1 ELSE 0 END) AS null_Rom_Type,
  SUM(CASE WHEN OS IS NULL THEN 1 ELSE 0 END) AS null_OS,
  SUM(CASE WHEN Graphics IS NULL THEN 1 ELSE 0 END) AS null_Graphics
FROM laptops_no_duplicates;

SELECT Brand, COUNT(*) AS count
FROM laptops_no_duplicates
GROUP BY Brand
ORDER BY count DESC;

SELECT COUNT(*) AS total_rows FROM laptops_no_duplicates;