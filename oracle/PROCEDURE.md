* Define: a group of PL/SQL statements that you can call by name.

* Syntax
  ```sql
  CREATE OR REPLACE PROCEDURE name
  [(parameter[, parameter, ...])]
  AS
  [local declarations]
  BEGIN
  executable statements
  [EXCEPTION
  exception handlers]
  END [name];
  ```

* Test
  ```sql
  /*You may need execute following command: GRANT CREATE ANY PROCEDURE TO test. If no parameters are needed, the "()" should be omitted. "()" must be added when calling procedure.*/
  CREATE OR REPLACE PROCEDURE procedure_a(x IN NUMBER, y OUT NUMBER) AS
    i NUMBER;
  BEGIN
    i := DBMS_RANDOM.VALUE(3, 1000);
    y := x * i;
  END procedure_a;

  CREATE OR REPLACE PROCEDURE procedure_b AS
  i NUMBER;
  BEGIN
    i:=100;
    procedure_a(10,i);
    INSERT INTO testa (id,value) VALUES(seq_testa.nextval,i);
  END procedure_b;
  ```