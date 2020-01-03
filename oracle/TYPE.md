* Syntax
  ```sql
  CREATE [OR REPLACE] TYPE type_name AS OBJECT
  (attribute_name1 attribute_type,
  attribute_name2 attribute_type,
  ...
  attribute_nameN attribute_type,
  [method1 specification],
  [method2 specification],
  ...
  [methodN specification]);
  [CREATE [OR REPLACE] TYPE BODY type_name AS
  method1 body;
  method2 body;
  ...
  methodN body;]
  END;
  ```

* Object
  ```sql
  CREATE OR REPLACE TYPE test_obj_type AS OBJECT
  (
    id    NUMBER,
    pid   NUMBER,
    ctime DATE
  );
  ```

* Collection
  ```sql
  CREATE OR REPLACE TYPE test_objs_type IS TABLE OF test_obj_type;
  ```
  
* Test
  ```sql
  DECLARE
    v_test_obj test_obj_type;
  BEGIN
    SELECT test_obj_type(id, NULL, ctime)
      INTO v_test_obj
      FROM test
     WHERE id = 140410;
    DBMS_OUTPUT.PUT_LINE('id: ' || v_test_obj.id);
    DBMS_OUTPUT.PUT_LINE('pid: ' || v_test_obj.pid);
    DBMS_OUTPUT.PUT_LINE('ctime: ' || v_test_obj.ctime);
  END;
  ```