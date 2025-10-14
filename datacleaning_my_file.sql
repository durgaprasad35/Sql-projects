create database datacleaning 

use datacleaning 

select * from my_file 
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'my_file';

-- changing the datatype of the column 
alter table my_file 
alter column Rank nvarchar(50) 
-- Updating the Peak column
UPDATE my_file
SET Peak = LEFT(Peak, CHARINDEX('[', Peak + '[') - 1);
-- Updating the All_Time_Peak column 
update my_file 
set All_Time_Peak = left(All_Time_Peak , charindex('[',All_Time_Peak+'[') - 1); 

-- updating the Actual_gross column 
update my_file 
set Actual_gross = left(Actual_gross,charindex('[',Actual_gross+'[') - 1); 

-- Checking for the spaces Artist column 
select len(Artist) as original_length ,
len(trim(Artist)) as trimmed_length 
from my_file  
-- updating the Artist_column 
update my_file 
set Artist = trim(Artist) 

-- Checking the Tour_title column 
select len(Tour_title) as original_length ,
len(trim(Tour_title)) as trimmed_length 
from my_file 
-- Updating the Tour_title column 
update my_file 
set Tour_title = trim(Tour_title) 

select replace(Year_s,'-','to') from my_file 

update my_file 
set Year_s = replace(Year_s,'-','To') 
WHERE Year_s LIKE '%–%';


UPDATE my_file
SET Ref = REPLACE(REPLACE(Ref, '[', ''), ']', '');

-- changing the datatypes of the column for analysis 
-- changing the Peak column dataype from object to numeric
alter table my_file 
alter column Peak numeric 
-- Changing the All_Time_Peak datatype from object to numeric
alter table my_file 
alter column All_Time_Peak float  
-- changing the Adjusted_gross_in_2022_dollars 
alter table my_file 
alter column Adjusted_gross_in_2022_dollars float 
-- changing the Year_s column from object to date 
alter table my_file 
alter column Year_s date 
-- changing the Shows column datatype from object to the numeric 
alter table my_file 
alter column Shows numeric 
-- changing the Average_gross column from object to float 
alter table my_file 
alter column Average_gross float 
-- changing the datatype of Actual_gross column 
alter table my_file 
alter column Actual_gross float 

select * from my_file