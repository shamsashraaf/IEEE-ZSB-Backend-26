# Research Questions

### 1- UNION vs UNION ALL

 - Duplicate Handling :

    - **UNION** :
       -  Combines result sets
       - Removes duplicate rows automatically
       - Works like `SELECT DISTINCT`

       > If the same name appears in both tables :-
        it will appear once only in the final result


    - **UNION ALL**:
        - Combines result sets
        - Keeps all duplicates `Does NOT remove anything`
       
        > If the same name appears in both tables :- 
        it will appear twice in the final result

- Performance Difference :

    - **UNION** : `Slower`

      After combining results the database :
         - Sort date
         - Check for duplicates
         - Remove duplicates
         > this takes extra `time` and `memory`

    - **UNION ALL** : `Faster` 

       it just **merges** the results 

         - NO extra processing
        - NO duplicate checking 

        > better performance especially with `large` datasets 
          
---
### 2- Subquery vs JOIN 

**subquery** : is a query within a query used to provide a value for the outer query
**JOIN** : combines rows from multiple tables based on related columns

**Why choose JOIN instead of Subquery in production?**

- Better performance (especially with large data) `JOINS are usually faster`
- Optimized better by the database engine
- More scalable `Works better with large datasets`
- Avoids slow correlated subqueries (which run once per row)

> In real production systems with large data,**JOIN** is generally more **efficient** and **reliable**.