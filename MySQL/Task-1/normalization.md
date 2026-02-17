# Normalization

#### Why did they first thought of Normalization :

> to achive the goal that our raltional schema is a good rational schema

**there are things we need to handle to reach our goal**
 
- [Final Answer if you wanna skip :)](#now-the-tables-after-the-3nf-is-)

### in our task: 
  we have a messy Excel sheet (that's sound like a very not good schema) called `Legacy_data` containing this table :

 > Student_Grade_Report(Student_Name, Student_phone, Student_Address, Course_Title, Instructor_Name, Instructor_Dept, Dept_Building, Grade)
 
 **what make this table messy is** :
  - **Student_phone** cell often contains multible numbers   `"Multi-valued"`
  - **Student_Adress** is devided into **city, street, Zip** `"partial Dependency"`
  - **Dept_Bulding** depends on **Istructor_Dept**      `"Transitive Dependency"`

We need to convert this table into Third Normal Form **3NF**

---

**applying Normalization** means to decompose unsatisfactory relations by breaking up their attributes into smaller ones , `and there is like a chain of forms doing so`  :

- First Normal Form **1NF**  : never have more than one value in the same cell **"Multi value , composite"**
- Second Normal Form **2NF** : non key must depend on all the keys of the table **"partial dependency"**
- Third Normal Form  **3NF** : never have a non key depend on a non key **"Transitive Dependency"**

every one of them handle something and you must go through all of the forms before the form you wanna reach (like a chain)

---
to reach 3NF..First we need to apply the 1NF and 2NF
---
**First problem** in our table is that we have a multivalued cell and a composite attribute (**1NF** handle this ) 
    
- For the multi value :

     We will make a new table "Student_Phone":

     Student_Phone(Student_name,Student_phone):

     "student_name" is the fk and it's a  composite primary key with "student_phone"

- For the composite attribute :
   
     We will decompose "Student_Adress" to it's components in the same table 

      

 ### now the main table is devided into two tables :
 - **Student_Grade_Report** :

     (Student_Name, City, Street, ZIP, Course_Title, Instructor_Name, Instructor_Dept, Dept_Building, Grade) 
    
- **Student_Phone** :

     (Student_Name, Student_Phone)


**Second Problem** is that we have 2 `partial dependencies` (**2NF** handle this problem) 

we did apply the 1NF so that we can start applying 2NF (the chain again :) )

we will make a new table for each partial dependencie :   **all instructor's info , the three components of adress**


 ### now the main tables is :

 - **Student_Grade_Report** :
        
        (Student_Name, Course_title, Grade)

 - **Student_Phone** :

        (Student_Name, Student_Phone)

- **Student_Adress** : 

         (Student_Name, City, Street, ZIP)

    the adress only depends on the student name and has no thing to do with the course title **pk is Student_Name**

- **Instructor_info** :
        
         (Course_title, Instructor_Name, Instructor_Dept, Dept_Building)
    
    instructor info is associated with the course title and has no thing to do with student name **pk is Course_title**


**Third problem** is that there is trancitive dependencies we found that **dept_building** a non key only depend on **instructor_dept** which is a non key (**3NF** handle this)

and again we did apply the 2NF so we can start applying 3NF 

we will make a new table for the dept_building and the instructor_dept and the **pk is Instructor_dept** and it will be **fk in the old table** to refrence the new table 
  
### now the tables after the 3NF is :

- **Student_Grade_Report** :
        
        (Student_Name, Course_title, Grade)

 - **Student_Phone** :

        (Student_Name, Student_Phone)

- **Student_Adress** : 

         (Student_Name, City, Street, ZIP)

- **Instructor_info** :
        
         (Course_title, Instructor_Name, Instructor_Dept)

- **Dept_info**:

         (Instructor_Dept, Dept_Building)

So finally we have a good schema in the Third Normal Form   **Mission Completed**        