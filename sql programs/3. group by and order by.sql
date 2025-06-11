-- GROUP BY--: 
#Group together rows of same values in the spcified cloumns that are you acually grouping on which aggregrate the functions.
Select gender from employee_demographics group by gender;
Select gender,avg(age) from employee_demographics group by gender;# it average the age based on the gender and group it in gender cloumn
Select gender,avg(age),min(age),max(age),count(age) from employee_demographics group by gender;# here it finds the minimum and maximum of the age and it count the how many columns are  in gender table.
-- ORDER BY--
# it is used to set the table values in asecending or descending order. By default if we use order by state it would be in asec.
select * from employee_demographics order by age, gender; # here we see that age cloumn is in proper format for low to high.
