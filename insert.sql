

insert into car (
    model,
    make_year,
    comfort_level 
) values 
	('Audi TT', 2010, 5),
	('Lada Granta', 2014, 3),
	('Honda Civic', 2006, 4),
	('BMW X7', 2008, 5),
	('VAZ 2108', 1990, 2),
	('Ford Fiesta', 2010, 3),
	('BMW 325i', 1999, 4),
	('Lada Cross', 2013, 3),
	('Ford Mustang', 1990, 4),
    ('Cadillac Escalade', 2016, 5)
;

-- Table: chitchat_preference
insert into chitchat_preference (
    description) values 
			('silence'), 
			('on the mood'), 
			('love to talk');

-- Table: music_preference
insert into music_preference (
    description
 ) values 
     ('without'), 
     ('rock'), 
     ('hip-hop'), 
     ('dance'), 
     ('classic');

-- Table: city
insert into city (
    city_name,
    state,
    country
   ) values
		('Chelyabinsk', 'Chelyabinsk st.', 'Russia'),
		('Yekaterinburg', 'Sverdlovsk st.', 'Russia'),
		('Kyshtym', 'Chelyabinsk st.', 'Russia'),
		('Ufa','Bashkortostan', 'Russia'),
		('Almata', 'Almata st.', 'Kazakhstan'),
		('Troitsk', 'Chelyabinsk st.', 'Russia');



-- Table: luggage_size
insert into luggage_size (
    description) values 
        ('without luggage'), 
        ('small bag'),
        ('medium bag'),
        ('need all luggage boot');

-- Table: member
insert into member (
    first_name,
    last_name,
    email,
    contact_number,
    driving_licence_number,
    driving_licence_valid_from) values
        ('Khan','Zamay', 'zam@bookingmachine.com',8902943223, 'a3432dwew', '2018-02-01'),
        ('Sasha', 'Sql', 'bflava@aue.ru', 8920095405, null, null),
        ('Yung','Trezzini','yarko@mail.ru', 777777777,'sdfj34r', '2025-04-05'),
        ('Sergey','Ivanov','ivanov9234@mail.ru', 8932480982, 'kjdf432n2', '2017-12-06'),
        ('Mike','Smith', 'rickre@zfs.ny', 8239829031, 'ncjs2e12m', '2020-05-01'),
        ('Slava','Karelin', 'slavakps@spb.ru',8234623742, 'cm343x9zc', '2019-04-09'),
        ('Natalya','Jordan', 'sad@ya.ru', 0902394223, null, null),
        ('Khusra','Islomov', '777alex777@gmail.com', 9820384222, null,null);

-- Table: member_car
insert into member_car (
    member_id,
    car_id,
    car_registration_number,
    car_color)
values (3,10, 'a777aa77ru', 'black'),
       (4,2, 'b234as89ru', 'green'),
       (1,1, 'x098zx77ru', 'orange'),
       (6,8, 'xz2323ru','white');




-- Table: member_preference
insert into member_preference (
    member_id,
    is_smoking_allowed,
    is_pet_allowed,
    music_preference_id,
    chitchat_preference_id
)values (3,1,1,3,3),
        (4,0,0,1,1),
        (6,1,0,4,2),
        (5,0,0,2,3),
        (1,1,0,5,2),
        (7,0,0,2,3);



-- Table: ride
insert into ride (
    member_car_id,
    created_on,
    travel_start_time,
    source_city_id,
    destination_city_id,
    seats_offered,
    contribution_per_head,
    luggage_size_id

)values (1,'2016-12-02', '2017-01-01', 1,4,5, 500, 2),
        (2, '2016-12-10', '2016-12-12', 1,2,3, 300, 1),
        (1, '2016-12-12', '2016-12-30', 4,1,5, 700,2),
        (4, '2016-11-29','2017-01-03', 2,4,2,300,3),
        (3, '2016-12-04', '2017-01-02',2,5,3,2500,3);

-- Table: request_status
insert into request_status (
    description
)values ('DENIED'),
        ('WAITING'), ('APPROVED');


-- Table: request
insert into request (
    requester_id,
    ride_id,
    enroute_city_id,
    created_on,
    request_status_id
) values (2,1,3,'2016-12-04',2),
         (2,3,1,'2016-12-13',3),
         (7,4,4,'2016-12-02',3),
         (8,4,4,'2016-12-10',1)
;