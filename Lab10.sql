-- Mark Rajovic Lab 10 Stored Procedures
-- 4/17/17

1.
create or replace function get_prereqs_for_coursenum(int, REFCURSOR) returns refcursor as 
$$
declare
   ClassCredit   int    := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select preReqNum
      from   Prerequisites
       where  courseNum=ClassCredit;
   return resultset;
end;
$$ 
language plpgsql;

select get_prereqs_for_coursenum(308, 'results');
Fetch all from results;
-- This example provides the prerequisites for Database Systems

2.
create or replace function is_prereq_for_coursenum(int, REFCURSOR) returns refcursor as 
$$
declare
   ClassCredit   int    := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select courseNum
      from   Prerequisites
      where  prereqNum=ClassCredit;
   return resultset;
end;
$$ 
language plpgsql;

select is_prereq_for_coursenum(120, 'results');
Fetch all from results;

-- This example returns the courses for which the passed-in course (Introduction to Programming)is an immediate prerequisite for!