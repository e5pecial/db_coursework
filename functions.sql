-- function for create ride
-- function for create request for ride
-- function for approve ride and change seats value

drop function create_ride(
	_member_car_id,
    _created_on,
    _travel_start_time,
    _source_city_id,
    _destination_city_id,
    _seats_offered,
    _contribution_per_head,
    _luggage_size_id);

create or replace function create_ride
	(
	_member_car_id int,
    _created_on timestamp without time zone,
    _travel_start_time timestamp without time zone ,
    _source_city_id int,
    _destination_city_id int,
    _seats_offered smallint,
    _contribution_per_head int,
    _luggage_size_id int

) returns void
	as $$
	    insert into ride (
    				member_car_id,
    				created_on,
    				travel_start_time,
    				source_city_id,
    				destination_city_id,
    				seats_offered,
				    contribution_per_head,
    				luggage_size_id

		) values (	_member_car_id,
    				now()::timestamp ,
			    	_travel_start_time,
				    _source_city_id,
				    _destination_city_id,
				    _seats_offered,
				    _contribution_per_head,
				    _luggage_size_id)

	$$
language sql;


drop function create_request( 
    _requester_id,
    _ride_id,
    _enroute_city_id,
    _created_on,
    _request_status_id);

create or replace function create_request(
					_requester_id int,
   	 				_ride_id int,
    				_enroute_city_id int,
    				_created_on timestamp without time zone,
    				_request_status_id int)
    returns void as 
    $$
      insert into request(
      				requester_id,
    				ride_id,
    				enroute_city_id,
    				created_on,
    				request_status_id)
      values ( 
      	_requester_id,
	    _ride_id,
	    _enroute_city_id,
	    now()::timestamp,
	    _request_status_id)
    $$
    language sql;


drop function approve_request(req_id int);

create or replace function approve_request(req_id int)
returns void as 
$$
  update request set request_status_id = 3
  	where request.id = req_id;
  update ride set seats_offered = seats_offered - 1
  	where ride.id = (select rr.ride_id from request rr where rr.id = req_id)

$$
language sql;
	