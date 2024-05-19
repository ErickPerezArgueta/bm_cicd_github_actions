USE ROLE ACCOUNTADMIN;
USE DATABASE BANANA_QUALITY;
USE SCHEMA DEV;

CREATE OR REPLACE TABLE BANANA_QUALITY.DEV.BANANA_QUALITY_RAW(
    SIZE DOUBLE NULL,
    WEIGHT DOUBLE NULL,
    SWEETNESS DOUBLE NULL,
    SOFTNESS DOUBLE NULL,
    HARVESTTIME DOUBLE NULL,
    RIPENESS DOUBLE NULL,
    ACIDITY DOUBLE NULL,
    QUALITY VARCHAR(4) NULL
);

CREATE OR REPLACE FILE FORMAT BANANA_QUALITY.DEV.MY_CSV_FORMAT
  TYPE = CSV
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  NULL_IF = ('NULL', 'null')
  EMPTY_FIELD_AS_NULL = true;


--USE SCHEMA BANANA_QUALITY.DEV;
--PUT 'file://'$GITHUB_WORKSPACE'/data/banana_quality_raw.csv' @BANANA_QUALITY.DEV.RAW_DATA AUTO_COMPRESS=FALSE;

COPY INTO BANANA_QUALITY.DEV.BANANA_QUALITY_RAW
FROM @BANANA_QUALITY.DEV.RAW_DATA/banana_quality_raw.csv
FILE_FORMAT = (FORMAT_NAME = MY_CSV_FORMAT);

SELECT * FROM BANANA_QUALITY_RAW;
