-- CIS3530 Assignment 1, Question 3
-- Rabia Qureshi (1046427)
-- Date: October 21, 2021


-- QUESTION 3a
SELECT DISTINCT parent AS "Grand Parents"
FROM parent_of
WHERE child IN (
    SELECT parent
    FROM parent_of
);

-- QUESTION 3b
SELECT DISTINCT p1.child AS sister, p2.child AS name
FROM parent_of AS p1 LEFT JOIN parent_of AS p2 ON p1.parent=p2.parent AND p1.child!=p2.child
WHERE p2.child IS NOT NULL
AND p1.child IN (
  SELECT *
  FROM females
);

-- QUESTION 3c
-- child can only have an aunt or uncle if their parent has a sibling
-- get the parents' siblings, and get the parents' kids
SELECT DISTINCT p1.child AS "Aunt Or Uncle", p3.child AS name
FROM parent_of AS p1
LEFT JOIN parent_of AS p2 ON p1.parent=p2.parent AND p1.child!=p2.child
LEFT JOIN parent_of AS p3 ON p2.child=p3.parent
WHERE p2.child IS NOT NULL
AND p3.child IS NOT NULL;

-- QUESTION 3d
SELECT DISTINCT p1.child AS "Aunt Or Uncle", p3.child AS niece
FROM parent_of AS p1
LEFT JOIN parent_of AS p2 ON p1.parent=p2.parent AND p1.child!=p2.child
LEFT JOIN parent_of AS p3 ON p2.child=p3.parent
WHERE p2.child IS NOT NULL
AND p3.child IS NOT NULL
AND p3.child IN (
  SELECT *
  FROM females
);

-- QUESTION 3e
SELECT DISTINCT p1.child AS "Aunt or Uncle", p2.child AS cousin
FROM parent_of AS p1, (
  SELECT DISTINCT p1.child AS s1, p2.child AS s2
  FROM parent_of AS p1, parent_of AS p2
  WHERE p1.parent=p2.parent AND p1.child!=p2.child
) AS siblingOfParent
INNER JOIN parent_of AS p2 ON p2.parent=siblingOfParent.s2
WHERE p1.parent=siblingOfParent.s1
AND p1.child<p2.child;

-- QUESTION 3f
SELECT wife AS "Daughter-in-law", parent AS "Father (of husband)"
FROM married_to NATURAL JOIN (
  SELECT *
  FROM parent_of NATURAL JOIN married_to
  WHERE husband=child
) AS parentOfSpouse;