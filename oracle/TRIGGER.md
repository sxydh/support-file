* Define: triggers are stored procedural code that is fired automatically when specified events happen in thedatabase.

* Syntax
  ```sql
  CREATE [OR REPLACE ] TRIGGER trigger_name  
  {BEFORE | AFTER | INSTEAD OF }  
  {INSERT [OR] | UPDATE [OR] | DELETE}  
  [OF col_name]  
  ON table_name  
  [REFERENCING OLD AS o NEW AS n]  
  [FOR EACH ROW]  
  WHEN (condition) 
  DECLARE 
     Declaration-statements 
  BEGIN  
     Executable-statements 
  EXCEPTION 
     Exception-handling-statements 
  END; 
  ```

* Test
  ```sql
  /*You may need execute following command: GRANT CREATE ANY TRIGGER TO test;*/
  CREATE OR REPLACE TRIGGER trigger_a
    AFTER UPDATE ON testa
    REFERENCING OLD AS o NEW AS n
    FOR EACH ROW
  DECLARE
    current_date DATE;
  BEGIN
    current_date := SYSDATE;
    UPDATE testb SET utime = current_date WHERE id = :o.id;
  END;
  ```