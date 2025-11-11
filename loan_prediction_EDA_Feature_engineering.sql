create database loan_prediction 

use loan_prediction 

select * from [Loan Eligibility Prediction] 

-- checking the Unique values in the Gender column  
select distinct Gender 
from [Loan Eligibility Prediction]; 
-- Performing the Feature engineering on the Gender column
update [Loan Eligibility Prediction] 
set Gender = case when Gender = 'Female' then 0 when Gender = 'Male' then 1 end  

select * from [Loan Eligibility Prediction]  

-- Checking the unique values in the Married column 
select distinct Married 
from [Loan Eligibility Prediction] 

-- Performing the Feature engineering on the Married column 
update [Loan Eligibility Prediction] 
set Married = case when Married = 'Yes' then 1 else 0 end 

select * from [Loan Eligibility Prediction] 

-- checking the unique elements in the Education column 
select distinct Education 
from [Loan Eligibility Prediction] 

-- Performing the feature engineering on the Education column 
update [Loan Eligibility Prediction] 
set Education = case when Education = 'Graduate' then 1 else 0 end 

select * from [Loan Eligibility Prediction] 

-- checking how many unique values are there in the Property_Area column 
select distinct Property_Area 
from [Loan Eligibility Prediction] ; 

-- Performing the Feature engineering on the Property_Area column 
update [Loan Eligibility Prediction] 
set Property_Area = case when Property_Area = 'Rural' then 1 
						 when Property_Area = 'Semiurban' then 2 
						 when Property_Area = 'Urban' then 3 
					end 
select * from [Loan Eligibility Prediction] 

-- Checking the unique elements in the Loan_Staus column 
select distinct Loan_Status 
from [Loan Eligibility Prediction] 
-- performing the feature engineering on the Loan_Status column 
update [Loan Eligibility Prediction] 
set Loan_Status = case when Loan_Status = 'N' then 0 else 1 end 

-- Checkinng null values in the Gender column 
select Gender 
from [Loan Eligibility Prediction] 
where Gender = null 
-- Observation : There are no null values in the Gender column 

-- Checking the null values in the Married column 
select Married 
from [Loan Eligibility Prediction] 
where Married = null 

-- Observation : In the married column also there are no null values 

select * from [Loan Eligibility Prediction] 

-- Checking null values in the Dependents 
select Dependents 
from [Loan Eligibility Prediction] 
where Dependents = null 

-- Observation there are no null values in the Dependents column 

select Education , Self_Employed , Applicant_Income,Coapplicant_Income,Loan_Amount,
Loan_Amount_Term,Credit_History,Property_Area,Loan_Status
from [Loan Eligibility Prediction] 
where Education = null or Self_Employed = null or Applicant_Income = null or Coapplicant_Income= null 
or Loan_Amount = null or Loan_Amount_Term = null or Credit_History = null or 
Property_Area = null or Loan_Status = null 

-- Observation : There are no null values in the above data set 
select * from [Loan Eligibility Prediction] 

-- Droping the customer_id column 
alter table [Loan Eligibility Prediction] 
drop column Customer_ID 

select * from [Loan Eligibility Prediction] 

-- Now the data is ready for the training the model!!!