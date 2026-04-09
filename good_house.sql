/*
 Navicat Premium Data Transfer

 Source Server         : wxd
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3306
 Source Schema         : good_house

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 13/12/2022 12:39:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_area
-- ----------------------------
DROP TABLE IF EXISTS `t_area`;
CREATE TABLE `t_area`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_area
-- ----------------------------
INSERT INTO `t_area` VALUES (1, '00', '不限');
INSERT INTO `t_area` VALUES (2, '01', '50㎡以下');
INSERT INTO `t_area` VALUES (3, '02', '50-70㎡');
INSERT INTO `t_area` VALUES (4, '03', '70-90㎡');
INSERT INTO `t_area` VALUES (10, '04', '90-110㎡');
INSERT INTO `t_area` VALUES (11, '05', '110-130㎡');
INSERT INTO `t_area` VALUES (12, '06', '130-150㎡');
INSERT INTO `t_area` VALUES (13, '07', '150-200㎡');
INSERT INTO `t_area` VALUES (14, '08', '200㎡以上');

-- ----------------------------
-- Table structure for t_decoration
-- ----------------------------
DROP TABLE IF EXISTS `t_decoration`;
CREATE TABLE `t_decoration`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`, `title`) USING BTREE,
  INDEX `title`(`title`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_decoration
-- ----------------------------
INSERT INTO `t_decoration` VALUES (1, '00', '不限');
INSERT INTO `t_decoration` VALUES (2, '01', '毛坯');
INSERT INTO `t_decoration` VALUES (3, '02', '普装');
INSERT INTO `t_decoration` VALUES (4, '03', '精装');
INSERT INTO `t_decoration` VALUES (6, '04', '豪装');

-- ----------------------------
-- Table structure for t_direction
-- ----------------------------
DROP TABLE IF EXISTS `t_direction`;
CREATE TABLE `t_direction`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`, `title`) USING BTREE,
  INDEX `title`(`title`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_direction
-- ----------------------------
INSERT INTO `t_direction` VALUES (1, '00', '不限');
INSERT INTO `t_direction` VALUES (2, '01', '东');
INSERT INTO `t_direction` VALUES (3, '02', '南');
INSERT INTO `t_direction` VALUES (4, '03', '西');
INSERT INTO `t_direction` VALUES (5, '04', '北');
INSERT INTO `t_direction` VALUES (6, '05', '东南');
INSERT INTO `t_direction` VALUES (7, '06', '东北');
INSERT INTO `t_direction` VALUES (8, '07', '西北');
INSERT INTO `t_direction` VALUES (9, '08', '西南');
INSERT INTO `t_direction` VALUES (10, '09', '南北');
INSERT INTO `t_direction` VALUES (11, '10', '东西');

-- ----------------------------
-- Table structure for t_housebelong
-- ----------------------------
DROP TABLE IF EXISTS `t_housebelong`;
CREATE TABLE `t_housebelong`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`, `title`) USING BTREE,
  INDEX `title`(`title`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_housebelong
-- ----------------------------
INSERT INTO `t_housebelong` VALUES (1, '00', '不限');
INSERT INTO `t_housebelong` VALUES (2, '01', '九里象湖城');
INSERT INTO `t_housebelong` VALUES (3, '02', '城开国际学园');
INSERT INTO `t_housebelong` VALUES (4, '03', '朝阳小区');
INSERT INTO `t_housebelong` VALUES (5, '04', '广润门');
INSERT INTO `t_housebelong` VALUES (6, '05', '磨坊');
INSERT INTO `t_housebelong` VALUES (7, '06', '南方大道');
INSERT INTO `t_housebelong` VALUES (8, '07', '北方大道');
INSERT INTO `t_housebelong` VALUES (11, '08', '夜之城');
INSERT INTO `t_housebelong` VALUES (14, '9', 'Olympus');
INSERT INTO `t_housebelong` VALUES (16, '10', '江西财经大学');

-- ----------------------------
-- Table structure for t_houseinformation
-- ----------------------------
DROP TABLE IF EXISTS `t_houseinformation`;
CREATE TABLE `t_houseinformation`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `suiteRoom` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `suiteHall` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `suiteBathroom` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `area` decimal(10, 0) NULL DEFAULT NULL,
  `direction` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `floor` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `totalFloor` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `birth` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `housebelong` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `price` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `decoration` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `property` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `propertyrights` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `salesman` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `housestatus` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE,
  INDEX `t_houseinformation_ibfk_4`(`housestatus`) USING BTREE,
  INDEX `t_houseinformation_ibfk_1`(`housebelong`) USING BTREE,
  INDEX `t_houseinformation_ibfk_2`(`decoration`) USING BTREE,
  INDEX `t_houseinformation_ibfk_3`(`direction`) USING BTREE,
  INDEX `t_houseinformation_ibfk_5`(`property`) USING BTREE,
  INDEX `t_houseinformation_ibfk_6`(`propertyrights`) USING BTREE,
  CONSTRAINT `t_houseinformation_ibfk_1` FOREIGN KEY (`housebelong`) REFERENCES `t_housebelong` (`title`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `t_houseinformation_ibfk_2` FOREIGN KEY (`decoration`) REFERENCES `t_decoration` (`title`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `t_houseinformation_ibfk_3` FOREIGN KEY (`direction`) REFERENCES `t_direction` (`title`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `t_houseinformation_ibfk_4` FOREIGN KEY (`housestatus`) REFERENCES `t_housestatus` (`title`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `t_houseinformation_ibfk_5` FOREIGN KEY (`property`) REFERENCES `t_property` (`title`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `t_houseinformation_ibfk_6` FOREIGN KEY (`propertyrights`) REFERENCES `t_propertyrights` (`title`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_houseinformation
-- ----------------------------
INSERT INTO `t_houseinformation` VALUES (1, '2ae3cc6047d74324bfca0d17f2cbff65', '又又又降了万寿宫地铁口广润社区精装两室全大太阳冷包入住', '2', '3', '1', 82, '南北', '9', '22', '1998', 'Olympus', '80.00', '普装', '普通', '商品房住宅', 'admin', '未售');
INSERT INTO `t_houseinformation` VALUES (2, 'fc6d0c6ad3c249d08c8a4a41a963d258', '城升国际立能对简室开家电齐全东信', '1', '1', '1', 47, '南', '4', '11', '2010', '城开国际学园', '70.00', '普装', '普通', '商品房住宅', 'admin', '未售');
INSERT INTO `t_houseinformation` VALUES (3, '8a1bafa5e30349938301fcf4466f83b7', '四号线地铁口精装内房南北西道全大太H小区坏境好', '2', '2', '1', 41, '东南', '3', '6', '1999', '朝阳小区', '60.00', '精装', '平房', '商品房住宅', 'wxd', '未售');
INSERT INTO `t_houseinformation` VALUES (4, 'b5d436be849e46139d4610ccd1158df7', '南城世纪村绝杀房源商超就在旁边精装大二房即住', '3', '2', '2', 124, '东西', '21', '22', '2006', '朝阳小区', '120.00', '精装', '别墅', '商品房住宅', 'lisi', '未售');
INSERT INTO `t_houseinformation` VALUES (14, '09b4d29f4f024b33b20cd011fb92c32b', '风暴点磨坊，依山傍水，风景秀丽', '6', '2', '4', 110, '西北', '1', '1', '2021', '磨坊', '100.00', '毛坯', '别墅', '商品房住宅', 'zhangsan', '已售');
INSERT INTO `t_houseinformation` VALUES (25, 'c47ed80f27b24f70b9a4a02f4cd734b2', 'Command Center, with a host of beautiful armor', '4', '2', '4', 100, '东南', '1', '2', '2019', '夜之城', '90', '普装', '普通', '商品房住宅', '3witch', '未售');
INSERT INTO `t_houseinformation` VALUES (29, 'dfb58dc3d9604d57add398546dfb9afb', '我们向往的地方', '3', '1', '1', 50, '西北', '10', '32', '2005', '南方大道', '51', '普装', '普通', '商品房住宅', 'XXXTENT', '未售');

-- ----------------------------
-- Table structure for t_housephoto
-- ----------------------------
DROP TABLE IF EXISTS `t_housephoto`;
CREATE TABLE `t_housephoto`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `photocode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `location` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_housephoto
-- ----------------------------
INSERT INTO `t_housephoto` VALUES (40, '2ae3cc6047d74324bfca0d17f2cbff65', '631af3a529694d42b52b4d2824028b9c', '户型图', '户型图', '户型图12');
INSERT INTO `t_housephoto` VALUES (42, 'fc6d0c6ad3c249d08c8a4a41a963d258', '8ecd06d84f0d404d9dfe3a6418296b66', '厨房', '厨房', '宽敞的厨房');
INSERT INTO `t_housephoto` VALUES (44, 'c47ed80f27b24f70b9a4a02f4cd734b2', '597d00cf239f4360b96b841e7ac6a93f', '户型图', '户型图', '户型图12');
INSERT INTO `t_housephoto` VALUES (49, '2ae3cc6047d74324bfca0d17f2cbff65', '30ab0dcdfdfa4be0a94897c4e099f159', '卧室', '卧室', '大的卧室，光线好');
INSERT INTO `t_housephoto` VALUES (51, '2ae3cc6047d74324bfca0d17f2cbff65', '5aec776abd9e4a7fb4a4511ae490c9ea', '阳台', '阳台', '阳台，宽敞明亮');
INSERT INTO `t_housephoto` VALUES (52, '8a1bafa5e30349938301fcf4466f83b7', 'b17e22832abd438f9925b4f37929632d', '阳台', '阳台', '阳台，宽敞明亮');
INSERT INTO `t_housephoto` VALUES (53, '2ae3cc6047d74324bfca0d17f2cbff65', '41e6c0d1167e459f9123b785e926cf95', '存储间', '储藏间', '十分宽敞的存储间');

-- ----------------------------
-- Table structure for t_housestatus
-- ----------------------------
DROP TABLE IF EXISTS `t_housestatus`;
CREATE TABLE `t_housestatus`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`, `title`) USING BTREE,
  INDEX `title`(`title`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_housestatus
-- ----------------------------
INSERT INTO `t_housestatus` VALUES (1, '00', '不限');
INSERT INTO `t_housestatus` VALUES (2, '01', '未售');
INSERT INTO `t_housestatus` VALUES (3, '02', '已售');

-- ----------------------------
-- Table structure for t_img
-- ----------------------------
DROP TABLE IF EXISTS `t_img`;
CREATE TABLE `t_img`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `photocode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `savingfilename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `originalfilename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `contenttype` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `photocode`(`photocode`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_img
-- ----------------------------
INSERT INTO `t_img` VALUES (28, '631af3a529694d42b52b4d2824028b9c', 'D:\\JavaTools\\eclipse\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\WarmHouse\\WEB-INF\\savedFiles\\0078b1fd65f54fc88aa3e70a140aeef5.png', '0078b1fd65f54fc88aa3e70a140aeef5.png', 'image/png');
INSERT INTO `t_img` VALUES (30, '8ecd06d84f0d404d9dfe3a6418296b66', 'D:\\JavaTools\\eclipse\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\WarmHouse\\WEB-INF\\savedFiles\\89cf4b511fab4316a72e6af5bdcb69fd.png', '89cf4b511fab4316a72e6af5bdcb69fd.png', 'image/png');
INSERT INTO `t_img` VALUES (32, '597d00cf239f4360b96b841e7ac6a93f', 'D:\\JavaTools\\eclipse\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\WarmHouse\\WEB-INF\\savedFiles\\ee52ae0e8acd41f2ae6a3ec87a4ebce9.png', 'ee52ae0e8acd41f2ae6a3ec87a4ebce9.png', 'image/png');
INSERT INTO `t_img` VALUES (36, '30ab0dcdfdfa4be0a94897c4e099f159', 'D:\\JavaTools\\eclipse\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\WarmHouse\\WEB-INF\\savedFiles\\1bbe305f0c764fe582eeaa93df38a7be.png', '1bbe305f0c764fe582eeaa93df38a7be.png', 'image/png');
INSERT INTO `t_img` VALUES (37, '5aec776abd9e4a7fb4a4511ae490c9ea', 'D:\\JavaTools\\eclipse\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\WarmHouse\\WEB-INF\\savedFiles\\51a958991d91485f94b8a3e0ea0157b1.png', '51a958991d91485f94b8a3e0ea0157b1.png', 'image/png');
INSERT INTO `t_img` VALUES (38, 'b17e22832abd438f9925b4f37929632d', 'D:\\JavaTools\\eclipse\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\WarmHouse\\WEB-INF\\savedFiles\\db58c74488f44c19bdf3b57bc45b5afa.png', 'db58c74488f44c19bdf3b57bc45b5afa.png', 'image/png');
INSERT INTO `t_img` VALUES (45, '50b673838f624554b1e20ca4cb8d700c', 'D:\\JavaTools\\eclipse\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\WarmHouse\\WEB-INF\\savedFiles\\42a18ae4a804439786aa5ec90d167662.jpg', '42a18ae4a804439786aa5ec90d167662.jpg', 'image/jpeg');
INSERT INTO `t_img` VALUES (54, '72744faa96e642309bfac30f7bc4ee8b', 'D:\\JavaTools\\eclipse\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\WarmHouse\\WEB-INF\\savedFiles\\144ec70769354c4593756fa874f05d8c.png', '144ec70769354c4593756fa874f05d8c.png', 'image/png');

-- ----------------------------
-- Table structure for t_property
-- ----------------------------
DROP TABLE IF EXISTS `t_property`;
CREATE TABLE `t_property`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`, `title`) USING BTREE,
  INDEX `title`(`title`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_property
-- ----------------------------
INSERT INTO `t_property` VALUES (1, '00', '不限');
INSERT INTO `t_property` VALUES (2, '01', '普通');
INSERT INTO `t_property` VALUES (3, '02', '别墅');
INSERT INTO `t_property` VALUES (4, '03', '平房');

-- ----------------------------
-- Table structure for t_propertyrights
-- ----------------------------
DROP TABLE IF EXISTS `t_propertyrights`;
CREATE TABLE `t_propertyrights`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`, `title`) USING BTREE,
  INDEX `title`(`title`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_propertyrights
-- ----------------------------
INSERT INTO `t_propertyrights` VALUES (1, '00', '不限');
INSERT INTO `t_propertyrights` VALUES (2, '01', '商品房住宅');
INSERT INTO `t_propertyrights` VALUES (3, '02', '商住两用');
INSERT INTO `t_propertyrights` VALUES (4, '03', '积极适用房');
INSERT INTO `t_propertyrights` VALUES (5, '04', '公房');

-- ----------------------------
-- Table structure for t_showhouse
-- ----------------------------
DROP TABLE IF EXISTS `t_showhouse`;
CREATE TABLE `t_showhouse`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_showhouse
-- ----------------------------
INSERT INTO `t_showhouse` VALUES (1, '00', '不限');
INSERT INTO `t_showhouse` VALUES (2, '01', '客厅');
INSERT INTO `t_showhouse` VALUES (3, '02', '卧室');
INSERT INTO `t_showhouse` VALUES (4, '03', '卫生间');
INSERT INTO `t_showhouse` VALUES (5, '04', '阳台');
INSERT INTO `t_showhouse` VALUES (6, '05', '厨房');
INSERT INTO `t_showhouse` VALUES (7, '06', '储藏间');
INSERT INTO `t_showhouse` VALUES (8, '07', '户型图');

-- ----------------------------
-- Table structure for t_suite
-- ----------------------------
DROP TABLE IF EXISTS `t_suite`;
CREATE TABLE `t_suite`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_suite
-- ----------------------------
INSERT INTO `t_suite` VALUES (1, '00', '不限');
INSERT INTO `t_suite` VALUES (2, '01', '一室');
INSERT INTO `t_suite` VALUES (3, '02', '二室');
INSERT INTO `t_suite` VALUES (4, '03', '三室');
INSERT INTO `t_suite` VALUES (5, '04', '四室');
INSERT INTO `t_suite` VALUES (6, '05', '五室');

-- ----------------------------
-- Table structure for t_sysrole
-- ----------------------------
DROP TABLE IF EXISTS `t_sysrole`;
CREATE TABLE `t_sysrole`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sysrole
-- ----------------------------
INSERT INTO `t_sysrole` VALUES (1, '01', '普通用户');
INSERT INTO `t_sysrole` VALUES (2, '02', '管理员');
INSERT INTO `t_sysrole` VALUES (3, '03', '系统管理员');
INSERT INTO `t_sysrole` VALUES (4, '00', '所有');

-- ----------------------------
-- Table structure for t_systable
-- ----------------------------
DROP TABLE IF EXISTS `t_systable`;
CREATE TABLE `t_systable`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tableName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tableTitle` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_systable
-- ----------------------------
INSERT INTO `t_systable` VALUES (1, '00', '面积分类', 't_area');
INSERT INTO `t_systable` VALUES (2, '01', '装修分类', 't_decoration');
INSERT INTO `t_systable` VALUES (3, '02', '物业分类', 't_property');
INSERT INTO `t_systable` VALUES (4, '03', '套间分类', 't_suite');
INSERT INTO `t_systable` VALUES (5, '04', '朝向分类', 't_direction');
INSERT INTO `t_systable` VALUES (6, '05', '展示位置', 't_showhouse');
INSERT INTO `t_systable` VALUES (7, '06', '产权分类', 't_propertyrights');
INSERT INTO `t_systable` VALUES (8, '07', '所属楼盘', 't_housebelong');
INSERT INTO `t_systable` VALUES (9, '08', '角色分类', 't_sysrole');
INSERT INTO `t_systable` VALUES (10, '09', '房屋状态', 't_housestatus');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (19, 'XXXTENT', 'xxxtenaction', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', '18970557344', NULL);
INSERT INTO `t_user` VALUES (20, 'wxd', '王晓东1', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '18970557344', NULL);
INSERT INTO `t_user` VALUES (21, 'admin', 'admin11', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '15970431447', '1924118115@qq.com');
INSERT INTO `t_user` VALUES (26, 'XXXTENT1', '张三', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '15970431447', NULL);
INSERT INTO `t_user` VALUES (33, 'Luxury9700', '王晓东', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', '15970431447', NULL);
INSERT INTO `t_user` VALUES (34, 'dyl', 'duyaliang', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '15970431447', NULL);
INSERT INTO `t_user` VALUES (36, 'lmm', 'maomao', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', '18970557344', NULL);
INSERT INTO `t_user` VALUES (37, 'zhangsan', 'admin', '9adcb29710e807607b683f62e555c22dc5659713', '123', NULL);
INSERT INTO `t_user` VALUES (38, 'lisi', '李四123', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '8208208820', NULL);
INSERT INTO `t_user` VALUES (39, 'wangwu', '王五', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', '18970557344', NULL);
INSERT INTO `t_user` VALUES (55, 'normal', '洪七公', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '18970557344', NULL);
INSERT INTO `t_user` VALUES (56, 'user1', '张无忌', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '15970431447', NULL);
INSERT INTO `t_user` VALUES (57, 'user2', '周芷若', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '1924118115', NULL);
INSERT INTO `t_user` VALUES (59, 'kuku', 'sweetKuKu', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '18970557344', NULL);
INSERT INTO `t_user` VALUES (60, '3witch', '张三', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '18970557344', NULL);
INSERT INTO `t_user` VALUES (61, 'pite', '张三', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '18970557344', NULL);
INSERT INTO `t_user` VALUES (62, '1900', 'pioneer', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '15970431447', NULL);
INSERT INTO `t_user` VALUES (63, '100emperor', 'EMP', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '18970557344', '1924118115@qq.com');
INSERT INTO `t_user` VALUES (64, 'admin123', 'admin123', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '18970557344', '2202004414@stu.jxufe.edu.cn');

-- ----------------------------
-- Table structure for t_userheadimg
-- ----------------------------
DROP TABLE IF EXISTS `t_userheadimg`;
CREATE TABLE `t_userheadimg`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `photocode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_userheadimg
-- ----------------------------
INSERT INTO `t_userheadimg` VALUES (19, 'admin', '72744faa96e642309bfac30f7bc4ee8b');

-- ----------------------------
-- Table structure for t_userrole
-- ----------------------------
DROP TABLE IF EXISTS `t_userrole`;
CREATE TABLE `t_userrole`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_userrole
-- ----------------------------
INSERT INTO `t_userrole` VALUES (1, 'XXXTENT', 'xxxtenaction', '所有');
INSERT INTO `t_userrole` VALUES (3, 'admin', 'admin01', '所有');
INSERT INTO `t_userrole` VALUES (5, 'XXXTENT1', '张三', '系统管理员');
INSERT INTO `t_userrole` VALUES (7, 'Luxury9700', '王晓东', '普通用户');
INSERT INTO `t_userrole` VALUES (10, 'dyl', '杜雅亮', '普通用户');
INSERT INTO `t_userrole` VALUES (12, 'lmm', '李毛毛02', '普通用户');
INSERT INTO `t_userrole` VALUES (13, 'zhangsan', 'admin', '普通用户');
INSERT INTO `t_userrole` VALUES (14, 'lisi', '李四', '普通用户');
INSERT INTO `t_userrole` VALUES (23, 'normal', '洪七公', '系统管理员');
INSERT INTO `t_userrole` VALUES (24, 'user1', '张无忌', '普通用户');
INSERT INTO `t_userrole` VALUES (25, 'user2', '周芷若', '普通用户');
INSERT INTO `t_userrole` VALUES (29, '3witch', '张三', '普通用户');
INSERT INTO `t_userrole` VALUES (30, 'pite', '张三', '普通用户');
INSERT INTO `t_userrole` VALUES (31, '1900', 'pioneer', '普通用户');
INSERT INTO `t_userrole` VALUES (34, '100emperor', 'EMP', '普通用户');
INSERT INTO `t_userrole` VALUES (35, 'admin123', 'admin123', '普通用户');
INSERT INTO `t_userrole` VALUES (38, 'wangwu', '王五', '普通用户');
INSERT INTO `t_userrole` VALUES (39, 'wangwu', '王五', '管理员');
INSERT INTO `t_userrole` VALUES (40, 'wangwu', '王五', '系统管理员');

SET FOREIGN_KEY_CHECKS = 1;
