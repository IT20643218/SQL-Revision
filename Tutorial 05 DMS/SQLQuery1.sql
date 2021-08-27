

--1. Find the names of the directors who had worked with American stars. Assume that if an actor/actress
--stars in a movie the directed by a director the actor/actress works with that director.

select m.DirectorName
from Movie m,StarsIn s,MovieStar ms
where m.title=s.movieTitle and s.starname=ms.name and ms.country='America'


--2. Find the movies in English for which all seats are booked in a theater.

select m.title,t.theaterName
from show s,Theater t ,Movie m
where s.theaterName=t.theaterName and m.title=s.movieTitle and m.language ='English' and s.spectators=t.capacity

--3. Display the names of stars who have acted in 3 or more movies in any year between 2017 and 2018. 

select starname,count (MovieTitle) as 'No of Movie'
from StarsIn
where movieYear between 2017 and 2018
group by starname
having count(movieTitle) >=3

--4. Find the names of male stars who had only starred in lead roles in 2018.

select s.starname
from MovieStar m,StarsIn s
where m.name=s.starname and s.role='lead' and m.gender='M' and s.movieYear=2018
and s.starname not in (select s1.starname
								from MovieStar m1,StarsIn s1
									where m1.name=s1.starname and s1.movieYear <2018)

--5. Find the names of the stars who has appeared in same movie with ‘Robert Downey’.

select distinct s.starname
from StarsIn s
where s.movieTitle in (select s1.movieTitle
							from StarsIn s1
								where s1.starname='Robert Downey')

--6. Find the names of feature movies which is viewed by at least 1 Million spectators in total.

select s.movieTitle,sum(s.spectators)
from Movie m,Show s
where m.title=s.movieTitle and m.filmtype='F'
group by s.movieTitle
having sum(s.spectators) >100

--7. Find the total income of each movie shown in theaters in America

select  s.movieTitle, sum(s.ticketPrice*s.spectators) as 'Total Income'
from theater t ,Show s
where t.theaterName=s.theaterName and t.country='America'
group by s.movieTitle

--8. Find the name of the theaters located in ‘New York’ which shows both ‘The Passenger’ and ‘Jurassic 
--World’ on 1st January-2018.

select s.theaterName
from Theater t ,Show s
where t.theaterName=s.theaterName and s.movieTitle='Jurassic World' and s.datetime='2018-01-01'
and t.city = 'New York' and s.theaterName IN (select t1.theaterName
												from Theater t1,Show s1
													where t1.theaterName=s1.theaterName and s1.movieTitle='The Passenger' 
															and t1.city='New York' and datetime='2018-01-01')

--9. Find the feature movies for which all shows have more than 200 spectators.

select m.title
from Show s, Movie m
where s.movieTitle=m.title and m.filmtype='F'
group by  m.title 
having min(s.spectators)>= 200

--10. Find the name of the most popular movie. The most popular movie is the movie viewed by most 
--spectators.

select s.movieTitle,sum(s.spectators)
from Show s
group by  s.movieTitle 
having sum(s.spectators) >=all (select sum(s1.spectators)
							      from Show s1
								    group by s1.movieTitle)
			