-- JOINS --
-- INNER JOINS -- #rows from two tables based on a matching value in a common column, returning only the rows where there are matches in both tables
Select * from employee_demographics as dem inner join employee_salary as sal on dem.employee_id = sal.employee_id;
Select dem.employee_id,age,occupation from employee_demographics as dem inner join employee_salary as sal on dem.employee_id = sal.employee_id;
-- OUTER JOINS --
#Outer Join ensures that all rows from one or both tables are included in the result, even if there is no match in the other table. 
#It is particularly useful when you need to show all records from one table, including those that don't have a match in the other table.
# It has three types. right ,left and self joins.
#The LEFT OUTER JOIN (referred to as LEFT JOIN) returns all rows from the left table, and the matching rows from the right table.
# If there is no match, the result will include NULL values for columns from the right table.
#The RIGHT OUTER JOIN (often called RIGHT JOIN) returns all rows from the right table, and the matching rows from the left table.
# If there is no match, the result will include NULL values for columns from the left table
select * from employee_demographics as dem left join employee_salary as sal on dem.employee_id = sal.employee_id;
select * from employee_demographics as dem right join employee_salary as sal on dem.employee_id = sal.employee_id;