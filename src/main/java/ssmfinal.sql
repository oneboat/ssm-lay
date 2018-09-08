/*
SQLyog Professional v12.2.6 (64 bit)
MySQL - 5.7.23-log : Database - test001
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`test001` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `test001`;

/*Table structure for table `t_t_count` */

DROP TABLE IF EXISTS `t_t_count`;

CREATE TABLE `t_t_count` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `usercount` int(11) DEFAULT NULL,
  `createtime` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `t_t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `t_t_count` */

insert  into `t_t_count`(`id`,`userId`,`usercount`,`createtime`) values 
(1,1,2800,'2018-08-10'),
(2,2,3200,'2018-08-10');

/*Table structure for table `t_t_device` */

DROP TABLE IF EXISTS `t_t_device`;

CREATE TABLE `t_t_device` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `dvid` varchar(225) DEFAULT NULL,
  `dvname` varchar(225) DEFAULT NULL,
  `dvtypecode` varchar(225) DEFAULT NULL,
  `dvnum` int(5) DEFAULT NULL,
  `dvtotaltime` varchar(225) DEFAULT NULL,
  `dvbelong` int(12) DEFAULT NULL,
  `app_version` varchar(225) DEFAULT NULL,
  `android_version` varchar(225) DEFAULT NULL,
  `MAC_address` varchar(225) DEFAULT NULL,
  `ip_address` varchar(225) DEFAULT NULL,
  `sim_code` varchar(225) DEFAULT NULL,
  `imei_code` varchar(225) DEFAULT NULL,
  `brand_pad` varchar(225) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `t_t_device` */

insert  into `t_t_device`(`id`,`dvid`,`dvname`,`dvtypecode`,`dvnum`,`dvtotaltime`,`dvbelong`,`app_version`,`android_version`,`MAC_address`,`ip_address`,`sim_code`,`imei_code`,`brand_pad`,`createtime`,`updatetime`) values 
(1,'ZW020180808101','子午流注开穴治疗仪','LG9089901',NULL,NULL,1,'1.0','6.0.1','B0:E8:36:68:18:F2','10.119.32.486','13912345678','866988035648359','xiaomi','2018-08-08 00:00:00',NULL);

/*Table structure for table `t_t_device_info` */

DROP TABLE IF EXISTS `t_t_device_info`;

CREATE TABLE `t_t_device_info` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `dvid` varchar(225) DEFAULT NULL,
  `begintime` datetime DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  `usednum` int(12) DEFAULT NULL,
  `createtime` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_t_device_info` */

/*Table structure for table `t_t_file` */

DROP TABLE IF EXISTS `t_t_file`;

CREATE TABLE `t_t_file` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `userid` int(5) DEFAULT NULL,
  `fileurl` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `t_t_file` */

insert  into `t_t_file`(`id`,`userid`,`fileurl`) values 
(1,1,'upload/1531784799406生活大爆炸第七季06集[中英双字].rmvb_20180701_181856.681.png'),
(2,4,'upload/15316675558912018052403.jpg');

/*Table structure for table `t_t_friends` */

DROP TABLE IF EXISTS `t_t_friends`;

CREATE TABLE `t_t_friends` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) DEFAULT NULL,
  `fid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mid` (`mid`),
  KEY `fid` (`fid`),
  CONSTRAINT `fid` FOREIGN KEY (`fid`) REFERENCES `t_t_user` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `mid` FOREIGN KEY (`mid`) REFERENCES `t_t_user` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

/*Data for the table `t_t_friends` */

insert  into `t_t_friends`(`id`,`mid`,`fid`) values 
(1,1,2),
(2,2,1),
(3,1,NULL),
(4,NULL,1),
(53,1,5),
(54,5,1);

/*Table structure for table `t_t_func` */

DROP TABLE IF EXISTS `t_t_func`;

CREATE TABLE `t_t_func` (
  `id` bigint(5) NOT NULL AUTO_INCREMENT,
  `func_name` varchar(50) DEFAULT NULL,
  `func_code` varchar(50) DEFAULT NULL,
  `pid` bigint(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  CONSTRAINT `pid` FOREIGN KEY (`pid`) REFERENCES `t_t_func` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

/*Data for the table `t_t_func` */

insert  into `t_t_func`(`id`,`func_name`,`func_code`,`pid`) values 
(1,'SSM系统功','A0001',NULL),
(2,'系统管理','A0001_001',1),
(3,'业务管理','A0001_002',1),
(4,'游戏娱乐','A0001_003',1),
(5,'系统信息','A0001_001_001',2),
(6,'用户管理','A0001_001_002',2),
(7,'角色管理','A0001_001_003',2),
(8,'权限管理','A0001_001_004',2),
(9,'查看系统功能','A0001_001_005',2),
(10,'学生管理','A0001_002_001',3),
(11,'个人信息','A0001_002_002',3),
(12,'好友列表','A0001_002_003',3),
(13,'视频音乐','A0001_002_004',3),
(14,'俄罗斯方块','A0001_003_001',4),
(15,'贪吃蛇','A0001_003_002',4),
(16,'连连看','A0001_003_003',4),
(17,'用户管理-查看','A0001_001_002_select',6),
(18,'用户管理-编辑','A0001_001_002_edit',6),
(19,'用户管理-添加','A0001_001_002_add',6),
(20,'用户管理-删除','A0001_001_002_delete',6),
(21,'角色管理-查看','A0001_001_003_select',7),
(22,'角色管理-添加','A0001_001_003_add',7),
(23,'角色管理-编辑','A0001_001_003_edit',7),
(24,'角色管理-删除','A0001_001_003_delete',7),
(25,'学生管理-查看','A0001_002_001_select',10),
(26,'学生管理-添加','A0001_002_001_add',10),
(27,'学生管理-编辑','A0001_002_001_edit',10),
(28,'学生管理-删除','A0001_002_001_delete',10),
(32,'视频音乐-查看','A0001_002_004_select',13),
(33,'视频音乐-添加','A0001_002_004_add',13),
(34,'视频音乐-编辑','A0001_002_004_edit',13),
(35,'视频音乐-删除','A0001_002_004_delete',13);

/*Table structure for table `t_t_gamescore` */

DROP TABLE IF EXISTS `t_t_gamescore`;

CREATE TABLE `t_t_gamescore` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` int(20) DEFAULT NULL,
  `score` binary(20) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `t_t_gamescore` */

insert  into `t_t_gamescore`(`id`,`userid`,`score`,`time`) values 
(1,1,'13\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2017-09-29 18:23:07');

/*Table structure for table `t_t_hospital` */

DROP TABLE IF EXISTS `t_t_hospital`;

CREATE TABLE `t_t_hospital` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `hpname` varchar(225) DEFAULT NULL,
  `hpcode` varchar(225) DEFAULT NULL,
  `cardid` varchar(225) DEFAULT NULL,
  `addressDetail` varchar(225) DEFAULT NULL,
  `hptel` varchar(225) DEFAULT NULL,
  `hpcontact` varchar(225) DEFAULT NULL,
  `hpemail` varchar(225) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `t_t_hospital` */

insert  into `t_t_hospital`(`id`,`hpname`,`hpcode`,`cardid`,`addressDetail`,`hptel`,`hpcontact`,`hpemail`,`createtime`,`updatetime`) values 
(1,'中大第一附院','zsdxfs','68956234','广州番禺','071-2536524',NULL,'zd@fs.com','2018-08-07 00:00:00',NULL);

/*Table structure for table `t_t_mav` */

DROP TABLE IF EXISTS `t_t_mav`;

CREATE TABLE `t_t_mav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `size` varchar(255) DEFAULT NULL,
  `length` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `filetype` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  CONSTRAINT `uid` FOREIGN KEY (`uid`) REFERENCES `t_t_user` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `t_t_mav` */

insert  into `t_t_mav`(`id`,`uid`,`name`,`size`,`length`,`path`,`filetype`) values 
(1,1,'brave.mp4','14M','4分6秒','myFiles/1522588894522brave.mp4','视频'),
(2,1,'Something Just Like This.mp4','22M','3分38秒','upload/1531785026678Something Just Like This.mp4','视频');

/*Table structure for table `t_t_permission` */

DROP TABLE IF EXISTS `t_t_permission`;

CREATE TABLE `t_t_permission` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `pname` varchar(255) DEFAULT NULL,
  `pcode` varchar(255) DEFAULT NULL,
  `pid` int(10) DEFAULT NULL,
  `plevel` int(3) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `remark` varchar(2550) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pcode` (`pcode`),
  KEY `qq` (`pid`),
  CONSTRAINT `qq` FOREIGN KEY (`pid`) REFERENCES `t_t_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

/*Data for the table `t_t_permission` */

insert  into `t_t_permission`(`id`,`pname`,`pcode`,`pid`,`plevel`,`url`,`remark`,`createtime`,`updatetime`) values 
(1,'系统所有权','P001',NULL,1,'/',NULL,NULL,NULL),
(2,'系统管理','P001_0A',1,2,'/',NULL,NULL,'2018-08-10 16:16:11'),
(3,'权限管理','P001_0A_PERMS',2,3,'/permission/perList.do',NULL,'2018-08-09 00:00:00',NULL),
(4,'权限管理-查询','P001_0A_PERMS_SELECT',3,4,'/permission/perList.do',NULL,'2018-08-09 00:00:00','2018-08-09 00:00:00'),
(5,'权限管理-添加','P001_0A_PERMS-ADD',3,4,'/permission/addNewPermission.do',NULL,'2018-08-09 00:00:00',NULL),
(6,'权限管理-编辑','P001A_0A_PERMS_EDIT',3,4,'/permission/editPermission.do',NULL,'2018-08-09 00:00:00',NULL),
(7,'权限管理-删除','P001_0A_PERMS_DELETE',3,4,'/permission/deletePermision.do',NULL,'2018-08-09 00:00:00',NULL),
(8,'角色管理','P001_0A_ROLE',2,3,'/',NULL,'2018-08-09 00:00:00','2018-08-09 00:00:00'),
(9,'角色管理-查询','P001_0A_ROLE_SELECT',8,4,'/role/roleList.do',NULL,'2018-08-09 00:00:00',NULL),
(10,'角色管理-添加','P001_0A_ROLE_ADD',8,4,'/role/addRole.do',NULL,'2018-08-09 00:00:00',NULL),
(11,'角色管理-编辑','P001_0A_ROLE_EDIT',8,4,'/role/editRole.do',NULL,'2018-08-09 00:00:00',NULL),
(12,'角色管理-删除','P001_0A_ROLE_DELETE',8,4,'/role/deleteRole.do',NULL,'2018-08-09 00:00:00',NULL),
(13,'角色管理-绑定权限','P001_0A_ROLE_BIND',8,4,'/system/addPersonalPers.do',NULL,'2018-08-10 00:00:00',NULL),
(14,'用户管理','P001_0A_USER',2,3,'/',NULL,'2018-08-10 00:00:00',NULL),
(15,'用户管理-查询','P001_0A_USER_SELECT',14,4,'/user/userManage.do',NULL,'2018-08-10 00:00:00','2018-08-10 00:00:00'),
(16,'用户管理-添加','P001_0A_USER_ADD',14,4,'/user/show/addUser.do',NULL,'2018-08-10 00:00:00',NULL),
(17,'用户管理-编辑','P001_0A_USER_EDIT',14,4,'/user/show/editUser.do',NULL,'2018-08-10 00:00:00',NULL),
(18,'用户管理-删除','P001_0A_USER_DELETE',14,4,'/user/deleteUser.do',NULL,'2018-08-10 00:00:00',NULL),
(19,'用户管理-绑定角色','P001_0A_USER_BIND',14,4,'/user/bindRoleForUser.do',NULL,'2018-08-10 00:00:00',NULL),
(20,'用户管理-解绑角色','P001_0A_USER_UNBIND',14,4,'/user/deleteUserRoles.do',NULL,'2018-08-10 00:00:00',NULL),
(21,'用户管理-重置密码','P001_0A_USER_RESETPWD',14,4,'/user/show/resetPassword.do',NULL,'2018-08-10 00:00:00',NULL),
(22,'日志管理','P001_0A_LOG',2,3,'/log/logList.do',NULL,'2018-08-10 00:00:00',NULL),
(23,'查看系统功能','P001_0A_FUNCTIONS',2,3,'/',NULL,'2018-08-10 00:00:00',NULL),
(24,'业务管理','P001_0B',1,2,'/',NULL,'2018-08-10 00:00:00',NULL),
(25,'设备管理','P001_0B_DEVICE',24,3,'/device/deviceList.do',NULL,'2018-08-10 00:00:00',NULL),
(26,'设备管理-查询','P001_0B_DEVICE_SELECT',25,4,'/device/deviceList.do',NULL,'2018-08-10 00:00:00',NULL),
(27,'设备管理-添加','P001_0B_DEVICE_ADD',25,4,'/device/addDevice.do',NULL,'2018-08-10 00:00:00',NULL),
(28,'设备管理-编辑','P001_0B_DEVICE_EDIT',25,4,'/device/editDevice.do',NULL,'2018-08-10 00:00:00',NULL),
(29,'设备管理-删除','P001_0B_DEVICE_DELETE',25,4,'/device/deleteDevice.do',NULL,'2018-08-10 00:00:00',NULL),
(30,'设备管理-使用记录','P001_0B_DEVICE_RECORD',25,4,'/device/deviceInfoList.do',NULL,'2018-08-10 00:00:00',NULL),
(32,'医院管理','P001_0B_HOSPITAL',24,3,'/hospital/hospitalList.do',NULL,'2018-08-10 00:00:00','2018-08-10 00:00:00'),
(33,'医院管理-查询','P001_0B_HOSPITAL_SELECT',32,4,'/hospital/hospitalList.do',NULL,'2018-08-10 00:00:00',NULL),
(34,'医院管理-添加','P001_0B_HOSPITAL_ADD',32,4,'/hospital/addHospital.do',NULL,'2018-08-10 00:00:00',NULL),
(35,'医院管理-编辑','P001_0B_HOSPITAL_EDIT',32,4,'/hospital/editHospital.do',NULL,'2018-08-10 00:00:00',NULL),
(36,'医院管理-删除','P001_0B_HOSPITAL_DELETE',32,4,'/hospital/deleteHospital.do',NULL,'2018-08-10 00:00:00',NULL),
(37,'医疗记录','P001_0B_CREC',24,3,'/crec/crecList.do',NULL,'2018-08-10 00:00:00',NULL),
(38,'医疗记录-查询','P001_0B_CREC_SELECT',37,4,'/crec/crecList.do',NULL,'2018-08-10 00:00:00',NULL),
(39,'医疗记录-下载','P001_0B_CREC_DOWNLOAD',37,4,'/crec/downloadRecord.do',NULL,'2018-08-10 00:00:00',NULL),
(40,'查看系统功能','P001_0A_FUNCS',2,3,'/',NULL,'2018-08-10 16:17:16',NULL);

/*Table structure for table `t_t_role` */

DROP TABLE IF EXISTS `t_t_role`;

CREATE TABLE `t_t_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(255) DEFAULT NULL,
  `rolecode` varchar(255) DEFAULT NULL,
  `rlevel` int(10) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rolecode` (`rolecode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `t_t_role` */

insert  into `t_t_role`(`id`,`rolename`,`rolecode`,`rlevel`,`pid`,`status`,`createtime`,`updatetime`) values 
(1,'超级管理员','R001',1,NULL,1,NULL,NULL),
(2,'医院管理员','R002',2,1,1,NULL,NULL);

/*Table structure for table `t_t_role_per` */

DROP TABLE IF EXISTS `t_t_role_per`;

CREATE TABLE `t_t_role_per` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `role_id` int(10) DEFAULT NULL,
  `per_id` int(10) DEFAULT NULL,
  `useful` int(1) DEFAULT '1',
  `operateTime` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `per_id` (`per_id`),
  KEY `ro_id` (`role_id`),
  CONSTRAINT `per_id` FOREIGN KEY (`per_id`) REFERENCES `t_t_permission` (`id`),
  CONSTRAINT `ro_id` FOREIGN KEY (`role_id`) REFERENCES `t_t_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

/*Data for the table `t_t_role_per` */

insert  into `t_t_role_per`(`id`,`role_id`,`per_id`,`useful`,`operateTime`,`createtime`) values 
(1,1,1,0,'2018-08-06 00:00:00',NULL),
(2,2,2,0,'2018-08-06 00:00:00',NULL),
(3,1,2,0,NULL,NULL),
(4,1,3,1,'2018-08-10 16:48:10',NULL),
(5,1,4,1,'2018-08-10 16:48:10',NULL),
(6,1,5,1,'2018-08-10 16:48:10',NULL),
(7,1,6,1,'2018-08-10 16:48:10',NULL),
(8,1,7,1,'2018-08-10 16:48:10',NULL),
(9,1,14,1,'2018-08-10 16:48:10',NULL),
(10,1,15,1,'2018-08-10 16:48:10',NULL),
(11,1,16,1,'2018-08-10 16:48:10',NULL),
(12,1,17,1,'2018-08-10 16:48:10',NULL),
(13,1,18,1,'2018-08-10 16:48:10',NULL),
(14,1,19,1,'2018-08-10 16:48:10',NULL),
(15,1,20,1,'2018-08-10 16:48:10',NULL),
(16,1,21,1,'2018-08-10 16:48:10',NULL),
(17,1,8,1,'2018-08-10 16:48:10',NULL),
(18,1,9,1,'2018-08-10 16:48:10',NULL),
(19,1,10,1,'2018-08-10 16:48:10',NULL),
(20,1,11,1,'2018-08-10 16:48:10',NULL),
(21,1,12,1,'2018-08-10 16:48:10',NULL),
(22,1,13,1,'2018-08-10 16:48:10',NULL),
(23,1,22,1,'2018-08-10 16:48:10',NULL),
(24,1,23,1,'2018-08-10 16:48:10',NULL),
(25,1,24,0,'2018-08-10 16:17:31',NULL),
(26,1,25,1,'2018-08-10 16:48:10',NULL),
(27,1,26,1,'2018-08-10 16:48:10',NULL),
(28,1,27,1,'2018-08-10 16:48:10',NULL),
(29,1,28,1,'2018-08-10 16:48:10',NULL),
(30,1,29,1,'2018-08-10 16:48:10',NULL),
(31,1,30,1,'2018-08-10 16:48:10',NULL),
(32,1,32,1,'2018-08-10 16:48:10',NULL),
(33,1,33,1,'2018-08-10 16:48:10',NULL),
(34,1,34,1,'2018-08-10 16:48:10',NULL),
(35,1,35,1,'2018-08-10 16:48:10',NULL),
(36,1,36,1,'2018-08-10 16:48:10',NULL),
(37,2,25,1,'2018-08-10 16:47:59','2018-08-10 00:00:00'),
(38,2,26,1,'2018-08-10 16:47:59','2018-08-10 00:00:00'),
(39,2,27,1,'2018-08-10 16:47:59','2018-08-10 00:00:00'),
(40,2,28,1,'2018-08-10 16:47:59','2018-08-10 00:00:00'),
(41,2,29,1,'2018-08-10 16:47:59','2018-08-10 00:00:00'),
(42,2,30,1,'2018-08-10 16:47:59','2018-08-10 00:00:00'),
(43,1,40,1,'2018-08-10 16:48:10','2018-08-10 16:17:31'),
(44,2,37,1,NULL,'2018-08-10 16:47:59'),
(45,2,38,1,NULL,'2018-08-10 16:47:59'),
(46,2,39,1,NULL,'2018-08-10 16:47:59'),
(47,1,37,1,NULL,'2018-08-10 16:48:10'),
(48,1,38,1,NULL,'2018-08-10 16:48:10'),
(49,1,39,1,NULL,'2018-08-10 16:48:10');

/*Table structure for table `t_t_student` */

DROP TABLE IF EXISTS `t_t_student`;

CREATE TABLE `t_t_student` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `sex` int(1) DEFAULT NULL,
  `age` int(3) DEFAULT NULL,
  `grade` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `t_t_student` */

insert  into `t_t_student`(`id`,`name`,`sex`,`age`,`grade`,`address`,`phone`) values 
(1,'刘季',NULL,55,NULL,'汉中市','18989283987'),
(5,'翟英俊',NULL,26,NULL,'寿春','18298378291');

/*Table structure for table `t_t_user` */

DROP TABLE IF EXISTS `t_t_user`;

CREATE TABLE `t_t_user` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `age` int(3) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `cardid` varchar(18) DEFAULT NULL,
  `ident` varchar(50) DEFAULT NULL,
  `identnum` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `t_t_user` */

insert  into `t_t_user`(`id`,`username`,`password`,`name`,`age`,`phone`,`address`,`cardid`,`ident`,`identnum`,`email`,`createtime`,`updatetime`) values 
(1,'admin','e10adc3949ba59abbe56e057f20f883e','超级管理员',0,NULL,'上海市浦江镇',NULL,'管理员',NULL,'13991548645@163.com',NULL,NULL),
(2,'zsdxfs','e10adc3949ba59abbe56e057f20f883e','中山大学附属第一医院',NULL,'13912345678','广州','',NULL,'2','13912345678@136.com',NULL,NULL);

/*Table structure for table `t_t_user_role` */

DROP TABLE IF EXISTS `t_t_user_role`;

CREATE TABLE `t_t_user_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) DEFAULT NULL,
  `role_id` int(10) DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `operateTime` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `role_id` FOREIGN KEY (`role_id`) REFERENCES `t_t_role` (`id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `t_t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `t_t_user_role` */

insert  into `t_t_user_role`(`id`,`user_id`,`role_id`,`status`,`operateTime`,`createtime`) values 
(1,1,1,1,'2018-08-06 00:00:00',NULL),
(2,2,2,1,NULL,NULL);

/* Procedure structure for procedure `addUser` */

/*!50003 DROP PROCEDURE IF EXISTS  `addUser` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addUser`(in v_name varchar(30),v_email varchar(50),v_password varchar(20),v_ident varchar(20),v_ident_num varchar(20))
BEGIN
		insert into t_t_user(username,email,password,ident,identnum)values(v_name,v_email,v_password,v_ident,v_ident_num);
		insert into t_t_user_role(user_id,role_id)
		select a.id,b.id from t_t_user a,t_t_role b where a.email = v_email and b.rolename=v_ident; 
	END */$$
DELIMITER ;

/* Procedure structure for procedure `test_p` */

/*!50003 DROP PROCEDURE IF EXISTS  `test_p` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `test_p`()
BEGIN
        DECLARE t_error INTEGER DEFAULT 0;    
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET t_error=1;    
    
        START TRANSACTION;    
		INSERT INTO T_USER(NAME,age,date)VALUES ('李晓盼','26',now());
		INSERT INTO T_USER(NAME,age,date)VALUES ('大牛','26',now());
		INSERT INTO T_USER(NAME,age,DATE)VALUES ('大牛','26',NOW());
	IF t_error = 1 THEN    
	    ROLLBACK;    
	ELSE    
	    COMMIT;    
	END IF;    
    select t_error;  
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
