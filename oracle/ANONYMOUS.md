* Syntax
  ```sql
  DECLARE
  declaration statements
  BEGIN
  executable statements
  EXCEPTION
  exception-handling statements
  END;
  ```

* Test
  ```sql
  DECLARE
    i NUMBER;
  BEGIN
    UPDATE t_shop_user SET id = id WHERE id = 10;
    COMMIT;
  END;
  ```