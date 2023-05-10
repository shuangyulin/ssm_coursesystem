-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_student` (
  `studentNumber` varchar(20)  NOT NULL COMMENT 'studentNumber',
  `password` varchar(20)  NOT NULL COMMENT '登陆密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `sex` varchar(4)  NOT NULL COMMENT '性别',
  `birthday` varchar(20)  NULL COMMENT '出生日期',
  `zzmm` varchar(20)  NOT NULL COMMENT '政治面貌',
  `className` varchar(30)  NOT NULL COMMENT '所在班级',
  `telephone` varchar(20)  NULL COMMENT '联系电话',
  `photo` varchar(60)  NOT NULL COMMENT '个人照片',
  `address` varchar(80)  NULL COMMENT '家庭地址',
  PRIMARY KEY (`studentNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `position` varchar(12)  NOT NULL COMMENT '职称',
  `password` varchar(20)  NOT NULL COMMENT '密码',
  `introduction` varchar(2000)  NULL COMMENT '教师简介',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_courseInfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `jianjie` varchar(500)  NOT NULL COMMENT '课程简介',
  `dagan` varchar(1000)  NOT NULL COMMENT '课程大纲',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_kejian` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `title` varchar(40)  NOT NULL COMMENT '课件标题',
  `path` varchar(50)  NOT NULL COMMENT '文件路径',
  `addTime` varchar(20)  NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_chapter` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `title` varchar(20)  NOT NULL COMMENT '章标题',
  `addTime` varchar(20)  NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_video` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `title` varchar(50)  NOT NULL COMMENT '视频资料标题',
  `chapterId` int(11) NOT NULL COMMENT '所属章',
  `path` varchar(50)  NOT NULL COMMENT '文件路径',
  `addTime` varchar(20)  NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_exercise` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `title` varchar(20)  NOT NULL COMMENT '习题名称',
  `chapterId` int(11) NOT NULL COMMENT '所在章',
  `content` varchar(1000)  NOT NULL COMMENT '练习内容',
  `addTime` varchar(20)  NOT NULL COMMENT '加入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `teacherId` int(11) NOT NULL COMMENT '提问的老师',
  `questioner` varchar(20)  NOT NULL COMMENT '提问者',
  `content` varchar(200)  NOT NULL COMMENT '提问内容',
  `reply` varchar(200)  NOT NULL COMMENT '回复内容',
  `addTime` varchar(20)  NOT NULL COMMENT '提问时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_homeworkTask` (
  `homeworkId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `teacherObj` int(11) NOT NULL COMMENT '老师',
  `title` varchar(50)  NOT NULL COMMENT '作业标题',
  `content` varchar(1000)  NOT NULL COMMENT '作业内容',
  `addTime` varchar(20)  NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`homeworkId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_homeworkUpload` (
  `uploadId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `homeworkTaskObj` int(11) NOT NULL COMMENT '作业标题',
  `studentObj` varchar(20)  NOT NULL COMMENT '提交的学生',
  `homeworkFile` varchar(60)  NOT NULL COMMENT '作业文件',
  `uploadTime` varchar(20)  NOT NULL COMMENT '提交时间',
  `resultFile` varchar(60)  NOT NULL COMMENT '批改结果文件',
  `pigaiTime` varchar(20)  NOT NULL COMMENT '批改时间',
  `pigaiFlag` int(11) NOT NULL COMMENT '是否批改',
  `pingyu` varchar(80)  NULL COMMENT '评语',
  PRIMARY KEY (`uploadId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_video ADD CONSTRAINT FOREIGN KEY (chapterId) REFERENCES t_chapter(id);
ALTER TABLE t_exercise ADD CONSTRAINT FOREIGN KEY (chapterId) REFERENCES t_chapter(id);
ALTER TABLE t_question ADD CONSTRAINT FOREIGN KEY (teacherId) REFERENCES t_teacher(id);
ALTER TABLE t_homeworkTask ADD CONSTRAINT FOREIGN KEY (teacherObj) REFERENCES t_teacher(id);
ALTER TABLE t_homeworkUpload ADD CONSTRAINT FOREIGN KEY (homeworkTaskObj) REFERENCES t_homeworkTask(homeworkId);
ALTER TABLE t_homeworkUpload ADD CONSTRAINT FOREIGN KEY (studentObj) REFERENCES t_student(studentNumber);


