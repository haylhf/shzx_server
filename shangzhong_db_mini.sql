/*
Navicat MySQL Data Transfer

Source Server         : Localhost
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : shangzhong_db

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2019-01-10 18:00:06
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `banji`
-- ----------------------------
DROP TABLE IF EXISTS `banji`;
CREATE TABLE `banji` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `grade` varchar(255) NOT NULL COMMENT '年级',
  `class_name` varchar(255) NOT NULL COMMENT '班级名称',
  `charge_teacher` int(10) unsigned NOT NULL COMMENT '班主任',
  PRIMARY KEY (`id`),
  KEY `fk_charge_teacher` (`charge_teacher`),
  CONSTRAINT `fk_charge_teacher` FOREIGN KEY (`charge_teacher`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of banji
-- ----------------------------

-- ----------------------------
-- Table structure for `booking_record`
-- ----------------------------
DROP TABLE IF EXISTS `booking_record`;
CREATE TABLE `booking_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '该表只是记录变更历史，实际的变更在确认后，应该更新到实际的表',
  `change_date` date NOT NULL COMMENT '变更线路的日期',
  `student` int(10) unsigned NOT NULL COMMENT '要变更线路的学生',
  `old_bus_line` int(10) unsigned NOT NULL COMMENT '原校车',
  `new_bus_line` int(10) unsigned NOT NULL COMMENT '新校车',
  `new_station` int(10) unsigned NOT NULL COMMENT '新站点',
  `change_content` varchar(1000) NOT NULL COMMENT '变更内容',
  `confirm_status` varchar(255) NOT NULL COMMENT '是否确认',
  `create_time` datetime NOT NULL COMMENT '该条记录的创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '该条记录的更新时间',
  PRIMARY KEY (`id`,`change_date`),
  KEY `fk_student` (`student`),
  KEY `fk_old_bus` (`old_bus_line`),
  KEY `fk_new_bus` (`new_bus_line`),
  KEY `fk_new_station` (`new_station`),
  CONSTRAINT `fk_new_bus_line` FOREIGN KEY (`new_bus_line`) REFERENCES `bus_line` (`id`),
  CONSTRAINT `fk_new_station` FOREIGN KEY (`new_station`) REFERENCES `bus_stations` (`id`),
  CONSTRAINT `fk_old_bus_line` FOREIGN KEY (`old_bus_line`) REFERENCES `bus_line` (`id`),
  CONSTRAINT `fk_student` FOREIGN KEY (`student`) REFERENCES `student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of booking_record
-- ----------------------------

-- ----------------------------
-- Table structure for `bus_base_info`
-- ----------------------------
DROP TABLE IF EXISTS `bus_base_info`;
CREATE TABLE `bus_base_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(255) NOT NULL COMMENT '校车编号',
  `plate_number` varchar(255) NOT NULL COMMENT '车牌号',
  `plate_number_pic` varchar(255) NOT NULL COMMENT '牌照照片存放路径',
  `bus_supplier` int(10) unsigned NOT NULL COMMENT '供应商，外键',
  `bus_mom` int(10) unsigned NOT NULL COMMENT '巴士妈妈，外键',
  `bus_driver` int(10) unsigned NOT NULL COMMENT '司机',
  `school_partition` varchar(255) NOT NULL COMMENT '浦东校区；浦西校区',
  `ipad_meid` varchar(255) NOT NULL COMMENT 'ipad绑定的设备号',
  `valid` tinyint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bus_supplier` (`bus_supplier`),
  KEY `fk_bus_mom` (`bus_mom`),
  KEY `fk_bus_driver` (`bus_driver`),
  CONSTRAINT `bus_base_info_ibfk_1` FOREIGN KEY (`bus_driver`) REFERENCES `user` (`id`),
  CONSTRAINT `bus_base_info_ibfk_2` FOREIGN KEY (`bus_mom`) REFERENCES `user` (`id`),
  CONSTRAINT `bus_base_info_ibfk_3` FOREIGN KEY (`bus_supplier`) REFERENCES `bus_supplier` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bus_base_info
-- ----------------------------

-- ----------------------------
-- Table structure for `bus_line`
-- ----------------------------
DROP TABLE IF EXISTS `bus_line`;
CREATE TABLE `bus_line` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bus_base_info` int(10) unsigned NOT NULL COMMENT '校车基本信息',
  `transport_range` int(10) unsigned NOT NULL COMMENT '班车区间，包含了夜班路线',
  `mode` varchar(255) NOT NULL COMMENT '"早班“、”午班“、”晚班“',
  PRIMARY KEY (`id`),
  KEY `fk_bus_base_info` (`bus_base_info`),
  KEY `fk_transport_range` (`transport_range`),
  CONSTRAINT `fk_bus_base_info` FOREIGN KEY (`bus_base_info`) REFERENCES `bus_base_info` (`id`),
  CONSTRAINT `fk_transport_range` FOREIGN KEY (`transport_range`) REFERENCES `transport_range` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bus_line
-- ----------------------------

-- ----------------------------
-- Table structure for `bus_stations`
-- ----------------------------
DROP TABLE IF EXISTS `bus_stations`;
CREATE TABLE `bus_stations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `station_name` varchar(255) NOT NULL COMMENT '站点名称',
  `gps_info` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `station_name` (`station_name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bus_stations
-- ----------------------------

-- ----------------------------
-- Table structure for `bus_supplier`
-- ----------------------------
DROP TABLE IF EXISTS `bus_supplier`;
CREATE TABLE `bus_supplier` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bus_supplier
-- ----------------------------
INSERT INTO `bus_supplier` VALUES ('1', '港湾校车有限公司', '13000002222');
INSERT INTO `bus_supplier` VALUES ('2', '小卫校车有限公司', '13066668888');
INSERT INTO `bus_supplier` VALUES ('3', '星空校车有限公司--add-by-swagger-online', '13400003333');

-- ----------------------------
-- Table structure for `device`
-- ----------------------------
DROP TABLE IF EXISTS `device`;
CREATE TABLE `device` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '设备名称',
  `meid` varchar(255) NOT NULL COMMENT 'MEID地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of device
-- ----------------------------
INSERT INTO `device` VALUES ('1', 'wxm', '111222');
INSERT INTO `device` VALUES ('2', 'ipad2', '222333');
INSERT INTO `device` VALUES ('3', 'ipad3', '3333aaa');

-- ----------------------------
-- Table structure for `messages`
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `send_time` datetime NOT NULL COMMENT '发布时间',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `publisher` varchar(255) NOT NULL COMMENT '发布人',
  `read_count` int(10) unsigned NOT NULL COMMENT '阅读次数',
  `content` text NOT NULL COMMENT '消息的内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of messages
-- ----------------------------

-- ----------------------------
-- Table structure for `night_line`
-- ----------------------------
DROP TABLE IF EXISTS `night_line`;
CREATE TABLE `night_line` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `line_number` varchar(255) NOT NULL COMMENT '线路号',
  `stations` text NOT NULL COMMENT '站点名称，JSON',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of night_line
-- ----------------------------

-- ----------------------------
-- Table structure for `picked_students_info`
-- ----------------------------
DROP TABLE IF EXISTS `picked_students_info`;
CREATE TABLE `picked_students_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transport_record_id` int(10) unsigned NOT NULL COMMENT 'transport_record的id，也可以据此查到线路信息，再进一步可以查到该学生是否乘坐该线路',
  `board_time` datetime NOT NULL COMMENT '上下车时间',
  `student_id` int(10) unsigned NOT NULL COMMENT '学生(用ID表示）',
  PRIMARY KEY (`id`),
  KEY `fk_student_id` (`student_id`),
  KEY `fk_transport_record_id` (`transport_record_id`),
  CONSTRAINT `fk_student_id` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`),
  CONSTRAINT `fk_transport_record_id` FOREIGN KEY (`transport_record_id`) REFERENCES `transport_record` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of picked_students_info
-- ----------------------------

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL,
  `role_des` varchar(255) DEFAULT NULL COMMENT '角色说明',
  `role_scope` text COMMENT '角色权限列表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '超级管理员', '全局管理', '');
INSERT INTO `role` VALUES ('2', '管理员', '管理', null);
INSERT INTO `role` VALUES ('3', '巴士妈妈', '巴士妈妈', null);
INSERT INTO `role` VALUES ('4', '班主任', '班主任', null);
INSERT INTO `role` VALUES ('5', '司机', '司机', null);

-- ----------------------------
-- Table structure for `student`
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `student_number` varchar(255) NOT NULL COMMENT '学号',
  `head_img` varchar(255) NOT NULL COMMENT '保存头像的URL',
  `name` varchar(255) NOT NULL COMMENT '姓名',
  `banji` int(10) unsigned NOT NULL COMMENT '班级,外键',
  `bus_line_morning` int(10) unsigned NOT NULL COMMENT '早班乘坐车的线路ID，外键',
  `bus_line_afternoon` int(10) unsigned NOT NULL COMMENT '午班乘坐车的线路ID，外键',
  `board_station_morning` int(10) unsigned NOT NULL COMMENT '上午班车上车站点',
  `board_station_afternoon` int(10) unsigned NOT NULL COMMENT '下午班车下车站点',
  `family_info` text NOT NULL COMMENT '家庭信息 JSON',
  PRIMARY KEY (`id`),
  KEY `fk_bus` (`bus_line_morning`),
  KEY `fk_banji` (`banji`),
  KEY `fk_board_station_morning` (`board_station_morning`),
  KEY `fk_board_station_afternoon` (`board_station_afternoon`),
  KEY `fk_bus_afternoon` (`bus_line_afternoon`),
  CONSTRAINT `fk_banji` FOREIGN KEY (`banji`) REFERENCES `banji` (`id`),
  CONSTRAINT `fk_board_station_afternoon` FOREIGN KEY (`board_station_afternoon`) REFERENCES `bus_stations` (`id`),
  CONSTRAINT `fk_board_station_morning` FOREIGN KEY (`board_station_morning`) REFERENCES `bus_stations` (`id`),
  CONSTRAINT `fk_bus_line_afternoon` FOREIGN KEY (`bus_line_afternoon`) REFERENCES `bus_line` (`id`),
  CONSTRAINT `fk_bus_line_morning` FOREIGN KEY (`bus_line_morning`) REFERENCES `bus_line` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of student
-- ----------------------------

-- ----------------------------
-- Table structure for `transport_range`
-- ----------------------------
DROP TABLE IF EXISTS `transport_range`;
CREATE TABLE `transport_range` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stations` text NOT NULL COMMENT '区间的站点名称，JSON\r\n\r\n[{"station_name": "AA路口"} ,\r\n{ "station_name": "BB口"},\r\n{ "station_name": "CC口"}\r\n]\r\n',
  `range_name` varchar(255) NOT NULL COMMENT '区间名字（通常是首尾站点名称）',
  `night_line_flag` varchar(255) NOT NULL COMMENT '”非晚班“、”晚班“， 用于指明是否晚班线路',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of transport_range
-- ----------------------------

-- ----------------------------
-- Table structure for `transport_record`
-- ----------------------------
DROP TABLE IF EXISTS `transport_record`;
CREATE TABLE `transport_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '接送信息',
  `date` date NOT NULL COMMENT '接送日期',
  `bus_line` int(10) unsigned NOT NULL COMMENT '校车线路，外键，',
  `current_station` int(10) unsigned DEFAULT NULL COMMENT '校车所处的当前站点',
  PRIMARY KEY (`id`),
  KEY `fk_tr_bus` (`bus_line`),
  KEY `fk_current_station` (`current_station`),
  CONSTRAINT `fk_bus_line` FOREIGN KEY (`bus_line`) REFERENCES `bus_line` (`id`),
  CONSTRAINT `fk_current_station` FOREIGN KEY (`current_station`) REFERENCES `bus_stations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of transport_record
-- ----------------------------

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(255) CHARACTER SET utf8 NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `wechatUnionId` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '微信unionId，在没授权前是空的。',
  `role_id` int(10) unsigned NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 NOT NULL,
  `head_image` varchar(255) DEFAULT NULL COMMENT '头像保存位置',
  `phone` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '电话',
  `create_time` datetime NOT NULL,
  `valid` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '是否在职 ， “1”:在职 “0”:离职',
  `msg_status_info` int(10) unsigned NOT NULL COMMENT '该用户的消息状态相关信息',
  PRIMARY KEY (`id`),
  KEY `fk_u_role_id` (`role_id`),
  KEY `fk-msg_status_info` (`msg_status_info`),
  CONSTRAINT `fk-msg_status_info` FOREIGN KEY (`msg_status_info`) REFERENCES `user_msg_status_info` (`id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'admin', 'wechat222', '1', '1', '', '13188888888', '2018-07-11 10:03:43', '1', '0');
INSERT INTO `user` VALUES ('2', 'busMom1', 'xiaozhang', null, '3', '1', null, '13588027825', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `user` VALUES ('3', 'busMom2', 'lily', null, '3', '1', null, '13033332222', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `user` VALUES ('4', 'bzr1', 'bzr_tom', null, '4', '1', null, '13600003333', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `user` VALUES ('5', 'bzr2', 'bzr_tim', null, '4', '1', null, '13600004444', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `user` VALUES ('6', 'bzr3', 'bzr_jack', null, '4', '1', null, '13033332211', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `user` VALUES ('7', 'bzr4', 'bzr_peter', null, '4', '1', null, '13622223333', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `user` VALUES ('8', 'sj1', 'sj_liusan', null, '5', '1', null, '13699990000', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `user` VALUES ('9', 'sj2', 'sj2_zhangsan', null, '5', '1', null, '13055550000', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `user` VALUES ('10', 'sj3', 'sj3_xiaowu', null, '5', '1', null, '13600022222', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `user` VALUES ('11', 'busMom3', 'busmm11', null, '3', '1', null, '13800009999', '0000-00-00 00:00:00', '1', '0');

-- ----------------------------
-- Table structure for `user_msg_status_info`
-- ----------------------------
DROP TABLE IF EXISTS `user_msg_status_info`;
CREATE TABLE `user_msg_status_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message_id` int(10) unsigned NOT NULL COMMENT '消息ID，',
  `status` varchar(255) NOT NULL COMMENT '消息状态，比如”未读“、“已读”、“删除"',
  PRIMARY KEY (`id`),
  KEY `fk_msg` (`message_id`),
  CONSTRAINT `fk_msg` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_msg_status_info
-- ----------------------------
