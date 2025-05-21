-- How many titles has each platform sold in total?
SELECT platform, COUNT(title) AS titles_sold 
FROM streaming_titles
GROUP BY platform;

-- Converting to percentage of all titles using subquery
SELECT 
    platform, 
    COUNT(title) AS titles_sold,
    CAST(
        ROUND((COUNT(title) * 100.0) / 
        (SELECT COUNT(*) * 1.0 FROM streaming_titles), 2) 
    AS DECIMAL(5,2)) AS percent_of_total
FROM streaming_titles
GROUP BY platform;

--Converting to percentage of all titles using CTE
WITH total_tables AS (
	SELECT COUNT(*) AS total FROM streaming_titles
)
SELECT
	st.platform,
	count(st.title) AS titles_sold,
	CAST(ROUND((COUNT(st.title) * 100.0) / (tt.total * 1.0), 2) AS DECIMAL(5,2)) AS percent_of_total
FROM streaming_titles st
CROSS JOIN total_tables tt
GROUP BY st.platform, tt.total;

-- Show a count of original vs. licensed titles per platform.
SELECT platform, is_original, COUNT(title) AS count_titles 
FROM streaming_titles
GROUP BY platform, is_original;

-- Convert to percentages with CTE to show the percentage of originals per platform
WITH counts AS (
  SELECT 
    platform,
    COUNT(*) AS total_titles,
    SUM(CASE WHEN is_original = 1 THEN 1 ELSE 0 END) AS original_titles
  FROM streaming_titles
  GROUP BY platform
)
SELECT 
  platform,
  original_titles,
  total_titles,
  ROUND(CAST(original_titles AS FLOAT) / total_titles * 100, 2) AS percent_original
FROM counts;

-- Compare how much content each platform has that's domestic(United States) vs. international
SELECT 
  platform,
  CASE 
	WHEN country <> 'United States' THEN 'International' ELSE 'Domestic'
  END AS content_origin,
  COUNT(*) AS title_count
FROM streaming_titles
GROUP BY platform, 
	CASE 
		WHEN country <> 'United States' THEN 'International' ELSE 'Domestic'
	END;

-- Convert to percentage
WITH origin_counts AS (
  SELECT 
    platform,
    CASE 
      WHEN country != 'United States' THEN 'International' ELSE 'Domestic'
    END AS content_origin,
    COUNT(*) AS title_count
  FROM streaming_titles
  GROUP BY platform, 
           CASE 
             WHEN country != 'United States' THEN 'International' ELSE 'Domestic'
           END
),
total_titles AS (
  SELECT 
    platform,
    COUNT(*) AS total_titles
  FROM streaming_titles
  GROUP BY platform
)
SELECT 
  o.platform,
  o.content_origin,
  o.title_count,
  ROUND(CAST(1.0 * o.title_count / t.total_titles * 100 AS DECIMAL(5,2)), 2) AS percent_of_platform
FROM origin_counts o
JOIN total_titles t
  ON o.platform = t.platform
ORDER BY o.platform, o.content_origin;

-- How many distinct genres does each platform have in their catalog?
WITH genre_diversity AS (
  SELECT 
    platform, 
    COUNT(DISTINCT genre) AS genre_count
  FROM streaming_titles
  GROUP BY platform
)
SELECT 
  platform, 
  genre_count,
  RANK() OVER (ORDER BY genre_count DESC) AS genre_rank
FROM genre_diversity;

-- What is the most common genre per platform
WITH genre_counts AS (
  SELECT 
    platform, 
    genre, 
    COUNT(*) AS genre_count,
    RANK() OVER (PARTITION BY platform ORDER BY COUNT(*) DESC) AS genre_rank
  FROM streaming_titles
  GROUP BY platform, genre
)
SELECT 
  platform,
  genre AS top_genre,
  genre_count
FROM genre_counts
WHERE genre_rank = 1;


