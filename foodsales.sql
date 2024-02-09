create database food_sales;
use food_sales;
SELECT * FROM food_sales;
show tables;
#total sales sales for all orders Revenue
select sum(total_price) as total_sales from food_sales;
select round(sum(total_price),2)as total_sales from food_sales;
select cast(sum(total_price) as decimal(10,2)) as total_sales from food_sales;

#total orders placed

select distinct(count(order_id)) from food_sales;

#average pizza per order
select sum(quantity)/count(distinct order_id) as avg_pizza_per_order  from food_sales;
select * from food_sales;

# best seller pizza
select pizza_name,sum(total_price) as total_revenue from food_sales group by pizza_name order by total_revenue desc limit 5 ;

-- worst seller pizza--
select pizza_name,sum(total_price) as total_revenue from food_sales group by pizza_name order by total_revenue asc limit 5 ;


select * from food_sales;
#monthly trend of order


-- alter table food_sales modify column order_date date;
select date_format(str_to_date(order_date,'%d-%m-%Y'),'%M') from food_sales;
select date_format(str_to_date(order_date,'%d-%m-%Y'),'%M') as formatted_month,
count(distinct order_id) as total_order from food_sales group by formatted_month order by total_order desc;


#order by total_order desc--


-- The belwo qury fetches the day wise sales for pizza order
select date_format(str_to_date(order_date,'%d-%m-%Y'),'%a') as formatted_day ,
count(distinct order_id) as total_order from food_sales group by formatted_day order by total_order desc ;



-- select distinct(pizza_category) --
-- select distinct(pizza_category), sum(total_price)/count(total_price)*100 from food_sales group by pizza_category ;


#total sales by Percentage 
select pizza_category,sum(total_price) as total_sales, 
(sum(total_price)*100.0/(select sum(total_price) from food_sales)) as percentage_of_total_sales
 from food_sales group by pizza_category;







-- Quaterily sales-- 
select  quarter((str_to_date(order_date,'%d-%m-%Y'))) as pp ,
round(sum(total_price),2) as total_order from food_sales group by pp;





# percentage of sales by pizza size
select pizza_size , sum(total_price) from food_sales group by pizza_size ;
select pizza_size,sum(total_price) as total_sales,
 (sum(total_price)*100.0/(select sum(total_price) from food_sales)) as percentage_of_total_sales 
 from food_sales group by pizza_size;
 
#day wise order of pizza

select date_format(str_to_date(order_date,'%d-%m-%Y'),'%a') as formatted_day ,
sum(total_price) as total_order from food_sales group by formatted_day order by total_order desc;

select count(*) from food_sales where pizza_name in ('The Hawaiian Pizza','The Thai Chicken Pizza');





-- Weekday and weekend sales;
-- select weekday(date_format(str_to_date(order_date,'%d-%m-%Y'),'%a')) as week1day,sum(order_id) from food_sales  ;

-- select weekend(date_format(str_to_date(order_date,'%d-%m-%Y'),'%a')) as weekend ,count(order_id) from food_sales;
select date_format(str_to_date(order_date,'%d-%m-%Y'),'%a') as formatted_day ,
sum(total_price) as total_order from food_sales group by formatted_day order by total_order desc ;

select
case
when dayofweek(str_to_date(order_date,'%d-%m-%y')) in (1,7) then 'weekend'
else 'weekday'
end as day_category,
sum(total_price) as total_sales
from food_sales group by day_category;