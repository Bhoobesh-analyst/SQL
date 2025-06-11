-- DATA CLEANING -- 
-- STEPS FOR THE PROCEDURE --
-- 1.REMOVE DUPLICATES
-- 2.STANDIZE THE DATA
-- 3.NULL VALUES OR BLANK VALUES
-- 4.REMOVE ANY COLUMNS -- 

SELECT * 
FROM world_layoffs.layoffs;
CREATE TABLE world_layoffs.layoffs_staging 
LIKE world_layoffs.layoffs;
INSERT layoffs_staging 
SELECT * FROM world_layoffs.layoffs;

-- REMOVE DUPLICATES


SELECT *
FROM world_layoffs.layoffs_staging
;
SELECT company, industry, total_laid_off,`date`,
		ROW_NUMBER() OVER (
			PARTITION BY company, industry, total_laid_off,`date`) AS row_num
	FROM 
		world_layoffs.layoffs_staging;
-- it looks like these are all legitimate entries and shouldn't be deleted. We need to really look at every single row to be accurate
-- these are our real duplicates 

SELECT *
FROM (
	SELECT company, industry, total_laid_off,`date`,
		ROW_NUMBER() OVER (
			PARTITION BY company, industry, total_laid_off,`date`
			) AS row_num
	FROM 
		world_layoffs.layoffs_staging
) duplicates
WHERE 
	row_num > 1
-- these are the ones we want to delete where the row number is > 1 or 2or greater essentially

-- now you may want to write it like this:

CREATE TABLE `layoffs_staging` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 
(
SELECT *
FROM (
	SELECT company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM 
		world_layoffs.layoffs_staging
) duplicates
WHERE 
	row_num > 1
)
DELETE
FROM DELETE_CTE
;
-- one solution, which I think is a good one. Is to create a new column and add those row numbers in. Then delete where row numbers are over 2, then delete that column
-- so let's do it!!


ALTER TABLE world_layoffs.layoffs_staging ADD row_num INT;
SELECT *
FROM world_layoffs.layoffs_staging
;

CREATE TABLE `world_layoffs`.`layoffs_staging2` (
`company` text,
`location`text,
`industry`text,
`total_laid_off` INT,
`percentage_laid_off` text,
`date` text,
`stage`text,
`country` text,
`funds_raised_millions` int,
row_num INT
);
INSERT INTO `world_layoffs`.`layoffs_staging2`
(`company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
`row_num`)
SELECT `company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM 
		world_layoffs.layoffs_staging;
-- now that we have this we can delete rows were row_num is greater than 2

DELETE FROM world_layoffs.layoffs_staging2
WHERE row_num >= 1;
select * from world_layoffs.layoffs_staging2;

 -- 2. Standardize Data
 
SELECT * 
FROM world_layoffs.layoffs_staging2;
-- if we look at industry it looks like we have some null and empty rows, let's take a look at these
SELECT DISTINCT industry
FROM world_layoffs.layoffs_staging2
ORDER BY industry;
Select company,trim(company) 
from world_layoffs.layoffs_staging2;
update world_layoffs.layoffs_staging2
set company = trim(company);
Select distinct industry
from world_layoffs.layoffs_staging2;
-- Here we are changing the Crypto currency into crypto
Select *
from world_layoffs.layoffs_staging2 where industry like 'Crypto%';
update world_layoffs.layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';
-- As we done on above process we are checking locations
 Select distinct location
from world_layoffs.layoffs_staging2
order by 1;
-- everything looks good except apparently we have some "United States" and some "United States." with a period at the end. Let's standardize this.

Select distinct country
from world_layoffs.layoffs_staging2
order by 1;
Select distinct country,trim(trailing '.' from country)
from world_layoffs.layoffs_staging2
order by 1;
update world_layoffs.layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';
-- we can use str to date to update this field
select `date`,
str_to_date(`date`,'%m/%d/%Y')
from world_layoffs.layoffs_staging2;
update world_layoffs.layoffs_staging2
set `date`= str_to_date(`date`,'%m/%d/%Y');
select `date` from  world_layoffs.layoffs_staging2;
-- now we can convert the data type properly
alter table world_layoffs.layoffs_staging2
modify column `date` date;
select * from world_layoffs.layoffs_staging2;

-- 3. Look at Null Values
-- the null values in total_laid_off, percentage_laid_off, and funds_raised_millions all look normal. I don't think I want to change that
-- I like having them null because it makes it easier for calculations during the EDA phase

-- so there isn't anything I want to change with the null values

Select * from world_layoffs.layoffs_staging2
where total_laid_off is null
and percentage_laid_off is not null;
update world_layoffs.layoffs_staging2
set industry=null
where industry='';
select *
from world_layoffs.layoffs_staging2
where industry is null
or industry='';
select * 
from world_layoffs.layoffs_staging2
where company = 'Airbnb';
select * 
from  world_layoffs.layoffs_staging2 t1
join  world_layoffs.layoffs_staging2 t2
	on t1.company = t2.company
    and t1.location = t2.location
where (t1.industry is null or t1.industry ='')
and t2.industry is not null;
update world_layoffs.layoffs_staging2 t1
join  world_layoffs.layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null;
-- 4. remove any columns and rows we need to

Select * from world_layoffs.layoffs_staging2
where total_laid_off is null
and percentage_laid_off is not null;
delete 
from world_layoffs.layoffs_staging2
where total_laid_off is null
and percentage_laid_off is not null;
select * from world_layoffs.layoffs_staging2;
alter table world_layoffs.layoffs_staging2               
drop column row_num;
