-- CIS3530 Assignment 1, Question 2
-- Rabia Qureshi (1046427)
-- Date: October 21, 2021


-- QUESTION 2a
SELECT *
FROM offering
WHERE cnum=3530;

-- QUESTION 2b
-- NOTE: DISTINCT works on all combinations of column values for all columns in the SELECT clause 
SELECT DISTINCT cnum,term,name
FROM course NATURAL JOIN offering
WHERE year=2016
AND dept='CIS'
ORDER BY cnum;

-- QUESTION 2c
SELECT DISTINCT cnum,name
FROM course NATURAL JOIN offering
WHERE instructor='Ritu';

-- QUESTION 2d
SELECT DISTINCT sid,firstname,lastname,email,cgpa
FROM student NATURAL JOIN offering NATURAL JOIN took
WHERE cnum=3530 
AND term='F'
AND year=2017
ORDER BY sid;

-- QUESTION 2e
SELECT *
FROM student 
WHERE sid NOT IN (
    SELECT DISTINCT sid
    FROM student NATURAL JOIN offering NATURAL JOIN took
    WHERE cnum=3530 
    AND dept='CIS'
);

-- QUESTION 2f
SELECT DISTINCT sid,firstname,lastname,email,cgpa
FROM student NATURAL JOIN offering NATURAL JOIN took
WHERE (cnum,dept) IN (
    SELECT DISTINCT cnum,dept
    FROM course NATURAL JOIN offering
    WHERE dept='HIS'
);

-- QUESTION 2g
SELECT DISTINCT o1.cNum,o1.dept,o2.cNum,o2.dept
FROM offering AS o1, offering AS o2
WHERE o1.cNum=o2.cNum 
AND o1.dept<o2.dept;

-- QUESTION 2h
SELECT DISTINCT name,course.cnum,course.dept,year,term
FROM course 
LEFT JOIN offering ON course.cnum=offering.cnum AND course.dept=offering.dept;

-- QUESTION 2i
SELECT DISTINCT sid,lastname,firstname, COUNT(oid) AS timestaken
FROM student NATURAL JOIN offering NATURAL JOIN took
WHERE oid IN (
    SELECT oid
    FROM course NATURAL JOIN offering
    WHERE cnum=3530 
    AND dept='CIS'
)
GROUP BY sid,lastname,firstname
HAVING COUNT(oid)>1;

-- QUESTION 2j
SELECT cnum,name,COUNT(*) AS enrollment
FROM course NATURAL JOIN offering NATURAL JOIN took
WHERE term='F'
AND year=2017
GROUP BY cnum,name;

-- QUESTION 2k
UPDATE offering
SET instructor='Harry'
WHERE cnum=3530;

-- QUESTION 2l
DELETE
FROM took
WHERE oid IN (
  SELECT oid
  FROM offering
  WHERE instructor='Ritu'
);
DELETE
FROM offering
WHERE instructor='Ritu';

