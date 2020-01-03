* Iterator column
  ```sql
  DECLARE
    v_id test.id%TYPE;
    CURSOR c_id IS
      SELECT id FROM test WHERE id < 139351;
  BEGIN
    OPEN c_id;
    LOOP
      FETCH c_id
        INTO v_id;
      EXIT WHEN c_id%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('ID : ' || v_id);
    END LOOP;
    CLOSE c_id;
  EXCEPTION
    WHEN OTHERS THEN
      IF c_id%ISOPEN THEN
        CLOSE c_id;
      END IF;
  END;
  ```
