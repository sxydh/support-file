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

* TRIGGER LEVEL
  * Row-level triggers  
    ▪ Row-level triggers execute once for each row in a transaction.  
    ▪ Row-level triggers are the most common type of triggers; they are often used in data auditing applications.  
    ▪ Row-level trigger is identified by the FOR EACH ROW clause in the CREATE TRIGGER command.  
  * Statement-level triggers  
    ▪ Statement-level triggers execute once for each transaction. For example, if a single transaction inserted 500 rows into the Customer table, then a statement-level trigger on that table would only be executed once.  
    ▪ Statement-level triggers therefore are not often used for data-related activities; they are normally used to enforce additional security measures on the types of transactions that may be performed on a table.  
    ▪ Statement-level triggers are the default type of triggers created and are identified by omitting the FOR EACH ROW clause in the CREATE TRIGGER command.  

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