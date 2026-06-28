-- ============================================================
-- CAMPAIGN DATA — SQL PRACTICE GUIDE
-- Week 2: Load & Query in MySQL Workbench
-- ============================================================
 
 
-- ============================================================
-- STEP 1: CREATE YOUR DATABASE & TABLE
-- Run this first, before importing the CSV
-- ============================================================
create database if not exists campaign_analysis;
use campaign_analysis;

drop table if exists campaign_data;

create table campaign_data (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    date            DATE,
    campaign_id     INT,
    channel         VARCHAR(50),
    audience_segment VARCHAR(100),
    impressions     INT,
    clicks          INT,
    spend           DECIMAL(10,2),
    conversions     INT,
    revenue         DECIMAL(10,2),
    ctr             DECIMAL(6,4),
    cpc             DECIMAL(6,2),
    conversion_rate DECIMAL(6,4)
);

-- ============================================================
-- STEP 2: IMPORT YOUR CSV
-- In MySQL Workbench:
--   1. Right-click your table → Table Data Import Wizard
--   2. Browse to campaign_data.csv
--   3. Match columns → Finish
-- OR use this command if you have file access:
-- ============================================================

LOAD DATA INFILE '/path/to/CampaignInsight_dataset.csv'
INTO TABLE campaign_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(date, campaign_id, channel, audience_segment, impressions,
clicks, spend, conversions, revenue, ctr, cpc, conversion_rate);