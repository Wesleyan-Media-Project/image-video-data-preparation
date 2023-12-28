-- A query to retrieve additional information on Google ad-id level data and create a "master table"
-- Replace "my-table" with your Google BigQuery table set up in the data collection step

SELECT ad_id, ad_url, ad_type, advertiser_id, advertiser_name, date_range_start, date_range_end, num_of_days,
  impressions, age_targeting, gender_targeting, geo_targeting_included, geo_targeting_excluded,
  spend_range_min_usd, spend_range_max_usd
 FROM `"my-table"` 
 where date_range_start <= '2022-11-08'
 and date_range_end > '2021-01-06'
 and regions = 'US';