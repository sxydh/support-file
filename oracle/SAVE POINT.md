* Test
  ```sql
  BEGIN
    INSERT INTO test
      (order_id, customer_ref, product_id)
    VALUES
      (1, 'SMITH', 55);
    SAVEPOINT pt;
    INSERT INTO test
      (order_id, customer_ref, product_id)
    VALUES
      (2, 'ANDERSON', 65);
    ROLLBACK TO pt;
    COMMIT;
  END;
  ```