drop database if exists library;

create database library;

use library;

drop table if exists book;

create table book(
    bno char(8),
    category char(10),
    title varchar(40),
    press varchar(30),
    year int,
    author varchar(30),
    price decimal(7,2),
    total int,
    stock int,
    primary key(bno)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into book (bno, category, title, press, year, author, price, total, stock) values
(10000001, '计算机', 'Python编程 : 从入门到实践', '人民邮电出版社', 2020, '[美]埃里克·马瑟斯', 62.10, 4, 4),
(10000002, '计算机','深入理解计算机系统', '机械工业出版社', 2016, 'Randal E.Bryant', 139.00, 2, 1),
(10000003, '计算机', '算法（第4版）', '人民邮电出版社', 2012, 'Robert Sedgewick', 99.00, 5, 5),
(10000004, '计算机', 'C Primer Plus（第6版）', '人民邮电出版社', 2016, 'Stephen Prata', 89.00, 6, 4),
(10000005, '小说', '活着', '作家出版社', 2012, '余华', 20.00, 3, 3),
(10000006, '小说', '白夜行', '南海出版公司', 2013, '东野圭吾', 29.50, 3, 3),
(10000007, '经济学', '经济学原理', '南海出版公司', 2013, '曼昆', 79.80, 3, 3);


drop table if exists card;

create table card(
    cno char(7),
    name varchar(10),
    department varchar(40),
    type enum('student','teacher'),
    primary key(cno)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into card (cno, name, department, type) values
('0103468', '张三', '法学部', 'student'),
('0101111', '李四', '计算机部', 'teacher'),
('0101023', '王五', '经济学部', 'student');

drop table if exists manager;

create table manager(
    mno char(7),
    name varchar(10),
    password varchar(20) not null,
    phone_num char(11),
    primary key(mno)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into manager (mno, name, password, phone_num) values
('1111', 'admin', '1111', '19888881111'),
('2222', 'root', '2222', '19888882222');

drop table if exists borrow;

create table borrow(
    cno char(7),
    bno char(8),
    borrow_date date,
    return_date date,
    mno char(7),
    foreign key(bno) references book(bno) on delete restrict on update cascade,
    foreign key(cno) references card(cno) on delete restrict on update cascade,
    foreign key(mno) references manager(mno) on delete restrict on update cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into borrow (cno, bno, borrow_date, return_date, mno) values
('0101111', '10000004', '2020-08-19', '2020-09-30', '1111'),
('0101111', '10000002', '2020-08-19', '2020-09-30', '1111'),
('0101023', '10000004', '2020-07-19', '2020-08-30', '1111');


create trigger autoBorrow after insert on borrow
for each row
update book set stock=stock-1 where bno=new.bno;

create trigger autoReturn after delete on borrow
for each row
update book set stock=stock+1 where bno=old.bno;

delimiter $$
create trigger autoSetDate before insert on borrow
for each row
begin
set new.borrow_date=curdate(), new.return_date=date_add(now(),interval '40' day);
end $$
