-- WHERE CLAUSE-- specifies criteria that field values must meet for the records that contain the values to be included in the query results.
Select * From parks_and_recreation. employee_salary where first_name = 'Tom'; 
Select * From parks_and_recreation. employee_salary where salary >50000; 
Select * From parks_and_recreation. employee_demographics where birth_date > '1985-01-01';
-- AND,OR,NOT--LOGICAL OPERATORS
Select * From parks_and_recreation. employee_demographics where birth_date > '1985-01-01' and gender = 'Male';
Select * From parks_and_recreation. employee_demographics where birth_date > '1985-01-01' or gender = 'Male';
Select * From parks_and_recreation. employee_demographics where birth_date > '1985-01-01' or not gender = 'Male';
-- LIKE STATEMENT--:used to search for a specific pattern in a string value
-- %:ANYTHING , _:SPICIFIC 
Select * From parks_and_recreation. employee_demographics where first_name like  'a%';#it means it give the first name which starts with the letter 'a' in the entire table.
Select * From parks_and_recreation. employee_demographics where first_name like  'a__';# here we have two'_'which means it represent the character in the table. If we give 3 '_' it shows the firstname based on four char in the table. 