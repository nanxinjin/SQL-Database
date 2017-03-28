
 /*2.1*/         
SET SERVEROUTPUT ON SIZE 32000

DECLARE
        CURSOR TEMPCURSOR IS
            SELECT age, COUNT(userID) AS NOU ,AVG(numberBookedSoFar) AS AB
            FROM Users
            GROUP BY age;
        PRINT TEMPCURSOR%ROWTYPE;
BEGIN
    OPEN TEMPCURSOR;
    DBMS_OUTPUT.PUT_LINE('AgeGroup          NumberOfUsers           AvgBooked');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');
    LOOP
        FETCH TEMPCURSOR INTO PRINT;
        EXIT WHEN TEMPCURSOR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(RPAD(PRINT.age,23) || RPAD(PRINT.NOU,23) || RPAD(PRINT.AB,23));
    END LOOP;
    
    CLOSE TEMPCURSOR;
END;
.
RUN


/*2.2*/

SET SERVEROUTPUT ON SIZE 32000

DECLARE
        CURSOR TEMPCURSOR1 IS
            SELECT theaterID,name, movieID,title,starttime,endtime,hall
            FROM Showtimes NATURAL JOIN Theaters NATURAL JOIN Movies
             ORDER BY theaterID, movieID;
        
        CURSOR TEMPCURSOR2 IS
            SELECT userID, email,age,movieID,title,theaterID
            FROM Tickets NATURAL JOIN Users NATURAL JOIN Showtimes NATURAL JOIN Movies ORDER BY theaterID,movieID;
            
        CURSOR TEMPCURSOR3 IS
            SELECT theaterID, name FROM Theaters ORDER BY theaterID;
            
        PRINT1 TEMPCURSOR1%ROWTYPE;
        PRINT2 TEMPCURSOR2%ROWTYPE;
        PRINT3 TEMPCURSOR3%ROWTYPE;
        
        FLAG NUMBER := 0;
        FLAG2 NUMBER := 0;
        
BEGIN
    OPEN TEMPCURSOR1;
    OPEN TEMPCURSOR2;
    OPEN TEMPCURSOR3;
    
    
    
    /*Print all theater names*/
    LOOP 
        FETCH TEMPCURSOR3 INTO PRINT3;
        EXIT WHEN TEMPCURSOR3%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Theater: ' || RPAD(PRINT3.name,20));
        
        /*Print all movies for each theater*/
        LOOP
            IF FLAG = 0 
            THEN FETCH TEMPCURSOR1 INTO PRINT1;
                 EXIT WHEN TEMPCURSOR1%NOTFOUND OR PRINT3.theaterID <> PRINT1.theaterID;
                 DBMS_OUTPUT.PUT_LINE('MovieTitle               StartTime               EndTime             Hall');
                 DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------------');
                 DBMS_OUTPUT.PUT_LINE(RPAD(PRINT1.title,25)||RPAD(PRINT1.starttime,24)||RPAD(PRINT1.endtime,20)||RPAD(PRINT1.hall,23));
                 
            ELSE
                EXIT WHEN TEMPCURSOR1%NOTFOUND OR PRINT3.theaterID <> PRINT1.theaterID;
                DBMS_OUTPUT.PUT_LINE('MovieTitle               StartTime               EndTime             Hall');
                 DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------------');
                DBMS_OUTPUT.PUT_LINE(RPAD(PRINT1.title,25)||RPAD(PRINT1.starttime,24)||RPAD(PRINT1.endtime,20)||RPAD(PRINT1.hall,23));
                FLAG := 0;
            END IF;
            DBMS_OUTPUT.PUT_LINE(chr(9) ||'UserID                           Email                           AgeGroup');
            DBMS_OUTPUT.PUT_LINE(chr(9) ||'---------------------------------------------------------------------------');
            /*Print all users for each movie*/
            LOOP
                IF FLAG2 = 0 THEN
                    FETCH TEMPCURSOR2 INTO PRINT2;
                    EXIT WHEN TEMPCURSOR2%NOTFOUND OR PRINT2.movieID <> PRINT1.movieID OR PRINT2.theaterID <> PRINT3.theaterID;
                    DBMS_OUTPUT.PUT_LINE(chr(9)||RPAD(PRINT2.userID,33)||RPAD(PRINT2.email,32)||RPAD(PRINT2.age,20));
                ELSE
                    EXIT WHEN TEMPCURSOR2%NOTFOUND OR PRINT2.theaterID <> PRINT3.theaterID OR PRINT2.movieID <> PRINT1.movieID;
                    DBMS_OUTPUT.PUT_LINE(chr(9)||RPAD(PRINT2.userID,33)||RPAD(PRINT2.email,32)||RPAD(PRINT2.age,20));
                    FLAG2:=0;
                END IF;
            END LOOP;
            FLAG2 :=1;
        END LOOP;
            FLAG :=1;
            DBMS_OUTPUT.PUT_LINE(chr(13));
    END LOOP;
    
    
    CLOSE TEMPCURSOR1;
    CLOSE TEMPCURSOR2;
    CLOSE TEMPCURSOR3;
END;
.
RUN
