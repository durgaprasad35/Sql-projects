use final 

select *
from Final_data;  

-- Rounding off the value of the age 

select round(Age,0)  as age_dis 
from Final_data 

-- Updating the Age column
update Final_data 
set Age = round(Age,0) 


select round(Weight_kg ,2)
from Final_data 

-- updating the Weight_kg column 
update Final_data 
set Weight_kg = round(Weight_kg ,2) 

select round(Height_m * 3.28084,2)  as Height_feet
from Final_data 

-- creating the new column 
alter table Final_data 
add Height_feet_ float; 
-- updating the Height_feet column 
update Final_data 
set Height_feet_ = round(Height_m * 3.28084 ,3) 

-- Dropping a column in the table 
alter table Final_data 
drop column Height_feet

select round(Water_Intake_liters,2) from Final_data 

-- updating the column Water_Intake_liters 
update Final_data 
set Water_Intake_liters = round(Water_Intake_liters,2)

-- Creating a column based on the bmi column 
alter table Final_data 
add Bmi_analyis nvarchar(50) 
-- now updating the new created column 
update Final_data
set Bmi_analyis = case 
						when BMI < 18.5 then 'Under Weight' 
						when BMI >= 18.5 and BMI <= 24.9 then 'Healthy Weight' 
						when BMI >= 25 and BMI <= 29.9 then 'Over Weight' 
						else 'Obesity' 
				  end 

-- removing the spaces in the column of meal_type 
update Final_data 
set 
	meal_type = trim(meal_type) , 
	diet_type = trim(diet_type) , 
	meal_name = trim(meal_name) , 
	cooking_method = trim(cooking_method), 
	Name_of_Exercise = trim(Name_of_Exercise) , 
	Benefit = trim(Benefit) , 
	Target_Muscle_Group = trim(Target_Muscle_Group) ,
	Equipment_Needed = trim(Equipment_Needed) , 
	Difficulty_Level = trim(Difficulty_Level) , 
	Body_Part = trim(Body_part) ,
	Type_of_Muscle = trim(Type_of_Muscle) ,
	Workout = trim(Workout)  
	 



-- Dropping the columns 

alter table Final_data 
drop column Height_m 

select * from Final_data 