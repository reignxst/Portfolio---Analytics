USE project;

CREATE TABLE calls (
    id          VARCHAR(50),
    customer_name   VARCHAR(50),
    sentiment       VARCHAR(50),
    csat_score      INT,
    call_timestamp  VARCHAR(12),
    reason          VARCHAR(25),
    city            VARCHAR(30),
    state           VARCHAR(25),
    channel         VARCHAR(20),
    response_time   VARCHAR(20),
    call_duration_in_minutes INT,
    call_center     VARCHAR(20)
);
SELECT * FROM calls LIMIT 10;

SET SQL_SAFE_UPDATES = 0;

UPDATE calls
SET call_timestamp = STR_TO_DATE(call_timestamp, '%m/%d/%Y');

ALTER TABLE calls
MODIFY call_timestamp DATE;

SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;

UPDATE calls
SET csat_score = NULL
WHERE csat_score = 0;

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM calls LIMIT 10;

SELECT COUNT(*) AS num_columns
FROM information_schema.columns
WHERE table_schema = 'project' AND table_name = 'calls';


SELECT DISTINCT sentiment FROM calls;
SELECT DISTINCT reason FROM calls;
SELECT DISTINCT channel FROM calls;
SELECT DISTINCT response_time FROM calls;
SELECT DISTINCT call_center FROM calls;

SELECT DAYNAME(call_timestamp) AS day_of_week,
       COUNT(*) AS num_calls
FROM calls
GROUP BY day_of_week
ORDER BY num_calls DESC;

SELECT MIN(call_duration_in_minutes) AS min_duration,
       MAX(call_duration_in_minutes) AS max_duration,
       AVG(call_duration_in_minutes) AS avg_duration
FROM calls;

SELECT MIN(csat_score) AS min_score,
       MAX(csat_score) AS max_score,
       AVG(csat_score) AS avg_score
FROM calls
WHERE csat_score IS NOT NULL;

SELECT call_center, response_time, COUNT(*) AS num_calls
FROM calls
GROUP BY call_center, response_time
ORDER BY call_center, num_calls DESC;

SELECT call_center, response_time, COUNT(*) AS num_calls
FROM calls
GROUP BY call_center, response_time
ORDER BY call_center, num_calls DESC;

SELECT DISTINCT call_timestamp,
       MAX(call_duration_in_minutes) OVER (PARTITION BY call_timestamp) AS max_duration_per_day
FROM calls
ORDER BY call_timestamp;