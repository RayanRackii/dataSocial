/*
 
 Data cleaning steps
 
 1. Remove unnecessary columns
 2. Extract 
 3. Rename the columns
 
 */
/* SELECT 
 NAME,
 total_subscribers,
 total_views,
 total_videos
 FROM top_br_youtubers_2024 */

-- CHARINDEX
/* Takes 2 arguments, the first one is the char, in this case @, and then shows at what index it is located  */
/* SELECT CHARINDEX('@', NAME) NAME from top_br_youtubers_2024; */

-- SUBSTRING
/* Takes 3 arguments, the fist one is the column, in this case NAME, the second argument is in which position the string should start in this case 
 1 (start) and the last is where the string should end. Cast is just to make sure that the type will be varchar*/
CREATE VIEW view_br_youtubers_2024 AS
SELECT
	CAST(
		SUBSTRING(NAME, 1, CHARINDEX('@', NAME) -1) AS varchar(100)
	) as channel_name,
	total_subscribers,
	total_views,
	total_videos
FROM
	top_br_youtubers_2024;