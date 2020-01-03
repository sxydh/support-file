* Based on table
  ```sql
  DECLARE
    test_rec test%ROWTYPE;
  BEGIN
    SELECT * INTO test_rec FROM test WHERE id = 139351;
    DBMS_OUTPUT.PUT_LINE('ID: ' || test_rec.id);
    DBMS_OUTPUT.PUT_LINE('INT: ' || test_rec.int);
    DBMS_OUTPUT.PUT_LINE('CTIME: ' || test_rec.ctime);
  END;
  ```

* Based on cursor
  ```sql
  DECLARE
    CURSOR test_cur IS
      SELECT id, int, ctime FROM test WHERE rownum <= 139351;
    test_rec test_cur%ROWTYPE;
  BEGIN
    OPEN test_cur;
    LOOP
      FETCH test_cur
        INTO test_rec;
      EXIT WHEN test_cur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('ID: ' || test_rec.id || ',   ' || 'INT: ' ||
                           test_rec.int || ',   ' || 'CTIME: ' ||
                           test_rec.ctime);
    END LOOP;
  END;
  ```