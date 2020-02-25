# Profile
Oracle common commands

# Specification
  * [*DBLink*](./DBLink.md)
  
  * SQL Plus
    ```sql
    HELP INDEX;
    CLEAR SCREEN;
    EXIT;
    ```
  * Dictionary
    ```sql
    /*Query the current database name*/
    SELECT name,dbid FROM v$database;

    /*查看所有用户表*/
    SELECT owner, table_name FROM dba_tables;
  
    /*Determine if the database is single or multiple instances*/
    SELECT parallel FROM v$instance;
  
    /*View database initialization parameters*/
    SELECT name,value FROM v$parameter ORDER BY name; --the current value
    SELECT name,value FROM v$spparameter ORDER BY name; --the local file value
  
    /*View the size of the memory structure*/
    SELECT component, current_size, min_size, max_size FROM v$sga_dynamic_components;
    ```

  * Table space
    ```sql
    /*Query all table spaces*/
    SELECT * FROM dba_tablespaces;
    
    /*Create a table space*/
    CREATE BIGFILE TABLESPACE test --the tablespace is BIGFILE, which means that you cannot add a second data file   later, the replacement is SMALLFILE, which can consist of multiple data files
    DATAFILE 'path\TEST.DBF'
    SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE 1024M
    LOGGING --all operations on the segment in the tablespace will generate redo content, which is the default
    EXTENT MANAGEMENT LOCAL --tablespace will use bitmap to allocate extent, which is the default
    SEGMENT SPACE MANAGEMENT AUTO --segment in the tablespace will use bitmap to track block usage, which is the default
    DEFAULT NOCOMPRESS; --the segment in the tablespace are not compressed, which is the default
  
    /*Rename tablespace*/
    ALTER TABLESPACE test RENAME TO test_newname;
  
    /*Alter tablespace to autoextend*/
    ALTER DATABASE DATAFILE 'path\TEST.DBF'
    AUTOEXTEND ON NEXT 50M MAXSIZE 1024M;
  
    /*Add datafile to tablespace*/
    ALTER TABLESPACE test
    ADD DATAFILE 'path\TEST_ADD.DBF'
    SIZE 10M AUTOEXTEND ON NEXT 50M MAXSIZE 2048M;
    
    /*Alter datafile size*/
    ALTER DATABASE DATAFILE 'path\TEST.DBF' RESIZE 1024M;
    
    /*Create a temporary tablespace*/
    CREATE TEMPORARY TABLESPACE test_temp
    TEMPFILE 'path\TEST_TEMP.DBF'
    SIZE 10M AUTOEXTEND ON NEXT 50M MAXSIZE 2048M
    EXTENT MANAGEMENT LOCAL;
    
    /*Alter tempfile size*/
    ALTER DATABASE TEMPFILE 'path\TEST_TEMP.DBF' RESIZE 1024M;
    
    /*Delete a tablespace*/
    DROP TABLESPACE test INCLUDING CONTENTS AND DATAFILES;
    ```

  * User
    ```sql
    /*Query all users*/
    SELECT * FROM all_users;
    
    /*Create a user, note, do not forget grant the quota to user*/
    CREATE USER test IDENTIFIED BY 123
    DEFAULT TABLESPACE test TEMPORARY TABLESPACE test_temp
    --QUOTA 100M ON test
    --PROFILE developer_profile --name the configuration file that manages resource and password
    --PASSWORD EXPIRE --force users to change their password
    ACCOUNT UNLOCK; --default
  
    /*Alter user password*/
    ALTER USER test IDENTIFIED BY 123456;
  
    /*Specified tablespace*/
    ALTER USER test DEFAULT TABLESPACE test TEMPORARY TABLESPACE test_temp;
    /*Grant privilege*/
    GRANT GLOBAL QUERY REWRITE, ON COMMIT REFRESH, SELECT ANY TABLE, CREATE ANY MATERIALIZED VIEW, CREATE SESSION,ALTER SESSION,CREATE ANY TABLE,CREATE VIEW,CREATE SYNONYM,CREATE CLUSTER,CREATE DATABASE LINK,CREATE SEQUENCE,CREATE TRIGGER,CREATE TYPE,CREATE PROCEDURE,CREATE OPERATOR TO test;
  
    /*Lock/unlock user*/
    ALTER USER test ACCOUNT LOCK;
    ALTER USER test ACCOUNT UNLOCK;
  
    /*Expire password*/
    ALTER USER test PASSWORD EXPIRE;
  
    /*Specified quota*/
    ALTER USER test QUOTA 5M ON test;
    ALTER USER test QUOTA UNLIMITED ON test;
    
    /*Delete user*/
    DROP USER test CASCADE;
    ```

  * Session
    ```sql
    /*AUTOTRACE*/
    SET AUTOT[RACE] {OFF|ON|TRACE[ONLY]} [EXP[LAIN]] [STAT[ISTICS]];
    ```

  * Privilege
    ```sql
    /*View user's privilege*/
    SELECT * FROM user_sys_privs;
    SELECT * FROM role_sys_privs; --view the roles owned by the current
  
    /*Grant privilege*/
    GRANT CREATE SESSION,ALTER SESSION,CREATE TABLE,CREATE VIEW,CREATE SYNONYM,CREATE CLUSTER,CREATE DATABASE LINK,  CREATE SEQUENCE,CREATE TRIGGER,CREATE TYPE,CREATE PROCEDURE,CREATE OPERATOR TO test;
  
    GRANT SELECT ON test.test TO scott --grant the scott privilege to query the test table of the test schema(a user   generally corresponds to a schema)
    WITH GRANT OPTION; --allow cascading revoke privilege
    GRANT ALL ON test TO scott WITH GRANT OPTION;
  
    /*Role*/
    CREATE ROLE test_role;
    GRANT CREATE SESSION TO test_role;
    GRANT test_role to test;
    REVOKE test_role FROM test;
  
    /*Revoke privilege*/
    REVOKE CREATE SESSION FROM test;
    ```

  * Table
    ```sql
    /*Create table*/
    CREATE TABLE test
    (
      ID   NUMBER NOT NULL,
      NAME VARCHAR2(50)
    )
    TABLESPACE test;
    ALTER TABLE test
    ADD CONSTRAINT test_primary_key PRIMARY KEY (ID);
    
    /*Query all tables of the current user*/
    SELECT table_name FROM user_tables; 
    /*Query the tables that the current user has permission to view*/
    SELECT user,table_name FROM all_tables; 
  
    /*Alter table*/
    ALTER TABLE test ADD (col NUMBER);
    ALTER TABLE test MODIFY (col VARCHAR2(200) DEFAULT NULL);
    ALTER TABLE test DROP COLUMN col;
    ALTER TABLE test RENAME COLUMN col TO col_new;
    ALTER TABLE test READ ONLY;
  
    /*Index*/
    CREATE INDEX <index name> ON <table name> (<col name>);
    CREATE [UNIQUE|BITMAP] INDEX [SCHEMA.]indexname ON [SCHEMA.]tablename (column [,column...]); --complete form
    DROP INDEX <index name>;
  
    /*Virtual index*/
    ALTER SESSION SET "_use_nosegment_indexes"=TRUE;
    CREATE INDEX <index name> ON <table name> (<col name>) NOSEGMENT;
  
    /*Show sql timer*/
    SET TIMING ON
    ```

  * View
    ```sql
    /*Create view*/
    CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW
    [schema.]viewname [(alias [,alias]...)]
    AS subquery
    [WITH CHECK OPTION [CONSTRAINT constraintname]]
    [WITH READ ONLY [CONSTRAINT constraintname]];
    CREATE VIEW test.view_test AS SELECT id FROM test.test WHERE id<1000100; --example
  
    /*Drop view*/
    DROP VIEW [schema.]viewname;
    ```

  * Constraint
    ```sql
    /*Add constraint*/
    ALTER TABLE test
    ADD CONSTRAINT constr_int_test CHECK (int<>0);
  
    /*Used when creating a table*/
    CREATE TABLE dept(
    deptno NUMBER(2,0) CONSTRAINT dept_deptno_pk PRIMARY KEY
    CONSTRAINT dept_deptno_ck CHECK (deptno BETWEEN 10 AND 90),
    dname VARCHAR2(20) CONSTRAINT dept_dname_nn NOT NULL);
  
    CREATE TABLE emp (
    empno NUMBER(4,0) CONSTRAINT emp_empno_pk PRIMARY KEY,
    ename VARCHAR2(20) CONSTRAINT emp_ename_nn NOT NULL,
    mgr NUMBER(4,0) CONSTRAINT emp_mgr_fk REFERENCES emp(empno),
    dob DATE,
    hiredate DATE,
    deptno NUMBER(2,0) CONSTRAINT emp_deptno_fk REFERENCES dept(deptno)
    ON DELETE SET NULL, --delete the reference row, this value will be null
    email VARCHAR2(30) CONSTRAINT emp_email_uk UNIQUE,
    CONSTRAINT emp_hiredate_ck CHECK (hiredate >= dob+365*16), --this constraint cannot be defined with hiredate
    CONSTRAINT emp_email_ck CHECK ((INSTR(email,'@') >0) AND (INSTR(email,'.') >0)));
    ```

  * Transaction
    ```sql
    /*SET TRANSACTION: establish the current transaction as read-only or read/write, establish its isolation level, or assign it to a specified rollback segment*/
    /*Available options: READ ONLY, READ WRITE, ISOLATION LEVEL SERIALIZABLE, ISOLATION LEVEL READ COMMITTED*/
    SET TRANSACTION READ ONLY NAME 'Toronto'; 
    SELECT product_id, quantity_on_hand FROM inventories
       WHERE warehouse_id = 5
       ORDER BY product_id; 
    COMMIT;
    ```

  * PL/SQL    
    [*ANONYMOUS*](./ANONYMOUS.md)    
    [*BULK COLLECT*](./BULK%20COLLECT.md)    
    [*CURSOR*](./CURSOR.md)    
    [*DBLink*](./DBLINK.md)    
    [*EXCEPTION*](./EXCEPTION.md)    
    [*FUNCTION*](./FUNCTION.md)    
    [*LOOP*](./LOOP.md)
    [*MATERIALIZED VIEW*](./MATERIALIZED%20VIEW.md)
    [*PACKAGE*](./PACKAGE.md)    
    [*PROCEDURE*](./PROCEDURE.md)    
    [*ROWTYPE*](./ROWTYPE.md)    
    [*SAVE POINT*](./SAVE%20POINT.md)    
    [*TRIGGER*](./TRIGGER.md)    
    [*TYPE*](./TYPE.md)    

  * DDL
    ```sql
    /*Copy and create table*/
    CREATE TABLE testb AS SELECT * FROM testa;
    ```
    
  * Query and DML
    ```sql
    /*ABS: returns the absolute value of n*/
    SELECT ABS(-15) FROM DUAL;
  
    /*ADD_MONTHS: returns the date date plus integer months*/
    SELECT ADD_MONTHS(SYSDATE, 1) FROM DUAL;
    
    /*CALL: suitable for any tool, execute a routine (a standalone procedure or function, or a procedure or function  defined within a type or package) from within SQL*/
    CALL procedure_test();
  
    /*INSERT ALL: is used to add multiple rows with a single INSERT statement*/
    INSERT ALL
      INTO mytable (column1, column2, column_n) VALUES (expr1, expr2, expr_n)
      INTO mytable (column1, column2, column_n) VALUES (expr1, expr2, expr_n)
      INTO mytable (column1, column2, column_n) VALUES (expr1, expr2, expr_n)
    SELECT * FROM dual;
  
    /*CASE WHEN: let you use IF ... THEN ... ELSE logic in SQL statements without having to invoke procedures*/
    SELECT CASE WHEN t.name='name' THEN 'case name' ELSE null END AS newName FROM test t;
    
    /*CEIL: returns smallest integer greater than or equal to n*/
    SELECT CEIL(12.6) FROM DUAL
    
    /*COALESCE: returns the first non-null expr in the expression list*/
    SELECT COALESCE(SUM(cid),0) FROM test;
    
    /*CONCAT: returns char1 concatenated with char2*/
    SELECT CONCAT('Bruce','Wayne') FROM DUAL;
  
    /*DECODE: compares expr to each search value one by one, if expr is equal to a search, then Oracle Database returns the corresponding result, if no match is found, then Oracle returns default, if default is omitted, then Oracle returns null*/
    SELECT DECODE(10,5,'num 5',10,'num 10','no match') FROM DUAL; --num 10
    SELECT DECODE(12,5,'num 5',10,'num 10','no match') FROM DUAL; --no match
    SELECT DECODE(12,5,'num 5',10,'num 10') FROM DUAL; --null
  
    /*DBMS*/
    SELECT dbms_random.string('p',10) FROM dual; --'u'/'U': uppercase alpha characters; 'l'/'L': lowercase alpha characters; 'a'/'A': mixed case alpha characters; 'x'/'X': uppercase alpha-numeric characters; 'p'/'P': any printable characters
    SELECT dbms_random.value(-100,100) FROM dual; --(-100~100)

    /*EXECUTE: only for SQL Plus*/
    EXECUTE procedure_test();
  
    /*GROUP BY: can be used in a SELECT statement to collect data across multiple records and group the results by one or more columns, in more simple words GROUP BY statement is used in conjunction with the aggregate functions to group the result-set by one or more columns*/
    SELECT name, SUM(value) FROM testa GROUP BY name;

    /*Hints: Hints are comments in a SQL statement that pass instructions to the Oracle Database optimizer. The optimizer uses these hints to choose an execution plan for the statement, unless some condition exists that prevents the optimizer from doing so*/
    INSERT /*+ IGNORE_ROW_ON_DUPKEY_INDEX (tablename (colname)) */ INTO tablename ... --any duplicate key values that are inserted will be silently ignored, rather than causing an ORA-0001 error
  
    /*INITCAP: returns char, with the first letter of each word in uppercase, all other letters in lowercase*/
    SELECT INITCAP('the soap') "Capitals" FROM DUAL; 
  
    /*INSERT WHEN INTO: the second SELECT is necessary*/
    INSERT WHEN
    (SELECT id FROM test WHERE id = 1) = 1 THEN INTO test
    (id, data)
    SELECT (SELECT COALESCE(MAX(id), 0) + 1 FROM test) id, 'data' data FROM DUAL
    
    /*INSTR: searches the string CORPORATE FLOOR, beginning with the third character, for the string "OR", it returns the position in CORPORATE FLOOR at which the second occurrence of "OR" begins*/
    /*The third and forth parameter can be omitted, then the default value will be 1 and 1 correspondingly*/
    SELECT INSTR('CORPORATE FLOOR', 'OR', 3, 2) "Instring" FROM DUAL;
  
    /*LAST_DAY: returns the date of the last day of the month that contains date*/
    SELECT SYSDATE,LAST_DAY(SYSDATE) "Last",LAST_DAY(SYSDATE) - SYSDATE "Days Left" FROM DUAL;
  
    /*LENGTH: return the length of char*/
    SELECT LENGTH('CANDIDE') "Length in characters" FROM DUAL;
    
    /*LISTAGG: orders data within each group specified in the ORDER BY clause and then concatenates the values of the   measure column, note: ignore null values*/
    SELECT
    1 temp, LISTAGG(id,',') WITHIN GROUP (ORDER BY id) ids, LISTAGG(name,',') WITHIN GROUP (ORDER BY name) names,   LISTAGG(data,',') WITHIN GROUP (ORDER BY data) datas
    FROM (
    SELECT 1 temp, id, name, data FROM test
    ) GROUP BY temp;
  
    /*LOCK TABLE: lock one or more tables, table partitions, or table subpartitions in a specified mode (ROW SHARE, ROW   EXCLUSIVE, SHARE UPDATE, SHARE, SHARE ROW EXCLUSIVE, EXCLUSIVE,NOWAIT)*/
    LOCK TABLE employees IN EXCLUSIVE MODE NOWAIT;
  
    /*LOWER: returns char, with all letters lowercase*/
    SELECT LOWER('MR. SCOTT MCMILLAN') "Lowercase" FROM DUAL;
  
    /*LPAD: fill the side of the string with the specified number of strings*/
    SELECT LPAD('CANDIDE',2,'LPAD-') FROM DUAL; --left
    SELECT RPAD('CANDIDE',2,'LPAD-') FROM DUAL; --right
    
    /*MERGE INTO: use the statement to select rows from one or more sources for update or insertion into a table or   view, you can specify conditions to determine whether to update or insert into the target table or view*/
    MERGE INTO test t
    USING (SELECT * FROM test WHERE id=1) tt
    ON (tt.id=2)
    WHEN MATCHED THEN UPDATE SET t.data='matched' WHERE t.id=70
    WHEN NOT MATCHED THEN INSERT (t.id) VALUES(74) WHERE (tt.id=1);
  
    /*MOD: returns the remainder of n2 divided by n1, returns n2 if n1 is 0*/
    SELECT MOD(11, 4) "Modulus" FROM DUAL; --3
  
    /*MONTHS_BETWEEN: returns number of months between dates date1 and date2, the month and the last day of the month   are defined by the parameter NLS_CALENDAR, if date1 is later than date2, then the result is positive, if date1 is   earlier than date2, then the result is negative*/
    SELECT MONTHS_BETWEEN(TO_DATE('02-02-1995', 'MM-DD-YYYY'),TO_DATE('01-01-1995', 'MM-DD-YYYY')) "Months" FROM DUAL;   --1.03225806451613
    
    /*NLSSORT: returns the string of bytes used to sort char*/
    SELECT * FROM test ORDER BY NLSSORT(char1, 'NLS_SORT=SCHINESE_PINYIN_M');
    
    /*NVL: lets you replace null (returned as a blank) with a string in the results of a query*/
    SELECT NVL(cid,-1) FROM test;
  
    /*NVL2: lets you determine the value returned by a query based on whether a specified expression is null or not   null, if expr1 is not null, then NVL2 returns expr2, if expr1 is null, then NVL2 returns expr3*/
    SELECT NVL2(NULL,2,3) FROM DUAL;

    /*ODCINUMBERLIST: list of values to rows*/
    SELECT DISTINCT COLUMN_VALUE FROM TABLE(SYS.ODCINUMBERLIST(1, 1, 2, 3, 3, 4, 4, 5));
    SELECT DISTINCT COLUMN_VALUE FROM TABLE(SYS.ODCIVARCHAR2LIST('1', '1', '2', '3', '3', '4', '4', '5'));
    
    /*ORDER BY: allows you to specify the order in which rows appear in the result set*/
    SELECT * FROM (SELECT * FROM test WHERE id BETWEEN 1 AND 11 ORDER BY ctime) WHERE rownum=1;
  
    /*Other*/
    SELECT * FROM test WHERE id='&&value' AND int='&&value'; --use placeholders
    DEFINE; --view already defined variables
    UNDEFINE variable; --delete already defined variables
    SELECT ... FROM <table name> WHERE ... < ALL(...);
    SELECT ... FROM <table name> WHERE ... < ANY(...);
    SELECT LEVEL FROM DUAL CONNECT BY LEVEL <= 3; --1, 2, 3, sometimes equals (SELECT ROWNUM FROM DUAL CONNECT BY ROWNUM <= 3;)
    INSERT INTO test (id, val) SELECT LEVEL, LEVEL FROM DUAL CONNECT BY LEVEL < 5; --insert multiple rows
  
    /*OVER: defines a window or user-specified set of rows within a query result set, a window function then computes a   value for each row in the window, you can use the OVER clause with functions to compute aggregated values such as   moving averages, cumulative aggregates, running totals, or a top N per group results*/
    SELECT name, SUM(value) OVER(PARTITION BY name) FROM testa;
    SELECT name, SUM(value) OVER(PARTITION BY name ORDER BY id) FROM testa; --cumulative
  
    /*PIVOT：allows you to write a cross-tabulation query starting in Oracle 11g, this means that you can aggregate your results and rotate rows into columns*/
    /*Ref: https://www.techonthenet.com/oracle/pivot.php*/
    SELECT * FROM (SELECT customer_ref, product_id FROM test) PIVOT (COUNT(product_id) FOR product_id IN (10, 20, 30)) ORDER BY customer_ref; --类似于' ... product_id, COUNT(product_id) ... WHERE product_id IN (10, 20, 30) ... GROUP BY customer_ref, product_id', 然后将product_id列转为标题行, 聚合结果列转为值行, 同时其它列保持不变

    /*REGEXP_LIKE: is similar to the LIKE condition, except REGEXP_LIKE performs regular expression matching instead of the simple pattern matching performed by LIKE. This condition evaluates strings using characters as defined by the input character set*/
    /*
    ▪ 'i' specifies case-insensitive matching
    ▪ 'c' specifies case-sensitive matching
    ▪ 'n' allows the period (.), which is the match-any-character wildcard character, to match the newline character. If you omit this parameter, then the period does not match the newline character
    ▪ 'm' treats the source string as multiple lines. Oracle interprets ^ and $ as the start and end, respectively, of any line anywhere in the source string, rather than only at the start or end of the entire source string. If you omit this parameter, then Oracle treats the source string as a single line
    ▪ 'x' ignores whitespace characters. By default, whitespace characters match themselves
    */
    SELECT t.*, t.rowid FROM t_shop_window_dish t WHERE REGEXP_LIKE(pinyin, 'lb', 'i');

    /*REPLACE: returns char with every occurrence of search_string replaced with replacement_string*/
    SELECT REPLACE('JACK and JUE', 'J', 'BL') "Changes" FROM DUAL;
  
    /*ROUND: returns n rounded to integer places to the right of the decimal point*/
    SELECT ROUND(15.193,1) "Round" FROM DUAL; --15.2
    SELECT ROUND(15.193,-1) "Round" FROM DUAL; --20
    
    /*ROW_NUMBER(): is an analytic function, it assigns a unique number to each row to which it is applied (either each   row in the partition or each row returned by the query), in the ordered sequence of rows specified in the   order_by_clause, beginning with 1*/
    SELECT t.*,ROW_NUMBER() OVER(PARTITION BY data ORDER BY id ASC) AS rnum FROM test t;
  
    /*INSERT INTO ... SELECT ...*/
    INSERT INTO testb(id) SELECT pid FROM testa WHERE id=1;
    
    /*SEQUENCE*/
    CREATE SEQUENCE [schema.] sequencename
    [INCREMENT BY number]
    [START WITH number]
    [MAXVALUE number | NOMAXVALUE]
    [MINVALUE number | NOMINVALUE]
    [CYCLE | NOCYCLE]
    [CACHE number | NOCACHE]
    [ORDER | NOORDER];
  
    ALTER SEQUENCE sequencename
    [INCREMENT BY number]
    [START WITH number]
    [MAXVALUE number | NOMAXVALUE]
    [MINVALUE number | NOMINVALUE]
    [CYCLE | NOCYCLE]
    [CACHE number | NOCACHE]
    [ORDER | NOORDER];
  
    CREATE SEQUENCE <SEQ NAME> 
    MINVALUE 1
    MAXVALUE 9999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20; --example
    
    SELECT sequence_owner,sequence_name FROM dba_sequences;
    SELECT <seq name>.nextval FROM dual; 
    ALTER SEQUENCE <seq name> INCREMENT BY -1; 
    
    /*START WITH: specifies the root row(s) of the hierarchy*/
    /*CONNECT BY PRIOR: specifies the relationship between parent rows and child rows of the hierarchy*/
    /*Execution order: CONNECT BY first, then WHERE*/
    SELECT * FROM test WHERE 1=1 START WITH id=23 CONNECT BY PRIOR pid=id; --up
    SELECT * FROM test WHERE 1=1 START WITH id=1 CONNECT BY PRIOR id=pid; --down
  
    /*SUBSTR: return a portion of char, beginning at character position, substring_length characters long*/
    SELECT SUBSTR('ABCDEFG', 3, 4) "Substring" FROM DUAL;
    
    /*SYS_GUID(): generates and returns a globally unique identifier (RAW value) made up of 16 bytes*/
    SELECT SYS_GUID() FROM DUAL;
    
    /*SYSDATE*/
    SELECT SYSDATE FROM DUAL;
    
    /*TO_CHAR: converts a datetime or interval value of DATE, TIMESTAMP, TIMESTAMP WITH TIME ZONE, or TIMESTAMP WITH   LOCAL TIME ZONE datatype to a value of VARCHAR2 datatype in the format specified by the date format fmt*/
    SELECT TO_CHAR(ctime,'yyyy-mm-dd') FROM test WHERE id=1
    
    /*TO_DATE: converts char of CHAR, VARCHAR2, NCHAR, or NVARCHAR2 datatype to a value of DATE datatype*/
    SELECT * FROM test WHERE ctime>=TO_DATE('2018/11/13 13:00:03','yyyy-mm-dd hh24:mi:ss');
  
    /*TRIM: enables you to trim leading or trailing characters (or both) from a character string*/
    SELECT TRIM(BOTH '*' FROM '****Hidden****'),TRIM(LEADING '*' FROM '****Hidden****'),TRIM(TRAILING '*' FROM   '****Hidden****') FROM DUAL;
  
    /*TRUNC (date): returns date with the time portion of the day truncated to the unit specified by the format model fmt, the value returned is always of datatype DATE, even if you specify a different datetime datatype for date, if you omit fmt, then date is truncated to the nearest day.*/
    SELECT TRUNC(TO_DATE('2016-05-26','yyyy-mm-dd'), 'yyyy') FROM DUAL; --2016/1/1
    SELECT TRUNC(TO_DATE('2016-05-26','yyyy-mm-dd'), 'mm') FROM DUAL; --2016/5/1
    SELECT TRUNC(TO_DATE('2016-05-26','yyyy-mm-dd'), 'dd') FROM DUAL; --2016/5/26
    SELECT TRUNC(TO_DATE('2016-05-26','yyyy-mm-dd'), 'd') FROM DUAL; --2016/5/22
  
    /*TRUNC (number): returns n1 truncated to n2 decimal places*/
    SELECT TRUNC(15.79,1) "Truncate" FROM DUAL; --15.7
    SELECT TRUNC(15.79,-1) "Truncate" FROM DUAL; --10
  
    /*TRUNCATE: to remove all rows from a table, you cannot roll back a TRUNCATE TABLE statement, nor can you use a   FLASHBACK TABLE statement to retrieve the contents of a table that has been truncated*/
    TRUNCATE TABLE testb;

    /*UNPIVOT*/
    SELECT id, valcol, namecol FROM pivot_test UNPIVOT(valcol FOR(namecol) IN(customer_id AS 'customer_id', quantity AS 'quantity')) ORDER BY id; --行转列, namecol: 标题行转换后的新列名, valcol: 值行转换后的新列名
  
    /*UPPER: returns char, with all letters uppercase*/
    SELECT UPPER(last_name) "Uppercase" FROM employees;
  
    /*WITH: the WITH clause may be processed as an inline view or resolved as a temporary table, the advantage of the   latter is that repeated references to the subquery may be more efficient as the data is easily retrieved from the   temporary table, rather than being requeried by each reference*/
    WITH vt AS
     (SELECT * FROM test)
    SELECT * FROM vt;

    /*WM_CONCAT: concatenates the values of the   measure column*/
    SELECT TO_CHAR(WM_CONCAT(id)) FROM t_order WHERE ROWNUM < 5;
    ```
