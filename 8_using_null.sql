sqlzoo
Using NULL
https://sqlzoo.net/wiki/Using_Null
============================================

/*1.
List the teachers who have NULL for their department.*/

SELECT NAME 
FROM   teacher 
WHERE  dept IS NULL; 

/*2.
Note the INNER JOIN misses the teachers with no department and the departments with no teacher.*/

SELECT teacher.NAME, 
       dept.NAME 
FROM   teacher 
       INNER JOIN dept 
               ON ( teacher.dept = dept.id ) 

/*3.
Use a different JOIN so that all teachers are listed.*/

SELECT t.NAME, 
       d.NAME 
FROM   teacher t 
       LEFT JOIN dept d 
              ON d.id = t.dept 

/*4.
Use a different JOIN so that all departments are listed.*/

SELECT t.NAME, 
       d.NAME 
FROM   teacher t 
       RIGHT JOIN dept d 
               ON d.id = t.dept 

/*5.
Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given.
Show teacher name and mobile number or '07986 444 2266'*/

SELECT NAME,
       COALESCE (mobile, '07986 444 2266')
FROM   teacher;

/*6.
Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department.*/

SELECT t.NAME,
       COALESCE(d.NAME, 'None')
FROM   teacher t
       LEFT JOIN dept d
              ON t.dept = d.id

/*7.
Use COUNT to show the number of teachers and the number of mobile phones.*/

SELECT Count(NAME),
       Count(mobile)
FROM   teacher

/*8.
Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.*/

SELECT d.NAME,
       Count(t.id)
FROM   teacher t
       RIGHT JOIN dept d
               ON t.dept = d.id
GROUP  BY d.NAME

/*9.
Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.*/

SELECT NAME,
       CASE
         WHEN dept IN ( 1, 2 ) THEN 'Sci'
         ELSE 'Art'
       END
FROM   teacher

/*10.
Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise.*/

SELECT NAME,
       CASE
         WHEN dept IN ( 1, 2 ) THEN 'Sci'
         ELSE 'Art'
       END
FROM   teacher 
