drop table logs;

create table logs (
	id serial,
	table_name varchar(25),
	last_operation varchar(25),
	trigger_name varchar(50),
	when_happen varchar(25),
	datetime timestamp default(current_timestamp)
);


-- Данный триггер должен сработать, когда 
-- введенная дата лицензии водителя уже просрочена, тогда
-- поднимается уведомление.



drop function check_licence_valid() cascade;
а, если завтра забивать очередь будут, то забивай нам на начало
create or replace function check_licence_valid() 
	returns trigger as $$
begin
	if new.driving_licence_valid_from < current_date then
		insert into logs (table_name, last_operation, trigger_name, when_happen) 
			values (tg_table_name, tg_op, tg_name, tg_when);
		raise notice 'Bad expire date, check logs table.';								
	end if;
	return new;
end;
$$ language plpgsql;

create trigger check_licence_date
before insert or update
	on member for each row execute procedure check_licence_valid();


-- После удаления модели машины информация заносится в logs.

drop function delete_ride() cascade;

create or replace function delete_ride()
	returns trigger as $$
begin
	insert into logs (table_name, last_operation, trigger_name, when_happen)
		values (tg_table_name, tg_op, tg_name, tg_when);
	raise notice 'The ride was deleted, check logs table';
	return old;
end;
$$ language plpgsql;

create trigger delete_ride_logging
before delete 
	on ride execute procedure delete_ride();
