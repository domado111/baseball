create table game(
    game_num Int primary key,
    roomname varchar(20) not null unique,
    user1 varchar(45),
    user2 varchar(45),
    user3 varchar(45),
    user4 varchar(45),
    winner varchar(45),
    point int default 0,
    winner_turn int default 0,
    start_date date,
    end_date date
);

create sequence game_seq
    start with 1
    increment By 1
    MaxValue 100000000
    minValue 1;
