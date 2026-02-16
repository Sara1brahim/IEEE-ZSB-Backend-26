# Normalization to 3NF – Student_Grade_Report

The university provided a messy table called:

Student_Grade_Report  
(Student_Name, Student_Phone, Student_Address, Course_Title,  
Instructor_Name, Instructor_Dept, Dept_Building, Grade)

This table mixes student, course, instructor, and department data in one place.  
Our goal is to organize it properly until it reaches Third Normal Form (3NF).

---

## What is Normalization?

Normalization is the process of organizing data in a database to:
- Reduce data duplication
- Prevent update and deletion problems
- Improve consistency
- Make the system easier to maintain

Instead of storing everything in one big table, we divide the data into smaller related tables.

---

# Step 1: First Normal Form (1NF)

### Goal:
Remove multi-valued attributes and make sure every cell contains only one value.

### The Problem:
The column `Student_Phone` sometimes contains multiple phone numbers in one cell.

Example (Incorrect):
Ahmed | 0100123456, 0111456789

This violates 1NF because each cell must contain only one atomic value.

### The Solution:
We separate phone numbers into a new table.

### Tables After 1NF:

Student  
- Student_ID (Primary Key)  
- Student_Name  
- Student_Address  

Student_Phone  
- Phone_ID (Primary Key)  
- Student_ID (Foreign Key)  
- Phone_Number  

Now:
- Each phone number is stored in a separate row.
- No cell contains multiple values.

The database now satisfies 1NF.

---

# Step 2: Second Normal Form (2NF)

### Goal:
Remove partial dependency.  
Every non-key column must depend on the entire Primary Key.

Assume that the relationship between Student and Course identifies a unique grade.  
So the logical primary key is (Student_ID, Course_Title).

### The Problem:
Student_Address depends only on Student_ID,  
not on Course_Title.

So it should not be repeated every time a student takes a new course.

### The Solution:
We separate student data from course performance data.

### Tables After 2NF:

Student  
- Student_ID (PK)  
- Student_Name  
- City  
- Street  
- Zip  

Course  
- Course_ID (PK)  
- Course_Title  

Enrollment  
- Student_ID (FK)  
- Course_ID (FK)  
- Grade  
Primary Key: (Student_ID, Course_ID)

Now:
- Student information depends only on Student_ID.
- Grade depends on both Student and Course.

The database now satisfies 2NF.

---

# Step 3: Third Normal Form (3NF)

### Goal:
Remove transitive dependency.  
Non-key columns must not depend on other non-key columns.

### The Problem:
Dept_Building depends on Instructor_Dept,  
not directly on Student or Course.

If the department changes its building, we would have to update many rows.

This is called a transitive dependency.

### The Solution:
We create separate tables for Department and Instructor.

### Final Tables in 3NF:

Student  
- Student_ID (PK)  
- Student_Name  
- City  
- Street  
- Zip  

Student_Phone  
- Phone_ID (PK)  
- Student_ID (FK)  
- Phone_Number  

Department  
- Dept_ID (PK)  
- Dept_Name  
- Dept_Building  

Instructor  
- Instructor_ID (PK)  
- Instructor_Name  
- Dept_ID (FK)  

Course  
- Course_ID (PK)  
- Course_Title  
- Instructor_ID (FK)  

Enrollment  
- Student_ID (FK)  
- Course_ID (FK)  
- Grade  
Primary Key: (Student_ID, Course_ID)

Now:
- Dept_Building depends only on Dept_ID.
- Instructor depends only on Department.
- Course depends only on Instructor.
- Enrollment connects Student and Course.

There are no partial or transitive dependencies.

The database is now in 3NF.

- Made the system scalable and maintainable

This structure is suitable for a real university database system.


