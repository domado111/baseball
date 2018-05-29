drop table users;
drop sequence user_seq;
drop table friends;

CREATE TABLE users (
    user_num INT primary key,
    grade int default 1,
    id VARCHAR(45) not null unique,
    password VARCHAR(100) not null,
    email VARCHAR(45) not null unique,
    nickname varchar(50) not null unique,
    win_count int default 0,
    lose_count int default 0,
    point int default 0,
    friend_count INT DEFAULT 0,
    status int default 0 check(status in (0,1,2)),
    reg_date date
);
--status 0 �������� 1 �¶��� 2 ������
--grade 0 ������, 1 ȸ��

CREATE SEQUENCE user_SEQ
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 10000
  MINVALUE 1
  NOCYCLE;
  

CREATE TABLE friends (
    friend_one INT not null,
    friend_two INT not null,
    status int default 0 check(status in (0,1,2)),
    CONSTRAINT friend_one_fk FOREIGN KEY (friend_one) REFERENCES users(user_num) on delete cascade,
    CONSTRAINT friend_two_fk FOREIGN KEY (friend_two) REFERENCES users(user_num) on delete cascade
);

delete from users;
delete from friends;

select * from friends;
select * from users;

commit;

insert into USERS(user_num,id,password,email,nickname,reg_date) values (user_seq.nextval,'test1','123','1q','����ȿ',sysdate);
insert into USERS(user_num,id,password,email,nickname,reg_date) values (user_seq.nextval,'test2','123','2w','�Ӵ��',sysdate);
insert into USERS(user_num,id,password,email,nickname,reg_date) values (user_seq.nextval,'test3','123','3e','��ȣ��',sysdate);
insert into USERS(user_num,id,password,email,nickname,reg_date) values (user_seq.nextval,'test4','123','4r','�ۿ���',sysdate);
insert into USERS(user_num,id,password,email,nickname,reg_date) values (user_seq.nextval,'test5','123','5t','�㼺��',sysdate);
insert into USERS(user_num,id,password,email,nickname,reg_date) values (user_seq.nextval,'test6','123','6y','�տ���',sysdate);
insert into USERS(user_num,id,password,email,nickname,reg_date) values (user_seq.nextval,'test8','123','8i','�̼���',sysdate);
insert into USERS(user_num,id,password,email,nickname,reg_date) values (user_seq.nextval,'test9','123','9o','������',sysdate);
insert into USERS(user_num,id,password,email,nickname,reg_date) values (user_seq.nextval,'test10','123','10q','������',sysdate);
insert into USERS(user_num,id,password,email,nickname,reg_date) values (user_seq.nextval,'test11','123','11w','�̺���',sysdate);
insert into USERS(user_num,id,password,email,nickname,reg_date) values (user_seq.nextval,'test12','123','12e','������',sysdate);
insert into USERS(user_num,id,password,email,nickname,reg_date) values (user_seq.nextval,'test13','123','13r','������',sysdate);
insert into USERS(user_num,id,password,email,nickname,reg_date) values (user_seq.nextval,'test14','123','14t','������',sysdate);
insert into USERS(user_num,id,password,email,nickname,reg_date) values (user_seq.nextval,'test15','123','15y','������',sysdate);


insert into friends(friend_one,friend_two,status) values (2,3,1);
insert into friends(friend_one,friend_two,status) values (2,4,1);
insert into friends(friend_one,friend_two,status) values (2,5,0);
insert into friends(friend_one,friend_two,status) values (2,6,0);
insert into friends(friend_one,friend_two,status) values (7,2,0);
insert into friends(friend_one,friend_two,status) values (8,2,0);
insert into friends(friend_one,friend_two,status) values (9,2,0);
insert into friends(friend_one,friend_two,status) values (10,2,0);


insert into friends(friend_one,friend_two,status) values (3,4,1);
insert into friends(friend_one,friend_two,status) values (4,5,1);
insert into friends(friend_one,friend_two,status) values (5,6,1);
insert into friends(friend_one,friend_two,status) values (6,7,1);
insert into friends(friend_one,friend_two,status) values (7,8,1);
insert into friends(friend_one,friend_two,status) values (9,10,1);


select nvl(count(*),0) from friends where (FRIEND_ONE=2 or FRIEND_Two=2) and (FRIEND_ONE=14 or FRIEND_Two=14);
