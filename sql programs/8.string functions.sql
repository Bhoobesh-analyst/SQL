-- STRING FUNCTIONS --
-- LENGTH -- 
select first_name,LENGTH(first_name) from employee_demographics ORDER by 2;
-- UPPER CASE & LOWER CASE --
Select first_name,UPPER(first_name) from employee_demographics;
Select first_name,LOWER(first_name) from employee_demographics;
 -- TRIM -- # Trim function is used to delete the space based on the input either left or right.
 Select trim('      sky      ');
 Select first_name,left(first_name,4) from employee_demographics;# 4 represents the char as to print
Select first_name,right(first_name,4) from employee_demographics;
Select first_name,left(first_name,4) ,right(first_name,4),substring(first_name,3,2),birth_date,substring(birth_date,6,2) As birth_month from employee_demographics;
-- REPLACE -- # It means by using replace function we can change the char.
select first_name ,replace(first_name,'a','z') from employee_demographics;
-- LOCATE-- # The locate function is used to find the location of the particular word or char.
select first_name ,locate('An',first_name) from employee_demographics;
-- CONCATE -- # It is used to combine the multiple values into single values.
select first_name,last_name ,concat(first_name,' ',last_name) as full_name from employee_demographics;