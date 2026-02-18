--1683. Invalid Tweets

Select tweet_id
from Tweets
where length(content)>15;


--1667. Fix Names in a Table

-- can you include in my feed why initcap can't be used here
select user_id , concat(upper(substr(name,1,1)),lower(substr(name,2))) as name
from users
order by user_id;


-- 1873. Calculate Special Bonus

select employee_id ,
 case
  when employee_id%2!=0 and name not like 'M%' 
  then salary 
  else 0 end 
as bonus
from Employees
order by employee_id;


--1527. Patients With a Condition

select  patient_id , patient_name ,conditions   
from Patients
where conditions like 'DIAB1%' OR conditions like '% DIAB1%';


-- 1741. Find Total Time Spent by Each Employee

select event_day as day , emp_id,sum(out_time-in_time) as total_time
from Employees
group by event_day,emp_id;


-- 1729. Find Followers Count

select user_id ,count(follower_id)as followers_count
from Followers
group by  user_id
order by user_id;


--1693. Daily Leads and Partners

select date_id ,make_name ,count(distinct lead_id) as unique_leads, count( distinct partner_id) as unique_partners    
from DailySales 
group by date_id ,make_name;


--1050. Actors and Directors Who Cooperated At Least Three Times

select actor_id , director_id
from ActorDirector
group by actor_id , director_id
having count(concat(actor_id,director_id)) >= 3;


--596. Classes With at Least 5 Students

select class
from Courses
group by class
having count(class) >= 5;


--511. Game Play Analysis I

select player_id , min(event_date) as first_login
from Activity
group by player_id;



--1393. Capital Gain/Loss

select stock_name , sum(
    case 
    when operation ='Sell' then price
    else - price
    end ) as capital_gain_loss
from Stocks
group by stock_name;


--176. Second Highest Salary

select max(salary) as SecondHighestSalary
from Employee
where salary <(select max(salary)
               from employee );