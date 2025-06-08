/* 
 
 Data quality tests
 
 1. Data needs 100 records of YT channels
 2. Data needs 4 fields
 3. Channel name must be string and the rest of coluns needs to be numerical
 4. Each record must be unique, unless deleted channels
 
 Row count - 100
 Column count - 4
 
 --Data types:
 channel_name: varchar
 total_subscribers: integer
 total_videos: integer
 total_views: integer
 
 */
-- 1. Row count check
SELECT
      COUNT(*) as no_of_rows
FROM
      dbo.view_br_youtubers_2024;

-- 2. Column count check
SELECT
      COUNT(*) AS column_count
FROM
      INFORMATION_SCHEMA.COLUMNS
WHERE
      TABLE_NAME = 'view_br_youtubers_2024';

-- 3. Data Type check

SELECT      
      COLUMN_NAME,
      DATA_TYPE
FROM  
      INFORMATION_SCHEMA.COLUMNS
WHERE 
      TABLE_NAME = 'view_br_youtubers_2024';

-- 4. Duplicate records check

SELECT
      channel_name,
      COUNT(*) as duplicate_count
FROM
      top_br_youtubers_2024
GROUP BY    
      channel_name
HAVING
      COUNT(*) > 1;

