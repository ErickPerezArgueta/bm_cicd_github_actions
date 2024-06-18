USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;
USE DATABASE BANANA_QUALITY;
USE SCHEMA EXP;

--PUTS RAW DATA FILE INTO STAGE (EXP)
PUT 'file://data/banana_quality_raw.csv' @BANANA_QUALITY.EXP.RAW_DATA AUTO_COMPRESS=FALSE;

CREATE OR REPLACE TABLE BANANA_QUALITY.EXP.BANANA_QUALITY_RAW(
    SIZE DOUBLE NULL,
    WEIGHT DOUBLE NULL,
    SWEETNESS DOUBLE NULL,
    SOFTNESS DOUBLE NULL,
    HARVESTTIME DOUBLE NULL,
    RIPENESS DOUBLE NULL,
    ACIDITY DOUBLE NULL,
    QUALITY VARCHAR(4) NULL
);

CREATE OR REPLACE FILE FORMAT BANANA_QUALITY.EXP.MY_CSV_FORMAT
  TYPE = CSV
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  NULL_IF = ('NULL', 'null')
  EMPTY_FIELD_AS_NULL = true;

COPY INTO BANANA_QUALITY.EXP.BANANA_QUALITY_RAW
FROM @BANANA_QUALITY.EXP.RAW_DATA/banana_quality_raw.csv
FILE_FORMAT = (FORMAT_NAME = MY_CSV_FORMAT);


--PUTS RAW DATA FILE INTO STAGE (VALIDATE)
USE SCHEMA VALIDATE;
PUT 'file://data/banana_quality_raw.csv' @BANANA_QUALITY.VALIDATE.RAW_DATA AUTO_COMPRESS=FALSE;

CREATE OR REPLACE TABLE BANANA_QUALITY.VALIDATE.BANANA_QUALITY_RAW(
    SIZE DOUBLE NULL,
    WEIGHT DOUBLE NULL,
    SWEETNESS DOUBLE NULL,
    SOFTNESS DOUBLE NULL,
    HARVESTTIME DOUBLE NULL,
    RIPENESS DOUBLE NULL,
    ACIDITY DOUBLE NULL,
    QUALITY VARCHAR(4) NULL
);

CREATE OR REPLACE FILE FORMAT BANANA_QUALITY.VALIDATE.MY_CSV_FORMAT
  TYPE = CSV
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  NULL_IF = ('NULL', 'null')
  EMPTY_FIELD_AS_NULL = true;

COPY INTO BANANA_QUALITY.VALIDATE.BANANA_QUALITY_RAW
FROM @BANANA_QUALITY.VALIDATE.RAW_DATA/banana_quality_raw.csv
FILE_FORMAT = (FORMAT_NAME = MY_CSV_FORMAT);


--PUTS RAW DATA FILE INTO STAGE (LIVE)
USE SCHEMA LIVE;
PUT 'file://data/banana_quality_raw.csv' @BANANA_QUALITY.LIVE.RAW_DATA AUTO_COMPRESS=FALSE;

CREATE OR REPLACE TABLE BANANA_QUALITY.LIVE.BANANA_QUALITY_RAW(
    SIZE DOUBLE NULL,
    WEIGHT DOUBLE NULL,
    SWEETNESS DOUBLE NULL,
    SOFTNESS DOUBLE NULL,
    HARVESTTIME DOUBLE NULL,
    RIPENESS DOUBLE NULL,
    ACIDITY DOUBLE NULL,
    QUALITY VARCHAR(4) NULL
);

CREATE OR REPLACE FILE FORMAT BANANA_QUALITY.LIVE.MY_CSV_FORMAT
  TYPE = CSV
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  NULL_IF = ('NULL', 'null')
  EMPTY_FIELD_AS_NULL = true;

COPY INTO BANANA_QUALITY.LIVE.BANANA_QUALITY_RAW
FROM @BANANA_QUALITY.LIVE.RAW_DATA/banana_quality_raw.csv
FILE_FORMAT = (FORMAT_NAME = MY_CSV_FORMAT);