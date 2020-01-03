* Test
  ```sql
  DECLARE
    i NUMBER;
    e_test EXCEPTION;
  BEGIN
    RAISE e_test;
  EXCEPTION
    WHEN e_test THEN
      dbms_output.put_line('raise custom exception');
      raise_application_error(-20010,'raise_application_error'); --(-20999~-20000)
  END;
  ```