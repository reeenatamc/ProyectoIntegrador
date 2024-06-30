DELIMITER //

CREATE PROCEDURE ExportarTodasLasTablas()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE table_name VARCHAR(255);
    DECLARE cur CURSOR FOR 
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'pi_db';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    leer_tablas: LOOP
        FETCH cur INTO table_name;
        IF done THEN
            LEAVE leer_tablas;
        END IF;

        SET @query = CONCAT(
            'SELECT * INTO OUTFILE "urlespecificada', table_name, '.csv" ',
            'FIELDS TERMINATED BY "," ENCLOSED BY \'"\' ',
            'LINES TERMINATED BY "\n" ',
            'FROM ', table_name
        );
        PREPARE stmt FROM @query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;
