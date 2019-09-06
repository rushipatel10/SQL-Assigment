/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

SELECT *
FROM  `Facilities`
WHERE  `membercost` >0
LIMIT 0 , 30
Answer: 'Tennis Court 1', 'Tennis Court 2', 'Massage Room 1', 'Massage Room 2', 'Squash Court'

/* Q2: How many facilities do not charge a fee to members? */

SELECT *
FROM  `Facilities`
WHERE  `membercost` =0
LIMIT 0 , 30
Answer: 'Badminton Court', 'Table Tennis', 'Snooker Table', 'Pool Table'

/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SELECT  `facid` ,  `name` ,  `membercost` ,  `monthlymaintenance`
FROM  `Facilities`
WHERE (
`membercost` >0
)
AND (
`membercost` < 0.2 *  `monthlymaintenance`
)
LIMIT 0 , 30
Answer:
(0, 'Tennis Court 1', '5.0', 200)
(1, 'Tennis Court 2', '5.0', 200)
(4, 'Massage Room 1', '9.9', 3000)
(5, 'Massage Room 2', '9.9', 3000)
(6, 'Squash Court', '3.5', 80)

/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */

SELECT *
FROM  `Facilities`
WHERE  `facid` =1
UNION
SELECT *
FROM  `Facilities`
WHERE  `facid` =5
LIMIT 0 , 30
Answer:
(1, 'Tennis Court 2', 5.0, 25.0, 8000, 200)
(5, 'Massage Room 2', 9.9, 80.0, 4000, 3000)

/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

SELECT name, monthlymaintenance,
CASE WHEN monthlymaintenance >100
THEN  'expensive'
ELSE  'cheap'
END AS
TYPE FROM Facilities
LIMIT 0 , 30
Answer: ('Tennis Court 1', 200, 'expensive')
('Tennis Court 2', 200, 'expensive')
('Badminton Court', 50, 'cheap')
('Table Tennis', 10, 'cheap')
('Massage Room 1', 3000, 'expensive')
('Massage Room 2', 3000, 'expensive')
('Squash Court', 80, 'cheap')
('Snooker Table', 15, 'cheap')
('Pool Table', 15, 'cheap')


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SELECT sub.`firstname` , sub.`surname`
FROM (
SELECT  `firstname` ,  `surname` , MAX(  `joindate` )
FROM  `Members`
WHERE  `surname` !=  'GUEST')
Answer:
('Darren', 'Smith')

/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT DISTINCT CONCAT( members.`firstname` ,  ' ', members.`surname` ) AS full_name
FROM country_club.Members members
JOIN (
SELECT bookings.facid, bookings.`memid`
FROM country_club.Bookings bookings
JOIN country_club.Facilities facilities ON bookings.facid = facilities.facid
AND facilities.name LIKE  '%Tennis Court%'
)sub ON members.`memid` = sub.`memid`
AND members.`firstname` NOT LIKE  'GUEST%'
ORDER BY 1
LIMIT 0 , 30
Answer: 'Anne Baker','Burton Tracy','Charles Owen','Darren Smith','David Farrell','David Jones',
'David Pinker','Douglas Jones','Erica Crumpet','Florence Bader','Gerald Butters','Henrietta Rumney',
'Jack Smith','Janice Joplette','Jemima Farrell','Joan Coplin','John Hunt','Matthew Genting','Millicent Purview',
'Nancy Dare','Ponder Stibbons','Ramnaresh Sarwin','Tim Boothe','Tim Rownam','Timothy Baker','Tracy Smith'


/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */


SELECT mems.surname AS member, facs.name AS facility,
CASE
WHEN mems.`memid` =0
THEN bks.`slots` * facs.guestcost
ELSE bks.`slots` * facs.membercost
END AS cost
FROM  `Members` mems
JOIN  `Bookings` bks ON mems.`memid` = bks.`memid`
JOIN  `Facilities` facs ON bks.`facid` = facs.`facid`
WHERE bks.`starttime` >=  '2012-09-14'
AND bks.`starttime` <  '2012-09-15'
AND (
(
mems.`memid` =0
AND bks.`slots` * facs.guestcost >30
)
OR (
mems.`memid` !=0
AND bks.`slots` * facs.membercost >30
)
)
ORDER BY cost DESC
LIMIT 0 , 30
Answer:
('GUEST','Massage Room 2', 320.0)
('GUEST','Massage Room 1', 160.0)
('GUEST','Massage Room 1', 160.0)
('GUEST','Massage Room 1', 160.0)
('GUEST','Tennis Court 2', 150.0)
('GUEST','Tennis Court 1', 75.0)
('GUEST','Tennis Court 2', 75.0)
('GUEST','Tennis Court 1', 75.0)
('GUEST','Squash Court', 70.0)
('Farrell','Massage Room 1', 39.6)
('GUEST','Squash Court', 35.0)
('GUEST','Squash Court', 35.0)

/* Q9: This time, produce the same result as in Q8, but using a subquery. */

SELECT member, facility, cost
FROM (
SELECT mems.surname AS member, facs.name AS facility,
CASE
WHEN mems.`memid` =0
THEN bks.slots * facs.guestcost
ELSE bks.slots * facs.membercost
END AS cost
FROM  `Members` mems
JOIN  `Bookings` bks ON mems.`memid` = bks.`memid`
INNER JOIN  `Facilities` facs ON bks.`facid` = facs.`facid`
WHERE bks.`starttime` >=  '2012-09-14'
AND bks.`starttime` <  '2012-09-15'
) AS bookings
WHERE cost >30
ORDER BY cost DESC
Answer:
('GUEST','Massage Room 2', 320.0)
('GUEST','Massage Room 1', 160.0)
('GUEST','Massage Room 1', 160.0)
('GUEST','Massage Room 1', 160.0)
('GUEST','Tennis Court 2', 150.0)
('GUEST','Tennis Court 1', 75.0)
('GUEST','Tennis Court 2', 75.0)
('GUEST','Tennis Court 1', 75.0)
('GUEST','Squash Court', 70.0)
('Farrell','Massage Room 1', 39.6)
('GUEST','Squash Court', 35.0)
('GUEST','Squash Court', 35.0)

/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

SELECT  `name` , totalrevenue
FROM (
SELECT facs.`name` , SUM(
CASE WHEN memid =0
THEN slots * facs.guestcost
ELSE slots * membercost
END ) AS totalrevenue
FROM  `Bookings` bks
INNER JOIN  `Facilities` facs ON bks.`facid` = facs.`facid`
GROUP BY facs.`name`
) AS selected_facilities
WHERE totalrevenue <=1000
ORDER BY totalrevenue
Answer:
('Table Tennis', 180.0)
('Snooker Table', 240.0)
('Pool Table', 270.0)