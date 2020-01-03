* Simple
  ```sql
  DECLARE
    i NUMBER;
  BEGIN
    i := 0;
    LOOP
      DBMS_OUTPUT.PUT_LINE(i);
      IF i > 100 THEN
        EXIT;
      END IF;
      -- EXIT WHEN i > 100;
      i := i + 1;
    END LOOP;
  END;
  ```

* WHILE
  ```sql
  DECLARE
    i NUMBER;
  BEGIN
    i := 0;
    WHILE i < 100 LOOP
      DBMS_OUTPUT.PUT_LINE(i);
      i := i + 1;
    END LOOP;
  END;
  ```

* FOR
  ```sql
  DECLARE
    i NUMBER;
  BEGIN
    i := 0;
    FOR i IN 1 .. 100 LOOP
      DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
  END;
  ```