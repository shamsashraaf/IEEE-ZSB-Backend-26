-- 1757. Recyclable and Low Fat Products

select product_id 
from Products
where low_fats ='Y' AND recyclable ='y';


-- 595. Big Countries

select name , population , area 
from World 
where area >= 3000000 OR population >= 25000000 ;


-- 584. Find Customer Referee

select name 
from Customer 
where referee_id !=2 OR referee_id is null;