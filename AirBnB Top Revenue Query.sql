SELECT id, listing_url, name, 30 - availability_30 as booked_out_30,
	CAST(replace(Price, '$', ' ') as UNSIGNED) as price_clean,
	CAST(replace(Price, '$', ' ') as UNSIGNED)*(30 - availability_30) as proj_rev_30 
FROM airbnblistings
ORDER BY proj_rev_30 DESC LIMIT 30