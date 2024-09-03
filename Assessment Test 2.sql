-- Assessment Test 2

-- Q:1 How can you retrieve all the information from the cd.facilities table?
-- Q:2 How would you retrieve a list of only facility names and member cost?
-- Q:3 How can you produce a list of facilities that charge a fee to members?
-- Q:4 How can you produce a list of facilities that charge a fee to members, and that fee is less than 1/50th of the monthly maintenance cost? Return the facid, facility name, member cost, and monthly.
-- Q:5 How can you produce a list of all facilities with the word 'Tennis' in their name?
-- Q:6 How can you retrieve the details of facilities with ID 1 and 5? Try to do it without using the OR operator.
-- Q:7 How can you produce a list of members who joined after the start of September 2012? Return the memid, surname, firstname, and joindate of the members in question.
-- Q:8 How can you produce an ordered list of the first 10 surnames in the members table? The list must not contain duplicates.
-- Q:9 You'd like to get the signup date of your last member. How can you retrieve this information?
-- Q:10 Produce a count of the number of facilities that have a cost to guests of 10 or more?
-- Q:11 Produce a list of the total number of slots booked per facility in the month of September 2012. Produce an output table consisting of facility id and slots, sorted by the number of slots.
-- Q:12 Produce a list of facilities with more than 1000 slots booked. Produce an output table consisting of facility id and total slots, sorted by facility id.
-- Q:13 How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? Return a list of start time and facility name pairings, ordered by the time.
-- Q:14 How can you produce a list of the start times for bookings by members named 'David Farrell'?

-- A:1
SELECT *
FROM cd.facilities;

-- A:2
SELECT name, membercost
FROM cd.facilities;

-- A:3
SELECT *
FROM cd.facilities 
WHERE membercost > 0;

-- A:4
SELECT facid, name, membercost, monthlymaintenance
FROM cd.facilities 
WHERE membercost > 0 AND (membercost < monthlymaintenance/50.0);

-- A:5
SELECT *
FROM cd.facilities
WHERE name LIKE '%Tennis%';

-- A:6
SELECT *
FROM cd.facilities
WHERE facid IN (1, 5);

-- A:7 
SELECT memid, surname, firstname, joindate
FROM cd.members
WHERE joindate > '2012-09-01';

-- A:8
SELECT DISTINCT(surname)
FROM cd.members
ORDER BY surname 
LIMIT 10;

-- A:9
SELECT surname, joindate
FROM cd.members
ORDER BY joindate DESC
LIMIT 1;

SELECT MAX(joindate)
FROM cd.members; (-- Both way is right, but this is easier)

-- A:10
SELECT COUNT(*)
FROM cd.facilities
WHERE guestcost >= 10;

-- A:11
SELECT facid, SUM(slots) AS totalslots
FROM CD.bookings
WHERE starttime BETWEEN '2012-09-01' AND '2012-09-30'
GROUP BY facid
ORDER BY SUM(slots);

-- A:12
SELECT facid, SUM(slots) AS totalslot
FROM cd.bookings
GROUP BY facid
HAVING SUM(slots) > 1000
ORDER BY facid;

-- A:13
SELECT starttime, name
FROM cd.facilities a
INNER JOIN cd.bookings b
ON a.facid = b.facid
WHERE name LIKE '%Tennis Court%' 
AND starttime >= '2012-09-21' AND starttime < '2012-09-22'
ORDER BY starttime;

-- A:14
SELECT starttime, firstname || ' ' || surname AS fullname
FROM cd.bookings a
INNER JOIN cd.members b
ON a.memid = b.memid
WHERE firstname = 'David' AND surname = 'Farrell';