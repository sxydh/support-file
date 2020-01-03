# Procedure
  * hieQueDown
    ```sql
    DELIMITER $$
    
    USE `charging_system`$$
    
    DROP PROCEDURE IF EXISTS `hieQueDown`$$
    
    CREATE DEFINER = `keep` @`%` PROCEDURE `hieQueDown` (IN root_id INT) 
    BEGIN
      CREATE TEMPORARY TABLE IF NOT EXISTS TEMP_HIE (
        sno INT PRIMARY KEY AUTO_INCREMENT,
        id INT,
        depth INT
      ) ;
      DELETE 
      FROM
        TEMP_HIE ;
      CALL hieQueRecursive (root_id, 0) ;
      SELECT 
        TEMP_HIE.*,
        CS_NODE.* 
      FROM
        TEMP_HIE,
        CS_NODE 
      WHERE TEMP_HIE.id = CS_NODE.id 
      ORDER BY TEMP_HIE.sno ;
    END $$
    
    DELIMITER ;
    ```
  
  * hieQueRecursive
    ```sql
    DELIMITER $$
    
    USE `charging_system`$$
    
    DROP PROCEDURE IF EXISTS `hieQueRecursive`$$
    
    CREATE DEFINER = `keep` @`%` PROCEDURE `hieQueRecursive` (IN cur_root_id INT, IN depth INT) 
    BEGIN
      DECLARE done INT DEFAULT 0 ;
      DECLARE next_root_id INT ;
      DECLARE curso CURSOR FOR 
      SELECT 
        id 
      FROM
        CS_NODE 
      WHERE p_id = cur_root_id ;
      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1 ;
      SET @@max_sp_recursion_depth = 255 ;
      INSERT INTO TEMP_HIE 
      VALUES
        (NULL, cur_root_id, depth) ;
      OPEN curso ;
      FETCH curso INTO next_root_id ;
      WHILE
        done = 0 DO CALL hieQueRecursive (next_root_id, depth + 1) ;
        FETCH curso INTO next_root_id ;
      END WHILE ;
      CLOSE curso ;
    END $$
    
    DELIMITER ;
    ```

# Function
  * hieQueDown
    ```sql
    DELIMITER $$
    
    USE `charging_system`$$
    
    DROP FUNCTION IF EXISTS `hieQueDown`$$
    
    CREATE DEFINER = `keep` @`%` FUNCTION `hieQueDown` (root_id INT) RETURNS VARCHAR (60000) CHARSET latin1 
    BEGIN
      DECLARE ids VARCHAR (60000) ;
      DECLARE child_ids VARCHAR (60000) ;
      SET ids = '' ;
      SET child_ids = CAST(root_id AS CHAR) ;
      WHILE
        child_ids IS NOT NULL DO 
        SET ids = CONCAT(ids, ',', child_ids) ;
        SELECT 
          GROUP_CONCAT(id) INTO child_ids 
        FROM
          CS_NODE 
        WHERE FIND_IN_SET(p_id, child_ids) > 0 ;
      END WHILE ;
      RETURN SUBSTRING(ids, 2) ;
    END $$
    
    DELIMITER ;
  ```

  * hieQueUp
    ```sql
    DELIMITER $$
    
    USE `charging_system`$$
    
    DROP FUNCTION IF EXISTS `hieQueUp`$$
    
    CREATE DEFINER=`keep`@`%` FUNCTION `hieQueUp`(sub_id INT) RETURNS VARCHAR(60000) CHARSET latin1
    BEGIN
      DECLARE ids VARCHAR (60000) ;
      DECLARE par_id VARCHAR (60000) ;
      DECLARE temp_id VARCHAR (60000) ;
      SET ids = '' ;
      SET par_id = CAST(sub_id AS CHAR) ;
      SET temp_id = CAST((sub_id + 1) AS CHAR) ;
      WHILE
        temp_id != par_id DO 
        SET temp_id = par_id ;
        SET ids = CONCAT(',', par_id, ids) ;
        SELECT 
          p_id INTO par_id 
        FROM
          CS_NODE 
        WHERE id = par_id ;
      END WHILE ;
      
      RETURN SUBSTRING(ids, 2) ;
        END$$
    
    DELIMITER ;
    ```