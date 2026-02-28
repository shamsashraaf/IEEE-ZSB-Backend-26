--182. Duplicate Emails

select email as Email
from Person 
group by email
having count(email)>1;



--196. Delete Duplicate Emails

delete p1
from person p1 
join person p2 on p1.email = p2.email
where p1.id > p2.id;


--177. Nth Highest Salary

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN  set N=N-1;
  RETURN (  select distinct salary
            from Employee
            order by salary desc
            limit 1 offset N  
  );
END


--178. Rank Scores

select score , dense_rank() over(order by score desc) as "rank"
from Scores
order by score desc;


--184. Department Highest Salary

select x.deptname as Department , x.name as Employee , x.salary
from( select e.name , e.salary , d.name as deptname , dense_rank() over(partition by e.departmentid order by salary desc) as r
      from Employee e
      inner join Department d
      on e.departmentid=d.id ) as x
where x.r=1;