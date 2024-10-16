--1. Which state has the highest number of EV sales?

select "State",sum("EV_Sales_Quantity") as "EV_Sales" from "EV_Sales"
group by "State"
order by "EV_Sales" desc
limit 1;

--2. What is the total number of EV sales across all states?

select "State",sum("EV_Sales_Quantity") as "Total_EV_Sales" from "EV_Sales"
group by "State"
order by "Total_EV_Sales" desc

--3. What is the average number of EV sales per state?

select "State",avg("EV_Sales_Quantity") as "Average_Sales" from "EV_Sales"
group by "State";


--4. Which state has shown the highest growth in EV sales?

select "State","Year", SUM("EV_Sales_Quantity") AS "yearly_sales"
from "EV_Sales"
GROUP BY "State","Year"
ORDER BY "yearly_sales" DESC
LIMIT 1;

--5. What percentage of the national EV sales does each state contribute?
select "State",sum("EV_Sales_Quantity")*100/(select sum("EV_Sales_Quantity") from "EV_Sales") as "percentage_contribution"
from "EV_Sales"
group by "State"
order by "percentage_contribution" desc;


-- Which states are above or below the national average in terms of EV sales?

WITH "State_Sales" AS (
    -- Calculate the total sales for each state
    SELECT "State", SUM("EV_Sales_Quantity") AS "Total_Sales"
    FROM "EV_Sales"
    GROUP BY "State"
),

"Avg_Sales" AS (
    -- Calculate the overall average total sales across all states
    SELECT AVG("Total_Sales") AS "Avg_Sales"
    FROM "State_Sales"
)

-- Compare each state's total sales with the overall average
SELECT "State", "Total_Sales",
       CASE 
         WHEN "Total_Sales" > (SELECT "Avg_Sales" FROM "Avg_Sales") THEN 'Above Average'
         ELSE 'Below Average'
       END AS "comparison"
FROM "State_Sales";


--7. What is the trend in EV sales for the top 5 states over the years?

SELECT "State","Year", SUM("EV_Sales_Quantity") AS "Yearly_Sales"
FROM "EV_Sales"
GROUP BY "State","Year"
ORDER BY "Yearly_Sales" DESC
LIMIT 5;
