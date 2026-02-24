--175. Combine Two Tables

select firstName,lastName,city,state 
from Person p
left join Address a
on p.personId = a.personId;


--1378. Replace Employee ID With The Unique Identifier

select unique_id,name
from Employees emp
left join EmployeeUNI empuni
on emp.id= empUNI.id;


--1581. Customer Who Visited but Did Not Make Any Transactions

select customer_id,count(customer_id) as count_no_trans 
from Visits  v
left join Transactions  t
on v.visit_id=t.visit_id
where t.transaction_id is null 
group by customer_id;


--1075. Project Employees I

select p.project_id,round(AVG(experience_years),2) as average_years 
from Project p 
join Employee e
on p.employee_id = e.employee_id      
group by p.project_id ;


--607. Sales Person

select s.name
from SalesPerson s
where sales_id not in ( select o.sales_id
                        from orders o
                        join Company c
                        on o.com_id=c.com_id      
                        where c.name='RED' );


--197. Rising Temperature

select w1.id
from Weather w1
join weather w2
on datediff(w1.recordDate, w2.recordDate) = 1
where w1.temperature>w2.temperature ;


--1661. Average Time of Process per Machine

select a.machine_id,round(AVG(act.timestamp-b.timestamp),3) as processing_time
from Activity a join Activity b
on a.machine_id=b.machine_id
and a.process_id=b.process_id
and b.activity_type='start'
join Activity act
on a.machine_id=act.machine_id
and a.process_id=act.process_id
and act.activity_type='end'
group by a.machine_id;


--1280. Students and Examinations

select s.student_id,s.student_name,
sub.subject_name, count(e.student_id)as attended_exams
from Students s
cross join Subjects sub
left join Examinations e
on s.student_id=e.student_id
and sub.subject_name=e.subject_name
group by 
s.student_id,s.student_name,sub.subject_name
order by s.student_id, sub.subject_name;


--570. Managers with at Least 5 Direct Reports

select emp.name 
from Employee e
inner join Employee emp
on e.managerId=emp.id
group by emp.id,emp.name
having count(e.id)>=5;


--1934. Confirmation Rate

select s.user_id,round(AVG(if(c.action='confirmed',1,0)),2) as confirmation_rate 
from Signups s
left join Confirmations c 
on s.user_id = c.user_id
group by s.user_id;


--1070. Product Sales Analysis III

select s.product_id,s.year as first_year,s.quantity, s.price
from Sales s
join ( select product_id, min(year)as first_year
       from Sales
       group by product_id) t
on s.product_id = t.product_id
and s.year = t.first_year;


--1158. Market Analysis I

select u.user_id as buyer_id,u.join_date,count(order_id) as orders_in_2019
from users u
left join orders o
on u.user_id = o.buyer_id
and year(order_date) = 2019
group by u.user_id, u.join_date;

