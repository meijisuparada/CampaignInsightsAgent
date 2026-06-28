 -- ============================================================
-- LEVEL 1: BEGINNER QUERIES
-- Concept: SELECT, FROM, WHERE, ORDER BY, LIMIT
-- ============================================================

use campagin_insight;

-- See what the data looks like
select * 
from campaigninsight_dataset 
limit 10;

-- Clean decimal points
set SQL_SAFE_UPDATES = 0;
-- update campaigninsight_dataset
update campaigninsight_dataset
set ctr = cast(round(cpc,2) as decimal (10,2));
update campaigninsight_dataset
set cpc = cast(round(cpc,2) as decimal (10,2));
update campaigninsight_dataset
set conversion_rate = cast(round(conversion_rate,2) as decimal (10,2));

-- What channels do we have?
select distinct channel from campaigninsight_dataset;

-- What audience segments exist?
select distinct audience_segment from campaigninsight_dataset;

-- Show rows where spend was over $5,000
select date, campaign_id, channel, spend
from campaigninsight_dataset
where spend > 5000
order by spend desc
limit 20;

-- ============================================================
-- LEVEL 2: INTERMEDIATE QUERIES
-- Concept: GROUP BY, SUM, AVG, COUNT, ROUND
-- ============================================================

--  Total spend and revenue by channel (Summary)
select
	channel,
	round(sum(spend),2) as total_spend,
    sum(conversions) as total_conversions,
    round(avg((spend / impressions)*1000),2) as avg_cpm,
    round(avg(conversion_rate),2) as avg_cvr,
	round((sum(revenue)/sum(spend)),2) as roas
from campaigninsight_dataset
group by channel
order by total_spend desc;

-- Performance by audience segment
select
    audience_segment,
    round(avg(conversion_rate), 2) as avg_cvr,
    round(sum(spend), 2)                 as total_spend,
    round(sum(revenue), 2)               as total_revenue
from campaigninsight_dataset
group by audience_segment
order by avg_cvr desc;

-- Monthly Spend Trend
select
	date_format(date, '%Y-%m') as month,
    round(sum(spend), 2) as total_spend,
    round(sum(revenue), 2) as total_revenue
from campaigninsight_dataset
group by month
order by month;

-- Flag underperforming channel+segment combos
select
	channel,
    audience_segment,
    round(sum(revenue)/sum(spend), 2) as roas
from campaigninsight_dataset
group by channel, audience_segment
having roas < 2.0
order by roas asc;

-- ============================================================
-- BONUS: REAL WORLD SCENARIO QUERIES
-- ============================================================
-- Client asks "How did Q1 vs Q2 compare?"
select
	case
		when month(date) between 1 and 3 then 'Q1'
        when month(date) between 4 and 6 then 'Q2'
	end as quarter,
	round(sum(spend), 2) as total_spend,
    round(sum(revenue), 2) as total_revenue,
    round(sum(revenue)/sum(spend), 2) as roas,
    round(sum(spend)/sum(conversions), 2) as cpa
from campaigninsight_dataset
group by quarter
order by quarter;
    
