join
sqlzoo
https://sqlzoo.net/wiki/The_JOIN_operation
==========================================

/*1.
Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'*/

SELECT matchid,
       player
FROM   goal
WHERE  teamid = 'GER'

/*2.
Show id, stadium, team1, team2 for just game 1012*/

SELECT id,
       stadium,
       team1,
       team2
FROM   game
WHERE  id = 1012

/*3.
Modify it to show the player, teamid, stadium and mdate for every German goal.*/

SELECT gl.player,
       gl.teamid,
       gm.stadium,
       gm.mdate
FROM   goal gl
       JOIN game gm
         ON gl.matchid = gm.id
WHERE  gl.teamid = 'GER'

/*4.
Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'*/

SELECT gm.team1,
       gm.team2,
       gl.player
FROM   goal gl
       JOIN game gm
         ON gl.matchid = gm.id
WHERE  gl.player LIKE 'Mario%'

/*5.
Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10*/

SELECT g.player,
       g.teamid,
       e.coach,
       g.gtime
FROM   goal g
       JOIN eteam e
         ON g.teamid = e.id
WHERE  gtime <= 10

/*6.
List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.*/

SELECT g.mdate,
       e.teamname
FROM   game g
       JOIN eteam e
         ON g.team1 = e.id
WHERE  e.coach = 'Fernando Santos'

/*7.
List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'*/

SELECT g.player
FROM   goal g
       JOIN game ga
         ON ga.id = g.matchid
WHERE  ga.stadium = 'National Stadium, Warsaw'

/*8.
Instead show the name of all players who scored a goal against Germany.*/

SELECT DISTINCT g.player
FROM   goal g
       JOIN game ga
         ON g.matchid = ga.id
WHERE  ( ga.team2 = 'GER'
          OR ga.team1 = 'GER' )
       AND g.teamid != 'GER'

/*9.
Show teamname and the total number of goals scored.*/

SELECT e.teamname,
       Count(*)
FROM   goal g
       JOIN eteam e
         ON e.id = g.teamid
GROUP  BY teamname

/*10.
Show the stadium and the number of goals scored in each stadium.*/

SELECT ga.stadium,
       Count(*)
FROM   game ga
       JOIN goal g
         ON g.matchid = ga.id
GROUP  BY ga.stadium

/*11.
For every match involving 'POL', show the matchid, date and the number of goals scored.*/

SELECT game.id, game.mdate, COUNT(goal.matchid)
FROM game
JOIN goal
ON game.id = goal.matchid
WHERE (game.team1 = 'POL' OR game.team2 = 'POL')
GROUP BY game.id, game.mdate
ORDER BY game.id;


/*12.
For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'*/

SELECT ga.id,
       ga.mdate,
       Count(gl.matchid)
FROM   game ga
       JOIN goal gl
         ON ga.id = gl.matchid
WHERE  gl.teamid = 'GER'
GROUP  BY ga.id,
          ga.mdate,
          gl.matchid

/*13.
List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.*/

SELECT game.mdate,
       game.team1,
       Sum(CASE
             WHEN goal.teamid = game.team1 THEN 1
             ELSE 0
           END) score1,
       game.team2,
       Sum(CASE
             WHEN goal.teamid = game.team2 THEN 1
             ELSE 0
           END) score2
FROM   game
       LEFT JOIN goal
              ON matchid = id
GROUP  BY mdate,
          team1,
          team2 

