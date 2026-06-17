create table sea(
transactions_id int,
sale_date date,
sale_time time,
customer_id int,
gender varchar(20),
age int,
category varchar(20),
quantiy int,
price_per_unit int,
cogs int,
total_sale int
)

alterv table sea
alter column cogs type to 

copy sea
from 'C:\Program Files\PostgreSQL\18\data\zero_ana.csv'
delimiter ','
csv header


--1 write a sql querry to retrieve all columns for sales on 2022-11-05
select * from sea
where sale_date = '2022-11-05'

--2 querry to retrieve all traansaction from category clothing and quantity>=3 in nov 2022
select * from sea
where    category = 'Clothing' 
and
      to_char(sale_date,'yyyy-mm')= '2022-11'
and    quantity >=3

--3. querry to calculate the total sales for each category
select category, sum(total_sale) from sea
group by category

--4. find avg age of customer who purchased items from beauty category
select avg(age) from sea
where category = 'Beauty'

--5 write a querry  to find transaction where total sale >1000
select * from sea
where total_sale > 1000


--6 write a querry  to find totalnum of transaction made by each gender in each category
select count(*),  category, gender from sea
group by gender,  category
order by count(*) desc, gender asc

--7. querry to calculate the average sale for each month . find out best selling month in each year
select * from(
select extract(month from sale_date),extract(year from sale_date),round(avg(total_sale),2) , 
rank() over(partition by extract(month from sale_date) order by avg(total_sale) desc) 
from sea
group by 1,2) as t
where rank = 1


--8 find top 5 customer based on total_sale
select customer_id ,gender, age,sum(total_sale)
from sea
group by 1,2,3
order by 4 desc
limit 5


--9 querry to find number of unique customer who purchased from each category
select  count(distinct(customer_id)), category from sea
group by 2

-- 10 write a querry to ctreate each shift and num of order (mrng<=12, noon between 12&17, eve >17)
select case
when extract(hour from sale_time) <=12 then 'morning'
when extract(hour from sale_time) between 12 and 17  then 'afternoon'
else 'evening'
end as shift
from sea














