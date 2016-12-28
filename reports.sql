-- Rides available from one specific city to another
drop function get_rides(in sc varchar, in dc varchar);

create or replace function get_rides(in sc varchar, in dc varchar)
	returns setof record as $$

Select m.first_name || '' || m.last_name as "Ride Owner"
       , c.model as "Car"
       , c.comfort_level as "Comfort Level"
       , mp.is_smoking_allowed
       , mp.is_pet_allowed
       , r.travel_start_time
       , r.contribution_per_head
       , seats_offered 
from ride r
     , member_car mc
     , car c, member m
     , member_preference mp
where r.member_car_id = mc.id and mc.member_id = m.id 
  and mc.car_id = c.id and m.id = mp.member_id
  and source_city_id = (select id 
	                      from city where city_name = $1)
  and destination_city_id = (select id 
  	                           from city where city_name = $2)
  and seats_offered > (select count(req.id) 
  	                     from request req, request_status reqs 
  	                       where req.request_status_id = reqs.id 
  	                         and reqs.id = 3 
  	                         and req.ride_id = r.id);

$$
language sql;

select * from get_rides('Chelyabinsk', 'Yekaterinburg') as (
	   "Ride Owner" varchar
       ,"Car" varchar
       , "Comfort Level" smallint
       , is_smoking_allowed character(1)
       , is_pet_allowed character(1)
       , travel_start_time timestamp without time zone	
       , contribution_per_head int
       , seats_offered smallint) ;


-- List of submitted / approved requests for a ride 

drop function approved_requests(ride_id int);

create or replace function approved_requests(ride_id int)
	returns setof record as $$
select first_name || ' ' || last_name as "Submitter"
       ,  req.created_on as "Submitted on"
       , rs.description as "Request Status"
from member m, request req, request_status rs
  where m.id = req.requester_id 
    and rs.id = req.request_status_id
    and req.ride_id = $1;
$$
language sql;

-- -- Previous and current rides offered 

drop function current_ride(mem_id int);

create or replace function current_ride(mem_id int)
	returns setof record as 
$$
select m.first_name || ' ' || m.last_name as "Ride Owner"
      , c.model as "Car", c.comfort_level as "Comfort Level"
      , mp.is_smoking_allowed
      , mp.is_pet_allowed
      , r.travel_start_time
      , r.contribution_per_head
      , case when seats_offered = 0 then 'FULL'
      	  	else seats_offered || ' seats available'
      	end
from ride r, member_car mc, car c, member m, member_preference mp
where r.member_car_id = mc.id and mc.member_id = m.id 
and mc.car_id = c.id and m.id = mp.member_id
and r.travel_start_time >= now()
and m.id = mem_id;
$$
language sql;


create or replace function previous_ride(mem_id int)
	returns setof record as 
$$
select m.first_name || ' ' || m.last_name as "Ride Owner"
      , c.model as "Car", c.comfort_level as "Comfort Level"
      , mp.is_smoking_allowed
      , mp.is_pet_allowed
      , r.travel_start_time
      , r.contribution_per_head
      , case when seats_offered = 0 then 'FULL'
      	  	else seats_offered || ' seats available'
      	end
from ride r, member_car mc, car c, member m, member_preference mp
where r.member_car_id = mc.id and mc.member_id = m.id 
and mc.car_id = c.id and m.id = mp.member_id
and r.travel_start_time  < now()
and m.id = 1;
$$
language sql;


-- List of co-travelers for a ride


drop function list_co_travelers(r_id int);

create or replace function list_co_travelers(r_id int)
	returns setof record as 
	$$
		select first_name || ' ' || last_name 
		  from member m
		     , request req
		     , request_status rs
		    where m.id = req.requester_id 
		      and rs.id = req.request_status_id
		      and rs.description = 'APPROVED'
		      and req.ride_id = r_id
		UNION
		select first_name || ' ' || last_name 
		  from member m, member_car mc, ride r
		    where m.id = mc.member_id 
		      and mc.id = r.member_car_id 
		      and r.id = r_id;
	$$
	language sql;