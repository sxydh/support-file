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
  * 字典
    ```sql
    /*sqlite_master: all table info*/
    select * from sqlite_master;
    ```
  * 表
    ```sql
    /*alter table add*/
    alter table test add newcolname type [default val] [not null]; -- 增加列

    /*constraint*/
    create table employees (
        employee_id integer primary key autoincrement,  
        last_name varchar not null,  
        first_name varchar,  
        department_id integer,  
        constraint fk_departments  
        foreign key (department_id)  
        references departments(department_id)  
    );

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
  * 触发器
    ```sql
    CREATE TRIGGER trigger_name [BEFORE|AFTER] event_name -- event_name 可以是在所提到的表 table_name 上的 INSERT、DELETE 和 UPDATE 数据库操作。可以在表名后选择指定 FOR EACH ROW
    ON table_name
    FOR EACH ROW
    BEGIN
     -- 触发器逻辑....
    END;

    -- 示例
    create trigger audit_log after insert on employees_test for each row
    begin 
        insert into audit (emp_no, name) values (new.id, new.name);
    end;
    ```
  * 数据
    ```sql
    /*cast*/
    select cast('100' as int); -- 100
 
    /*date*/
    select date(datetime(current_timestamp, 'localtime'), '-31 day'); -- 2020-07-09
 
    /*datetime*/
    select datetime(current_timestamp, 'localtime'); -- 2020-08-09 21:18:04
 
    /*group_concat*/
    select group_concat(id) from psy_state group by date; -- default','
    select group_concat(id, '-') from psy_state group by date;
 
    /*indexed*/
    select t.* from test indexed by idx_value where value = 100; -- 强制使用指定索引
 
    /*insert*/
    insert into test (id,data) values(1,'abcd');

    /*offset limit*/
    select t.* from test t limit 3 offset 1; -- 从第1行开始取后3行，不包括第一行，行号起始为1
 
    /*on*/
    insert into test (id, name) values ('1', 'name1') on conflict(id) do update set id = id, name = 'name1-1';

    /*replace*/
    select replace('a, b, c', 'a', ''); -- , b, c
 
    /*printf*/
    select printf("%.2f", 0.2658); -- 0.27
    
    /*round*/
    select round(59.9, 0); -- 60
    
    /*select*/
    select * from test;
 
    /*strftime*/
    select strftime('%Y-%m-%d %H:%M:%S.%s', '2014-10-07 02:34:56'); -- 2014-10-07 02:34:56.1412649296
    select strftime('%Y-%m-%d %H:%M:%S.%s', datetime(current_timestamp, 'localtime')); -- 2020-08-09 21:21:28.1597008088
 
    /*substr*/
    select substr('abcdef', 1, 2); -- ab
 
    /*time*/
    select time(2*3600, 'unixepoch'); -- 02:00:00
    ```
   