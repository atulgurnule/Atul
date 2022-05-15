use StudentDB
SELECT * FROM Mobiledata

select * from Course
select * from Course_Copy
sp_help Course

INSERT INTO Course_Copy(CourseName)
SELECT CourseName FROM Course 