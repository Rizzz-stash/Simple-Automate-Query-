/* Notebook - Creating a New Database, Schema and User
 Show databases */

\l
 
/* Create database */

create database staff;
 
/* Connect to a database */

\c staff;
 
/* Create a new user with a password */
create user kiki with encrypted password 'decoder61';
 
/* Show users */

\du
 
/* Grant privileges on a database to a user */
grant all privileges on database staff to kiki;
 
/* Create a new schema */
create schema mystaff authorization john;
 
/* Show schemas */
\dn
 
/* how to list all postgres tables in one particular schema */
\dt schemaname.* 

/* Deleting a schema / database / user */
drop schema mystaff;

/* how to drop certain table in particular schema */
drop table schemaname.tablename;

\c postgres
drop database staff;
drop user kiki;

#######################################################################

/* Notebook - Creating Database Tables with Python */
import psycopg2
 
try:
    connection = psycopg2.connect(database = "staff", user = "kiki", password = "decoder61", host = "127.0.0.1", port = "5432")
    
except psycopg2.Error as err:
    print("An error was generated!")
    
else:
    print("Connection to database was successful!")
    
cursor = connection.cursor()
 
cursor.execute('''create table mystaff.employees
      (id int primary key not null,
       first_name varchar(25) not null,
       last_name varchar(25) not null,
       department varchar(25) not null,
       phone varchar(25),
       address varchar(50),
       salary int);''')
       
connection.commit()
 
connection.close()

#######################################################################

/* Notebook - Inserting Records Into a Table with Python */
import psycopg2
 
try:
    connection = psycopg2.connect(database = "staff", user = "kiki", password = "decoder61", host = "127.0.0.1", port = "5432")
    
except psycopg2.Error as err:
    print("An error was generated!")
    
else:
    print("Connection to database was successful!")
    
cursor = connection.cursor()
 
cursor.execute('''create table mystaff.employees
      (id int primary key not null,
       first_name varchar(25) not null,
       last_name varchar(25) not null,
       department varchar(25) not null,
       phone varchar(25),
       address varchar(50),
       salary int);''')
       
cursor.execute("insert into mystaff.employees (id,first_name,last_name,department,phone,address,salary) \
 values (1, 'John', 'Smith', 'Sales', '0123456789', '1st Street, Miami', 50000), \
        (2, 'Jack', 'Doe', 'IT', '0213456742', '2nd Street, NY', 55000), \
        (3, 'Emily', 'Davids', 'Sales', '0123456999', '3rd Street, LA', 59000), \
        (4, 'Karen', 'Willson', 'Logistics', '0823556785', '4th Street, Las Vegas', 41000), \
        (5, 'Emma', 'Richard', 'Marketing', '0423453580', '5th Street, Denver', 40000);")
       
connection.commit()
 
connection.close()

#######################################################################


/* Notebook - Updating Records Into a Table with Python */
#Updating the department column for the row(s) where the value on the last_name column is Doe
 
cursor = connection.cursor()
cursor.execute("update mystaff.employees set department = 'Logistics' where last_name = 'Doe';")
connection.commit()
connection.close()

#######################################################################

/* Notebook - Deleting Records From a Table with Python */
#Deleting all the records in the database for which the value in the salary column is greater than 50000
 
cursor = connection.cursor()
cursor.execute("delete from mystaff.employees where salary > 50000;")
connection.commit()
connection.close()

#######################################################################

/* Notebook - Querying the Database with Python */
cursor = connection.cursor()
 
 #Each with seperate execution

cursor.execute("select * from mystaff.employees where salary > 50000;").

records = cursor.fetchall()
 
for record in records:
    print(record)
    

cursor.execute("select * from mystaff.employees where last_name like '%Richard%';")

records = cursor.fetchall()
 
for record in records:
    print(record)
    

cursor.execute("select * from mystaff.employees where salary between 40000 and 45000;")

records = cursor.fetchall()
 
for record in records:
    print(record)
    

cursor.execute("select * from mystaff.employees where department in ('Sales', 'IT');")
 
records = cursor.fetchall()
 
for record in records:
    print(record)
    

#######################################################################


/* Notebook - Fetching Information From the Database with Python */
cursor = connection.cursor()
 
cursor.execute("select * from mystaff.employees where salary > 50000;")
#cursor.execute("select * from mystaff.employees where last_name like '%Emma%';")
#cursor.execute("select * from mystaff.employees where salary between 40000 and 45000;")
#cursor.execute("select * from mystaff.employees where department in ('Sales', 'IT');")
 
#Fetching all the rows in a query result; returns a list
records = cursor.fetchall()
 
#Fetching the next 2 rows in a query result; returns a list
records = cursor.fetchmany(size = 2)
 
#Fetching the next row in a query result; returns a tuple; returns None when no more records are available
#records = cursor.fetchone()
 
for record in records:
    print(record)


#######################################################################

/* Notebook - Committing and Rolling Back Transactions */
import psycopg2
 
try:
    connection = psycopg2.connect(database="staff", user = "kiki", password = "decoder61", host = "127.0.0.1", port = "5432")
    
except psycopg2.Error as err:
    print("An error was generated!")
    
else:
    print("Connection to database was successful!")
 
#Commiting (saving) the changes/transactions performed since the last commit()
connection.commit()
 
#Rolling back (undoing) the changes/transactions performed since the last commit()
connection.rollback()

#######################################################################

