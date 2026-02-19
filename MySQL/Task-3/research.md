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



## 2- DELETE vS TRUNCATE vS DROP :

|Delete|Truncate|Drop|
|:------|:------|:------|
|removes **specific rows**|removes **all rows**| delete **entire table** `(structure and date)` |
|**can** use `WHERE`|**can't** use `WHERE`|**can't** use `WHERE`|
|**can be** `rolled back` |**can't** be `rolled back` |**can't** be `rolled back`|


## 3- Order of Execution :

The database does not read a **SELECT** query in the order you write it.

**Logical order** of execution :

- **FROM** → Get the table(s)
- **WHERE** → Filter rows
- **GROUP BY** → Group rows
- **HAVING** → Filter groups
- **SELECT** → Choose columns
- **ORDER BY** → Sort final result


## 4- COUNT(*) vs COUNT(Column_Name) :

#### COUNT(*) :
   - Counts all rows.
   - Includes rows even if there are **NULL values**.
   - Does NOT care about column values.

#### COUNT(Column_Name):
   - Counts only rows where the column is **NOT NULL**.
   - Ignores **NULL** values in that column.


## 5- CHAR(10) vs VARCHAR(10) :

- Both can store up to **10 characters**, but they handle **storage** differently.

#### CHAR(10) :

- Fixed length.
- Always uses 10 characters, even if the word is **shorter**.
 - If we store "Cat", it becomes:

         "Cat       "

    - Uses full 10 characters (3 letters + 7 spaces) .

#### VARCHAR(10) :

- Variable length.
- Stores only the actual characters.
- If we store "Cat", it stays:
 
        "Cat"
    
    - Uses only 3 characters (plus small extra storage for length).