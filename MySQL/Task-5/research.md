# Research Questions 

## 1. Window Functions vs GROUP BY

|GROUP BY|Window Functions|
|:----|:----|
|`Reduces` the **granularity** of the result|Do `NOT` reduce **granularity**|
|It collapses multiple rows into **one row** per group|They perform calculations across rows but **keep** every original row|
|The number of rows in the output becomes `smaller`|The number of rows stays `the same`|

>**GROUP BY** changes the level of detail by aggregating rows into groups,
while **window functions** preserve the original row-level granularity and add calculations alongside it.

## 2. Clustered vs Non-Clustered Indexes

- **Clustered Index (Leaf Nodes)** :
    - The leaf nodes contain the **actual** table data
    - The table itself is physically ordered based on the clustered index key
    - The B-Tree’s bottom level = the real rows

- **Clustered Index (Leaf Nodes)** :
    - The leaf nodes do NOT contain the full table rows
    - They contain:
        - The indexed column(s)
        - A pointer to the actual data
    - That pointer is:
        -  he clustered key (if a clustered index exists), or A row identifier (RID) if the table is a heap

- **Why Only ONE Clustered Index?**

  - **Because** A table’s data can only be physically sorted in one way   
  - **Since :**
     - A clustered index determines the **physical** order of rows on disk
     - Physical storage can only follow **one order**

## 3. Filtered & Unique Indexes

**Filtered Index** is an index that is created on only a subset of rows in a table using a WHERE condition.
- Why is it useful?
     - **less storage** : it indexes only some rows, not the whole table
     - **Faster Queries** : the database scans a much **smaller index** , does **fewer reads** , **executes faster** so performance improves significantly for **filtered queries**
- When is it ideal?
    - Soft delete systems (WHERE IsDeleted = 0)
    - Active / inactive records
    - Rare values (like Status = 'Pending')
    - Large tables with frequently queried subsets

 - Unique Index on Email – Why does it slow **INSERT** but speed **SELECT**? 

    * **SELECT** gets faster:
       * **AS** the index is stored as a **B-Tree** , it is **sorted** and **searching** becomes **O(log n)** instead of **O(n)**

    * **INSERT** becomes slower :

       * **AS** The database must : 
          
          -  Check if the email already exists (to enforce uniqueness)  
          - Find correct position in the **B-Tree**
          - Insert into the index structure
          - Possibly rebalance the tree
          > so each **insert** : Requires extrea read , write ... more work = slower **INSERT**

## 4. Choosing the Right Index for a Staging Table 
- We will use the **Heap** structure.
- Because it allows :
  - **maximum** insert speed.
  - **minimal** maintenance.
  - efficient **read once**.  

## 5. Database Transactions (ACID)

- **ALL or Nothing** (Atomicity) :

   A transaction must complete **fully** or not happen at all. If one part fails, the whole transaction is **rolled back**

- **What disastrous scenario happens if a partial failure occurs
without using a Transaction?**
   
Imagine transferring $100 from Account A to Account B:
  - Subtract $100 from A 
  - Crash happens before adding to B
  - Result without transaction:
   
    - $100 disappears
    - Money is lost → inconsistent database

  - With **Atomic transaction** :  both steps rollback so database stays consistent