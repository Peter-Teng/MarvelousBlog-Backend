﻿create database MarvelousBlog;

use MarvelousBlog;

CREATE TABLE author (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '作者（管理员）id' ,
    nickname VARCHAR(20) NOT NULL COMMENT '作者（管理员）登录名',
    password VARCHAR(50) NOT NULL COMMENT '作者（管理员）登录密码',
    avatar VARCHAR(100) DEFAULT NULL COMMENT '作者（管理员）头像',
	role TINYINT NOT NULL DEFAULT 0  COMMENT '作者身份，1为站主，0为普通作者'
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE visitor (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '访客id' ,
    mobile VARCHAR(20) DEFAULT NULL COMMENT '访客手机号',
    email VARCHAR(50) DEFAULT NULL COMMENT '访客邮箱' ,
    register_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '访客注册时间',
    nickname VARCHAR(20) NOT NULL COMMENT '访客昵称' ,
    password VARCHAR(50) NOT NULL COMMENT '访客密码',
    last_login_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '访客上次登录时间',
    status TINYINT DEFAULT 1 COMMENT '访客激活状态（0为禁用，1为激活）'
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE label (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '标签id',
    label_name VARCHAR(20) NOT NULL COMMENT '标签名字',
    description VARCHAR(150) DEFAULT NULL COMMENT '标签描述'
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE article(
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '文章id',
    title VARCHAR(50) NOT NULL COMMENT '文章标题' ,
    summary VARCHAR(75) DEFAULT NULL COMMENT '文章摘要' ,
    label_id BIGINT DEFAULT NULL COMMENT '文章标签' ,
    post_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间' ,
    author_id BIGINT NOT NULL COMMENT '作者ID' ,
    visit_count BIGINT DEFAULT 0 COMMENT '浏览量',
    last_modify_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '上次修改时间',
    INDEX label_id(label_id) USING BTREE ,
    INDEX post_time(post_time) USING BTREE ,
    CONSTRAINT fk_label_id_1 FOREIGN KEY (label_id) REFERENCES label(id) ON DELETE CASCADE ON UPDATE CASCADE ,
    CONSTRAINT fk_author_id_1 FOREIGN KEY (author_id) REFERENCES author(id) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE comment(
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '评论id',
    context TEXT DEFAULT NULL COMMENT '评论内容',
    comment_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '评论时间' ,
    visitor_id BIGINT NOT NULL COMMENT '访客id',
    article_id BIGINT NOT NULL COMMENT '评论文章id',
    INDEX comment_time(comment_time) USING BTREE ,
    CONSTRAINT fk_visitor_id_1 FOREIGN KEY (visitor_id) REFERENCES visitor(id) ON DELETE CASCADE ON UPDATE CASCADE ,
    CONSTRAINT fk_article_id_1 FOREIGN KEY (article_id) REFERENCES article(id) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE content(
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '内容id',
    article_id BIGINT NOT NULL COMMENT '文章id',
    content LONGTEXT DEFAULT NULL COMMENT '文章内容',
    CONSTRAINT fk_article_id_2 FOREIGN KEY (article_id) REFERENCES article(id) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

show tables ;

#DROP DATABASE MarvelousBlog;
