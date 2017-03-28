/*1.1*/
SELECT title 
FROM Movies 
NATURAL JOIN (SELECT movieID 
	FROM Showtimes NATURAL JOIN (SELECT showID, COUNT(userID) AS NumOfTicket 
								FROM Tickets 
								GROUP BY showID 
								ORDER BY showID) 
	WHERE max_occupancy-NumOfTicket = 0);


/*1.2*/
SELECT name, NumOfShow 
FROM Theaters NATURAL JOIN (SELECT theaterID, COUNT(showID) AS NumOfShow 
							FROM Showtimes NATURAL JOIN Theaters 
							GROUP BY theaterID 
							ORDER BY theaterID) 
WHERE NumOfShow >= 3; 


/*1.3*/
SELECT name, theaterID 
FROM Theaters NATURAL JOIN (SELECT theaterID 
							FROM Showtimes 
							GROUP BY theaterID 
							HAVING (COUNT (DISTINCT Showtimes.movieID)) = (SELECT COUNT(movieID) FROM Movies));


/*1.4*/
SELECT email, age, title
FROM (SELECT userID, email, age 
	  FROM Users NATURAL JOIN (SELECT DISTINCT userID
                               FROM Tickets 
                        		GROUP BY userID
                                HAVING COUNT(showID) = 1 
                                ORDER BY userID)) 
NATURAL JOIN (SELECT userID, showID  
			  FROM Tickets 
			  NATURAL JOIN (SELECT DISTINCT userID  
                        	FROM Tickets 
                        	GROUP BY userID 
                        	HAVING COUNT(showID) = 1 
                        	ORDER BY userID)) 
NATURAL JOIN (SELECT movieID,title,showID
				FROM Showtimes 
				NATURAL JOIN Movies 
				NATURAL JOIN (SELECT userID, showID  
                              FROM Tickets 
                              NATURAL JOIN (SELECT DISTINCT userID  
                                            FROM Tickets 
                                            GROUP BY userID 
                                            HAVING COUNT(showID) = 1 
                                             ORDER BY userID)));


/*1.5*/
SELECT title 
FROM Movies NATURAL JOIN (SELECT DISTINCT movieID
                          FROM Showtimes NATURAL JOIN (SELECT showID, COUNT(DISTINCT age)
                                                        FROM (SELECT showID, userID, age
                                                              FROM Users 
                                                              NATURAL JOIN (SELECT showID, userID
                                                                            FROM Tickets 
                                                                            NATURAL JOIN (SELECT showID, movieID 
                                                                                          FROM Showtimes
                                                                                          ORDER BY showID)
                                                                            ORDER BY showID)
                                                              ORDER BY showID )
                                                        GROUP BY showID
                                                        HAVING COUNT(DISTINCT age) = 1
                                                        ORDER BY showID)
                           ORDER BY movieID)
ORDER BY movieID;


/*1.6*/
SELECT name 
FROM Theaters NATURAL JOIN Showtimes NATURAL JOIN (SELECT showID 
                                                   FROM(SELECT DISTINCT showID, COUNT(userID) AS ticketCount
	                                                    FROM Tickets
	                                                    GROUP BY showID
	                                                    ORDER BY showID)
                                                    WHERE ticketCount = (SELECT MAX(ticketCount)
					                                                     FROM(SELECT DISTINCT showID, COUNT(userID) AS ticketCount
						                                                      FROM Tickets
						                                                      GROUP BY showID
						                                                 ORDER BY showID))
                                                    ORDER BY showID)
ORDER BY theaterID;


/*1.7*/
select userID, email, name
FROM Users
Natural Join
(
    select userID, theaterID 
    from 
        (   
            select userID, TheaterID, count(*) as cnt 
            from Tickets 
            Natural Join Showtimes 
            group by userID, TheaterID 
            order by userID, cnt desc
        ) rPart
    where not exists
        (
            select * 
            from
                (
                    select userID, TheaterID, count(*) as cnt 
                    from Tickets 
                    Natural Join Showtimes 
                    group by userID, TheaterID 
                    order by userID, cnt desc
                ) lPart
            where lPart.userID = rPart.userID and lPart.cnt > rPart.cnt
        )
    order by userID
) 
Natural Join Theaters;


/*1.8*/
SELECT title, avgForMovie
FROM Movies NATURAL JOIN (SELECT movieID, COUNT(showID),AVG(userForShow) AS avgForMovie 
                          FROM Showtimes NATURAL JOIN (SELECT DISTINCT showID, COUNT(userID) AS userForShow
                                                       FROM Tickets
                                                       GROUP BY showID
                                                       ORDER BY showID)
                          GROUP BY movieID
                          ORDER BY movieID)
ORDER BY movieID;

/*1.9*/
SELECT showID, max_occupancy-NumOfTicket 
FROM Showtimes NATURAL JOIN (SELECT showID, COUNT(userID) AS NumOfTicket 
							FROM Tickets 
							GROUP BY showID 
							ORDER BY showID);


/*1.10*/
SELECT userID, genre
FROM(SELECT userID, showID, genre
     FROM (SELECT showID, movieID, genre 
           FROM Movies 
           NATURAL JOIN Showtimes) 
NATURAL JOIN (SELECT userID, showID
              FROM Tickets)
ORDER BY userID)NATURAL JOIN (SELECT userID, COUNT(DISTINCT genre)
FROM (SELECT userID, showID, genre
FROM (SELECT showID, movieID, genre 
      FROM Movies 
      NATURAL JOIN Showtimes) 
NATURAL JOIN (SELECT userID, showID
              FROM Tickets)
ORDER BY userID)
GROUP BY userID
HAVING COUNT(DISTINCT genre) = 1
ORDER BY userID);