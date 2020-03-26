* Define: is a set of PL/SQL statements you can call by name, stored functions are very similar to procedures, except that a function returns a value to the environment in which it is called, user functions can be used as part of a SQL expression.

* Syntax
  ```sql
  CREATE [OR REPLACE] FUNCTION function_name
  (parameter list)
  RETURN datatype
  IS
  BEGIN
  <body>
  RETURN (return_value);
  END;
  ```

* Create
  ```sql
  CREATE OR REPLACE FUNCTION function_a(x IN NUMBER, y IN NUMBER)
    RETURN NUMBER AS
    i NUMBER;
    j NUMBER;
  BEGIN
    i := DBMS_RANDOM.VALUE(3, 1000); -- 随机数
    SELECT i INTO j FROM DUAL; -- 变量可以直接使用
    DBMS_OUTPUT.PUT_LINE(j); -- 控制台输出
    return x * y * i * j;
  END function_a;
  ```

* Test
  ```sql
  SELECT function_a(1,1) FROM dual;
  ```
