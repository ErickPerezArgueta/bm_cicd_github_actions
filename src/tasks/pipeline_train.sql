USE ROLE $ROLE$;
USE WAREHOUSE $WAREHOUSE$;
USE DATABASE $DB_NAME$;
USE SCHEMA $SCHEMA$;

CREATE OR REPLACE TASK $SCHEMA$.TASK_PROCESS
WAREHOUSE = $WAREHOUSE$
SCHEDULE = '3 MINUTE'
AS
    CALL $DB_NAME$.$SCHEMA$.process_step();

CREATE OR REPLACE TASK $SCHEMA$.TASK_TRAIN
WAREHOUSE = $WAREHOUSE$
AFTER $SCHEMA$.TASK_PROCESS
AS
    CALL $DB_NAME$.$SCHEMA$.train_step();
;
ALTER TASK $SCHEMA$.TASK_TRAIN RESUME;
ALTER TASK $SCHEMA$.TASK_PROCESS RESUME;


