create database SocialMediaAnalysis;
use SocialMediaAnalysis;

create table Users (
userid int primary key auto_increment,
username varchar(50) not null unique,
email varchar(50) not null unique,
CreatedAt timestamp default current_timestamp
);
desc users;

insert into  Users (username, email, CreatedAt) values
('jayesh', 'jayesh@gmail.com', NOW()),
('ganesh', 'ganesh@gmail.com', NOW()),
('chetan', 'chetan@gmail.com', NOW()),
('prasad', 'prasad@gmail.com', NOW()),
('kaushik', 'kaushik@gmail.com', NOW()),
('sahil', 'sahil@gmail.com', NOW()),
('suraj', 'suraj@gmail.com', NOW()),
('karan', 'karan@gmail.com', NOW()),
('dinesh', 'dinesh@gmail.com', NOW()),
('vishal', 'vishal@gmail.com', NOW());
truncate table users;
select * from users;

create table posts (
postid int primary key auto_increment,
userid int,
content text not null,
CreatedAt timestamp default current_timestamp,
foreign key (userid) references users(userid)
);

insert into  posts (userid, content, CreatedAt) values
(1, 'This is the first post!', NOW()),
(2, 'Another day, another post.', NOW()),
(3, 'Loving this new feature!', NOW()),
(4, 'Can’t wait for the weekend!', NOW()),
(5, 'Check out my latest update.', NOW()),
(6, 'Feeling excited about the project.', NOW()),
(7, 'Just had an amazing lunch.', NOW()),
(8, 'What a fantastic event last night!', NOW()),
(9, 'Here is a cool photo I took.', NOW()),
(10, 'Looking forward to tomorrow’s meeting.', NOW());

select * from posts;

create table comments (
    commentid int primary key auto_increment,
    postid int,
    userid int,
    comment text not null,
    CreatedAt timestamp default current_timestamp,
    foreign key(postid) references posts(postid),
	foreign key (userid) references users(userid)
);

insert into comments (postid, userid, comment, CreatedAt) values
(1, 2, 'Great post!', NOW()),
(1, 3, 'I agree with this.', NOW()),
(2, 1, 'Thanks for sharing.', NOW()),
(2, 4, 'Interesting perspective.', NOW()),
(3, 5, 'This is really helpful.', NOW()),
(3, 6, 'Couldn’t have said it better.', NOW()),
(4, 7, 'Totally agree!', NOW()),
(4, 8, 'Can’t wait either.', NOW()),
(5, 9, 'Looking forward to the update.', NOW()),
(5, 10, 'Keep us posted!', NOW());

select * from comments;

create table interactions (
    interactionid int primary key auto_increment,
    postid int,
    userid int,
    interactiontype enum('Like', 'Share') not null,
	CreatedAt timestamp default current_timestamp,
    foreign key(postid) references posts(postid), 
    foreign key (userid) references users(userid)
);

insert into interactions (postid, userid, interactiontype, CreatedAt ) values
(1, 2, 'Like', NOW()),
(1, 3, 'Share', NOW()),
(2, 1, 'Like', NOW()),
(2, 4, 'Like', NOW()),
(3, 5, 'Share', NOW()),
(3, 6, 'Like', NOW()),
(4, 7, 'Share', NOW()),
(4, 8, 'Like', NOW()),
(5, 9, 'Like', NOW()),
(5, 10, 'Share', NOW());

select * from interactions;




-- 1 uaersname start with j 
select username  from users where username  like "j%";

-- 2 end eith n 
select username  from users where username  like "%n";

-- 3 Modify the content column in the Posts table to VARCHAR(255)
alter table posts modify column content varchar(255);

-- 4 Alter the Users table to add a new column last_login:
alter table users add column last_login timestamp;

-- 5 Drop the last_login column from the Users table
alter table users drop last_login;

-- 6 Update the email of a specific user:
update users 
set email ="jay@gmail.com"
where username  = "jayesh";

-- 7 Select all posts by a userid = 1:
select * from posts where userid = 1;

-- 8 Update the content by a potsid = 1
update posts
set content = "hallo my  name is jayesh"
where postid = 1; 

-- 9 Update the comment text in the Comments table:
update comments 
set comment = "i am like this post"
where commentid = 1;

-- 10 returen comman record
select users.userid, users.username, posts.postid,posts. content
from users 
inner join posts 
on users.userid = posts.userid;

-- 11 Select all users and their posts:
select  users.userid, users.username, posts.postid,posts. content
from users 
left join posts
on users.userid = posts.userid;

-- 12 Select all posts with the number of comments for each post:
select posts.postid ,posts.content, count(comments.commentid)
from posts
left join comments
on posts.postid = comments.postid 
group by posts.postid;

-- 13 Select all users who have interacted with posts:
select distinct users.username 
from users 
join interactions
on users.userid = interactions.userid;

-- 14 returen unique(diff) email from users
select distinct email from users;

-- 15 Find the user with the most posts:
select userid, count(*) from posts group by userid order by count(*) desc limit 1; 

-- 16 Find the post with the highest number of interactions:
select postid, count(*) from interactions group by postid order by count(*) limit 1 ;

-- 17 Find users who have never commented:
select userid  from users where userid not in (select userid from comments);

-- 18 Find the total number of interactions per user:
select userid, count(*) from interactions group by userid;

-- 19 Find posts shared by more than one user
select postid, count(*) from interactions where interactiontype = "share" group by postid having count(*)>1;

-- 20 Find users who have liked a post:
select username from users where userid in (select userid from interactions where interactiontype = "like");

-- 21 Count the number of comments on the third post:
select count(*) from comments where postid = 3;











