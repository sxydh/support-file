# Profile
  Simple mysql tutorial.

# Specification
  * 基本
    ```sql
    @ --声明局部变量
    @@ --声明全局变量

    cd\ --进入根目录
    cls --清屏
    \c --自带的command line clien清空输入
    mysql --help --不要加分号, 获取帮助信息, 未进入数据库的情况下
    
    /*登陆*/
    mysql -h127.0.0.1 -P3306 -uroot  -p
    ```

  * 数据库
    ```sql
    /*创建数据库*/
    CREATE SCHEMA `test`;

    /*删除数据库*/
    DROP DATABASE charging_system;

    /*查看所有数据库*/
    SHOW DATABASES;
    ```

  * 用户
    ```sql
    /*查询所有用户*/
    SELECT user FROM mysql.user;
    
    /*新建用户*/
    CREATE USER test IDENTIFIED BY '******';

    /*创建远程访问用户并授权, 注意, 大小写是敏感的, 可用此语句重置远程用户密码*/
    GRANT ALL ON *.* TO test@'%' IDENTIFIED BY '******' WITH GRANT OPTION;
    FLUSH PRIVILEGES;

    /*修改密码*/
    ALTER USER 'test'@'localhost' IDENTIFIED WITH mysql_native_password BY '******'; 
    FLUSH PRIVILEGES;
    
    /*授权*/
    GRANT ALL ON *.* TO test;
    FLUSH PRIVILEGES;

    /*撤销授权*/
    REVOKE ALL ON *.* FROM 'test'@'%';
    FLUSH PRIVILEGES;

    /*删除用户*/
    DELETE FROM user WHERE user='root' AND host='%';
    FLUSH PRIVILEGES;
    ```

  * 表
    ```sql
    /*创建表*/
    CREATE TABLE IF NOT EXISTS `tableName`
    (
    id int NOT NULL AUTO_INCREMENT,
    name char(50) NOT NULL DEFAULT '1',
    PRIMARY KEY (id)
    )
    Engine InnoDB;

    /*显示所有表*/
    SHOW TABLES;
  
    /*显示所有列*/
    SHOW COLUMNS FROM `tableName`;
    DESCRIBE `tableName`;
  
    /*重命名表*/
    RENAME TABLE `oldName` TO `newName`;
    
    ALTER TABLE `tableName` CHANGE `oldName` `newName` char(50);

    /*修改列*/
    ALTER TABLE `tableName` MODIFY `columnName` int;
    
    /*新增列*/
    ALTER TABLE `tableName` ADD `columnName` char(50);

    /*删除列*/
    ALTER TABLE `tableName` DROP `columnName`;
    
    /*调整列顺序*/
    ALTER TABLE `tableName` MODIFY `columnA` char(50) AFTER `columnB`;
    
    /*删除表*/
    DROP TABLE `tableName`;
    ```
    
  * 数据操作
    ```sql
    /*AVG(): The AVG() function returns the average value of an expression*/
    SELECT AVG(price) AS avgprice FROM products;

    /*CONCAT: 拼接字段, 注意如果任一行处拼接时, 有一个值是null, 该处的拼接结果将会是null*/
    SELECT CONCAT(`columnNameA`,'chars',`columnNameB`) FROM `tableName`; 

    /*DELETE*/
    DELETE p FROM person p, person d WHERE p.email = d.email AND p.id > d.id; -- 删除重复邮箱

    /*GROUP BY*/
    SELECT GROUP_CONCAT(id), GROUP_CONCAT(user_id), node_id FROM CS_USER_REF_NODE GROUP BY node_id HAVING COUNT(id) >= 1; -- HAVING可用于选取符合条件的一些组，不符合条件的组则过滤掉

    /*IF*/
    SELECT DISTINCT 
      a.Num ConsecutiveNums 
    FROM
      (SELECT 
        t.Num,
        @cnt := IF(@pre = t.Num, @cnt + 1, 1) cnt, -- 三元表达式
        @pre := t.Num pre 
      FROM
        LOGS t,
        (SELECT 
          @pre := NULL, -- 变量声明, 初始化时没有值一定要赋值为NULL, 否则会有错误结果
          @cnt := 0) b) a 
    WHERE a.cnt >= 3 

    /*LIMIT*/ 
    SELECT * FROM `tableName` LIMIT 2,3; -- 不包含第二行, 取后三行
    SELECT * FROM `tableName` LIMIT 3 OFFSET 2; -- 同上, 注意位置和上述是相反的

    /*RECURSIVE*/
    WITH RECURSIVE cte AS (
      SELECT     id,
                 NAME,
                 p_id
      FROM       CS_NODE
      WHERE      id = 3
      UNION ALL
      SELECT     r.id,
                 r.name,
                 r.p_id
      FROM       CS_NODE r
      INNER JOIN cte
              ON r.id = cte.p_id
    )
    SELECT cte.*, @rowno := @rowno + 1 AS rowno FROM cte, (SELECT @rowno := 0) r ORDER BY rowno DESC; -- 向上

    WITH RECURSIVE cte AS (
      SELECT     id,
                 NAME,
                 p_id
      FROM       CS_NODE
      WHERE      id = 4
      UNION ALL
      SELECT     r.id,
                 r.name,
                 r.p_id
      FROM       CS_NODE r
      INNER JOIN cte
              ON r.p_id = cte.id
    )
    SELECT cte.* FROM cte; -- 向下

    /*REGEXP*/
    SELECT * FROM CS_USER WHERE NAME REGEXP '^s....$';

    /*ROW_NUMBER(): since version 8.0*/
    SELECT ref.*, ROW_NUMBER() OVER(PARTITION BY node_id ORDER BY createtime DESC) rnum FROM CS_USER_REF_NODE ref;

    /*ROWNUM*/
    SELECT e.*, @rownum := @rownum + 1 rn FROM employee e, (SELECT @rownum := 0) t; -- 获取行号

    /*DATE_FORMAT*/
    SELECT DATE_FORMAT(createtime, '%Y-%m-%d %T') FROM CS_ORDER;

    SELECT RAND();

    /*TRIM: TRIM([{BOTH | LEADING | TRAILING} [remstr] FROM] str), 默认BOTH*/
    SELECT TRIM('  BHE  '); -- BHE

    /*UPPER*/
    SELECT UPPER('bhe');

    SELECT UUID();
    ```

  * 存储过程和函数   
    [*Hierarchical queries*](./HIE%20QUERY.md)
    [*Solution*](./SOLUTION.md)