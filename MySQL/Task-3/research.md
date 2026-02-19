# Research Questions :

## 1- Deference between Where and Having :

Both **WHERE** and **HAVING** are used to `filter data`, but the key difference is:

|Where   | Having   |
| :-------- | :-------- |
| Filters rows before grouping |Filters groups after grouping|
| Used with normal conditions | Used with aggregate functions |
| Cannot use SUM(), COUNT(), etc. | Can use SUM(), COUNT(), AVG(), etc.|

**WHERE** :
- used before **GROUP BY** 

Code Ex :

```SQL
select *
from Employees
WHERE Salary > 5000;
```
- This filters rows where salary is greater than 5000.

**HAVING**:
- Used after **GROUP BY**

Code Ex :
```SQL
select Department, COUNT(*) as TotalEmployees
from Employees
GROUP BY Department
HAVING COUNT(*) > 5;
```
- This groups employees by department, then filters departments that have more than 5 employees


## 2- DELETE VS TRUNCATE VS DROP :

|Delete|Truncate|Drop|
|:------|:------|:------|
|removes **specific rows**|removes **all rows**| delete **entire table** `(structure and date)` |
|**can** use `WHERE`|**can't** use `WHERE`|**can't** use `WHERE`|
|**can be** `rolled back` |**can't** be `rolled back` |**can't** be `rolled back`|

**DELETE** :

Code Ex :

```SQL
DELETE FROM Employees
WHERE Salary < 3000;
```
- Deletes selected rows.
- Can be undone .

**TRUNCATE** :

Code Ex :

```SQL
TRUNCATE TABLE Employees;
```
- Deletes all rows quickly.
- Cannot use WHERE.
- Usually cannot be rolled back.

**DROP** :

Code Ex :

```SQL
DROP TABLE Employees;
```
- Deletes the whole table (data + structure).
- Cannot be undone.

