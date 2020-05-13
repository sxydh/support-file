* Define
  * [*简版*](https://docs.oracle.com/cd/E11882_01/server.112/e25494/appendix_a.htm#ADMIN12510)
  * [*详细版*](https://docs.oracle.com/database/121/ARPLS/d_job.htm#ARPLS66573)

* 查看
  ```sql
  SELECT * FROM dba_jobs s
  ```

* 创建
  ```sql
  DECLARE job_n NUMBER;
  BEGIN
    dbms_job.submit ( job_n, 
        WHAT => 'BEGIN UPDATE test SET value = value + 1; COMMIT; END;', 
        NEXT_DATE => SYSDATE,
        INTERVAL => 'SYSDATE + 1 / (24 * 60 * 60)' ); -- 每隔一秒执行一次
    COMMIT;
  END;
  ```

* 手动执行
  ```sql
  BEGIN  
    dbms_job.run(31);  
  END; 
  ```
  
* 修改
  ```sql
  BEGIN 
    dbms_job.interval(31, 'TRUNC(SYSDATE, ''mi'') + 2 * 60 / (24 * 60 * 60)'); -- what 同理
    COMMIT;
  END;
  ```
  
* 删除
  ```sql
  BEGIN
    dbms_job.remove ( 89 );
    COMMIT;
  END;
  ```
