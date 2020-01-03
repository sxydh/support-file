* Test
  ```sql
  CREATE OR REPLACE TYPE test_obj_type AS OBJECT
  (
    id    NUMBER,
    pid   NUMBER,
    ctime DATE
  );
  
  DECLARE
    TYPE v_test_obj_type IS TABLE OF test_obj_type INDEX BY BINARY_INTEGER;
    v_test_tab v_test_obj_type;
  BEGIN
    SELECT test_obj_type(id, NULL, ctime)
      BULK COLLECT
      INTO v_test_tab
      FROM test
     WHERE rownum <= 5;
    FOR i IN 1 .. v_test_tab.count LOOP
      DBMS_OUTPUT.PUT_LINE('id: ' || v_test_tab(i).id);
      DBMS_OUTPUT.PUT_LINE('pid: ' || v_test_tab(i).pid);
      DBMS_OUTPUT.PUT_LINE('ctime: ' || v_test_tab(i).ctime);
    END LOOP;
  END;
  ```