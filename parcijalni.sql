create table narudzba (
id_narudzba int primary key not null,
hrana varchar (255),
stol varchar (255),
id_konobar int
);

insert into hrana 
values (1, 'meksicka', 1,1)

insert into hrana 
values (2, 'slavonska', 2,2)

insert into hrana 
values (3, 'talijanska', 3,3)

insert into konobar
values (1,'marko', 'markic', 20, 1,1)

insert into konobar
values (2,'ivan', 'ivic', 25, 2,2)

insert into konobar
values (3,'marija', 'maric', 30, 3,3)

insert into narudzba
values (1,'taco', 'jedan', 1)

insert into narudzba
values (2,'kulen', 'dva', 2)

insert into narudzba
values (3,'pizza', 'tri', 3)

select * from restoran.narudzba, restoran.konobar
