/*

1. Define variables
2. Create a CTE that rounds the avarage views per video
3. Select the columns that are required for the analysis
4. Filter the results by the Youtube channels with the highest subscriber bases
5. Order by net_profit

*/

-- 1
DECLARE @conversionRate FLOAT = 0.02;       -- Conversion rate @ 2%
DECLARE @productCost MONEY = 5.0;           -- Product cost @ $5
DECLARE @campaignCost MONEY = 50000.0;      -- Campaign cost @ $50k

-- 2
WITH channelData AS (
      SELECT
            channel_name, 
            total_views,
            total_videos,
            ROUND((CAST(total_views as FLOAT) / total_videos), -4) AS rounded_avg_views_per_video
      FROM
            view_br_youtubers_2024
            
)

-- 3
SELECT
      channel_name,
      rounded_avg_views_per_video,
      (rounded_avg_views_per_video * @conversionRate) as potential_units_sold_per_video,
      (rounded_avg_views_per_video * @conversionRate * @productCost) as potential_revenue_per_video,
      (rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCost as net_profit
FROM 
      channelData
WHERE
      channel_name 
-- 4
IN
      ('Canal KondZilla', 'Bispo Bruno Leonardo', 'LUCCAS NETO - LUCCAS TOON')
-- 5
ORDER BY
      net_profit DESC;

/* DROP TABLE channel_profit_analysis;

-- Create new Table Analysis
WITH channelData AS (
      SELECT
            channel_name, 
            total_views,
            total_videos,
            ROUND((CAST(total_views as FLOAT) / total_videos), -4) AS rounded_avg_views_per_video
      FROM
            view_br_youtubers_2024
)
SELECT
      channel_name,
      rounded_avg_views_per_video,
      (rounded_avg_views_per_video * @conversionRate) as potential_units_sold_per_video,
      (rounded_avg_views_per_video * @conversionRate * @productCost) as potential_revenue_per_video,
      (rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCost as net_profit
INTO
      dbo.channel_profit_analysis
FROM 
      channelData */