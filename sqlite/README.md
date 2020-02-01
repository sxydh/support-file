# Profile
SQLite simple guide
 
# Specification
 * 基本操作
   ```sql
   /*connect to a transient in-memory database*/
   sqlite3
   
   /*formatted output*/
   .header on
   .mode column
   .timer on
   
   /*quit SQLite*/
   .quit
   ```
 * 库
   ```sql
   /*create an database and enter into it, note that the following commands must be input in the exit state, and the database file will be saved in the path where the current  cmd is located*/
   sqlite3 test.db
   
   /*show databases*/
   .databases
   
   /*database output, note that the following commands must be entered in the exit state*/
   sqlite3 test.db .dump > test.sql
   
   /*database input, note that the following commands must be entered in the exit state*/
   sqlite3 test.db < test.sql
   
   /*"sqlite3" will let you to connect to a transient in-memory database, you need to use following commands to enter into specified database*/
   .open test
   ```
 * 表
   ```sql
   /*create table*/
   create table test(
   id int primary key not null,
   data char(50)
   );
   
   /*show tables*/
   .tables
   
   /*show table information*/
   .schema test
   ```
 * 数据
   ```sql
   /*cast*/
   select cast('100' as int); -- 100

   /*group_concat*/
   select group_concat(id) from psy_state group by date;
   select group_concat(id, '-') from psy_state group by date;

   /*insert*/
   insert into test (id,data) values(1,'abcd');

   /*on*/
   insert into test (id, name) values ('1', 'name1') on conflict(id) do update set id = id, name = 'name1-1'

   /*printf*/
   select printf("%.2f", 0.2658); -- 0.27
   
   /*round*/
   select round(59.9, 0); -- 60
   
   /*select*/
   select * from test;
   ```
  