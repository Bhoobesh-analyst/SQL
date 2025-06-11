-- CASE STATEMENT --
# A conditional statement used to evaluate a given expression and perform different actions based on the result of that evaluation.
select first_name,last_name,age ,
case	
	when age<=30 then'young'
    when age between 31 and 50 then 'old'
    when age>=50 then 'on death on door'
end as age_bracket
from employee_demographics;
-- PAY INCREASE AND BONUS --
-- < 50000 = 5%
-- > 50000 = 7%
-- FINANCE = 10% bonus
Select first_name,last_name,salary,
case	
	when salary < 50000 then salary*1.05
    when salary > 50000 then salary*1.05
end as new_salary,
case	
	when dept_id = 6 then salary*.10
end as bonus
from employee_salary;

