SELECT *
FROM `my-new-project-396319.dynamic_dataset.donors`

-- Orders contribution amount by total amount and last name

SELECT Last, Contribution_2020
FROM `my-new-project-396319.dynamic_dataset.donors`
ORDER BY Contribution_2020 desc

-- Concatenates name and job title ordered by contribution

SELECT Job_Title,
  CONCAT(
    first, 
    IFNULL(CONCAT(' ', middle), ''), 
    ' ', 
    last,
    IFNULL(CONCAT(', ', Job_Title), '')
  ) as full_name, Contribution_2020
FROM `my-new-project-396319.dynamic_dataset.donors`
ORDER BY Contribution_2020 DESC;


-- Shows full name, total contribution amount, and contribution amounts per year in descending order.
-- If contribution amounts are null, they are converted to 0.

SELECT Job_Title,
  CONCAT(
    first, 
    IFNULL(CONCAT(' ', middle), ''), 
    ' ', 
    last,
    IFNULL(CONCAT(', ', Job_Title), '')
  ) as full_name,
  (IFNULL(Contribution_2020,0)+
  IFNULL(Contribution_2019,0)+
  IFNULL(Contribution_2018,0)+
  IFNULL(Contribution_2017,0)+
  IFNULL(Contribution_2016,0)) as total_contribution,
  Contribution_2020, Contribution_2019, Contribution_2018, Contribution_2017, Contribution_2016
FROM `my-new-project-396319.dynamic_dataset.donors`
ORDER BY total_contribution DESC;

-- Full name, total contribution amount, concatenated addresses, and are board members.

SELECT Job_Title,
  CONCAT(
    first, 
    IFNULL(CONCAT(' ', middle), ''), 
    ' ', 
    last,
    IFNULL(CONCAT(', ', Job_Title), '')
  ) as full_name,
  (IFNULL(Contribution_2020,0)+
  IFNULL(Contribution_2019,0)+
  IFNULL(Contribution_2018,0)+
  IFNULL(Contribution_2017,0)+
  IFNULL(Contribution_2016,0)) as total_contribution,
  CONCAT(
    Street_Address, '',
    IFNULL(CONCAT(' ', Unit), ''),' ',
    City,' ',
    State,' ',
    Zip
  ) as full_address,
  Board_Member
FROM `my-new-project-396319.dynamic_dataset.donors`
WHERE Board_Member = "TRUE"
ORDER BY total_contribution DESC;

-- using a temp table to find the average total contribution

SELECT
  Job_Title,
  full_name,
  total_contribution,
  Contribution_2020, 
  Contribution_2019, 
  Contribution_2018, 
  Contribution_2017, 
  Contribution_2016,
  (total_contribution/5) as avg_total_contribution
FROM (
  SELECT
    Job_Title,
    CONCAT(
      first, 
      IFNULL(CONCAT(' ', middle), ''), 
      ' ', 
      last,
      IFNULL(CONCAT(', ', Job_Title), '')
    ) as full_name,
    (IFNULL(Contribution_2020,0)+
    IFNULL(Contribution_2019,0)+
    IFNULL(Contribution_2018,0)+
    IFNULL(Contribution_2017,0)+
    IFNULL(Contribution_2016,0)) as total_contribution,
    Contribution_2020, 
    Contribution_2019, 
    Contribution_2018, 
    Contribution_2017, 
    Contribution_2016
  FROM `my-new-project-396319.dynamic_dataset.donors`
)
ORDER BY avg_total_contribution DESC;

-- JOIN and ordered by total contribution

SELECT DISTINCT don.First, don.Last,
  (IFNULL(don.Contribution_2020,0)+
  IFNULL(don.Contribution_2019,0)+
  IFNULL(don.Contribution_2018,0)+
  IFNULL(don.Contribution_2017,0)+
  IFNULL(don.Contribution_2016,0)) as total_contribution
FROM `my-new-project-396319.dynamic_dataset.donors` as don
  FULL JOIN `my-new-project-396319.dynamic_dataset.new_donor_list` as don2
  ON don.First = don2.First
ORDER BY total_contribution DESC;

-- TEMP table of the top 10 board donors from the two joined tables

CREATE OR REPLACE TABLE `my-new-project-396319.dynamic_dataset.top_10_board_donors` AS
SELECT
  CONCAT(
    don.first, 
    IFNULL(CONCAT(' ', don.middle), ''), 
    ' ', 
    don.last,
    IFNULL(CONCAT(', ', don.Job_Title), '')
  ) as full_name,
  IFNULL(don.Contribution_2020, 0) +
  IFNULL(don.Contribution_2019, 0) +
  IFNULL(don.Contribution_2018, 0) +
  IFNULL(don.Contribution_2017, 0) +
  IFNULL(don.Contribution_2016, 0) as total_contribution,
  don.Board_Member
FROM `my-new-project-396319.dynamic_dataset.donors` as don
FULL JOIN `my-new-project-396319.dynamic_dataset.new_donor_list` as don2
ON don.First = don2.First
WHERE don.Board_Member = "TRUE"
ORDER BY total_contribution DESC
LIMIT 10;
