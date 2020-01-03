# Profile

TiDB common commands

## Specification

* 创建、授权和删除用户

  ```sql
  CREATE USER 'tiuser'@'localhost' IDENTIFIED BY '123456';
  GRANT SELECT ON samp_db.* TO 'tiuser'@'localhost'; -- 授权用户 tiuser 可检索数据库 samp_db 内的表
  SHOW GRANTS for tiuser@localhost; -- 查询用户 tiuser 的权限
  DROP USER 'tiuser'@'localhost';
  ```

* 创建、查看和删除数据库

  ```sql
  CREATE DATABASE db_name [options];
  CREATE DATABASE IF NOT EXISTS samp_db;

  SHOW DATABASES;

  DROP DATABASE samp_db;
  ```

* 创建、查看和删除表

  ```sql
  CREATE TABLE table_name column_name data_type constraint;
  CREATE TABLE IF NOT EXISTS person (
      number INT(11),
      name VARCHAR(255),
      birthday DATE
  );

  SHOW CREATE table person;
  SHOW FULL COLUMNS FROM person;

  DROP TABLE person;
  DROP TABLE IF EXISTS person;

  SHOW TABLES FROM samp_db;
  ```

* 读取历史数据

  ```sql
  create table t (c int);
  insert into t values (1), (2), (3);
  select * from t; -- 1, 2, 3
  
  select now(); -- update前时间点, 2019-12-31 02:53:09
  
  update t set c=22 where c=2;
  select * from t; -- 1, 22, 3
  
  set @@tidb_snapshot="2019-12-31 02:53:09"; -- 设置一个特殊的环境变量, 这个是一个 session scope 的变量, 其意义为读取这个时间之前的最新的一个版本, 注意此设置生效后更新数据会报错
  
  select * from t; -- 1, 2, 3
  
  set @@tidb_snapshot=""; -- 清空这个变量后, 即可读取最新版本数据
  select * from t; -- 1, 22, 3
  ```

* 修改时区, NOW() 和 CURTIME() 的返回值都受到时区设置的影响, 只有 Timestamp 数据类型的值是受时区影响的. 可以理解为, Timestamp 数据类型的实际表示使用的是 (字面值 + 时区信息). 其它时间和日期类型, 比如 Datetime/Date/Time 是不包含时区信息的, 所以也不受到时区变化的影响. 其实 Timestamp 持久化到存储的值始终没有变化过, 只是根据时区的不同显示值不同. Timestamp 类型和 Datetime 等类型的值, 两者相互转换的过程中, 会涉及到时区. 这种情况一律基于 session 的当前 time_zone 时区处理  
  
  设置 time_zone 的值的格式:  
  * 'SYSTEM' 表明使用系统时间
  * 相对于 UTC 时间的偏移, 比如 '+10:00' 或者 '-6:00'
  * 某个时区的名字, 比如 'Europe/Helsinki',  'US/Eastern' 或 'MET'
  
  ```sql
  SET GLOBAL time_zone = timezone; -- 修改全局时区
  SET time_zone = timezone; -- 修改 session 使用的时区, 默认条件下, 这个值取的是全局变量 time_zone 的值
  SELECT @@global.time_zone, @@session.time_zone; -- 查看当前使用的时区的值

  set @@time_zone = 'UTC';
  set @@time_zone = '+8:00';

  ```

* 自定义变量

  ```sql
  SET @var_name := expr; -- 用户自定义变量是跟 session 绑定的, 也就是说只有当前连接可以看见设置的用户变量, 其他客户端连接无法查看到
  ```

* 事务, TiDB 默认使用乐观事务模式, 存在事务提交时因为冲突而失败的问题. 为了保证事务的成功率, 需要修改应用程序, 加上重试的逻辑. 悲观事务模式可以避免这个问题, 应用程序无需添加重试逻辑, 就可以正常执行.  

  ```sql
  BEGIN PESSIMISTIC; -- 此语句开启的事务, 会进入悲观事务模式
  set @@tidb_txn_mode = 'pessimistic'; -- 使这个 session 执行的所有显式事务 (即非 autocommit 的事务) 都会进入悲观事务模式
  set @@global.tidb_txn_mode = 'pessimistic'; -- 使之后整个集群所有新创建的 session 都会进入悲观事务模式执行显式事务

  BEGIN OPTIMISTIC; -- 此语句开启的事务, 会进入乐观事务模式
  set @@tidb_txn_mode = 'optimistic'; -- 使当前的 session 执行的事务进入乐观事务模式
  ```  
