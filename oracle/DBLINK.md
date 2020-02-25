* Define
  ```sql
  /*Authority check*/
  SELECT * FROM user_sys_privs WHERE PRIVILEGE LIKE UPPER('%DATABASE LINK%');

  /*Grant*/
  GRANT CREATE PUBLIC DATABASE LINK,DROP PUBLIC DATABASE LINK TO test; 

  /*Revoke if you want*/
  REVOKE CREATE PUBLIC DATABASE LINK,DROP PUBLIC DATABASE LINK FROM test; 

  /*Create*/
  CREATE PUBLIC DATABASE LINK test_link_check_shop_new
  CONNECT TO check_shop_new IDENTIFIED BY "check_shop_new"
  USING '(DESCRIPTION =(ADDRESS_LIST =(ADDRESS =(PROTOCOL = TCP)(HOST = 192.168.18.161)(PORT = 1521)))(CONNECT_DATA =(SERVICE_NAME = orcl)))';

  /*Drop*/
  DROP PUBLIC DATABASE LINK test_link_check_shop_new;
  ```