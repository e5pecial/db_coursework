-- Bad styleguide because it's recovery version from sql dump

-- tables
-- Table: car

CREATE TABLE car (
    id serial,
    model varchar(50)  NOT NULL,
    make_year smallint  NOT NULL,
    comfort_level smallint  NOT NULL,
    CONSTRAINT car_pk PRIMARY KEY (id)
);

-- Table: chitchat_preference
create type chitchat as enum (
    'silence', 'on the mood', 'love to talk');

CREATE TABLE chitchat_preference (
    id serial,
    description chitchat  NOT NULL,
    CONSTRAINT chitchat_preference_pk PRIMARY KEY (id)
);

-- Table: city
CREATE TABLE city (
    id serial,
    city_name varchar(50)  NOT NULL,
    state varchar(50)  NOT NULL,
    country varchar(50)  NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
);

create type luggage as enum (
    'without luggage', 'small bag', 'medium bag', 'need all luggage boot');

-- Table: luggage_size
CREATE TABLE luggage_size (
    id serial,
    description luggage  NOT NULL,
    CONSTRAINT luggage_size_pk PRIMARY KEY (id)
);

-- Table: member
CREATE TABLE member (
    id serial,
    first_name varchar(50)  NOT NULL,
    last_name varchar(50)  NOT NULL,
    email varchar(255)  NOT NULL,
    contact_number bigint  NOT NULL,
    driving_licence_number varchar(50)  NULL,
    driving_licence_valid_from timestamp without time zone NULL,
    CONSTRAINT member_pk PRIMARY KEY (id),
    CONSTRAINT valid_first_name 
      CHECK(first_name ~ '[a-zA-Z]+'),
    CONSTRAINT valid_last_name 
      CHECK(last_name ~ '[a-zA-Z]+'),
    constraint un_email unique (email),
    constraint un_num unique (contact_number)
);

-- Table: member_car
CREATE TABLE member_car (
    id serial,
    member_id int  NOT NULL,
    car_id int  NOT NULL,
    car_registration_number varchar(50)  NOT NULL,
    car_color varchar(20)  NOT NULL,
    CONSTRAINT member_car_pk PRIMARY KEY (id)
);

-- Table: member_preference
CREATE TABLE member_preference (
    member_id int,
    is_smoking_allowed char(1)  NOT NULL,
    is_pet_allowed char(1)  NOT NULL,
    music_preference_id int  NOT NULL,
    chitchat_preference_id int  NOT NULL,
    CONSTRAINT member_preference_pk PRIMARY KEY (member_id)
);

-- Table: music_preference

create type music_pref as enum (
 'without', 'rock', 'hip-hop', 'dance', 'classic');

CREATE TABLE music_preference (
    id serial,
    description music_pref NOT NULL,
    CONSTRAINT music_preference_pk PRIMARY KEY (id)
);

-- Table: request
CREATE TABLE request (
    id serial,
    requester_id int  NOT NULL,
    ride_id int  NOT NULL,
    created_on timestamp without time zone  NOT NULL,
    request_status_id int  NOT NULL,
    CONSTRAINT request_pk PRIMARY KEY (id)
);

-- Table: request_status
create type status as enum (
    'DENIED','WAITING', 'APPROVED');

CREATE TABLE request_status (
    id serial,
    description status  NOT NULL,
    CONSTRAINT request_status_pk PRIMARY KEY (id)
);

-- Table: ride
CREATE TABLE ride (
    id serial,
    member_car_id int  NOT NULL,
    created_on timestamp without time zone  NOT NULL,
    travel_start_time timestamp without time zone  NOT NULL,
    source_city_id int  NOT NULL,
    destination_city_id int  NOT NULL,
    seats_offered smallint  NOT NULL,
    contribution_per_head int  NOT NULL,
    luggage_size_id int  NOT NULL,
    CONSTRAINT ride_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: destination_ride_city (table: ride)
ALTER TABLE ride ADD CONSTRAINT destination_ride_city
    FOREIGN KEY (destination_city_id)
    REFERENCES city (id) on update cascade on delete cascade

;


ALTER TABLE member_preference ADD CONSTRAINT member_pref_chitchat_pref
    FOREIGN KEY (chitchat_preference_id)
    REFERENCES chitchat_preference (id) on delete cascade
;

-- Reference: request_request_status (table: request)
ALTER TABLE request ADD CONSTRAINT request_request_status
    FOREIGN KEY (request_status_id)
    REFERENCES request_status (id) on delete cascade
;

-- Reference: request_ride (table: request)
ALTER TABLE request ADD CONSTRAINT request_ride
    FOREIGN KEY (ride_id)
    REFERENCES ride (id)  on delete cascade
;

-- Reference: request_user (table: request)
ALTER TABLE request ADD CONSTRAINT request_user
    FOREIGN KEY (requester_id)
    REFERENCES member (id) on delete cascade
;

-- Reference: ride_luggage_size (table: ride)
ALTER TABLE ride ADD CONSTRAINT ride_luggage_size
    FOREIGN KEY (luggage_size_id)
    REFERENCES luggage_size (id)
;

-- Reference: ride_user_car (table: ride)
ALTER TABLE ride ADD CONSTRAINT ride_user_car
    FOREIGN KEY (member_car_id)
    REFERENCES member_car (id) on delete cascade
;

-- Reference: source_ride_city (table: ride)
ALTER TABLE ride ADD CONSTRAINT source_ride_city
    FOREIGN KEY (source_city_id)
    REFERENCES city (id) on delete cascade
;

-- Reference: user_car_car (table: member_car)
ALTER TABLE member_car ADD CONSTRAINT user_car_car
    FOREIGN KEY (car_id)
    REFERENCES car (id) on delete cascade
;

-- Reference: user_car_user (table: member_car)
ALTER TABLE member_car ADD CONSTRAINT user_car_user
    FOREIGN KEY (member_id)
    REFERENCES member (id) on delete cascade
;

-- Reference: user_pref_music_pref (table: member_preference)
ALTER TABLE member_preference ADD CONSTRAINT user_pref_music_pref
    FOREIGN KEY (music_preference_id)
    REFERENCES music_preference (id) on delete cascade
;

-- Reference: user_preference_user (table: member_preference)
ALTER TABLE member_preference ADD CONSTRAINT user_preference_user
    FOREIGN KEY (member_id)
    REFERENCES member (id) on delete cascade
;