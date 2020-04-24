* Define
  ```sql
  /*Authority check, current user*/
  SELECT * FROM user_sys_privs WHERE PRIVILEGE LIKE UPPER('%DATABASE LINK%');

  /*Grant, db user*/
  GRANT CREATE PUBLIC DATABASE LINK,DROP PUBLIC DATABASE LINK TO keep; 

  /*Revoke if you want, db user*/
  REVOKE CREATE PUBLIC DATABASE LINK,DROP PUBLIC DATABASE LINK FROM keep; 

  /*Create, current user*/
  CREATE PUBLIC DATABASE LINK link_another
  CONNECT TO another IDENTIFIED BY "123"
  USING '(DESCRIPTION =(ADDRESS_LIST =(ADDRESS =(PROTOCOL = TCP)(HOST = 127.0.0.1)(PORT = 1521)))(CONNECT_DATA =(SERVICE_NAME = orcl)))';

  /*Drop*/
  DROP PUBLIC DATABASE LINK link_keep;
  ```