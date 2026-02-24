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
