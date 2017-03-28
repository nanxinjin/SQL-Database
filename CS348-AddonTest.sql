/*CS348 Project1 Add-on Test*/

/*For 1.1 Add one USER and ADD one show for a movie that has max_occupancy = 1*/
insert into Users values(11,'test1@abcd.com','Teen',1);
insert into Showtimes values(14,1,1,'11:30:00','12:00:00',4,2);
insert into Tickets values(11,14);/*OUTPUT: The Great Wall*/

/*Same show ticket for different users & Same user buy different shows*/
insert into Tickets values(1,2);
update Users SET numberBookedSoFar = numberBookedSoFar + 1 where userID = 1;
insert into Tickets values(3,1);
update Users SET numberBookedSoFar = numberBookedSoFar + 1 where userID = 3;
insert into Tickets values(2,1);
update Users SET numberBookedSoFar = numberBookedSoFar + 1 where userID = 2;
insert into Tickets values(1,3);
update Users SET numberBookedSoFar = numberBookedSoFar + 1 where userID = 1;
insert into Tickets values(3,2);
update Users SET numberBookedSoFar = numberBookedSoFar + 1 where userID = 3;

/*For 1.3 Add different movies(#1, #5, #6) to Theater #1*/
insert into Showtimes values(11,1,1,'13:00:00','13:30:00',1,100);
insert into Showtimes values(12,5,1,'12:30:00','13:00:00',1,100);
insert into Showtimes values(13,6,1,'12:00:00','12:30:00',1,100);/*Goodrich	1*/