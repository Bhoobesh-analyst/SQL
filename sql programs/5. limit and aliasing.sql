-- LIMIT -- # it gives the limitation for the table
select * from employee_demographics limit 3;
select * from employee_demographics order by age desc limit 3;
select * from employee_demographics order by age desc limit 2,1;
-- ALIASING -- # here we can change the cloumn name
select gender, avg(age) as avg_age from employee_demographics group by gender having avg_age >40; 

