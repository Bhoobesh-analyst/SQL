-- UNION --
# union is used to concate the one database to another database. By using uinon it default used to delete the duplicate valuesa and give the unique values only.
Select first_name , last_name from employee_demographics union Select first_name,last_name from employee_salary;
Select first_name , last_name from employee_demographics union all Select first_name,last_name from employee_salary;
# As we uses union all it does not delete the duplicate elements where it give the all the values in the table.
Select first_name , last_name,'old man'as label from employee_demographics where age>40 and gender = 'Male' 
union Select first_name,last_name,'old lady' as label from employee_demographics where age>40 and gender = 'Female'
union Select first_name,last_name,'highly paid employee' as label from employee_salary where salary>70000 order by first_name,last_name;