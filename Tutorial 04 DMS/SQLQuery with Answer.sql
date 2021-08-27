
select *
from Room_Details

select *
from Employee_Details

select *
from Meeting_Details

select *
from Meeting_Employees

--1. Find the first name of employees from India whose last name start with K

select FirstName
from Employee_Details
where Country = 'United States' and LastName like 's%'

--2. Find the names of Rooms with a capacity over 50.

select RoomName
from Room_Details
where RoomSize >50

--3. Find the IDs of Meetings with a duration more than 3 hours

select MeetingID
from Meeting_Details
where DATEDIFF (hour,TimeFrom,TimeTo) >3


--4. Find the Meetings held in meeting rooms with a capacity over 50

select m.MeetingTitle
from Meeting_Details m ,Room_Details r
where m.RoomID = r.RoomID and r.RoomSize >50


--5. Find the first name and last name of employees who participated in Appraisal meeting on 18th 
--August 2016.

select *
from Employee_Details

select *
from Meeting_Employees

select *
from Meeting_Details

select e.FirstName,e.LastName
from Meeting_Details m ,Employee_Details e,Meeting_Employees me
where e.EmployeeID=me.EmployeeID and me.MeetingID=m.MeetingID and m.MeetingTitle ='Appraisal Meeting' and m.MeetingDate = '18-Aug-2016'

--6. Display the highest and the lowest capacity of a room.

select MAX(RoomSize) as "Highest Capacity",Min(RoomSize) as "Lowest Capacity"
from Room_Details

--7. Find the number of employees from India.

select count (EmployeeID) as 'No of Employee'
from Employee_Details
where Country ='India'

--8. Find the number of employees who had participated in Appraisal Meeting_Details in August.

select count(me.EmployeeID)
from Meeting_Details m, Meeting_Employees me
where  m.MeetingID=me.MeetingID and m.MeetingTitle ='Appraisal Meeting' and DATEPART(month,m.MeetingDate)=8

--9. Find the number of employees from each country.

select Country,count(*) as 'No of Employees'
from Employee_Details
group by country

--10. For each type of Meetings display the number of employees who had participated.

select m.MeetingTitle ,count(*) as 'No of Employees'
from Meeting_Details m,Meeting_Employees me
where m.MeetingID = me.MeetingID
group by MeetingTitle

--11. Find the number of Meetings held in each room in august 2016.Display the room Name and number 
--of Meetings.

select r.RoomName,count (m.MeetingID)
from Meeting_Details m,Room_Details r
where m.RoomID=r.RoomID and DATEPART(month,m.MeetingDate)=8
group by RoomName

--12. Find the country which has more than 20 employees from.

select *from Employee_Details

select *from Meeting_Employees

select *from Meeting_Details


select Country, count(EmployeeID) as 'No of Employee'
from Employee_Details 
group by Country
having count(EmployeeID) >20

--13. Find the Meetings attended by more than 5 employees

select m.MeetingTitle,count(me.MeetingID)
from Meeting_Details m,Meeting_Employees me
where m.MeetingID=me.MeetingID
group by MeetingTitle
having count(me.MeetingID) >5


--14. Find the country which has most employees are from

select Country,count(EmployeeID) 
from Employee_Details
group by Country
having count(EmployeeID) >=all (select count(EmployeeID)
					from Employee_Details
					group by Country)

--all -to find grater than or equal bigset value of table

--15. Find the meeting rooms which did not have any Meetings in August

select r.RoomName
from Room_Details r
where r.RoomID	NOT IN (select RoomID
					from Meeting_Details
					where DATEPART(month,MeetingDate) = 8)

