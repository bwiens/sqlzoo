sqlzoo
SELECT within SELECT
https://sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial
=====================================================

/*1.
List each country name where the population is larger than that of 'Russia'.*/

SELECT NAME 
FROM   world 
WHERE  population > (SELECT population 
                     FROM   world 
                     WHERE  NAME = 'Russia') 

/*2.
Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.*/

SELECT NAME 
FROM   world 
WHERE  continent = 'Europe' 
       AND gdp / population > (SELECT gdp / population 
                               FROM   world 
                               WHERE  NAME = 'United Kingdom')

/*3.
List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.*/

SELECT NAME, 
       continent 
FROM   world 
WHERE  continent IN (SELECT continent 
                     FROM   world 
                     WHERE  NAME IN ( 'Argentina', 'Australia' ))
ORDER  BY NAME 

/*4.
Which country has a population that is more than Canada but less than Poland? Show the name and the population.*/

SELECT NAME, 
       population 
FROM   world 
WHERE  population > (SELECT population 
                     FROM   world 
                     WHERE  NAME = 'Canada') 
       AND population < (SELECT population 
                         FROM   world 
                         WHERE  NAME = 'Poland') 

/*5.
Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.

Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.*/

SELECT NAME, 
       Concat(Round(100 * population / (SELECT population 
                                        FROM   world 
                                        WHERE  NAME = 'Germany')), '%')
FROM   world 
WHERE  continent = 'Europe' 

/*6.
Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)*/

SELECT NAME 
FROM   world 
WHERE  gdp > (SELECT Max(gdp) 
              FROM   world 
              WHERE  continent = 'Europe') 

/*7.
Find the largest country (by area) in each continent, show the continent, the name and the area:*/

SELECT continent, 
       NAME, 
       area 
FROM   world x 
WHERE  area >= ALL (SELECT area 
                    FROM   world y 
                    WHERE  x.continent = y.continent 
                           AND y.area > 0); 

/*8.
List each continent and the name of the country that comes first alphabetically.*/

SELECT continent, 
       NAME 
FROM   world x 
WHERE  NAME <= ALL (SELECT NAME 
                    FROM   world y 
                    WHERE  x.continent = y.continent);

/*9.
Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.*/

SELECT NAME, 
       continent, 
       population 
FROM   world 
WHERE  continent IN (SELECT continent 
                     FROM   world x 
                     WHERE  25000000 >= (SELECT Max(population)
                                         FROM   world y 
                                         WHERE  x.continent = y.continent));

/*10.
Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.*/

SELECT NAME, 
       continent 
FROM   world x 
WHERE  population > ALL (SELECT 3 * population 
                         FROM   world y 
                         WHERE  x.continent = y.continent 
                                AND x.NAME != y.NAME) 
