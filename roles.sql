drop role admin;
drop role user;
drop role guest;

create role admin login;
create role user login;
create role guest login;


grant all on all tables in schema public to admin;



grant select on member to user;
grant select on ride to user;
grant select on request to user;
grant select on member_preference;
grant execute on function approved_requests(ride_id int) to user

grant select on ride to guest;
grant execute on function get_rides(in sc varchar, in dc varchar) to guest;
