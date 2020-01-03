* [*CREATE MATERIALIZED VIEW LOG*](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_6003.htm)   
  When DML changes are made to master table data, Oracle Database stores rows describing those changes in the materialized view log and then uses the materialized view log to refresh materialized views based on the master table. This process is called incremental or fast refresh. 
  ```sql
  CREATE MATERIALIZED VIEW mv
  AS SELECT o.* FROM t_order o WHERE TO_CHAR(o.ctime, 'yyyy-MM-dd') = TO_CHAR(SYSDATE, 'yyyy-MM-dd');
  ```

* 