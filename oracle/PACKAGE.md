* Syntax
  ```sql
  CREATE OR REPLACE PACKAGE package_name
  IS
  [declarations of variables and types]
  [specifications of cursors]
  [specifications of modules]
  END [package_name];

  CREATE OR REPLACE PACKAGE BODY package_name
  IS
  [declarations of variables and types]
  [specification and SELECT statement of cursors]
  [specification and body of modules]
  [BEGIN
  executable statements]
  [EXCEPTION
  exception handlers]
  END [package_name];
  ```

* Declare
  ```sql
  CREATE OR REPLACE PACKAGE package_a AS
    PROCEDURE procedure_a(x IN NUMBER, y OUT NUMBER);
    PROCEDURE procedure_b;
    FUNCTION function_a(x IN NUMBER, y IN NUMBER) RETURN NUMBER;
  END package_a;
  ```

* Body
  ```sql
  CREATE OR REPLACE PACKAGE BODY package_a AS
    PROCEDURE procedure_a(x IN NUMBER, y OUT NUMBER) AS
      i NUMBER;
    BEGIN
      i := DBMS_RANDOM.VALUE(3, 1000);
      y := x * i;
    END procedure_a;
  
    PROCEDURE procedure_b AS
      i NUMBER;
    BEGIN
      i := 100;
      procedure_a(10, i);
      INSERT INTO testa (id, int) VALUES (seq_testa.nextval, i);
    END procedure_b;
  
    FUNCTION function_a(x IN NUMBER, y IN NUMBER) RETURN NUMBER AS
      i NUMBER;
    BEGIN
      i := DBMS_RANDOM.VALUE(3, 1000);
      RETURN x * y * i;
    END function_a;
  END package_a;
  ```

* Call
  ```sql
  CALL package_a.procedure_b();
  ```

