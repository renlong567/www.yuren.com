/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50612
Source Host           : localhost:3306
Source Database       : yuren

Target Server Type    : MYSQL
Target Server Version : 50612
File Encoding         : 65001

Date: 2015-07-01 23:50:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `qinggan_address`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_address`;
CREATE TABLE `qinggan_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `country` varchar(255) NOT NULL COMMENT '国家',
  `province` varchar(255) NOT NULL COMMENT '省信息',
  `city` varchar(255) NOT NULL COMMENT '市',
  `county` varchar(255) NOT NULL COMMENT '县',
  `address` varchar(255) NOT NULL COMMENT '地址信息（不含国家，省市县镇区信息）',
  `zipcode` varchar(20) NOT NULL COMMENT '邮编',
  `type_id` enum('shipping','billing') NOT NULL DEFAULT 'shipping' COMMENT '类型，默认走送货地址',
  `mobile` varchar(100) NOT NULL COMMENT '手机号码',
  `tel` varchar(100) NOT NULL COMMENT '电话号码',
  `email` varchar(100) NOT NULL COMMENT '邮箱',
  `fullname` varchar(100) NOT NULL COMMENT '联系人姓名',
  `is_default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0普通，1默认填写',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0女1男',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='会员地址库';

-- ----------------------------
-- Records of qinggan_address
-- ----------------------------

-- ----------------------------
-- Table structure for `qinggan_adm`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_adm`;
CREATE TABLE `qinggan_adm` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID，系统自增',
  `account` varchar(50) NOT NULL COMMENT '管理员账号',
  `pass` varchar(100) NOT NULL COMMENT '管理员密码',
  `email` varchar(50) NOT NULL COMMENT '管理员邮箱',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0未审核1正常2管理员锁定',
  `if_system` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '系统管理员',
  `vpass` varchar(50) NOT NULL COMMENT '二次验证密码，两次MD5加密',
  `category` longtext NOT NULL COMMENT '可操作的分类ID，系统管理员无效',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员信息';

-- ----------------------------
-- Records of qinggan_adm
-- ----------------------------
INSERT INTO `qinggan_adm` VALUES ('1', 'admin', 'ac39b51ea0e551c3f3c58f5a4c8c8e0c:16', '51109638@qq.com', '1', '1', '', '');

-- ----------------------------
-- Table structure for `qinggan_adm_popedom`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_adm_popedom`;
CREATE TABLE `qinggan_adm_popedom` (
  `id` int(10) unsigned NOT NULL COMMENT '管理员ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '权限ID，对应popedom表里的id',
  PRIMARY KEY (`id`,`pid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员权限分配表';

-- ----------------------------
-- Records of qinggan_adm_popedom
-- ----------------------------

-- ----------------------------
-- Table structure for `qinggan_all`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_all`;
CREATE TABLE `qinggan_all` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `site_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '网站ID',
  `identifier` varchar(100) NOT NULL COMMENT '标识串',
  `title` varchar(200) NOT NULL COMMENT '分类名称',
  `ico` varchar(255) NOT NULL COMMENT '图标',
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0普通１系统',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='分类管理';

-- ----------------------------
-- Records of qinggan_all
-- ----------------------------
INSERT INTO `qinggan_all` VALUES ('4', '1', 'copyright', '页脚版权', 'images/ico/copyright.png', '0');
INSERT INTO `qinggan_all` VALUES ('9', '1', 'contactus', '联系方式', 'images/ico/email2.png', '0');
INSERT INTO `qinggan_all` VALUES ('37', '1', 'share', '分享代码', 'images/ico/share.png', '0');

-- ----------------------------
-- Table structure for `qinggan_cart`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_cart`;
CREATE TABLE `qinggan_cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `session_id` varchar(255) NOT NULL COMMENT 'SESSION_ID号',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID号，为0表示游客',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='购物车';

-- ----------------------------
-- Records of qinggan_cart
-- ----------------------------
INSERT INTO `qinggan_cart` VALUES ('1', '5jbhaha6vim2g6mti3ifronfd5', '0', '1434334988');
INSERT INTO `qinggan_cart` VALUES ('2', 'gdnbtu02qvkn5gk9vvhvqct694', '0', '1434420159');
INSERT INTO `qinggan_cart` VALUES ('3', '8t5vpudlii4ab036mapbn1b3t2', '0', '1434507401');
INSERT INTO `qinggan_cart` VALUES ('4', 'duh34bq06e62hsvf5s8tomqc95', '0', '1434522996');
INSERT INTO `qinggan_cart` VALUES ('5', 'b9s9jnvnuj0rue6co973kfpqa1', '0', '1434767611');

-- ----------------------------
-- Table structure for `qinggan_cart_product`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_cart_product`;
CREATE TABLE `qinggan_cart_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `cart_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购物车ID号',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主题ID',
  `title` varchar(255) NOT NULL COMMENT '产品名称',
  `price` float NOT NULL COMMENT '产品单价',
  `qty` int(11) NOT NULL DEFAULT '0' COMMENT '产品数量',
  `ext` text NOT NULL COMMENT '扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='购物车里的产品信息';

-- ----------------------------
-- Records of qinggan_cart_product
-- ----------------------------

-- ----------------------------
-- Table structure for `qinggan_cate`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_cate`;
CREATE TABLE `qinggan_cate` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `site_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '网站ID',
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '父级ID，0为根分类',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0不使用1正常使用',
  `title` varchar(200) NOT NULL COMMENT '分类名称',
  `taxis` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '分类排序，值越小越往前靠',
  `tpl_list` varchar(255) NOT NULL COMMENT '列表模板',
  `tpl_content` varchar(255) NOT NULL COMMENT '内容模板',
  `psize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '列表每页数量',
  `seo_title` varchar(255) NOT NULL COMMENT 'SEO标题',
  `seo_keywords` varchar(255) NOT NULL COMMENT 'SEO关键字',
  `seo_desc` varchar(255) NOT NULL COMMENT 'SEO描述',
  `identifier` varchar(255) NOT NULL COMMENT '分类标识串',
  `tag` varchar(255) NOT NULL COMMENT '自身Tag设置',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `site_id` (`site_id`,`status`)
) ENGINE=MyISAM AUTO_INCREMENT=226 DEFAULT CHARSET=utf8 COMMENT='分类管理';

-- ----------------------------
-- Records of qinggan_cate
-- ----------------------------
INSERT INTO `qinggan_cate` VALUES ('8', '1', '7', '1', '学校新闻', '10', '', '', '0', '', '', '', 'xuexiaoxinwen', '公司 新闻');
INSERT INTO `qinggan_cate` VALUES ('7', '1', '0', '1', '新闻资讯', '10', '', '', '0', '', '', '', 'information', '');
INSERT INTO `qinggan_cate` VALUES ('220', '1', '0', '1', '最新动态', '255', '', '', '0', '', '', '', 'zxdt', '');
INSERT INTO `qinggan_cate` VALUES ('223', '1', '0', '1', '热点新闻', '255', '', '', '0', '', '', '', 'rdxw', '');
INSERT INTO `qinggan_cate` VALUES ('224', '1', '7', '1', '行业新闻', '255', '', '', '0', '', '', '', 'xingyexinwen', '');
INSERT INTO `qinggan_cate` VALUES ('225', '1', '7', '1', '常见问题', '255', '', '', '0', '', '', '', 'changjianwenti', '');

-- ----------------------------
-- Table structure for `qinggan_currency`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_currency`;
CREATE TABLE `qinggan_currency` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '货币ID',
  `code` varchar(3) NOT NULL COMMENT '货币标识，仅限三位数的大写字母',
  `val` float(13,8) unsigned NOT NULL COMMENT '货币转化',
  `taxis` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序，值越小越往前靠',
  `title` varchar(50) NOT NULL COMMENT '名称',
  `symbol_left` varchar(24) NOT NULL COMMENT '价格左侧',
  `symbol_right` varchar(24) NOT NULL COMMENT '价格右侧',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0不使用1使用',
  `hidden` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0不隐藏1隐藏',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='货币管理';

-- ----------------------------
-- Records of qinggan_currency
-- ----------------------------
INSERT INTO `qinggan_currency` VALUES ('1', 'CNY', '6.16989994', '10', '人民币', '￥', '', '1', '0');
INSERT INTO `qinggan_currency` VALUES ('2', 'USD', '1.00000000', '20', '美金', 'US$', '', '1', '0');
INSERT INTO `qinggan_currency` VALUES ('3', 'HKD', '7.76350021', '30', '港元', 'HK$', '', '1', '0');
INSERT INTO `qinggan_currency` VALUES ('4', 'EUR', '0.76639998', '40', '欧元', 'EUR', '', '1', '0');
INSERT INTO `qinggan_currency` VALUES ('5', 'GBP', '0.64529997', '50', '英镑', '￡', '', '1', '0');

-- ----------------------------
-- Table structure for `qinggan_email`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_email`;
CREATE TABLE `qinggan_email` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `site_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '网站ID，0表示全部网站',
  `identifier` varchar(255) NOT NULL COMMENT '发送标识',
  `title` varchar(200) NOT NULL COMMENT '邮件主题',
  `content` text NOT NULL COMMENT '邮件内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='邮件内容';

-- ----------------------------
-- Records of qinggan_email
-- ----------------------------
INSERT INTO `qinggan_email` VALUES ('4', '1', 'register_code', '获取会员注册资格', '<p>您好，{$email}</p><p>您将注册成为网站【{$config.title} 】会员，请点击下面的地址，进入下一步注册：</p><p><br/></p><blockquote style=\"margin: 0 0 0 40px; border: none; padding: 0px;\"><p><a href=\"{$link}\" target=\"_blank\">{$link}</a></p><p>（此链接24小时内有效）</p></blockquote><p><br/></p><p><br/></p><p>感谢您对本站的关注，茫茫人海中，能有缘走到一起。</p>');
INSERT INTO `qinggan_email` VALUES ('5', '1', 'getpass', '取回密码操作', '<p>您好，{$user.account}</p><p>您执行了忘记密码操作功能，请点击下面的链接执行下一步：</p><p><br /></p><p><blockquote style=\"margin: 0 0 0 40px; border: none; padding: 0px;\"><p><a href=\"{$link}\" target=\"_blank\">{$link}</a></p></blockquote><br /></p><p>感谢您对本站的支持，有什么问题您在登录后可以咨询我们的客服。</p>');
INSERT INTO `qinggan_email` VALUES ('6', '1', 'project_save', '主题添加通知', '<p>您好，管理员</p><blockquote><p>您的网站（<a href=\"http://{$sys.url}\" target=\"_self\">{$sys.url}</a>）新增了一篇主题，下述是主题的基本信息：<br/></p><p>主题名称：{$rs.title}</p><p>项目类型：{$page_rs.title}</p><p><br/></p><p>请登录网站查询</p></blockquote>');
INSERT INTO `qinggan_email` VALUES ('7', '1', 'order_admin', '网站收到一个新的订单，订单号是：{$order.sn}', '<p>您好，管理员</p><blockquote><p>您的网站：{$sys.url} 收到一份新的订单，订单号是：{$order.sn}</p><p><br/></p><p>请登录网站后台进行核验</p></blockquote>');

-- ----------------------------
-- Table structure for `qinggan_ext`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_ext`;
CREATE TABLE `qinggan_ext` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '字段ID，自增',
  `module` varchar(100) NOT NULL COMMENT '模块',
  `title` varchar(255) NOT NULL COMMENT '字段名称',
  `identifier` varchar(50) NOT NULL COMMENT '字段标识串',
  `field_type` varchar(255) NOT NULL DEFAULT '200' COMMENT '字段存储类型',
  `note` varchar(255) NOT NULL COMMENT '字段内容备注',
  `form_type` varchar(100) NOT NULL COMMENT '表单类型',
  `form_style` varchar(255) NOT NULL COMMENT '表单CSS',
  `format` varchar(100) NOT NULL COMMENT '格式化方式',
  `content` text NOT NULL COMMENT '默认值',
  `taxis` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  `ext` text NOT NULL COMMENT '扩展内容',
  PRIMARY KEY (`id`),
  KEY `module` (`module`)
) ENGINE=MyISAM AUTO_INCREMENT=277 DEFAULT CHARSET=utf8 COMMENT='字段管理器';

-- ----------------------------
-- Records of qinggan_ext
-- ----------------------------
INSERT INTO `qinggan_ext` VALUES ('35', 'all-4', '内容', 'content', 'longtext', '', 'code_editor', '', 'html_js', '', '90', 'a:2:{s:5:\"width\";s:3:\"700\";s:6:\"height\";s:3:\"200\";}');
INSERT INTO `qinggan_ext` VALUES ('59', 'all-9', '联系人', 'fullname', 'varchar', '填写联系人姓名', 'text', '', 'safe', '', '10', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"300\";}');
INSERT INTO `qinggan_ext` VALUES ('61', 'all-9', '邮箱', 'email', 'varchar', '', 'text', '', 'safe', '', '50', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";b:0;}');
INSERT INTO `qinggan_ext` VALUES ('62', 'all-9', '联系地址', 'address', 'varchar', '', 'text', '', 'safe', '', '20', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"500\";}');
INSERT INTO `qinggan_ext` VALUES ('63', 'all-9', '联系电话', 'tel', 'varchar', '', 'text', '', 'safe', '', '40', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"300\";}');
INSERT INTO `qinggan_ext` VALUES ('66', 'all-9', '邮编', 'zipcode', 'varchar', '请填写六位数字的邮编号码', 'text', '', 'safe', '', '30', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"300\";}');
INSERT INTO `qinggan_ext` VALUES ('161', 'project-90', '内容', 'content', 'longtext', '', 'editor', '', 'html_js', '', '255', 'a:12:{s:5:\"width\";s:3:\"900\";s:6:\"height\";s:3:\"360\";s:7:\"is_code\";s:0:\"\";s:9:\"btn_image\";s:1:\"1\";s:9:\"btn_video\";s:1:\"1\";s:8:\"btn_file\";s:1:\"1\";s:8:\"btn_page\";s:0:\"\";s:8:\"btn_info\";s:0:\"\";s:7:\"is_read\";s:0:\"\";s:5:\"etype\";s:4:\"full\";s:7:\"btn_map\";s:0:\"\";s:7:\"inc_tag\";s:1:\"1\";}');
INSERT INTO `qinggan_ext` VALUES ('165', 'project-92', '内容', 'content', 'longtext', '', 'editor', '', 'html_js', '', '255', 'a:12:{s:5:\"width\";s:3:\"900\";s:6:\"height\";s:3:\"360\";s:7:\"is_code\";s:0:\"\";s:9:\"btn_image\";s:1:\"1\";s:9:\"btn_video\";s:1:\"1\";s:8:\"btn_file\";s:1:\"1\";s:8:\"btn_page\";s:0:\"\";s:8:\"btn_info\";s:0:\"\";s:7:\"is_read\";s:0:\"\";s:5:\"etype\";s:4:\"full\";s:7:\"btn_map\";s:0:\"\";s:7:\"inc_tag\";s:0:\"\";}');
INSERT INTO `qinggan_ext` VALUES ('228', 'project-93', '内容', 'content', 'longtext', '', 'editor', '', 'html', '', '255', 'a:12:{s:5:\"width\";s:3:\"900\";s:6:\"height\";s:3:\"360\";s:7:\"is_code\";s:0:\"\";s:9:\"btn_image\";s:1:\"1\";s:9:\"btn_video\";s:1:\"1\";s:8:\"btn_file\";s:1:\"1\";s:8:\"btn_page\";s:0:\"\";s:8:\"btn_info\";s:0:\"\";s:7:\"is_read\";s:0:\"\";s:5:\"etype\";s:4:\"full\";s:7:\"btn_map\";s:0:\"\";s:7:\"inc_tag\";s:0:\"\";}');
INSERT INTO `qinggan_ext` VALUES ('227', 'project-87', '通栏图片', 'banner', 'varchar', '', 'upload', '', 'safe', '', '40', 'a:3:{s:11:\"upload_type\";s:7:\"picture\";s:7:\"cate_id\";s:1:\"1\";s:11:\"is_multiple\";s:1:\"0\";}');
INSERT INTO `qinggan_ext` VALUES ('212', 'cate-160', '性别', 'gender', 'varchar', '', 'radio', '', 'safe', '女', '120', '');
INSERT INTO `qinggan_ext` VALUES ('213', 'project-146', '内容', 'content', 'longtext', '', 'editor', '', 'html', '', '255', 'a:12:{s:5:\"width\";s:3:\"900\";s:6:\"height\";s:3:\"360\";s:7:\"is_code\";s:0:\"\";s:9:\"btn_image\";s:1:\"1\";s:9:\"btn_video\";s:1:\"1\";s:8:\"btn_file\";s:1:\"1\";s:8:\"btn_page\";s:0:\"\";s:8:\"btn_info\";s:0:\"\";s:7:\"is_read\";s:0:\"\";s:5:\"etype\";s:4:\"full\";s:7:\"btn_map\";s:0:\"\";s:7:\"inc_tag\";s:0:\"\";}');
INSERT INTO `qinggan_ext` VALUES ('218', 'project-43', '英文标题En-Title', 'entitle', 'varchar', '', 'text', '', 'safe', '', '10', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"500\";}');
INSERT INTO `qinggan_ext` VALUES ('219', 'project-43', '通栏图片', 'banner', 'varchar', '', 'upload', '', 'safe', '', '40', 'a:3:{s:11:\"upload_type\";s:7:\"picture\";s:7:\"cate_id\";s:1:\"1\";s:11:\"is_multiple\";s:1:\"0\";}');
INSERT INTO `qinggan_ext` VALUES ('220', 'all-9', '公司名称', 'company', 'varchar', '', 'text', '', 'safe', '', '10', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"500\";}');
INSERT INTO `qinggan_ext` VALUES ('222', 'project-149', '英文标题', 'entitle', 'varchar', '放在首页的公司简介的英文小标题', 'text', '', 'safe', '', '30', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"500\";}');
INSERT INTO `qinggan_ext` VALUES ('223', 'project-149', '小标题', 'subtitle', 'varchar', '这里是放在首页的小标题信息，如公司简介', 'text', '', 'safe', '', '20', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"300\";}');
INSERT INTO `qinggan_ext` VALUES ('224', 'project-149', '摘要', 'note', 'longtext', '简要文字描述', 'editor', '', 'html', '', '40', 'a:12:{s:5:\"width\";s:3:\"700\";s:6:\"height\";s:3:\"140\";s:7:\"is_code\";b:0;s:9:\"btn_image\";s:1:\"1\";s:9:\"btn_video\";b:0;s:8:\"btn_file\";b:0;s:8:\"btn_page\";b:0;s:8:\"btn_info\";b:0;s:7:\"is_read\";b:0;s:5:\"etype\";s:6:\"simple\";s:7:\"btn_tpl\";b:0;s:7:\"btn_map\";b:0;}');
INSERT INTO `qinggan_ext` VALUES ('225', 'project-149', '图片', 'pic', 'varchar', '', 'text', '', 'safe', '', '255', 'a:2:{s:8:\"form_btn\";s:5:\"image\";s:5:\"width\";s:3:\"500\";}');
INSERT INTO `qinggan_ext` VALUES ('226', 'project-149', '更多的链接地址', 'link', 'longtext', '请填写公司简介的链接地址', 'url', '', 'safe', '', '90', 'a:1:{s:5:\"width\";s:3:\"500\";}');
INSERT INTO `qinggan_ext` VALUES ('231', 'all-37', '百度分享代码', 'baidu', 'longtext', '', 'code_editor', '', 'html_js', '', '10', 'a:2:{s:5:\"width\";s:3:\"800\";s:6:\"height\";s:3:\"300\";}');
INSERT INTO `qinggan_ext` VALUES ('232', 'cate-195', '链接', 'link', 'longtext', '手动指定外部链接时，伪静态链接可以留空', 'url', '', 'safe', '', '90', '');
INSERT INTO `qinggan_ext` VALUES ('233', 'cate-195', '链接方式', 'target', 'varchar', '设置是否在新窗口打开', 'radio', '', 'safe', '_self', '100', 'a:1:{s:11:\"option_list\";s:5:\"opt:6\";}');
INSERT INTO `qinggan_ext` VALUES ('234', 'cate-196', '链接', 'link', 'longtext', '手动指定外部链接时，伪静态链接可以留空', 'url', '', 'safe', '', '90', '');
INSERT INTO `qinggan_ext` VALUES ('235', 'cate-196', '链接方式', 'target', 'varchar', '设置是否在新窗口打开', 'radio', '', 'safe', '_self', '100', 'a:1:{s:11:\"option_list\";s:5:\"opt:6\";}');
INSERT INTO `qinggan_ext` VALUES ('238', 'cate-204', '摘要', 'note', 'longtext', '简要文字描述', 'textarea', '', 'safe', '', '20', 'a:2:{s:5:\"width\";s:3:\"600\";s:6:\"height\";s:2:\"80\";}');
INSERT INTO `qinggan_ext` VALUES ('240', 'cate-205', '摘要', 'note', 'longtext', '简要文字描述', 'textarea', '', 'safe', '', '20', 'a:2:{s:5:\"width\";s:3:\"600\";s:6:\"height\";s:2:\"80\";}');
INSERT INTO `qinggan_ext` VALUES ('241', 'cate-206', '摘要', 'note', 'longtext', '简要文字描述', 'textarea', '', 'safe', '', '20', 'a:2:{s:5:\"width\";s:3:\"600\";s:6:\"height\";s:2:\"80\";}');
INSERT INTO `qinggan_ext` VALUES ('246', 'project-142', '英文标题', 'entitle', 'varchar', '设置与主题名称相对应的英文标题', 'text', '', 'safe', '', '255', 'a:4:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"500\";s:15:\"ext_quick_words\";b:0;s:14:\"ext_quick_type\";b:0;}');
INSERT INTO `qinggan_ext` VALUES ('259', 'cate-207', '摘要', 'note', 'longtext', '简要文字描述', 'textarea', '', 'safe', '', '20', 'a:2:{s:5:\"width\";s:3:\"600\";s:6:\"height\";s:2:\"80\";}');
INSERT INTO `qinggan_ext` VALUES ('260', 'cate-208', '摘要', 'note', 'longtext', '简要文字描述', 'textarea', '', 'safe', '', '20', '');
INSERT INTO `qinggan_ext` VALUES ('263', 'cate-210', '摘要', 'note', 'longtext', '简要文字描述', 'textarea', '', 'safe', '', '20', 'a:2:{s:5:\"width\";s:3:\"600\";s:6:\"height\";s:2:\"80\";}');
INSERT INTO `qinggan_ext` VALUES ('272', 'cate-221', '链接', 'link', 'longtext', '手动指定外部链接时，伪静态链接可以留空', 'url', '', 'safe', '', '90', 'a:1:{s:5:\"width\";s:3:\"500\";}');
INSERT INTO `qinggan_ext` VALUES ('273', 'cate-222', '链接', 'link', 'longtext', '手动指定外部链接时，伪静态链接可以留空', 'url', '', 'safe', '', '90', 'a:1:{s:5:\"width\";s:3:\"500\";}');

-- ----------------------------
-- Table structure for `qinggan_extc`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_extc`;
CREATE TABLE `qinggan_extc` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '内容值ID，对应ext表中的id',
  `content` longtext NOT NULL COMMENT '内容文本',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='扩展字段内容维护';

-- ----------------------------
-- Records of qinggan_extc
-- ----------------------------
INSERT INTO `qinggan_extc` VALUES ('35', 'Copyright © 2015 郑州育人国际学校 All Rights Reserved');
INSERT INTO `qinggan_extc` VALUES ('59', 'XXX老师');
INSERT INTO `qinggan_extc` VALUES ('61', 'admin@domain.com');
INSERT INTO `qinggan_extc` VALUES ('62', '河南省郑州市经开区第五大街经北五路');
INSERT INTO `qinggan_extc` VALUES ('63', '158185XXXXX');
INSERT INTO `qinggan_extc` VALUES ('66', '450000');
INSERT INTO `qinggan_extc` VALUES ('161', '<p>PHPOK企业建站系统（下述将用“系统”简称）是一套致力于企业网通用配置平台应用。公司长期专注于微小型企业网络化的研发和经营，拥有八年多的企业建站经验。系统广泛应用于全国多个省市，涉及行业包括保险、服装、电器、化工、物流、房地产、旅游、贸易、珠宝、WAP等行业。 <br/> <br/>公司一贯坚持以“专业是基础，服务是保证，质量是信誉”的理念，来适应和满足客户不断增长的业务需求，提供有竞争力的、可持续发展的产品和技术解决方案。 </p>');
INSERT INTO `qinggan_extc` VALUES ('165', '<p>公司网站：www.phpok.com</p><p>联系地址：深圳市罗湖区东盛路辐照中心7栋3楼</p><p>联系电话：15818533971</p><p><br /></p><p>如何到达：<br />地铁环中线——布心站”下车B出口直走,第一个红绿灯也就是太白路，往右走一直沿着太白路走直到看到左侧有一东盛路，沿着东盛路左侧第一栋就是辐照中心。地铁步行到公司大约15分钟。周围标志性建筑：金威啤酒厂。<br /><br />途径附近公交：<br />乘坐107路，203路，212路，24路，2路，379路，40路，59路，62路，83路，<br />B698路单向行驶，N2路，N6路，到松泉公寓下车。<br /></p>');
INSERT INTO `qinggan_extc` VALUES ('228', '<p>这里是内容说明！</p>');
INSERT INTO `qinggan_extc` VALUES ('227', '543');
INSERT INTO `qinggan_extc` VALUES ('213', '<table><tbody><tr class=\"firstRow\"><td width=\"117\" valign=\"top\" style=\"word-break: break-all;\"><span style=\"color: rgb(192, 0, 0);\">2011年12月</span></td><td width=\"721\" valign=\"top\" style=\"word-break: break-all;\">phpok3.4版发布（后台更换为桌面式）</td></tr><tr><td width=\"116\" valign=\"top\" style=\"word-break: break-all;\"><span style=\"color: rgb(192, 0, 0);\">2011年9月</span></td><td width=\"721\" valign=\"top\" style=\"word-break: break-all;\">phpok3.3完整版发布</td></tr><tr><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"115\"><span style=\"color: rgb(192, 0, 0);\">2010年8月</span></td><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"719\">phpok3.0完整版发布</td></tr><tr><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"115\"><span style=\"color: rgb(192, 0, 0);\">2008年9月</span></td><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"719\">phpok3.0精简版发布</td></tr><tr><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"115\"><span style=\"color: rgb(192, 0, 0);\">2008年5月</span></td><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"719\">phpok2.2稳定版发布</td></tr><tr><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"116\"><span style=\"color: rgb(192, 0, 0);\">2008年3月</span></td><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"719\">phpok2.0发布</td></tr><tr><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"116\"><span style=\"color: rgb(192, 0, 0);\">2007年5月</span></td><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"719\">qgweb5.2发布，同时更名为 phpok1.0版本</td></tr><tr><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"115\"><span style=\"color: rgb(192, 0, 0);\">2007年1月</span></td><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"719\">qgweb5.0发布（第一次实现多语言，多风格的建站系统）</td></tr><tr><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"115\"><span style=\"color: rgb(192, 0, 0);\">2006年10月</span></td><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"719\">qgweb4.2发布（GBK）</td></tr><tr><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"115\"><span style=\"color: rgb(192, 0, 0);\">2006年8月</span></td><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"719\">qgweb4.1发布（UTF-8）</td></tr><tr><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"115\"><span style=\"color: rgb(192, 0, 0);\">2006年6月</span></td><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"719\">qgweb4.0发布</td></tr><tr><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"115\"><span style=\"color: rgb(192, 0, 0);\">2005年11月</span></td><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"719\">qgWeb3.0发布</td></tr><tr><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"115\"><span style=\"color: rgb(192, 0, 0);\">2005年8月</span></td><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"719\">工作室论坛开通</td></tr><tr><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"115\"><span style=\"color: rgb(192, 0, 0);\">2005年7月</span></td><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"719\">qgWeb1.0发布</td></tr><tr><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"115\"><span style=\"color: rgb(192, 0, 0);\">2005年4月</span></td><td valign=\"top\" colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all;\" width=\"719\">qgWeb0.54版发布</td></tr></tbody></table><p><br/></p>');
INSERT INTO `qinggan_extc` VALUES ('218', '');
INSERT INTO `qinggan_extc` VALUES ('219', '');
INSERT INTO `qinggan_extc` VALUES ('220', '郑州育人国际学校');
INSERT INTO `qinggan_extc` VALUES ('223', '学校简介');
INSERT INTO `qinggan_extc` VALUES ('222', 'About Us');
INSERT INTO `qinggan_extc` VALUES ('224', '<p style=\"text-indent: 2em; text-align: left;\">PHPOK企业程序（简称程序）是锟铻科技有限公司（前身为情感工作室）开发的一套实用性强，定制灵活的企业网站建设系统，基于PHP+MySQL架构，可运行于Linux、Windows、MacOSX、Solaris等各种平台上。</p><p style=\"text-indent: 2em; text-align: left;\">程序采用MVC模式开发，支持各种自定义：分类，项目，模块，站点信息等等，您甚至可以基于这些自定义选项来编写相应的插件以实现各个项目的勾连。</p><p style=\"text-indent: 2em; text-align: left;\">程序最新版本已内置了这些常用的项目：单页面（适用于公司简介），新闻资讯，下载中心，图片展示，在线商城，留言本，迷你小论坛及基础会员功能。您随时可以在后台禁用这些项目甚至是删除之。简约，实用，够用，好用，是我们一直都在努力追求的目标。</p>');
INSERT INTO `qinggan_extc` VALUES ('226', 'a:2:{s:7:\"default\";s:21:\"index.php?id=about-us\";s:7:\"rewrite\";s:13:\"about-us.html\";}');
INSERT INTO `qinggan_extc` VALUES ('225', 'res/201506/17/d4ee2167f68ecc93.jpg');
INSERT INTO `qinggan_extc` VALUES ('231', '<div class=\"bdsharebuttonbox\"><a href=\"#\" class=\"bds_more\" data-cmd=\"more\"></a><a href=\"#\" class=\"bds_qzone\" data-cmd=\"qzone\" title=\"分享到QQ空间\"></a><a href=\"#\" class=\"bds_tsina\" data-cmd=\"tsina\" title=\"分享到新浪微博\"></a><a href=\"#\" class=\"bds_tqq\" data-cmd=\"tqq\" title=\"分享到腾讯微博\"></a><a href=\"#\" class=\"bds_renren\" data-cmd=\"renren\" title=\"分享到人人网\"></a><a href=\"#\" class=\"bds_weixin\" data-cmd=\"weixin\" title=\"分享到微信\"></a></div>\r\n<script>window._bd_share_config={\"common\":{\"bdSnsKey\":{},\"bdText\":\"\",\"bdMini\":\"2\",\"bdPic\":\"\",\"bdStyle\":\"0\",\"bdSize\":\"16\"},\"share\":{}};with(document)0[(getElementsByTagName(\'head\')[0]||body).appendChild(createElement(\'script\')).src=\'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=\'+~(-new Date()/36e5)];</script>');
INSERT INTO `qinggan_extc` VALUES ('246', 'Links');

-- ----------------------------
-- Table structure for `qinggan_fields`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_fields`;
CREATE TABLE `qinggan_fields` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '字段ID，自增',
  `title` varchar(255) NOT NULL COMMENT '字段名称',
  `identifier` varchar(50) NOT NULL COMMENT '字段标识串',
  `field_type` varchar(255) NOT NULL DEFAULT '200' COMMENT '字段存储类型',
  `note` varchar(255) NOT NULL COMMENT '字段内容备注',
  `form_type` varchar(100) NOT NULL COMMENT '表单类型',
  `form_style` varchar(255) NOT NULL COMMENT '表单CSS',
  `format` varchar(100) NOT NULL COMMENT '格式化方式',
  `content` varchar(100) NOT NULL COMMENT '默认值',
  `taxis` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  `ext` text NOT NULL COMMENT '扩展内容',
  `area` text NOT NULL COMMENT '使用范围，多个应用范围用英文逗号隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=124 DEFAULT CHARSET=utf8 COMMENT='字段管理器';

-- ----------------------------
-- Records of qinggan_fields
-- ----------------------------
INSERT INTO `qinggan_fields` VALUES ('6', '内容', 'content', 'longtext', '', 'editor', '', 'html', '', '255', 'a:11:{s:5:\"width\";s:3:\"950\";s:6:\"height\";s:3:\"360\";s:7:\"is_code\";s:0:\"\";s:9:\"btn_image\";s:1:\"1\";s:9:\"btn_video\";s:1:\"1\";s:8:\"btn_file\";s:1:\"1\";s:8:\"btn_page\";s:0:\"\";s:8:\"btn_info\";s:0:\"\";s:7:\"is_read\";s:0:\"\";s:5:\"etype\";s:4:\"full\";s:7:\"btn_map\";s:0:\"\";}', 'all,cate,module,project,user,usergroup');
INSERT INTO `qinggan_fields` VALUES ('7', '图片', 'pictures', 'varchar', '支持多图', 'upload', '', 'safe', '', '50', 'a:3:{s:11:\"upload_type\";s:7:\"picture\";s:7:\"cate_id\";s:1:\"1\";s:11:\"is_multiple\";s:1:\"1\";}', 'all,cate,module,project,user');
INSERT INTO `qinggan_fields` VALUES ('8', '缩略图', 'thumb', 'varchar', '', 'upload', '', 'safe', '', '30', 'a:3:{s:11:\"upload_type\";s:7:\"picture\";s:7:\"cate_id\";s:1:\"1\";s:11:\"is_multiple\";s:1:\"0\";}', 'all,cate,module,project,user');
INSERT INTO `qinggan_fields` VALUES ('9', '压缩文件', 'file', 'varchar', '仅支持压缩文件', 'upload', '', 'safe', '', '60', 'a:3:{s:11:\"upload_type\";s:3:\"zip\";s:7:\"cate_id\";s:1:\"1\";s:11:\"is_multiple\";s:1:\"0\";}', 'all,cate,module,project');
INSERT INTO `qinggan_fields` VALUES ('11', '链接', 'link', 'longtext', '手动指定外部链接时，伪静态链接可以留空', 'url', '', 'safe', '', '90', 'a:1:{s:5:\"width\";s:3:\"500\";}', 'all,cate,module,project,user');
INSERT INTO `qinggan_fields` VALUES ('12', '摘要', 'note', 'longtext', '简要文字描述', 'textarea', '', 'safe', '', '20', 'a:2:{s:5:\"width\";s:3:\"600\";s:6:\"height\";s:2:\"80\";}', 'all,cate,module,project');
INSERT INTO `qinggan_fields` VALUES ('13', '性别', 'gender', 'varchar', '', 'radio', '', 'safe', '女', '120', 'a:3:{s:11:\"option_list\";b:0;s:9:\"put_order\";s:1:\"0\";s:10:\"ext_select\";s:8:\"男\r\n女\";}', 'all,cate,module,project,user');
INSERT INTO `qinggan_fields` VALUES ('14', '邮箱', 'email', 'varchar', '', 'text', '', 'safe', '', '130', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";b:0;}', 'all,cate,module,project,user');
INSERT INTO `qinggan_fields` VALUES ('37', '链接方式', 'target', 'varchar', '设置是否在新窗口打开', 'radio', '', 'safe', '_self', '100', 'a:1:{s:11:\"option_list\";s:5:\"opt:6\";}', 'cate,module,project');
INSERT INTO `qinggan_fields` VALUES ('30', '姓名', 'fullname', 'varchar', '', 'text', '', 'safe', '', '10', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"300\";}', 'all,cate,module,project,user');
INSERT INTO `qinggan_fields` VALUES ('31', '通栏图片', 'banner', 'varchar', '', 'upload', '', 'safe', '', '40', 'a:3:{s:11:\"upload_type\";s:7:\"picture\";s:7:\"cate_id\";s:1:\"1\";s:11:\"is_multiple\";s:1:\"0\";}', 'all,cate,module,project');
INSERT INTO `qinggan_fields` VALUES ('34', '附件', 'files', 'varchar', '仅支持rar和zip的压缩包，支持多附件', 'upload', '', 'safe', '', '70', 'a:3:{s:11:\"upload_type\";s:3:\"zip\";s:7:\"cate_id\";s:1:\"1\";s:11:\"is_multiple\";s:1:\"1\";}', 'all,cate,module,project');
INSERT INTO `qinggan_fields` VALUES ('35', '文档', 'doc', 'varchar', '支持在线办公室的文档', 'upload', '', 'safe', '', '80', 'a:3:{s:11:\"upload_type\";s:8:\"document\";s:7:\"cate_id\";s:1:\"1\";s:11:\"is_multiple\";s:1:\"1\";}', 'all,cate,module,project');
INSERT INTO `qinggan_fields` VALUES ('36', '视频', 'video', 'varchar', '支持并推荐您使用FlV格式视频', 'upload', '', 'int', '', '110', 'a:3:{s:11:\"upload_type\";b:0;s:7:\"cate_id\";b:0;s:11:\"is_multiple\";b:0;}', 'module,project');
INSERT INTO `qinggan_fields` VALUES ('60', '客服QQ', 'qq', 'varchar', '', 'text', '', 'safe', '', '150', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"300\";}', 'all,cate,module,project,user');
INSERT INTO `qinggan_fields` VALUES ('116', '广告内容', 'ad', 'longtext', '', 'editor', '', 'html_js', '', '255', 'a:12:{s:5:\"width\";s:3:\"600\";s:6:\"height\";s:3:\"100\";s:7:\"is_code\";i:1;s:9:\"btn_image\";i:1;s:9:\"btn_video\";i:1;s:8:\"btn_file\";b:0;s:8:\"btn_page\";b:0;s:8:\"btn_info\";b:0;s:7:\"is_read\";b:0;s:5:\"etype\";s:6:\"simple\";s:7:\"btn_tpl\";b:0;s:7:\"btn_map\";b:0;}', 'all,cate,module,project');
INSERT INTO `qinggan_fields` VALUES ('75', '联系地址', 'address', 'varchar', '', 'text', '', 'safe', '', '79', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"500\";}', 'all,module,user');
INSERT INTO `qinggan_fields` VALUES ('76', '联系电话', 'tel', 'varchar', '', 'text', '', 'safe', '', '89', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"300\";}', 'all,cate,module,project,user');
INSERT INTO `qinggan_fields` VALUES ('77', '邮编', 'zipcode', 'varchar', '请填写六位数字的邮编号码', 'text', '', 'safe', '', '30', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"300\";}', 'all,module');
INSERT INTO `qinggan_fields` VALUES ('79', 'LOGO', 'logo', 'varchar', '网站LOGO，规格：88x31', 'text', '', 'safe', '', '160', 'a:2:{s:8:\"form_btn\";s:5:\"image\";s:5:\"width\";s:3:\"500\";}', 'all,cate,module,project');
INSERT INTO `qinggan_fields` VALUES ('80', '图片', 'pic', 'varchar', '', 'text', '', 'safe', '', '255', 'a:2:{s:8:\"form_btn\";s:5:\"image\";s:5:\"width\";s:3:\"500\";}', 'all,cate,module,project,user');
INSERT INTO `qinggan_fields` VALUES ('81', '统计', 'statjs', 'varchar', '', 'code_editor', '', 'html_js', '', '255', 'a:2:{s:5:\"width\";s:3:\"500\";s:6:\"height\";s:2:\"80\";}', 'all');
INSERT INTO `qinggan_fields` VALUES ('82', '备案号', 'cert', 'varchar', '', 'text', '', 'safe', '', '255', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"300\";}', 'all');
INSERT INTO `qinggan_fields` VALUES ('95', '发货时间', 'sendtime', 'varchar', '设置发货时间', 'text', '', 'time', '', '255', 'a:2:{s:8:\"form_btn\";s:4:\"date\";s:5:\"width\";s:3:\"300\";}', 'module');
INSERT INTO `qinggan_fields` VALUES ('96', '企业名称', 'company', 'varchar', '', 'text', '', 'safe', '', '255', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"500\";}', 'all,module,project,user');
INSERT INTO `qinggan_fields` VALUES ('106', '管理员回复', 'adm_reply', 'longtext', '', 'editor', '', 'html', '', '255', 'a:12:{s:5:\"width\";s:3:\"800\";s:6:\"height\";s:3:\"180\";s:7:\"is_code\";b:0;s:9:\"btn_image\";i:1;s:9:\"btn_video\";i:1;s:8:\"btn_file\";i:1;s:8:\"btn_page\";b:0;s:8:\"btn_info\";b:0;s:7:\"is_read\";b:0;s:5:\"etype\";s:6:\"simple\";s:7:\"btn_tpl\";b:0;s:7:\"btn_map\";b:0;}', 'module');
INSERT INTO `qinggan_fields` VALUES ('112', '赞', 'good', 'varchar', '设置点赞次数', 'text', '', 'int', '', '20', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"100\";}', 'module');
INSERT INTO `qinggan_fields` VALUES ('113', '省市', 'province_city', 'longtext', '', 'select', '', 'safe', '', '255', 'a:4:{s:11:\"option_list\";s:5:\"opt:2\";s:11:\"is_multiple\";s:1:\"0\";s:5:\"width\";b:0;s:10:\"ext_select\";b:0;}', 'all,cate,module,project,user,usergroup');
INSERT INTO `qinggan_fields` VALUES ('114', '手机号', 'mobile', 'varchar', '', 'text', '', 'safe', '', '255', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"300\";}', 'all,cate,module,project,user,usergroup');
INSERT INTO `qinggan_fields` VALUES ('117', '规格参数', 'spec', 'longtext', '', 'param', '', '', '', '255', 'a:2:{s:6:\"p_name\";s:30:\"名称\r\n型号\r\n流量\r\n大小\";s:6:\"p_type\";s:1:\"1\";}', 'module');
INSERT INTO `qinggan_fields` VALUES ('118', '产品属性', 'spec_single', 'longtext', '', 'param', '', '', '', '255', 'a:2:{s:6:\"p_name\";s:119:\"型号\r\n推荐用途\r\n平台\r\n显卡类型\r\n网卡\r\n类型\r\n速度\r\n核心数\r\n二级缓存\r\n显示芯片\r\n显存容量\";s:6:\"p_type\";s:1:\"0\";}', 'module');
INSERT INTO `qinggan_fields` VALUES ('119', '页脚版权', 'copyright', 'longtext', '', 'editor', '', 'html', '', '255', 'a:12:{s:5:\"width\";s:3:\"800\";s:6:\"height\";s:3:\"100\";s:7:\"is_code\";b:0;s:9:\"btn_image\";s:1:\"1\";s:9:\"btn_video\";b:0;s:8:\"btn_file\";b:0;s:8:\"btn_page\";b:0;s:8:\"btn_info\";b:0;s:7:\"is_read\";b:0;s:5:\"etype\";s:6:\"simple\";s:7:\"btn_tpl\";b:0;s:7:\"btn_map\";b:0;}', 'all,module');
INSERT INTO `qinggan_fields` VALUES ('120', '英文标题', 'entitle', 'varchar', '设置与主题名称相对应的英文标题', 'text', '', 'safe', '', '255', 'a:4:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"500\";s:15:\"ext_quick_words\";b:0;s:14:\"ext_quick_type\";b:0;}', 'all,cate,module,project,user,usergroup,cart,order,pay');
INSERT INTO `qinggan_fields` VALUES ('121', '二维码图片', 'barcode', 'varchar', '请上传相应的二维码图片', 'upload', '', '', '', '255', 'a:3:{s:11:\"upload_type\";s:7:\"picture\";s:7:\"cate_id\";s:1:\"1\";s:11:\"is_multiple\";s:1:\"0\";}', 'all,cate,module,project,user,usergroup,cart,order,pay');
INSERT INTO `qinggan_fields` VALUES ('122', '子标题', 'subtitle', 'varchar', '', 'text', '', '', '', '20', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"300\";}', 'all,cate,module,project,user,usergroup,cart,order,pay');
INSERT INTO `qinggan_fields` VALUES ('123', '百度分享代码', 'baidu', 'longtext', '', 'code_editor', '', 'html_js', '', '10', 'a:2:{s:5:\"width\";s:3:\"800\";s:6:\"height\";s:3:\"300\";}', 'all,cate,module,project,user,usergroup,cart,order,pay');

-- ----------------------------
-- Table structure for `qinggan_gd`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_gd`;
CREATE TABLE `qinggan_gd` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `identifier` varchar(100) NOT NULL COMMENT '标识串',
  `width` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片宽度',
  `height` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片高度',
  `mark_picture` varchar(255) NOT NULL COMMENT '水印图片位置',
  `mark_position` varchar(100) NOT NULL COMMENT '水印位置',
  `cut_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '图片生成方式，支持缩放法、裁剪法、等宽、等高及自定义五种，默认使用缩放法',
  `quality` tinyint(3) unsigned NOT NULL DEFAULT '100' COMMENT '图片生成质量，默认是100',
  `bgcolor` varchar(10) NOT NULL DEFAULT 'FFFFFF' COMMENT '补白背景色，默认是白色',
  `trans` tinyint(3) unsigned NOT NULL DEFAULT '65' COMMENT '透明度',
  `editor` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0普通1默认插入编辑器',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='上传图片自动生成方案';

-- ----------------------------
-- Records of qinggan_gd
-- ----------------------------
INSERT INTO `qinggan_gd` VALUES ('2', 'thumb', '200', '240', '', '', '1', '80', 'FFFFFF', '0', '0');
INSERT INTO `qinggan_gd` VALUES ('12', 'auto', '0', '0', 'res/201502/26/36afa2d3dfe37cbd.png', '', '0', '80', 'FFFFFF', '0', '1');
INSERT INTO `qinggan_gd` VALUES ('22', 'mobile', '640', '0', '', '', '0', '80', 'FFFFFF', '0', '0');
INSERT INTO `qinggan_gd` VALUES ('29', 'photo', '0', '400', '', '', '0', '80', 'FFFFFF', '0', '0');
INSERT INTO `qinggan_gd` VALUES ('25', 'small', '50', '50', '', '', '1', '80', 'FFFFFF', '0', '0');
INSERT INTO `qinggan_gd` VALUES ('28', 'product', '300', '300', '', '', '0', '80', 'FFFFFF', '0', '0');
INSERT INTO `qinggan_gd` VALUES ('30', 'news', '343', '230', '', '', '0', '80', 'FFFFFF', '0', '0');

-- ----------------------------
-- Table structure for `qinggan_list`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_list`;
CREATE TABLE `qinggan_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '0为根主题，其他ID对应list表的id字段',
  `cate_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `module_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '模块ID',
  `project_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '项目ID',
  `site_id` mediumint(8) unsigned NOT NULL COMMENT '网站ID',
  `title` varchar(255) NOT NULL COMMENT '主题',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0未审核，1已审核',
  `hidden` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0显示，1隐藏',
  `hits` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '查看次数',
  `tpl` varchar(255) NOT NULL COMMENT '自定义的模板',
  `seo_title` varchar(255) NOT NULL COMMENT 'SEO标题',
  `seo_keywords` varchar(255) NOT NULL COMMENT 'SEO关键字',
  `seo_desc` varchar(255) NOT NULL COMMENT 'SEO描述',
  `tag` varchar(255) NOT NULL COMMENT 'tag标签',
  `attr` varchar(255) NOT NULL COMMENT '主题属性',
  `replydate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后回复时间',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID号，为0表示管理员发布',
  `identifier` varchar(255) NOT NULL COMMENT '内容标识串',
  `price` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '价格',
  `currency_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '货币ID，对应currency表',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `site_id` (`site_id`,`identifier`,`status`)
) ENGINE=MyISAM AUTO_INCREMENT=1443 DEFAULT CHARSET=utf8 COMMENT='内容主表';

-- ----------------------------
-- Records of qinggan_list
-- ----------------------------
INSERT INTO `qinggan_list` VALUES ('1276', '0', '0', '21', '41', '1', '企业建站，我信赖PHPOK', '1394008409', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('520', '0', '0', '23', '42', '1', '网站首页', '1380942032', '10', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('712', '0', '0', '23', '42', '1', '学校简介', '1383355821', '20', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('713', '0', '0', '23', '42', '1', '学校新闻', '1383355842', '11', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('714', '0', '0', '23', '42', '1', '管理团队', '1383355849', '30', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1396', '712', '0', '23', '42', '1', '使命', '1434774120', '21', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1277', '0', '0', '21', '41', '1', '选择PHPOK，企业更专业', '1394008434', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('755', '712', '0', '23', '42', '1', '目标', '1383640450', '22', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1373', '0', '0', '22', '43', '1', '来自工程师的8项Web性能提升建议', '1424920049', '0', '1', '0', '39', '', '', '', '', '', 'h', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1433', '0', '0', '23', '42', '1', '校园公告', '1435646525', '80', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1404', '0', '0', '23', '42', '1', '招生信息', '1434980657', '60', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1405', '0', '0', '23', '42', '1', '联系方式', '1434980679', '70', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1254', '712', '0', '23', '42', '1', '办学理念', '1392375210', '23', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1256', '0', '0', '23', '42', '1', '办学特色', '1392375722', '50', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1261', '0', '0', '61', '142', '1', '启邦互动', '1393321211', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1262', '0', '0', '61', '142', '1', '联迅网络', '1393321235', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1263', '0', '0', '61', '142', '1', '梦幻网络', '1393321258', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1264', '0', '0', '61', '142', '1', '中国站长站', '1393321288', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1265', '0', '0', '61', '142', '1', 'A5站长网', '1393321321', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1266', '0', '0', '61', '142', '1', '中国站长', '1393321365', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1267', '0', '0', '61', '142', '1', '落伍者', '1393321391', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1268', '0', '0', '61', '142', '1', '源码之家', '1393321413', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1432', '0', '0', '68', '173', '1', '校园风貌', '1433256898', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1278', '0', '0', '21', '41', '1', '开源精神，开创未来', '1394008456', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1300', '0', '0', '23', '147', '1', '学校简介', '1409554964', '20', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1301', '0', '0', '23', '147', '1', '发展历程', '1409554975', '30', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1302', '0', '0', '23', '147', '1', '学校新闻', '1409554988', '40', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1304', '0', '0', '23', '147', '1', '联系我们', '1409555008', '60', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1368', '0', '8', '22', '43', '1', 'EverEdit - 值得关注的代码编辑器', '1424912045', '0', '1', '0', '21', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1369', '0', '8', '22', '43', '1', '金山 WPS - 免费正版办公软件(支持Win/Linux/手机)', '1422929304', '0', '1', '0', '16', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1370', '0', '0', '22', '43', '1', 'MySQL出错代码', '1424918437', '0', '1', '0', '10', '', '', '', '', '', 'h', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1371', '0', '0', '22', '43', '1', 'MySQL安装后需要调整什么?', '1424918471', '0', '1', '0', '4', '', '', '', '', '', 'h', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1372', '0', '0', '22', '43', '1', 'FTP软件使用中的PASV和PORT上传模式', '1424918718', '0', '1', '0', '7', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1381', '0', '0', '22', '43', '1', '科技进步给工人带来失业恐惧？', '1428675994', '0', '1', '0', '8', '', '', '', '', '科技 失业恐惧', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1382', '0', '0', '22', '43', '1', '站点采用HTTPS协议的利弊分析、及SEO建议', '1433723870', '0', '1', '0', '20', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1431', '0', '0', '68', '173', '1', '最新动态', '1433860579', '0', '1', '0', '1', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1397', '712', '0', '23', '42', '1', '育人理念', '1434774198', '24', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1408', '0', '0', '23', '147', '1', '首页', '1434984015', '10', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1417', '0', '0', '74', '169', '1', '招生信息', '1433681711', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1406', '1256', '0', '23', '42', '1', '家长参与', '1434982473', '52', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1407', '1256', '0', '23', '42', '1', '学生心声', '1434982487', '51', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1410', '0', '0', '22', '43', '1', '招生信息test1', '1433853741', '0', '1', '0', '3', '', '', '', '', '', '', '0', '0', '招生信息test1', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1411', '0', '0', '22', '167', '1', 'xygg', '1433942580', '0', '1', '0', '5', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1416', '0', '0', '74', '169', '1', 'test1', '1433163207', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1427', '0', '0', '22', '172', '1', '最新动态1', '1433042992', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1429', '0', '0', '22', '172', '1', '最新动态13', '1433820620', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1422', '0', '0', '22', '171', '1', '热点新闻test1', '1433041785', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1428', '0', '0', '22', '172', '1', '最新动态12', '1434425409', '0', '1', '0', '1', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1423', '0', '0', '22', '171', '1', '热点新闻test2', '1433646606', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1424', '0', '0', '22', '171', '1', '热点新闻test3', '1433041820', '0', '1', '0', '1', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1430', '0', '8', '22', '43', '1', 'test1', '1433248590', '0', '1', '0', '1', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1434', '714', '0', '23', '42', '1', '师资队伍', '1435646977', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1435', '0', '0', '74', '174', '1', '最新动态', '1435583756', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1436', '0', '0', '74', '169', '1', '校园风貌', '1435756628', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1437', '0', '0', '74', '169', '1', '学校新闻', '1435583852', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1438', '0', '0', '74', '169', '1', '新闻图片', '1435497469', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1439', '0', '0', '68', '173', '1', '招生信息', '1435676345', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1440', '0', '0', '68', '173', '1', '校园公告', '1435762772', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1441', '0', '0', '68', '173', '1', '最新动态', '1436194785', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');
INSERT INTO `qinggan_list` VALUES ('1442', '0', '0', '68', '173', '1', '校园风貌', '1435676428', '0', '1', '0', '0', '', '', '', '', '', '', '0', '0', '', '0.0000', '0');

-- ----------------------------
-- Table structure for `qinggan_list_21`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_list_21`;
CREATE TABLE `qinggan_list_21` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主题ID',
  `site_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '网站ID',
  `project_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '项目ID',
  `cate_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '主分类ID',
  `link` longtext NOT NULL COMMENT '链接',
  `target` varchar(255) NOT NULL DEFAULT '_self' COMMENT '链接方式',
  `pic` varchar(255) NOT NULL DEFAULT '' COMMENT '图片',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`,`project_id`,`cate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='图片播放器';

-- ----------------------------
-- Records of qinggan_list_21
-- ----------------------------
INSERT INTO `qinggan_list_21` VALUES ('1276', '1', '41', '0', 'http://www.phpok.com', '_blank', '829');
INSERT INTO `qinggan_list_21` VALUES ('1277', '1', '41', '0', 'http://www.phpok.com', '_blank', '828');
INSERT INTO `qinggan_list_21` VALUES ('1278', '1', '41', '0', 'http://www.phpok.com', '_blank', '827');

-- ----------------------------
-- Table structure for `qinggan_list_22`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_list_22`;
CREATE TABLE `qinggan_list_22` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主题ID',
  `site_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '网站ID',
  `project_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '项目ID',
  `cate_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '主分类ID',
  `thumb` varchar(255) NOT NULL DEFAULT '' COMMENT '缩略图',
  `content` longtext NOT NULL COMMENT '内容',
  `note` longtext NOT NULL COMMENT '摘要',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`,`project_id`,`cate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章资讯';

-- ----------------------------
-- Records of qinggan_list_22
-- ----------------------------
INSERT INTO `qinggan_list_22` VALUES ('1373', '1', '43', '68', '726', '<p>在互联网盛行的今天，越来越多的在线用户希望得到安全可靠并且快速的访问体验。针对Web网页过于膨胀以及第三脚本蚕食流量等问题，Radware向网站运营人员提出以下改进建议，帮助他们为用户提供最快最优质的访问体验。</p><p style=\"text-align: center;\"><img src=\"res/201502/26/auto_726.jpg\" border=\"0\" width=\"368\" alt=\"来自工程师的8项Web性能提升建议\" height=\"233\" style=\"margin: 0px; padding: 0px; border: 1px solid rgb(153, 153, 153); font-family: inherit; font-size: 0px; font-style: inherit; font-variant: inherit; line-height: inherit; vertical-align: middle; color: transparent; display: inline-block;\"/></p><p>1、 管理“页面膨胀”页面大小与性能有着密切的关系。据调查显示，100强电商页面大小中位数达到了1492KB，比一年半之前增大了48%。</p><blockquote><p>在研究报告里加载最快的10个页面中，页面包含的资源请求中位数为50个，页面大小中位数为556KB。而加载最慢的10个页面中，页面包含的资源请求中位数为141个，页面大小中位数为3289KB。换句话说，加载最慢的页面的资源中位数几乎是加载最快的页面的三倍，页面大小则是六倍。</p><p>仔细研究页面尺寸大小，我们可以得到更多的信息。加载最快的10个页面所包含的资源总数范围比较密集：在15个~72个之间；页面尺寸最小的仅为251KB，最大的2003KB。而加载最慢的10个页面所包含的资源总数范围则比较广泛：在89个~373个之间；页面尺寸最小为2073KB，最大的则超过了10MB。</p></blockquote><p>2、进行图像优化</p><blockquote><p>图像是造成页面膨胀的罪魁祸首之一，通常占据页面字节数的50-60%。在页面中添加图片或是将现有图片放大，是迅速获取用户并提高业务转化率的有效方式。但是这种方法会对性能造成严重的影响。</p><p>进行图像优化是提升性能最简单的一种方法，它可以使页面加载更快。为了更有效的完成图像渲染，图像必须经过压缩和整合、图像的尺寸和格式必须经过仔细调整，图像质量也必须经过优化，这样才可以依据图像的重要性进行区别化的加载处理。</p></blockquote><p>3、 控制第三方脚本</p><blockquote><p>在典型的页面服务器请求中，来自于第三方脚本的请求占了其中的50%或更多。这些第三方脚本不仅会增加页面的字节数，带来延迟，而且也会成为Web页面中最大的潜在故障点。无响应、未经优化的第三方脚本会降低整个网络的加载速度。</p><p>解决办法是延迟第三方脚本的加载，将其放在关键页面内容之后进行加载，更为理想的情况是放在页面onLoad事件之后加载，这样才不会影响企业的搜索排名(谷歌将onLoad事件作为加载时间指标)。对于一些分析工具和第三方广告商而言，如果延迟第三方脚本加载的方法不可行，可以利用脚本的异步版本，与关键内容的加载同步进行。用户必须了解网站中有哪些脚本，删除那些无用的脚本，并对第三方脚本的性能进行持续监控。</p></blockquote><p>4、真正做到移动设备优先</p><blockquote><p>“移动设备优先”并不是一个全新的概念。早在2013年，移动设备的使用量就已经超过了台式机，然而与众多口头承诺的移动性能相比，真正专注于移动设备的开发还是存在一定的差距。例如，2011年11月，移动设备上的平均页面大小为475KB，现在则增长至897 KB。也就是说，在短短三年之间，平均页面大小几乎翻了一番。</p><p>尽管移动设备和网络取得了一些进展，但就性能而言，还是无法与大小已接近1MB的服务页面需求保持同步。我们知道，页面大小与加载时间息息相关，移动用户对缓慢的加载速度尤其敏感。如果企业希望网站可以真正做到“移动设备优先”，就必须正确处理这些问题。<br/></p></blockquote><p>5、在进行响应式Web设计时兼顾性能</p><blockquote><p>响应式设计让设计人员和开发人员可以更好地控制Web页面的外观和感觉。它可以使跨多平台和设备上的页面变得更漂亮。但同时也会带来巨大的性能损失，这些性能损失并不能通过更快速的浏览器、网络和小工具得到缓解。而且随着时间的推移，这样影响还将持续恶化。<br/></p><p>响应式设计建立在样式表和JavaScript之上。然而，低效的CSS和JS所带来的性能问题远远大于其设计优势给我们带来的好处。样式表应当放在HEAD文档中，用以实现页面的逐步渲染。然而，样式表却经常出现在页面其它位置，这就阻碍了页面的渲染速度。换句话说，JavaScript文件应当放在页面底部或在关键内容加载完成之后再被加载才是合理的处理方式。<br/></p></blockquote><p>6、 实时监控性能</p><blockquote><p>大家都知道要解决一个问题就必须先对问题有充分的了解。要解决页面性能问题，企业就必须知道用户在什么时候可以看到主要页面内容并与之进行交互；同时，企业还需了解性能和可用性问题是如何影响业务指标的。企业需要有方法获取实际的性能指标并对其进行分析。实时用户监控(RUM)工具可以从真实用户的角度实时获取、分析并记录网站的性能和可用性。</p></blockquote><p>7、切勿过分依赖CDN解决所有性能问题</p><blockquote><p>使用内容分发网络(CDN)的网站完成主要内容渲染所需的时间比未曾使用CDN的网站要长的多。这是一个相关性问题，而非因果关系：通常情况下，相较于未使用CDN的网站，使用CDN的网站页面更大，也更复杂。页面的大小和复杂程度才是造成性能问题的元凶，而非CDN。但这一结果也表明，仅依靠CDN并不能解决所有的性能难题。</p><p>如果部署得当，CDN会是解决延迟问题非常有效的工具：缩短托管服务器接收、处理并响应图像、CSS文件等页面资源请求所需的时间。但是，延迟仅仅只是现代电商网站的关键问题之一。为了实现最佳的加速效果，网站运营人员可以采用组合解决方案：CDN+前端优化+应用交付控制器和内部管理。</p></blockquote><p>8、在企业内部加强Web性能观念的宣传</p><blockquote><p>大量研究证明，提高页面速度可以对所有的关键性能指标产生积极影响：页面访问量、用户粘连度、业务转化率、用户满意度、客户保持、购物车的内容多少和收入。</p><p>然而，正如上述7个建议中所表明的那样，许多企业都犯了同样的错误，最终损害了Web性能。目前，企业应该重点解决Web开发目标和在线业务目标之间的差距问题，而且，每个企业都应该至少拥有一个内部性能专家，以便更好的解决Web性能问题。</p></blockquote><p><br style=\"text-align: left;\"/></p>', '在互联网盛行的今天，越来越多的在线用户希望得到安全可靠并且快速的访问体验。针对Web网页过于膨胀以及第三脚本蚕食流量等问题，Radware向网站运营人员提出以下改进建议，帮助他们为用户提供最快最优质的访问体验。');
INSERT INTO `qinggan_list_22` VALUES ('1368', '1', '43', '8', '724', '<p style=\"text-align: center;\"><img src=\"res/201502/26/auto_724.jpg\" alt=\"auto_724.jpg\"/></p><p>Everedit 结合众多编辑器的特点开发出的兼顾性能和使用、小巧的、强悍的文本编辑器。</p><blockquote><p>首先，要能够支持多种文档编码，显示和输入的时候不应该乱码。</p><p>其次，要能够对于常见的代码进行着色和自定义。</p><p>再者，要能够自定义键盘和工具等。</p></blockquote><p>对于绝大多数人而言，上面的功能就足够了。那么对于进阶者，可能要求更高一些。比如对于着色，有的人希望着色能够足够强大，显示自己定义的日记格式、折叠等；对于键盘，有的人希望能够多个按键组合触发命令，甚至模拟一些终端编辑器的操作，比如&nbsp;VIM，高手还希望这个编辑器的自定义性足够强，可玩度高，能够支持脚本和插件等等。那么很高兴的告诉大家，Everedit具备上面无论是初学者还是高手所期望的全部功能，而且非常的小巧，压缩包只有3M左右，无论是冷启动还是热启动都非常的迅速。</p><p>因为作者初开发这个目的就是做一个强化的 Editplus。所以在 Everedit 的身上，您能够找到很多这个编辑器的影子！</p><p>官网地址：<a href=\"http://www.everedit.net/\" target=\"_blank\" textvalue=\"http://www.everedit.net/\" style=\"color: rgb(255, 0, 0); text-decoration: underline;\"><span style=\"color: rgb(255, 0, 0);\">http://www.everedit.net/</span></a></p><p><br/></p>', 'EverEdit 是一款相当优秀国产的免费文本(代码)编辑器，最初这项目是为了解决 EditPlus 的一些不足并增强其功能而开始的，比如 Editplus 的着色器较为简陋，无法进行复杂着色，如markdown语法; 也不支持自动完成, 还有多点 Snippet 等等。');
INSERT INTO `qinggan_list_22` VALUES ('1369', '1', '43', '8', '725', '<p style=\"text-align: center;\"><img src=\"res/201502/26/auto_725.jpg\" alt=\"auto_725.jpg\"/></p><p>一直以来办公软件市场份额都是被微软的 Office 牢牢占据，但其价格较贵，国内大多都是用着盗版。其实国产免费的 WPS 已经完完全全可以和Office媲美，且完美兼容各种doc、docx、xls、xlsx、ppt等微软文档格式！</p><p>金山 WPS Office 作为优秀免费国产软件，一直在用户中口碑相当好！它完全免费，体积小巧，跨平台支持Win、Linux、Android 和 iOS，兼容微软包括最新的 Office2013 在内的各种文档格式，几乎可以完美替代收费的 Office。另外 WPS 新增了用于协同工作的「轻办公」，适合国情的大量在线模版、范文、素材库等也都让其更加适合国人使用……</p><p>WPS Office 全面采用了「扁平化」界面设计，看起来非常专业时尚！它包含3个主要组件：文字、表格和演示，分别对应微软 MS Office 的 Word、Excel和PowerPoint，并且针对国内用户的习惯，WPS提供更多适合国人使用的模版。在界面和操作使用上也很相似，如果你习惯了用Office，那么你几乎可以不用重新学习即可马上熟练使用WPS。</p><p>WPS Office 深度兼容 Microsoft Office 的文档格式，你可以直接保存和打开 Microsoft Word、Excel 和 PowerPoint 文件；也可以用 Microsoft Office轻松编辑 WPS 系列文档。经测试，微软新的 docx、xlsx等格式打开都非常正常，兼容接近完美。</p><p>目前金山 WPS 已经提供了包括 Windows、Linux、Android 和 iOS 等系统的版本，而且它们通过轻办公的云服务将用户文档完全打通，轻松实现随时随地的移动办公，相比目前市面上很多 Office 类的软件都要方便得多。</p><p>对于非重度办公的用户而言，金山WPS 和 微软Office 在界面和使用上其实并没有很大的差别，由于WPS有着良好的兼容性，实测几乎所有文档均能正常打开，完全可以替代MS Office。具体 WPS 和 MS Office 的技术谁更先进其实我们并不需要了解，免费好用才是王道！免去什么激活啊，什么注册码的麻烦，直接安装就可以免费使用，随时升级，这省下多少心呢！</p><p>最后，感谢金山给国人带来如此优秀实用的一款免费正版办公软件！</p>', '一直以来办公软件市场份额都是被微软的 Office 牢牢占据，但其价格较贵，国内大多都是用着盗版。其实国产免费的 WPS 已经完完全全可以和Office媲美，且完美兼容各种doc、docx、xls、xlsx、ppt等微软文档格式！');
INSERT INTO `qinggan_list_22` VALUES ('1370', '1', '43', '207', '888', '<p>1005：创建表失败</p><p>1006：创建数据库失败</p><p>1007：数据库已存在，创建数据库失败</p><p>1008：数据库不存在，删除数据库失败</p><p>1009：不能删除数据库文件导致删除数据库失败</p><p>1010：不能删除数据目录导致删除数据库失败</p><p>1011：删除数据库文件失败</p><p>1012：不能读取系统表中的记录</p><p>1020：记录已被其他用户修改</p><p>1021：硬盘剩余空间不足，请加大硬盘可用空间</p><p>1022：关键字重复，更改记录失败</p><p>1023：关闭时发生错误</p><p>1024：读文件错误</p><p>1025：更改名字时发生错误</p><p>1026：写文件错误</p><p>1032：记录不存在</p><p>1036：数据表是只读的，不能对它进行修改</p><p>1037：系统内存不足，请重启数据库或重启服务器</p><p>1038：用于排序的内存不足，请增大排序缓冲区</p><p>1040：已到达数据库的最大连接数，请加大数据库可用连接数</p><p>1041：系统内存不足</p><p>1042：无效的主机名</p><p>1043：无效连接</p><p>1044：当前用户没有访问数据库的权限</p><p>1045：不能连接数据库，用户名或密码错误</p><p>1048：字段不能为空</p><p>1049：数据库不存在</p><p>1050：数据表已存在</p><p>1051：数据表不存在</p><p>1054：字段不存在</p><p>1065：无效的SQL语句，SQL语句为空</p><p>1081：不能建立Socket连接</p><p>1114：数据表已满，不能容纳任何记录</p><p>1116：打开的数据表太多</p><p>1129：数据库出现异常，请重启数据库</p><p>1130：连接数据库失败，没有连接数据库的权限</p><p>1133：数据库用户不存在</p><p>1141：当前用户无权访问数据库</p><p>1142：当前用户无权访问数据表</p><p>1143：当前用户无权访问数据表中的字段</p><p>1146：数据表不存在</p><p>1147：未定义用户对数据表的访问权限</p><p>1149：SQL语句语法错误</p><p>1158：网络错误，出现读错误，请检查网络连接状况</p><p>1159：网络错误，读超时，请检查网络连接状况</p><p>1160：网络错误，出现写错误，请检查网络连接状况</p><p>1161：网络错误，写超时，请检查网络连接状况</p><p>1062：字段值重复，入库失败</p><p>1169：字段值重复，更新记录失败</p><p>1177：打开数据表失败</p><p>1180：提交事务失败</p><p>1181：回滚事务失败</p><p>1203：当前用户和数据库建立的连接已到达数据库的最大连接数，请增大可用的数据库连接数或重启数据库</p><p>1205：加锁超时</p><p>1211：当前用户没有创建用户的权限</p><p>1216：外键约束检查失败，更新子表记录失败</p><p>1217：外键约束检查失败，删除或修改主表记录失败</p><p>1226：当前用户使用的资源已超过所允许的资源，请重启数据库或重启服务器</p><p>1227：权限不足，您无权进行此操作</p><p>1235：MySQL版本过低，不具有本功能</p><p><br/></p>', '');
INSERT INTO `qinggan_list_22` VALUES ('1371', '1', '43', '207', '', '<p>面对MySQL的DBA或者做MySQL性能相关的工作的人，我最喜欢问的问题是，在MySQL服务器安装后，需要调整什么，假设是以缺省的设置安装的。</p><p>我很惊讶有非常多的人没有合理的回答，很多的MySQL服务器都在缺省的配置下运行。</p><p>尽管可以调整非常多的MySQL服务器变量，但是在通常情况下只有少数的变量是真正重要的。在设置完这些变量以后，其他变量的改动通常只能带来相对有限的性能改善。</p><p><strong>key_buffer_size</strong>：非常重要，如果使用MyISAM表。如果只使用MyISAM表，那么把它的值设置为可用内存的30%到40%。恰当的大小依赖索引的数量、数据量和负载 ----记住MyISAM使用操作系统的cache去缓存数据，所以也需要为它留出内存，而且数据通常比索引要大很多。然而需要查看是否所有的 key_buffer总是在被使用 ---- key_buffer为4G而.MYI文件只有1G的情况并不罕见。这样就有些浪费了。如果只是使用很少的MyISAM表，希望它的值小一些，但是仍然至少要设成16到32M，用于临时表（占用硬盘的）的索引。</p><p><strong>innodb_buffer_pool_size</strong>：非常重要，如果使用Innodb表。相对于MyISAM表而言，Innodb表对buffer size的大小更敏感。在处理大的数据集（data set）时，使用缺省的key_buffer_size和innodb_buffer_pool_size，MyISAM可能正常工作，而Innodb可能就是慢得像爬一样了。同时Innodb buffer pool缓存了数据和索引页，因此不需要为操作系统的缓存留空间，在只用Innodb的数据库服务器上，可以设成占内存的70%到80%。上面 key_buffer的规则也同样适用 ---- 如果只有小的数据集，而且也不会戏剧性地增大，那么不要把innodb_buffer_pool_size设得过大。因为可以更好地使用多余的内存。</p><p></p><p><strong>innodb_additional_pool_size</strong>：这个变量并不太影响性能，至少在有像样的（decent）内存分配的操作系统中是这样。但是仍然需要至少设为20MB（有时候更大），是Innodb分配出来用于处理一些杂事的。</p><p><strong>innodb_log_file_size</strong>：对于以写操作为主的负载(workload)非常重要，特别是数据集很大的时候。较大的值会提高性能，但增加恢复的时间。因此需要谨慎。我通常依据服务器的大小（server size）设置为64M到512M。</p><p><strong>innodb_log_buffer_size</strong>：缺省值在中等数量的写操作和短的事务的大多数负载情况下是够用的。如果有大量的UPDATE或者大量地使用blob，可能需要增加它的值。不要把它的值设得过多，否则会浪费内存--log buffer至少每秒刷新一次，没有必要使用超过一秒钟所需要的内存。8MB到16MB通常是足够的。小一些的安装应该使用更小的值。</p><p><strong>innodb_flush_logs_at_trx_commit</strong>：为Innodb比MyISAM慢100倍而哭泣？可能忘记了调整这个值。缺省值是1，即每次事务提交时都会把日志刷新到磁盘上，非常耗资源，特别是没有电池备份的cache时。很多应用程序，特别是那些从MyISAM表移植过来的，应该把它设成2。意味着只把日志刷新到操作系统的cache，而不刷新到磁盘。此时，日志仍然会每秒一次刷新到磁盘上，因此通常不会丢失超过1到2秒的更新。设成0会更快一些，但安全性差一些，在MySQL服务崩溃的时候，会丢失事务。设成2只会在操作系统崩溃的时候丢失数据。</p><p></p><p><strong>table_cache</strong>：打开表是昂贵的（耗资源）。例如，MyISAM表在MYI文件头做标记以标明哪些表正在使用。您不会希望这样的操作频繁发生，通常最好调整cache 大小，使其能够满足大多数打开的表的需要。它使用了一些操作系统的资源和内存，但是对于现代的硬件水平来说通常不是问题。对于一个使用几百个表的应用， 1024是一个合适的值（注意每个连接需要各自的缓存）。如果有非常多的连接或者非常多的表，则需要增大它的值。我曾经看到过使用超过100000的值。</p><p></p><p><strong>thread_cache</strong>：线程创建/销毁是昂贵的，它在每次连接和断开连接时发生。我通常把这个值至少设成16。如果应用有时会有大量的并发连接，并且可以看到 threads_created变量迅速增长，我就把它的值调高。目标是在通常的操作中不要有线程的创建。</p><p><strong>query_cache</strong>：如果应用是以读为主的，并且没有应用级的缓存，那么它会有很大帮助。不要把它设得过大，因为它的维护可能会导致性能下降。通常会设置在32M到 512M之间。设置好后，经过一段时间要进行检查，看看是否合适。对于某些工作负载，缓存命中率低于会就启用它。</p><p>注意：就像看到的，上面所说的都是全局变量。这些变量依赖硬件和存储引擎的使用，而会话级的变量（per session variables）则与特定的访问量(workload)相关。如果只是一些简单的查询，就没有必要增加sort_buffer_size，即使有 64G的内存让您去浪费。而且这样做还可能降低性能。我通常把调整会话级的变量放在第二步，在我分析了访问量（或负载）之后。</p><p>此外在MySQL分发版中包含了一些my.cnf文件的例子，可以作为非常好的模板去使用。如果能够恰当地从中选择一个，通常会比缺省值要好。</p>', '');
INSERT INTO `qinggan_list_22` VALUES ('1372', '1', '43', '207', '', '<p>一、FTP连接中的PASV和PORT模式：</p><blockquote><p>PORT：其实是Standard模式的另一个名字，又称为Active模式。中文意思是“主动模式；</p><p>PASV：也就是Passive的简写，中文就是“被动模式。</p></blockquote><p>二、两者之间有什么不同：<br/></p><blockquote><p>1、不同之处是由于PORT这个方式需要在接上TCP 21端口后，服务器通过自己的TCP 20来发出数据。并且需要建立一个新的连接来传送档案。而PORT的命令包含一些客户端没用的资料，所以有了PASv的出现；</p><p>2、而PASV模式就当然拥有PORT模式的优点及去掉一些PORT的缺点。PASV运行方式就是当服务器接收到PASV命令时，就会自动从端口1024到5000中随机选择，而且还会使用同一个端口来传送数据，不用建立新的连接。</p></blockquote><p>三、有的 FTP 服务器是不支持 PASV 模式的，登入時要取消 PASV 模式才行。常用 FTP 下载工具取消PASV 模式的方法如下：</p><blockquote><p>1、Cutftp：点菜单上的“文件”－&gt;“站点管理”－&gt;在“站点管理器”窗口－&gt;“新建站点”－&gt;填上“域名”－&gt;“编辑”－&gt;“常规”－&gt;把“使用 pasv 模式”前的勾勾去掉。</p><p>2、FlashFXP：点菜单上的“站点”－&gt;“站点管理器”－&gt;站点管理器窗口－&gt;“新建站点”－&gt;填上“域名”－&gt;“选项”－&gt;把“使用被动模式”前的勾勾去掉－&gt;“应用” 即可。</p><p>3、FileZilla：点菜单上的“站点”－&gt;“站点管理器”－&gt;站点管理器窗口－&gt;“传输设置”－&gt;“传输模式”－&gt;选择“主动”或“默认”即可。</p></blockquote>', '');
INSERT INTO `qinggan_list_22` VALUES ('1381', '1', '43', '68', '734', '<p style=\"margin-top: 0px; margin-bottom: 1.5em; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">之前就有报道说，富士康正在大力研发并使用机械手臂以代替人工劳动力。其对外公布的计划是每年增加超过1万台机器人和10万套自动化设备。这是一个相当庞大的工程，即使对于富士康这样的企业来说也是如此。那么，我们不去刨根问底富士康为什么要花这么大力气投入到机器人的研发使用上，我们只想知道这样的做法会不会带动更多的制造厂商如法炮制利用机器人代替人工劳动力，导致普通工人因机器人的介入丢失饭碗进而对科技进步的现实产生恐惧感。</p><p style=\"margin-top: 0px; margin-bottom: 1.5em; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255); text-align: center;\"><img src=\"res/201504/10/auto_734.jpg\" style=\"vertical-align: middle; border: none;\"/><br/></p><p style=\"margin-top: 0px; margin-bottom: 1.5em; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">其实，谁都知道富士康之所以开始加大对机器人的研发，并希望通过机器人来取代人工，除了招工难的原因之外，同时降低人工成本和管理成本也是他们所考虑的问题重点。虽然劳动者在工作岗位上的工作范围较广，但肯定没有那些不用吃不用休息的机器人好使啊。可现实遇到的麻烦是，要想用机器人取代人工根本没那么简单：</p><ol style=\"margin-bottom: 1em; margin-left: 30px; padding: 0px; list-style-position: initial; list-style-image: initial; color: rgb(51, 51, 51); font-family: Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\" class=\" list-paddingleft-2\"><li><p><span style=\"color:#000000\">机器人从事的工作较为低级，且本身的造价过高</span></p></li><li><p><span style=\"color:#000000\">机械手臂很难做到像人类身体和五指那样的灵活</span></p></li><li><p><span style=\"color:#000000\">机械手臂的后期维护过程中人力成本、时间成本较高</span></p></li></ol><p style=\"margin-top: 0px; margin-bottom: 1.5em; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">如果解决了以上这三个问题，使用机械手臂也就不算是什么难事了。有富士康离职员工表示，在富士康主营的手机代工业务里，机器人主要应用领域还是在前端的高精度贴片和后端的装配、搬运环节，在绝大部分中间制造环节，还是必须用人工来完成。</p><p style=\"margin-top: 0px; margin-bottom: 1.5em; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">所以，不管是从成本上还是可行度上考虑，要想真正实现完全自动化都是一件极具挑战的任务，也是一项超前的探索，毕竟这和汽车制造业、重工企业相比起来精确很多，还需要长时间的摸索。换句话说，要想在短时间内用机器手臂代替人工劳动力不是一件轻而易举的事，至于恐惧嘛，更是没必要。</p><p style=\"margin-top: 0px; margin-bottom: 1.5em; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">除了国内，国外的小伙伴也同样有相似的担忧。美国的制造业是全球靠前的，正是因为这样的竞争压力和过高的人力成本，促使企业绞尽脑汁扩大机器人的工作量和岗位占有量，无疑致使出于普通岗位的工人开始担忧自己的工作前景。</p><p style=\"margin-top: 0px; margin-bottom: 1.5em; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">目前，就有美国媒体报道说，四分之一的美国人（尤以年收入在3万美元以下的穷人为主）担心科技的发展会影响他们的就业，这一数字着实让人感到惊讶。根据CNBC最新的All-America Economic Survey调查结果显示，年收入在10万美元以上的人群中也有4%的人抱有同样的担心。</p><p style=\"margin-top: 0px; margin-bottom: 1.5em; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255); text-align: center;\"><img src=\"res/201504/10/auto_735.jpg\" style=\"vertical-align: middle; border: none;\"/><br/></p><p style=\"margin-top: 0px; margin-bottom: 1.5em; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">提到对科技的敬畏就不得不提到教育水平的分界线：五分之一的高中及以下学历的人担心自己会被机器人抢了饭碗，研究生以上学历的人中只有6%担心这一点。CNBC的民调显示美国人和科技之间的关系很复杂，52%的人认为逐渐依赖科技只会让生活变得更加复杂，便利的一面根本不明显。同样的问题在1999年的调查中只有39%这么认为。事实上，收入和接受教育程度跟这样的担忧直接挂钩，也就是说，学历越低、越穷的人就越担心科技发展的太快，觉得自己跟不上时代的步伐。其实这样的担心也不是空穴来风，因为59%的受访者认为网络技术会给工作带来高效率，但是他们并不觉得高效率的产出跟他们所获得薪水成正比，只有35%的人承认自己的薪水因科技因素的介入而上涨，61%的工薪阶层人士其薪水是停滞不前的。或者可以这么解读他们的想法：随着技术的提升，人的劳动力被解放出来，自己的收入没有获得的主要原因是被机械设备赚去了。因此他们就觉得这样的科技进步对自己根本没有什么实际效益。</p><p style=\"margin-top: 0px; margin-bottom: 1.5em; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">不过，有一件事几乎在美国是得到认可的，那就是：科技发展的很快，太快。70%的受访者说科技前进的脚步完全超出了他们5年前所设想的那样，只有9%的人持反对态度。</p><p style=\"margin-top: 0px; margin-bottom: 1.5em; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\"><strong>总结</strong>：从上面的案例可以看出，科学技术的发展总体上带动了经济的发展，但在这同时，劳动者和科技成果之间的矛盾会显露出来，一方面是觉得自己的价值得不到体现，另一方面是觉得自己的岗位随时都有可能被机器人代替而带来的焦躁感。事实上，这完全是多虑了，说是杞人忧天也不为过。毕竟在制造业，人力是不可完全取代的。</p>', '80后的我们生活在一个幸福的时代，至少跟自己的父辈比起来我们会用电子产品，生活上不愁吃不饱穿不暖。可是就是在这样的时代，有人觉得科技发展的脚步危及到自己的生存乐土。可在物竞天择的时代，我不赞同他们！');
INSERT INTO `qinggan_list_22` VALUES ('1382', '1', '43', '68', '736', '<p style=\"text-align:center\"><strong><img src=\"res/201504/10/auto_736.png\" alt=\"auto_736.png\"/></strong></p><p style=\"text-align: left; text-indent: 2em;\"><strong>注：</strong>本文作者为Moz网站专栏作家Cyrus Shepard，是一篇关于“HTTPS站点优化建议及技巧”的分享型文章。文章写于谷歌宣布将“HTTPS协议作为搜索引擎排名参考因素”后。</p><p style=\"text-align: left; text-indent: 2em;\">谷歌几乎没有明确对外公开过影响谷歌搜索引擎排名的因素具体有哪些，因而当其在去年8月份宣布采用“HTTPS加密协议有利于搜索引擎排名”时，我的心情就两字儿：震惊！</p><p style=\"text-align: left; text-indent: 2em;\">HTTPS与其他的谷歌参考因素不同，实行起来比较复杂，有一定的风险性，而且还需一些额外的费用。但利益也是显而易见的，使用HTTPS协议的站点更安全、且在搜索排名上更具优势。</p><p style=\"text-align: left; text-indent: 2em;\">据Moz网站2014年9月份的调查数据显示：</p><p style=\"text-align: left; text-indent: 2em;\"><span style=\"text-indent: 2em;\">17.24%的站长表示其网站已采用HTTPS协议；</span></p><p style=\"text-align: left; text-indent: 2em;\">24.9%的站长表示正在搭建中；</p><p style=\"text-align: left; text-indent: 2em;\">57.85%的站长表示目前仍无此项计划。</p><p style=\"text-align: left; text-indent: 2em;\">如下图：</p><p style=\"text-align:center\"><a href=\"http://upload.chinaz.com/2015/0410/1428648643514.jpg\"><img src=\"res/201504/10/auto_737.jpg\" border=\"0\" alt=\"站长之家, 搜索引擎排名, HTTPS搭建, https和http有什么区别\" style=\"margin: 0px; padding: 0px; border: 1px solid rgb(153, 153, 153); font-style: inherit; font-variant: inherit; line-height: inherit; vertical-align: middle; color: transparent; display: inline-block; width: 600px; height: auto;\"/></a></p><p style=\"text-align: left; text-indent: 2em;\">虽然大部分站长仍无转向HTTPS阵营的打算，但相比之前的情况已有提升。看来，谷歌的算法更新对站长们还是很有震慑力的。</p><p style=\"text-align: left; text-indent: 2em;\">采用HTTPS协议对SEO有何好处？</p><p style=\"text-align: left; text-indent: 2em;\">除了安全性更高这一好处外，HTTPS对SEO也是有一定益处的。</p><p style=\"text-align: left; text-indent: 2em;\">1、使用HTTPS协议有利于搜索引擎排名</p><p style=\"text-align: left; text-indent: 2em;\">去年8月份，谷歌曾发布公告表示将把“是否使用安全加密协议（即HTTPS）”作为搜索引擎排名的一项参考因素。同等情况下，HTTPS站点能比HTTP站点获得更好的搜索排名。</p><p style=\"text-align: left; text-indent: 2em;\">不过得说明下，影响谷歌搜索引擎排名的因素已有逾200项，因而HTTPS协议的影响到底几何目前尚不清楚。</p><p style=\"text-align: left; text-indent: 2em;\">因而，与其他谷歌排名影响因素一样的是，HTTPS协议也并非独立存在的。</p><p style=\"text-align: left; text-indent: 2em;\">建议：</p><p style=\"text-align: left; text-indent: 2em;\">如果只是为了搜索引擎排名的话，那有很多因素的影响力比HTTPS协议大。</p><p style=\"text-align: left; text-indent: 2em;\">如下图（14个影响力大于HTTPS协议的影响因素）：</p><p style=\"text-align:center\"><a href=\"http://upload.chinaz.com/2015/0410/1428648643875.png\"><img src=\"res/201504/10/auto_738.png\" border=\"0\" alt=\"站长之家, 搜索引擎排名, HTTPS搭建, https和http有什么区别\" style=\"margin: 0px; padding: 0px; border: 1px solid rgb(153, 153, 153); font-style: inherit; font-variant: inherit; line-height: inherit; vertical-align: middle; color: transparent; display: inline-block; width: 600px; height: auto;\"/></a></p><p style=\"text-align: left; text-indent: 2em;\">更多影响因素可查看：<a href=\"http://www.chinaz.com/web/2014/0911/367371.shtml\" target=\"_blank\">影响谷歌搜索引擎排名的因素调查（完整版）</a></p><p style=\"text-align: left; text-indent: 2em;\">2、安全隐私</p><p style=\"text-align: left; text-indent: 2em;\">不少站长都认为，只有诸如电子商务、金融、社交网络等存在敏感信息安全问题的站点才有采用HTTPS协议的必要，其实不然。任何类型的站点都可以从中获益。</p><blockquote style=\"text-align: left; text-indent: 2em;\"><p style=\"text-align: left; text-indent: 2em;\">1）使用HTTPS协议可认证用户和服务器，确保数据发送到正确的客户机和服务器；</p><p style=\"text-align: left; text-indent: 2em;\">2）HTTPS协议是由SSL+HTTP协议构建的可进行加密传输、身份认证的网络协议，要比http协议安全，可防止数据在传输过程中不被窃取、改变，确保数据的完整性。</p><p style=\"text-align: left; text-indent: 2em;\">3）HTTPS是现行架构下最安全的解决方案，虽然不是绝对安全，但它大幅增加了中间人攻击的成本。</p></blockquote><p style=\"text-align: left; text-indent: 2em;\">建议：</p><p style=\"text-align: left; text-indent: 2em;\">在成本费用允许情况下，还是建议站长采用HTTPS加密协议，毕竟网站安全也是用户体验的一个重要环节，而且还有利于搜索引擎排名，何乐而不为呢！</p><p style=\"text-align: left; text-indent: 2em;\">使用HTTPS协议有何挑战？</p><p style=\"text-align: left; text-indent: 2em;\">1、容易忽略的问题</p><p style=\"text-align: left; text-indent: 2em;\">将站点由HTTP转为HTTPS协议涉及到很多问题，有时候会忽略了一些重要的细节问题：</p><p style=\"text-align: left; text-indent: 2em;\">1）robots.txt文件中是否屏蔽了重要的URL链接？</p><p style=\"text-align: left; text-indent: 2em;\">2）Canonical标签指向的URL是否正确？</p><p style=\"text-align: left; text-indent: 2em;\">3）当用户访问你的网站时，是否会出现浏览器安全警告提示窗口？（出现安全警告提示可能会吓走用户）</p><p style=\"text-align: left; text-indent: 2em;\">虽然概率很小，但这几个问题还是可能出现的。</p><p style=\"text-align: left; text-indent: 2em;\">2、网站加载速度问题</p><p style=\"text-align: left; text-indent: 2em;\">HTTPS协议的握手过程比较费时，对网站的响应速度有负面影响。据ACM CoNEXT数据显示，使用HTTPS协议很可能会使页面的加载时间延长近50%。而网站加载速度也是影响搜索引擎排名的一个很重要的因素。</p><p style=\"text-align: left; text-indent: 2em;\">不过，还是可以通过一些技巧来减少这个问题的。比如，压缩文本内容可以降低解码耗用的CPU资源。实际上，建立HTTPS连接，要求额外的TCP往返，因此会新增一些发送和接收的字节，但这是第一次打开网页时的情况。</p><p style=\"text-align: left; text-indent: 2em;\">3、成本</p><p style=\"text-align: left; text-indent: 2em;\">据数据显示，很多站长每年花在SSL证书上的费用在100美元-200美元之间，这对于个人博客、或是小型站点来说是一笔不小的开支。不过，现在网上也有不少免费SSL证书，</p><p style=\"text-align: left; text-indent: 2em;\">4、HTTPS兼容性问题</p><p style=\"text-align: left; text-indent: 2em;\">这里所说得“兼容性”包括很多方面，比如现有的Web应用要尽可能无缝地迁移到HTTPS、浏览器对HTTPS的兼容性问题、HTTPS协议解析以及SSL证书管理等。</p><p style=\"text-align: left; text-indent: 2em;\">5、更多问题</p><p style=\"text-align: left; text-indent: 2em;\">如果你的网站依靠AdSense获得收入的话，那么转型HTTPS站点可能会使得收入大幅下降（谷歌对广告源采用SSL协议的站点有所限制）。</p><p style=\"text-align: left; text-indent: 2em;\">此外，即使是谷歌管理员工具也尚不支持HTTPS站点的迁移工作。要完成SSL加密的全球化，需要的不止是时间，还少不了各方的努力啊。</p><p style=\"text-align: left; text-indent: 2em;\">使用HTTPS协议的站点数量增长情况</p><p style=\"text-align: left; text-indent: 2em;\">如今，越来越多的站点采用了HTTPS协议，不过大多用于登陆页面、或是存在交易信息的页面，很少网站选择全站采用HTTPS协议。</p><p style=\"text-align: left; text-indent: 2em;\">据Builtwith调查数据显示，在排名TOP 10000的网站中，只有4.2%的站点默认使用HTTPS加密访问模式。再将范围放大到TOP 100万个网站，这个百分比则降到了1.9%。</p><p style=\"text-align: left; text-indent: 2em;\">如下图：</p><p style=\"text-align:center\"><a href=\"http://upload.chinaz.com/2015/0410/1428648643761.jpg\"><img src=\"res/201504/10/auto_739.jpg\" border=\"0\" alt=\"站长之家, 搜索引擎排名, HTTPS搭建, https和http有什么区别\" style=\"margin: 0px; padding: 0px; border: 1px solid rgb(153, 153, 153); font-style: inherit; font-variant: inherit; line-height: inherit; vertical-align: middle; color: transparent; display: inline-block; width: 600px; height: auto;\"/></a></p><p style=\"text-align: left; text-indent: 2em;\">不过，随着谷歌和百度等搜索引擎对HTTPS协议的“优待”，这个百分比未来应该会有所上升。</p><p style=\"text-align: left; text-indent: 2em;\"><br/></p><p style=\"text-align: left; text-indent: 2em;\"><strong>HTTPS站点的SEO自检清单</strong></p><blockquote><p style=\"text-align: left; text-indent: 2em;\">1、确保网站的每个元素（包括插件、JS、CSS文件、图片、内容分发网站等）都采用HTTPS协议；</p><p style=\"text-align: left; text-indent: 2em;\">2、使用301重定向将HTTP URL指向HTTPS版地址。记住别误用302跳转；<br/></p><p style=\"text-align: left; text-indent: 2em;\">3、保证Canonical标签指向HTTPS版URL；</p><p style=\"text-align: left; text-indent: 2em;\">4、采用HTTPS协议后，应确保网站内链指向的是HTTPS版URL，而非旧版URL。这对用户体验以及网站优化而言，都是一个很重要的步骤。</p><p style=\"text-align: left; text-indent: 2em;\">5、在谷歌、必应等平台上的管理员工具中监控HTTPS版本站点；</p><p style=\"text-align: left; text-indent: 2em;\">6、使用谷歌管理员工具中Fetch&amp;Render功能（http://googlewebmastercentral.blogspot.com/2014/05/rendering-pages-with-fetch-as-google.html），确保你的HTTPS站点能够正常的被谷歌抓取；</p><p style=\"text-align: left; text-indent: 2em;\">7、更新网站sitemaps，并在谷歌管理员工具中提交新版sitemaps；</p><p style=\"text-align: left; text-indent: 2em;\">8、更新robots.txt文件，加入新版sitemaps内容，确保重要的HTTPS版页面不会被屏蔽；</p><p style=\"text-align: left; text-indent: 2em;\">9、如有必要，还应该更新网站的分析跟踪代码。现在已经有很多新的谷歌分析代码段都能够处理HTTPS站点了。<br/></p><p style=\"text-align: left; text-indent: 2em;\">10、采用HSTS协议（HTTP严格传输安全协议），其作用是强制客户端（如浏览器）使用HTTPS与服务器建立连接。可在保证安全性的前提下，提高网站的响应速度。</p></blockquote>', '');
INSERT INTO `qinggan_list_22` VALUES ('1410', '1', '43', '219', '889', '<p>招生信息test1招生信息test1招生信息test1招生信息test1招生信息test1</p>', '招生信息test1招生信息test1招生信息test1招生信息test1');
INSERT INTO `qinggan_list_22` VALUES ('1411', '1', '167', '0', '', '<p>xyggxyggxyggxyggxyggxyggxygg</p>', 'xyggxyggxyggxyggxygg');
INSERT INTO `qinggan_list_22` VALUES ('1427', '1', '172', '0', '', '<p>最新动态1</p>', '最新动态1');
INSERT INTO `qinggan_list_22` VALUES ('1428', '1', '172', '0', '', '<p>最新动态12</p>', '最新动态12');
INSERT INTO `qinggan_list_22` VALUES ('1429', '1', '172', '0', '', '<p>最新动态13</p>', '最新动态13');
INSERT INTO `qinggan_list_22` VALUES ('1430', '1', '43', '8', '888', '<p>test1test1test1</p>', 'test1');
INSERT INTO `qinggan_list_22` VALUES ('1422', '1', '171', '0', '', '<p>热点新闻test1</p>', '热点新闻test1');
INSERT INTO `qinggan_list_22` VALUES ('1423', '1', '171', '0', '', '<p>热点新闻test2</p>', '热点新闻test2');
INSERT INTO `qinggan_list_22` VALUES ('1424', '1', '171', '0', '', '<p>热点新闻test3</p>', '热点新闻test3');

-- ----------------------------
-- Table structure for `qinggan_list_23`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_list_23`;
CREATE TABLE `qinggan_list_23` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主题ID',
  `site_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '网站ID',
  `project_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '项目ID',
  `cate_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '主分类ID',
  `link` longtext NOT NULL COMMENT '链接',
  `target` varchar(255) NOT NULL DEFAULT '_self' COMMENT '链接方式',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`,`project_id`,`cate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='导航';

-- ----------------------------
-- Records of qinggan_list_23
-- ----------------------------
INSERT INTO `qinggan_list_23` VALUES ('520', '1', '42', '0', 'a:2:{s:7:\"default\";s:9:\"index.php\";s:7:\"rewrite\";s:10:\"index.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('712', '1', '42', '0', 'a:2:{s:7:\"default\";s:21:\"index.php?id=about-us\";s:7:\"rewrite\";s:13:\"about-us.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('713', '1', '42', '0', 'a:2:{s:7:\"default\";s:17:\"index.php?id=news\";s:7:\"rewrite\";s:9:\"news.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('714', '1', '42', '0', 'a:2:{s:7:\"default\";s:20:\"index.php?id=product\";s:7:\"rewrite\";s:12:\"product.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('1396', '1', '42', '0', 'a:2:{s:7:\"default\";s:20:\"index.php?id=mission\";s:7:\"rewrite\";s:12:\"mission.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('755', '1', '42', '0', 'a:2:{s:7:\"default\";s:17:\"index.php?id=work\";s:7:\"rewrite\";s:9:\"work.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('1433', '1', '42', '0', 'a:2:{s:7:\"default\";s:17:\"index.php?id=xygg\";s:7:\"rewrite\";s:0:\"\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('1404', '1', '42', '0', 'a:2:{s:7:\"default\";s:9:\"index.php\";s:7:\"rewrite\";s:10:\"index.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('1254', '1', '42', '0', 'a:2:{s:7:\"default\";s:31:\"index.php?id=development-course\";s:7:\"rewrite\";s:23:\"development-course.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('1256', '1', '42', '0', 'a:2:{s:7:\"default\";s:18:\"index.php?id=photo\";s:7:\"rewrite\";s:10:\"photo.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('1408', '1', '147', '0', 'a:2:{s:7:\"default\";s:9:\"index.php\";s:7:\"rewrite\";s:10:\"index.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('1300', '1', '147', '0', 'a:2:{s:7:\"default\";s:21:\"index.php?id=about-us\";s:7:\"rewrite\";s:13:\"about-us.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('1301', '1', '147', '0', 'a:2:{s:7:\"default\";s:31:\"index.php?id=development-course\";s:7:\"rewrite\";s:23:\"development-course.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('1302', '1', '147', '0', 'a:2:{s:7:\"default\";s:17:\"index.php?id=news\";s:7:\"rewrite\";s:9:\"news.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('1304', '1', '147', '0', 'a:2:{s:7:\"default\";s:23:\"index.php?id=contact-us\";s:7:\"rewrite\";s:15:\"contact-us.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('1397', '1', '42', '0', 'a:2:{s:7:\"default\";s:32:\"index.php?id=student-development\";s:7:\"rewrite\";s:24:\"student-development.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('1405', '1', '42', '0', 'a:2:{s:7:\"default\";s:9:\"index.php\";s:7:\"rewrite\";s:10:\"index.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('1406', '1', '42', '0', 'a:2:{s:7:\"default\";s:9:\"index.php\";s:7:\"rewrite\";s:10:\"index.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('1407', '1', '42', '0', 'a:2:{s:7:\"default\";s:9:\"index.php\";s:7:\"rewrite\";s:10:\"index.html\";}', '_self');
INSERT INTO `qinggan_list_23` VALUES ('1434', '1', '42', '0', 'a:2:{s:7:\"default\";s:9:\"index.php\";s:7:\"rewrite\";s:10:\"index.html\";}', '_self');

-- ----------------------------
-- Table structure for `qinggan_list_24`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_list_24`;
CREATE TABLE `qinggan_list_24` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主题ID',
  `site_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '网站ID',
  `project_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '项目ID',
  `cate_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '主分类ID',
  `thumb` varchar(255) NOT NULL DEFAULT '' COMMENT '缩略图',
  `pictures` varchar(255) NOT NULL DEFAULT '' COMMENT '图片',
  `content` longtext NOT NULL COMMENT '内容',
  `spec_single` longtext NOT NULL COMMENT '产品属性',
  `qingdian` longtext NOT NULL COMMENT '包装清单',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`,`project_id`,`cate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='产品';

-- ----------------------------
-- Records of qinggan_list_24
-- ----------------------------

-- ----------------------------
-- Table structure for `qinggan_list_40`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_list_40`;
CREATE TABLE `qinggan_list_40` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主题ID',
  `site_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '网站ID',
  `project_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '项目ID',
  `cate_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '主分类ID',
  `content` longtext NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`,`project_id`,`cate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='关于我们';

-- ----------------------------
-- Records of qinggan_list_40
-- ----------------------------

-- ----------------------------
-- Table structure for `qinggan_list_46`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_list_46`;
CREATE TABLE `qinggan_list_46` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主题ID',
  `site_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '网站ID',
  `project_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '项目ID',
  `cate_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '主分类ID',
  `fullname` varchar(255) NOT NULL DEFAULT '' COMMENT '姓名',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '邮箱',
  `content` longtext NOT NULL COMMENT '内容',
  `adm_reply` longtext NOT NULL COMMENT '管理员回复',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`,`project_id`,`cate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='留言模块';

-- ----------------------------
-- Records of qinggan_list_46
-- ----------------------------

-- ----------------------------
-- Table structure for `qinggan_list_61`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_list_61`;
CREATE TABLE `qinggan_list_61` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主题ID',
  `site_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '网站ID',
  `project_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '项目ID',
  `cate_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '主分类ID',
  `link` longtext NOT NULL COMMENT '链接',
  `target` varchar(255) NOT NULL DEFAULT '_self' COMMENT '链接方式',
  `tel` varchar(255) NOT NULL DEFAULT '' COMMENT '联系人电话',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`,`project_id`,`cate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='友情链接';

-- ----------------------------
-- Records of qinggan_list_61
-- ----------------------------
INSERT INTO `qinggan_list_61` VALUES ('1261', '1', '142', '0', 'http://www.sz-qibang.com/', '_blank', '');
INSERT INTO `qinggan_list_61` VALUES ('1262', '1', '142', '0', 'http://www.17tengfei.com/', '_blank', '');
INSERT INTO `qinggan_list_61` VALUES ('1263', '1', '142', '0', 'http://www.7139.com', '_blank', '');
INSERT INTO `qinggan_list_61` VALUES ('1264', '1', '142', '0', 'http://www.chinaz.com/', '_blank', '');
INSERT INTO `qinggan_list_61` VALUES ('1265', '1', '142', '0', 'http://www.admin5.com/', '_blank', '');
INSERT INTO `qinggan_list_61` VALUES ('1266', '1', '142', '0', 'http://www.cnzz.cn/', '_blank', '');
INSERT INTO `qinggan_list_61` VALUES ('1267', '1', '142', '0', 'http://www.im286.com/', '_blank', '');
INSERT INTO `qinggan_list_61` VALUES ('1268', '1', '142', '0', 'http://www.mycodes.net/', '_blank', '');

-- ----------------------------
-- Table structure for `qinggan_list_64`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_list_64`;
CREATE TABLE `qinggan_list_64` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主题ID',
  `site_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '网站ID',
  `project_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '项目ID',
  `cate_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '主分类ID',
  `code` longtext NOT NULL COMMENT '客服代码',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`,`project_id`,`cate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='客服';

-- ----------------------------
-- Records of qinggan_list_64
-- ----------------------------

-- ----------------------------
-- Table structure for `qinggan_list_68`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_list_68`;
CREATE TABLE `qinggan_list_68` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主题ID',
  `site_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '网站ID',
  `project_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '项目ID',
  `cate_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '主分类ID',
  `thumb` varchar(255) NOT NULL DEFAULT '' COMMENT '缩略图',
  `pictures` varchar(255) NOT NULL DEFAULT '' COMMENT '图片',
  `content` longtext NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`,`project_id`,`cate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='图集相册';

-- ----------------------------
-- Records of qinggan_list_68
-- ----------------------------
INSERT INTO `qinggan_list_68` VALUES ('1431', '1', '173', '0', '875', '866,867,870,872,874,876,873,871,869,865', '<p>tests他tests他tests他tests他tests他tests他tests他</p>');
INSERT INTO `qinggan_list_68` VALUES ('1432', '1', '173', '0', '830', '', '');
INSERT INTO `qinggan_list_68` VALUES ('1439', '1', '173', '0', '868', '', '');
INSERT INTO `qinggan_list_68` VALUES ('1440', '1', '173', '0', '868', '', '');
INSERT INTO `qinggan_list_68` VALUES ('1441', '1', '173', '0', '830', '', '');
INSERT INTO `qinggan_list_68` VALUES ('1442', '1', '173', '0', '868', '', '');

-- ----------------------------
-- Table structure for `qinggan_list_74`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_list_74`;
CREATE TABLE `qinggan_list_74` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主题ID',
  `site_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '网站ID',
  `project_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '项目ID',
  `cate_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '主分类ID',
  `pic` varchar(255) NOT NULL DEFAULT '' COMMENT '图片',
  `link` longtext NOT NULL COMMENT '链接',
  `target` varchar(255) NOT NULL DEFAULT '_blank' COMMENT '链接方式',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`,`project_id`,`cate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='新闻图片轮播';

-- ----------------------------
-- Records of qinggan_list_74
-- ----------------------------
INSERT INTO `qinggan_list_74` VALUES ('1417', '1', '169', '0', '830', 'index.php', '_blank');
INSERT INTO `qinggan_list_74` VALUES ('1416', '1', '169', '0', '868', 'index.php', '_blank');
INSERT INTO `qinggan_list_74` VALUES ('1435', '1', '174', '0', '887', 'index.php', '_blank');
INSERT INTO `qinggan_list_74` VALUES ('1436', '1', '169', '0', '875', 'index.php', '_blank');
INSERT INTO `qinggan_list_74` VALUES ('1437', '1', '169', '0', '875', 'index.php', '_blank');
INSERT INTO `qinggan_list_74` VALUES ('1438', '1', '169', '0', '855', 'index.php', '_blank');

-- ----------------------------
-- Table structure for `qinggan_list_cate`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_list_cate`;
CREATE TABLE `qinggan_list_cate` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主题ID',
  `cate_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  PRIMARY KEY (`id`,`cate_id`),
  KEY `id` (`id`),
  KEY `cate_id` (`cate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='主题绑定的分类';

-- ----------------------------
-- Records of qinggan_list_cate
-- ----------------------------
INSERT INTO `qinggan_list_cate` VALUES ('1253', '168');
INSERT INTO `qinggan_list_cate` VALUES ('1306', '191');
INSERT INTO `qinggan_list_cate` VALUES ('1310', '198');
INSERT INTO `qinggan_list_cate` VALUES ('1311', '204');
INSERT INTO `qinggan_list_cate` VALUES ('1334', '204');
INSERT INTO `qinggan_list_cate` VALUES ('1336', '204');
INSERT INTO `qinggan_list_cate` VALUES ('1348', '204');
INSERT INTO `qinggan_list_cate` VALUES ('1356', '205');
INSERT INTO `qinggan_list_cate` VALUES ('1368', '8');
INSERT INTO `qinggan_list_cate` VALUES ('1369', '8');
INSERT INTO `qinggan_list_cate` VALUES ('1370', '8');
INSERT INTO `qinggan_list_cate` VALUES ('1370', '207');
INSERT INTO `qinggan_list_cate` VALUES ('1371', '207');
INSERT INTO `qinggan_list_cate` VALUES ('1372', '207');
INSERT INTO `qinggan_list_cate` VALUES ('1373', '68');
INSERT INTO `qinggan_list_cate` VALUES ('1380', '204');
INSERT INTO `qinggan_list_cate` VALUES ('1381', '68');
INSERT INTO `qinggan_list_cate` VALUES ('1382', '68');
INSERT INTO `qinggan_list_cate` VALUES ('1386', '211');
INSERT INTO `qinggan_list_cate` VALUES ('1387', '211');
INSERT INTO `qinggan_list_cate` VALUES ('1388', '211');
INSERT INTO `qinggan_list_cate` VALUES ('1389', '211');
INSERT INTO `qinggan_list_cate` VALUES ('1392', '215');
INSERT INTO `qinggan_list_cate` VALUES ('1392', '216');
INSERT INTO `qinggan_list_cate` VALUES ('1393', '207');
INSERT INTO `qinggan_list_cate` VALUES ('1394', '207');
INSERT INTO `qinggan_list_cate` VALUES ('1395', '68');
INSERT INTO `qinggan_list_cate` VALUES ('1409', '219');
INSERT INTO `qinggan_list_cate` VALUES ('1410', '219');
INSERT INTO `qinggan_list_cate` VALUES ('1418', '221');
INSERT INTO `qinggan_list_cate` VALUES ('1419', '222');
INSERT INTO `qinggan_list_cate` VALUES ('1420', '222');
INSERT INTO `qinggan_list_cate` VALUES ('1421', '222');
INSERT INTO `qinggan_list_cate` VALUES ('1430', '8');

-- ----------------------------
-- Table structure for `qinggan_module`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_module`;
CREATE TABLE `qinggan_module` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `title` varchar(255) NOT NULL COMMENT '模块名称',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0不使用1使用',
  `taxis` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '模块排序',
  `note` varchar(255) NOT NULL COMMENT '模块说明',
  `layout` text NOT NULL COMMENT '布局',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 COMMENT='模块管理，每创建一个模块自动创建一个表';

-- ----------------------------
-- Records of qinggan_module
-- ----------------------------
INSERT INTO `qinggan_module` VALUES ('21', '图片轮播', '1', '20', '适用于图片播放器，图片友情链接', 'pic,link,target');
INSERT INTO `qinggan_module` VALUES ('22', '文章资讯', '1', '10', '适用于新闻，文章之类', 'hits,dateline,thumb');
INSERT INTO `qinggan_module` VALUES ('23', '自定义链接', '1', '30', '适用于导航，页脚文本导航，文字友情链接', 'link,target');
INSERT INTO `qinggan_module` VALUES ('24', '产品', '1', '40', '适用于电子商务中产品展示模型', 'hits,dateline,thumb');
INSERT INTO `qinggan_module` VALUES ('40', '单页信息', '1', '60', '适用于公司简介，联系我们', 'hits,dateline');
INSERT INTO `qinggan_module` VALUES ('46', '留言模块', '0', '100', '', 'dateline,fullname,email,content');
INSERT INTO `qinggan_module` VALUES ('61', '友情链接', '1', '120', '适用于导航，页脚文本导航，文字友情链接', 'link,target,tel');
INSERT INTO `qinggan_module` VALUES ('64', '客服', '0', '130', '', 'dateline');
INSERT INTO `qinggan_module` VALUES ('68', '图集相册', '1', '80', '', 'hits,dateline,thumb');
INSERT INTO `qinggan_module` VALUES ('74', '新闻图片轮播', '1', '15', '适用于新闻小图片播放器', 'pic,link,target');

-- ----------------------------
-- Table structure for `qinggan_module_fields`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_module_fields`;
CREATE TABLE `qinggan_module_fields` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '字段ID，自增',
  `module_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '模块ID',
  `title` varchar(255) NOT NULL COMMENT '字段名称',
  `identifier` varchar(50) NOT NULL COMMENT '字段标识串',
  `field_type` varchar(255) NOT NULL DEFAULT '200' COMMENT '字段存储类型',
  `note` varchar(255) NOT NULL COMMENT '字段内容备注',
  `form_type` varchar(100) NOT NULL COMMENT '表单类型',
  `form_style` varchar(255) NOT NULL COMMENT '表单CSS',
  `format` varchar(100) NOT NULL COMMENT '格式化方式',
  `content` varchar(255) NOT NULL COMMENT '默认值',
  `taxis` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  `ext` text NOT NULL COMMENT '扩展内容',
  `is_front` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0前端不可用1前端可用',
  PRIMARY KEY (`id`),
  KEY `module_id` (`module_id`)
) ENGINE=MyISAM AUTO_INCREMENT=272 DEFAULT CHARSET=utf8 COMMENT='字段管理器';

-- ----------------------------
-- Records of qinggan_module_fields
-- ----------------------------
INSERT INTO `qinggan_module_fields` VALUES ('92', '21', '链接', 'link', 'longtext', '', 'text', '', 'safe', '', '90', 'a:2:{s:8:\"form_btn\";s:3:\"url\";s:5:\"width\";s:3:\"500\";}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('82', '22', '缩略图', 'thumb', 'varchar', '', 'upload', '', 'safe', '', '30', 'a:3:{s:7:\"cate_id\";s:1:\"1\";s:11:\"is_multiple\";s:1:\"0\";s:11:\"upload_auto\";s:1:\"0\";}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('83', '22', '内容', 'content', 'longtext', '', 'editor', '', 'html_js', '', '255', 'a:13:{s:5:\"width\";s:3:\"950\";s:6:\"height\";s:3:\"360\";s:7:\"is_code\";i:0;s:9:\"btn_image\";i:1;s:9:\"btn_video\";i:1;s:8:\"btn_file\";i:1;s:8:\"btn_page\";i:1;s:8:\"btn_info\";i:1;s:7:\"is_read\";i:0;s:5:\"etype\";s:4:\"full\";s:7:\"btn_map\";i:1;s:7:\"inc_tag\";i:1;s:10:\"paste_text\";i:0;}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('84', '23', '链接', 'link', 'longtext', '设置导航链接', 'url', '', 'safe', '', '90', 'a:1:{s:5:\"width\";s:3:\"500\";}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('85', '23', '链接方式', 'target', 'varchar', '设置是否在新窗口打开', 'radio', '', 'safe', '_self', '100', 'a:1:{s:11:\"option_list\";s:5:\"opt:6\";}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('87', '24', '缩略图', 'thumb', 'varchar', '上传规格要求150x200，该图片仅在首页及产品列表页中使用', 'upload', '', 'safe', '', '30', 'a:3:{s:7:\"cate_id\";s:2:\"12\";s:11:\"is_multiple\";s:1:\"0\";s:11:\"upload_auto\";s:1:\"1\";}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('88', '24', '图片', 'pictures', 'varchar', '设置产品的图片，支持多图，上传规格为500x500', 'upload', '', 'safe', '', '50', 'a:3:{s:7:\"cate_id\";s:2:\"14\";s:11:\"is_multiple\";s:1:\"1\";s:11:\"upload_auto\";s:1:\"0\";}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('90', '24', '内容', 'content', 'longtext', '填写产品介绍信息', 'editor', '', 'html_js', '', '255', 'a:12:{s:5:\"width\";s:3:\"950\";s:6:\"height\";s:3:\"400\";s:7:\"is_code\";i:0;s:9:\"btn_image\";i:1;s:9:\"btn_video\";i:1;s:8:\"btn_file\";i:1;s:8:\"btn_page\";i:0;s:8:\"btn_info\";i:0;s:7:\"is_read\";i:0;s:5:\"etype\";s:4:\"full\";s:7:\"btn_map\";i:0;s:7:\"inc_tag\";i:0;}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('93', '21', '链接方式', 'target', 'varchar', '设置是否在新窗口打开', 'radio', '', 'safe', '_blank', '100', 'a:3:{s:11:\"option_list\";s:5:\"opt:6\";s:9:\"put_order\";s:1:\"0\";s:10:\"ext_select\";b:0;}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('131', '40', '内容', 'content', 'longtext', '', 'editor', '', 'html_js', '', '255', 'a:7:{s:5:\"width\";s:3:\"800\";s:6:\"height\";s:3:\"360\";s:7:\"is_code\";b:0;s:9:\"btn_image\";s:1:\"1\";s:9:\"btn_video\";s:1:\"1\";s:8:\"btn_file\";s:1:\"1\";s:8:\"btn_page\";b:0;}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('141', '46', '姓名', 'fullname', 'varchar', '', 'text', '', 'safe', '', '10', 'a:4:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"300\";s:15:\"ext_quick_words\";b:0;s:14:\"ext_quick_type\";b:0;}', '1');
INSERT INTO `qinggan_module_fields` VALUES ('142', '46', '邮箱', 'email', 'varchar', '', 'text', '', 'safe', '', '130', 'a:4:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"300\";s:15:\"ext_quick_words\";b:0;s:14:\"ext_quick_type\";b:0;}', '1');
INSERT INTO `qinggan_module_fields` VALUES ('143', '46', '内容', 'content', 'longtext', '', 'textarea', '', 'safe', '', '200', 'a:2:{s:5:\"width\";s:3:\"500\";s:6:\"height\";s:3:\"180\";}', '1');
INSERT INTO `qinggan_module_fields` VALUES ('144', '46', '管理员回复', 'adm_reply', 'longtext', '', 'editor', '', 'html', '', '255', 'a:7:{s:5:\"width\";s:3:\"800\";s:6:\"height\";s:3:\"100\";s:7:\"is_code\";i:0;s:9:\"btn_image\";i:0;s:9:\"btn_video\";i:0;s:8:\"btn_file\";i:0;s:8:\"btn_page\";b:0;}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('200', '21', '图片', 'pic', 'varchar', '图片宽高建议使用980x180', 'upload', '', 'safe', '', '20', 'a:3:{s:7:\"cate_id\";s:2:\"13\";s:11:\"is_multiple\";s:1:\"0\";s:11:\"upload_auto\";s:1:\"0\";}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('177', '22', '摘要', 'note', 'longtext', '简要文字描述', 'textarea', '', 'safe', '', '20', 'a:2:{s:5:\"width\";s:3:\"800\";s:6:\"height\";s:2:\"80\";}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('204', '61', '链接方式', 'target', 'varchar', '设置是否在新窗口打开', 'radio', '', 'safe', '_self', '100', 'a:3:{s:11:\"option_list\";s:5:\"opt:6\";s:9:\"put_order\";s:1:\"0\";s:10:\"ext_select\";s:0:\"\";}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('203', '61', '链接', 'link', 'longtext', '填写链接要求带上http://', 'text', 'height:22px;line-height:22px;padding:3px;border:1px solid #ccc;', 'safe', '', '90', 'a:4:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"280\";s:15:\"ext_quick_words\";b:0;s:14:\"ext_quick_type\";b:0;}', '1');
INSERT INTO `qinggan_module_fields` VALUES ('217', '24', '参数', 'spec_single', 'longtext', '设置产品的规格参数', 'param', '', 'safe', '', '110', 'a:3:{s:6:\"p_name\";s:140:\"袖型\r\n细节\r\n风格\r\n尺码\r\n人群\r\n版型\r\n颜色\r\n元素\r\n领型\r\n图案\r\n材质\r\n镶嵌方式\r\n款式\r\n重量\r\n圈号\r\n证书\r\n产地\";s:6:\"p_type\";s:1:\"0\";s:7:\"p_width\";s:0:\"\";}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('218', '64', '客服代码', 'code', 'longtext', '请输入相应的客服代码，不支持JS', 'code_editor', '', 'html', '', '20', 'a:2:{s:5:\"width\";s:3:\"500\";s:6:\"height\";s:3:\"100\";}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('219', '24', '包装清单', 'qingdian', 'longtext', '设置产品包装中包含哪些清单', 'editor', '', 'html', '', '130', 'a:13:{s:5:\"width\";s:3:\"950\";s:6:\"height\";s:2:\"80\";s:7:\"is_code\";i:0;s:9:\"btn_image\";i:0;s:9:\"btn_video\";i:0;s:8:\"btn_file\";i:0;s:8:\"btn_page\";i:0;s:8:\"btn_info\";i:0;s:7:\"is_read\";i:0;s:5:\"etype\";s:6:\"simple\";s:7:\"btn_map\";i:0;s:7:\"inc_tag\";i:0;s:10:\"paste_text\";i:0;}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('239', '68', '缩略图', 'thumb', 'varchar', '请上传200x240规格的图片，文件大小建议不超过100KB', 'upload', '', 'safe', '', '30', 'a:3:{s:7:\"cate_id\";s:2:\"12\";s:11:\"is_multiple\";s:1:\"0\";s:11:\"upload_auto\";s:1:\"1\";}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('240', '68', '图片', 'pictures', 'varchar', '支持多图', 'upload', '', 'safe', '', '50', 'a:3:{s:7:\"cate_id\";s:2:\"15\";s:11:\"is_multiple\";s:1:\"1\";s:11:\"upload_auto\";s:1:\"0\";}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('244', '61', '联系人电话', 'tel', 'varchar', '填写联系人电话，以方便与人取得联系', 'text', 'height:22px;line-height:22px;padding:3px;border:1px solid #ccc;', 'safe', '', '110', 'a:4:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"280\";s:15:\"ext_quick_words\";b:0;s:14:\"ext_quick_type\";b:0;}', '1');
INSERT INTO `qinggan_module_fields` VALUES ('267', '68', '内容', 'content', 'longtext', '', 'editor', '', 'html', '', '255', 'a:11:{s:5:\"width\";s:3:\"950\";s:6:\"height\";s:3:\"360\";s:7:\"is_code\";s:0:\"\";s:9:\"btn_image\";s:1:\"1\";s:9:\"btn_video\";s:1:\"1\";s:8:\"btn_file\";s:1:\"1\";s:8:\"btn_page\";s:0:\"\";s:8:\"btn_info\";s:0:\"\";s:7:\"is_read\";s:0:\"\";s:5:\"etype\";s:4:\"full\";s:7:\"btn_map\";s:0:\"\";}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('269', '74', '图片', 'pic', 'varchar', '图片宽高建议使用343x230', 'upload', '', 'safe', '', '20', 'a:3:{s:7:\"cate_id\";s:2:\"13\";s:11:\"is_multiple\";s:1:\"0\";s:11:\"upload_auto\";s:1:\"0\";}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('270', '74', '链接', 'link', 'longtext', '', 'text', '', 'safe', '', '90', 'a:2:{s:8:\"form_btn\";s:3:\"url\";s:5:\"width\";s:3:\"500\";}', '0');
INSERT INTO `qinggan_module_fields` VALUES ('271', '74', '链接方式', 'target', 'varchar', '设置是否在新窗口打开', 'radio', '', 'safe', '_blank', '100', 'a:3:{s:11:\"option_list\";s:5:\"opt:6\";s:9:\"put_order\";s:1:\"0\";s:10:\"ext_select\";b:0;}', '0');

-- ----------------------------
-- Table structure for `qinggan_opt`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_opt`;
CREATE TABLE `qinggan_opt` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `group_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '组ID',
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '父级ID',
  `title` varchar(255) NOT NULL COMMENT '名称',
  `val` varchar(255) NOT NULL COMMENT '值',
  `taxis` int(10) unsigned NOT NULL DEFAULT '255' COMMENT '排序，值越小越往前靠',
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COMMENT='表单列表选项';

-- ----------------------------
-- Records of qinggan_opt
-- ----------------------------
INSERT INTO `qinggan_opt` VALUES ('1', '1', '0', '女', '', '20');
INSERT INTO `qinggan_opt` VALUES ('2', '1', '0', '男', '1', '10');
INSERT INTO `qinggan_opt` VALUES ('5', '2', '0', '福建省', '福建省', '255');
INSERT INTO `qinggan_opt` VALUES ('6', '2', '5', '泉州市', '泉州市', '255');
INSERT INTO `qinggan_opt` VALUES ('7', '2', '6', '永春县', '永春县', '255');
INSERT INTO `qinggan_opt` VALUES ('8', '2', '7', '一都镇', '一都镇', '255');
INSERT INTO `qinggan_opt` VALUES ('9', '2', '8', '美岭村', '美岭村', '255');
INSERT INTO `qinggan_opt` VALUES ('11', '2', '0', '广东省', '广东省', '255');
INSERT INTO `qinggan_opt` VALUES ('12', '2', '11', '深圳市', '深圳市', '255');
INSERT INTO `qinggan_opt` VALUES ('13', '2', '12', '龙岗区', '龙岗区', '10');
INSERT INTO `qinggan_opt` VALUES ('14', '2', '12', '罗湖区', '罗湖区', '20');
INSERT INTO `qinggan_opt` VALUES ('15', '2', '12', '福田区', '福田区', '30');
INSERT INTO `qinggan_opt` VALUES ('16', '2', '12', '龙华区', '龙华区', '40');
INSERT INTO `qinggan_opt` VALUES ('17', '4', '0', '是', '1', '10');
INSERT INTO `qinggan_opt` VALUES ('18', '4', '0', '否', '', '20');
INSERT INTO `qinggan_opt` VALUES ('21', '6', '0', '当前窗口', '_self', '10');
INSERT INTO `qinggan_opt` VALUES ('22', '6', '0', '新窗口', '_blank', '20');
INSERT INTO `qinggan_opt` VALUES ('23', '7', '0', '启用', '1', '10');
INSERT INTO `qinggan_opt` VALUES ('24', '7', '0', '禁用', '', '20');
INSERT INTO `qinggan_opt` VALUES ('25', '8', '0', 'UTF-8', 'utf8', '20');
INSERT INTO `qinggan_opt` VALUES ('26', '8', '0', 'GBK', 'gbk', '10');
INSERT INTO `qinggan_opt` VALUES ('62', '12', '0', '不置顶', '', '10');
INSERT INTO `qinggan_opt` VALUES ('63', '12', '0', '一级置顶', '1', '20');
INSERT INTO `qinggan_opt` VALUES ('64', '12', '0', '二级置顶', '2', '30');

-- ----------------------------
-- Table structure for `qinggan_opt_group`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_opt_group`;
CREATE TABLE `qinggan_opt_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID ',
  `title` varchar(100) NOT NULL COMMENT '名称，用于后台管理',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='可选菜单管理器';

-- ----------------------------
-- Records of qinggan_opt_group
-- ----------------------------
INSERT INTO `qinggan_opt_group` VALUES ('1', '性别');
INSERT INTO `qinggan_opt_group` VALUES ('2', '省市县多级联动');
INSERT INTO `qinggan_opt_group` VALUES ('4', '是与否');
INSERT INTO `qinggan_opt_group` VALUES ('6', '窗口打开方式');
INSERT INTO `qinggan_opt_group` VALUES ('7', '注册');
INSERT INTO `qinggan_opt_group` VALUES ('8', '邮件编码');
INSERT INTO `qinggan_opt_group` VALUES ('12', '置顶属性');

-- ----------------------------
-- Table structure for `qinggan_order`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_order`;
CREATE TABLE `qinggan_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `sn` varchar(255) NOT NULL COMMENT '订单编号，唯一值',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID号，为0表示游客',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `qty` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '产品数量',
  `price` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '金额',
  `currency_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '货币类型',
  `status` varchar(255) NOT NULL COMMENT '订单的最后状态',
  `endtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `passwd` varchar(255) NOT NULL COMMENT '密码串',
  `ext` text NOT NULL COMMENT '扩展内容信息，可用于存储一些扩展信息',
  `note` text NOT NULL COMMENT '摘要',
  `pay_id` int(11) NOT NULL COMMENT '支付接口ID',
  `pay_title` varchar(255) NOT NULL COMMENT '支付名称',
  `pay_date` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支付时间戳',
  `pay_status` varchar(255) NOT NULL COMMENT '支付状态',
  `pay_price` varchar(255) NOT NULL COMMENT '支付金额',
  `pay_currency` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支付货币类型',
  `pay_currency_code` varchar(20) NOT NULL COMMENT '支付货币简码',
  `pay_currency_rate` decimal(13,8) unsigned NOT NULL DEFAULT '0.00000000' COMMENT '汇率',
  `pay_end` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1支付已审核并已结束0表示正在进行中',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ordersn` (`sn`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='订单中心';

-- ----------------------------
-- Records of qinggan_order
-- ----------------------------

-- ----------------------------
-- Table structure for `qinggan_order_address`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_order_address`;
CREATE TABLE `qinggan_order_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单ID',
  `country` varchar(255) NOT NULL DEFAULT '中国' COMMENT '国家',
  `province` varchar(255) NOT NULL COMMENT '省信息',
  `city` varchar(255) NOT NULL COMMENT '市',
  `county` varchar(255) NOT NULL COMMENT '县',
  `address` varchar(255) NOT NULL COMMENT '地址信息（不含国家，省市县镇区信息）',
  `zipcode` varchar(20) NOT NULL COMMENT '邮编',
  `type_id` enum('shipping','billing') NOT NULL DEFAULT 'shipping' COMMENT '类型，默认走送货地址',
  `mobile` varchar(100) NOT NULL COMMENT '手机号码',
  `tel` varchar(100) NOT NULL COMMENT '电话号码',
  `email` varchar(100) NOT NULL COMMENT '邮箱',
  `fullname` varchar(100) NOT NULL COMMENT '联系人姓名',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0女1男',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='订单地址库';

-- ----------------------------
-- Records of qinggan_order_address
-- ----------------------------

-- ----------------------------
-- Table structure for `qinggan_order_product`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_order_product`;
CREATE TABLE `qinggan_order_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单ID号',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主题ID',
  `title` varchar(255) NOT NULL COMMENT '产品名称',
  `price` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '产品单价',
  `qty` int(11) NOT NULL DEFAULT '0' COMMENT '产品数量',
  `thumb` int(11) NOT NULL COMMENT '产品图片ID',
  `ext` text NOT NULL COMMENT '产品扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='订单的产品信息';

-- ----------------------------
-- Records of qinggan_order_product
-- ----------------------------

-- ----------------------------
-- Table structure for `qinggan_payment`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_payment`;
CREATE TABLE `qinggan_payment` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '付款组',
  `code` varchar(100) NOT NULL COMMENT '标识ID',
  `title` varchar(255) NOT NULL COMMENT '主题',
  `currency` varchar(30) NOT NULL COMMENT '可使用的货币ID',
  `logo1` varchar(255) NOT NULL COMMENT 'LOGO小图',
  `logo2` varchar(255) NOT NULL COMMENT 'LOGO中图',
  `logo3` varchar(255) NOT NULL COMMENT 'LOGO大图',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态0未使用1正在使用中',
  `taxis` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序，值越小越往前靠',
  `note` text NOT NULL COMMENT '付款注意事项说明',
  `param` text NOT NULL COMMENT '参数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='支付方案';

-- ----------------------------
-- Records of qinggan_payment
-- ----------------------------

-- ----------------------------
-- Table structure for `qinggan_payment_group`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_payment_group`;
CREATE TABLE `qinggan_payment_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `site_id` int(11) NOT NULL DEFAULT '0' COMMENT '站点ID，为0表示全部',
  `title` varchar(255) NOT NULL COMMENT '付款组名称',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0不启用1启用',
  `taxis` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序，值越小越往前靠',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1默认组0普通组',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='付款组管理';

-- ----------------------------
-- Records of qinggan_payment_group
-- ----------------------------
INSERT INTO `qinggan_payment_group` VALUES ('1', '1', '快捷支付', '1', '10', '0');
INSERT INTO `qinggan_payment_group` VALUES ('2', '1', '银行卡支付', '1', '20', '0');

-- ----------------------------
-- Table structure for `qinggan_phpok`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_phpok`;
CREATE TABLE `qinggan_phpok` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '项目ID',
  `type_id` varchar(255) NOT NULL COMMENT '调用类型',
  `identifier` varchar(100) NOT NULL COMMENT '标识串，同一个站点中只能唯一',
  `site_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '站点ID',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `cateid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `ext` text NOT NULL COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier` (`identifier`,`site_id`)
) ENGINE=MyISAM AUTO_INCREMENT=119 DEFAULT CHARSET=utf8 COMMENT='数据调用中心';

-- ----------------------------
-- Records of qinggan_phpok
-- ----------------------------
INSERT INTO `qinggan_phpok` VALUES ('18', '网站首页图片播放', '41', 'arclist', 'picplayer', '1', '1', '0', 'a:23:{s:5:\"psize\";s:1:\"5\";s:6:\"offset\";i:0;s:7:\"is_list\";s:1:\"1\";s:7:\"in_text\";s:1:\"1\";s:4:\"attr\";b:0;s:11:\"fields_need\";b:0;s:3:\"tag\";b:0;s:8:\"keywords\";b:0;s:7:\"orderby\";b:0;s:4:\"cate\";b:0;s:8:\"cate_ext\";i:0;s:12:\"catelist_ext\";i:0;s:11:\"project_ext\";i:0;s:11:\"sublist_ext\";i:0;s:10:\"parent_ext\";i:0;s:13:\"fields_format\";i:0;s:8:\"user_ext\";i:0;s:4:\"user\";b:0;s:12:\"userlist_ext\";i:0;s:6:\"in_sub\";i:0;s:10:\"in_project\";i:0;s:7:\"in_cate\";i:0;s:8:\"title_id\";b:0;}');
INSERT INTO `qinggan_phpok` VALUES ('19', '头部导航内容', '42', 'arclist', 'menu', '1', '1', '0', 'a:23:{s:5:\"psize\";s:2:\"80\";s:6:\"offset\";i:0;s:7:\"is_list\";s:1:\"1\";s:7:\"in_text\";s:1:\"1\";s:4:\"attr\";b:0;s:11:\"fields_need\";b:0;s:3:\"tag\";b:0;s:8:\"keywords\";b:0;s:7:\"orderby\";b:0;s:4:\"cate\";b:0;s:8:\"cate_ext\";i:0;s:12:\"catelist_ext\";i:0;s:11:\"project_ext\";i:0;s:11:\"sublist_ext\";i:0;s:10:\"parent_ext\";i:0;s:13:\"fields_format\";i:0;s:8:\"user_ext\";i:0;s:4:\"user\";b:0;s:12:\"userlist_ext\";i:0;s:6:\"in_sub\";s:1:\"1\";s:10:\"in_project\";i:0;s:7:\"in_cate\";i:0;s:8:\"title_id\";b:0;}');
INSERT INTO `qinggan_phpok` VALUES ('20', '公司简介', '90', 'project', 'aboutus', '1', '1', '0', 'a:20:{s:5:\"psize\";b:0;s:6:\"offset\";b:0;s:7:\"is_list\";b:0;s:7:\"in_text\";b:0;s:4:\"attr\";b:0;s:11:\"fields_need\";b:0;s:3:\"tag\";b:0;s:8:\"keywords\";b:0;s:7:\"orderby\";b:0;s:4:\"cate\";b:0;s:8:\"cate_ext\";b:0;s:12:\"catelist_ext\";b:0;s:11:\"project_ext\";i:1;s:11:\"sublist_ext\";b:0;s:10:\"parent_ext\";b:0;s:13:\"fields_format\";b:0;s:8:\"user_ext\";b:0;s:4:\"user\";b:0;s:12:\"userlist_ext\";b:0;s:6:\"in_sub\";b:0;}');
INSERT INTO `qinggan_phpok` VALUES ('55', '友情链接', '142', 'arclist', 'link', '1', '1', '0', 'a:23:{s:5:\"psize\";s:2:\"30\";s:6:\"offset\";i:0;s:7:\"is_list\";s:1:\"1\";s:7:\"in_text\";s:1:\"1\";s:4:\"attr\";b:0;s:11:\"fields_need\";b:0;s:3:\"tag\";b:0;s:8:\"keywords\";b:0;s:7:\"orderby\";b:0;s:4:\"cate\";b:0;s:8:\"cate_ext\";i:0;s:12:\"catelist_ext\";i:0;s:11:\"project_ext\";i:0;s:11:\"sublist_ext\";i:0;s:10:\"parent_ext\";i:0;s:13:\"fields_format\";i:0;s:8:\"user_ext\";i:0;s:4:\"user\";b:0;s:12:\"userlist_ext\";i:0;s:6:\"in_sub\";i:0;s:10:\"in_project\";s:1:\"2\";s:7:\"in_cate\";b:0;s:8:\"title_id\";b:0;}');
INSERT INTO `qinggan_phpok` VALUES ('91', '新闻中心', '43', 'arclist', 'news', '1', '1', '7', 'a:13:{s:5:\"psize\";s:1:\"8\";s:6:\"offset\";i:0;s:7:\"is_list\";s:1:\"1\";s:4:\"attr\";s:0:\"\";s:11:\"fields_need\";s:0:\"\";s:3:\"tag\";s:0:\"\";s:8:\"keywords\";s:0:\"\";s:7:\"orderby\";s:0:\"\";s:4:\"cate\";s:0:\"\";s:13:\"fields_format\";i:0;s:4:\"user\";s:0:\"\";s:6:\"in_sub\";i:0;s:8:\"title_id\";s:0:\"\";}');
INSERT INTO `qinggan_phpok` VALUES ('117', '校园风貌', '173', 'arclist', 'xiaoyuanfengmao', '1', '1', '0', 'a:13:{s:5:\"psize\";s:1:\"4\";s:6:\"offset\";i:0;s:7:\"is_list\";s:1:\"1\";s:4:\"attr\";s:0:\"\";s:11:\"fields_need\";s:9:\"ext.thumb\";s:3:\"tag\";s:0:\"\";s:8:\"keywords\";s:0:\"\";s:7:\"orderby\";s:0:\"\";s:4:\"cate\";s:0:\"\";s:13:\"fields_format\";i:0;s:4:\"user\";s:0:\"\";s:6:\"in_sub\";i:0;s:8:\"title_id\";s:0:\"\";}');
INSERT INTO `qinggan_phpok` VALUES ('110', '首页新闻图片', '169', 'arclist', 'xwtp', '1', '1', '0', 'a:13:{s:5:\"psize\";s:1:\"4\";s:6:\"offset\";i:0;s:7:\"is_list\";s:1:\"1\";s:4:\"attr\";s:0:\"\";s:11:\"fields_need\";s:0:\"\";s:3:\"tag\";s:0:\"\";s:8:\"keywords\";s:0:\"\";s:7:\"orderby\";s:0:\"\";s:4:\"cate\";s:0:\"\";s:13:\"fields_format\";i:0;s:4:\"user\";s:0:\"\";s:6:\"in_sub\";i:0;s:8:\"title_id\";s:0:\"\";}');
INSERT INTO `qinggan_phpok` VALUES ('115', '最新动态', '172', 'arclist', 'zuixindongtai', '1', '1', '0', 'a:13:{s:5:\"psize\";s:1:\"5\";s:6:\"offset\";i:0;s:7:\"is_list\";s:1:\"1\";s:4:\"attr\";s:0:\"\";s:11:\"fields_need\";s:0:\"\";s:3:\"tag\";s:0:\"\";s:8:\"keywords\";s:0:\"\";s:7:\"orderby\";s:9:\"l.id DESC\";s:4:\"cate\";s:0:\"\";s:13:\"fields_format\";i:0;s:4:\"user\";s:0:\"\";s:6:\"in_sub\";i:0;s:8:\"title_id\";s:0:\"\";}');
INSERT INTO `qinggan_phpok` VALUES ('94', '页脚导航', '147', 'arclist', 'footnav', '1', '1', '0', 'a:23:{s:5:\"psize\";s:2:\"10\";s:6:\"offset\";i:0;s:7:\"is_list\";s:1:\"1\";s:7:\"in_text\";s:1:\"1\";s:4:\"attr\";b:0;s:11:\"fields_need\";b:0;s:3:\"tag\";b:0;s:8:\"keywords\";b:0;s:7:\"orderby\";b:0;s:4:\"cate\";b:0;s:8:\"cate_ext\";i:0;s:12:\"catelist_ext\";i:0;s:11:\"project_ext\";i:0;s:11:\"sublist_ext\";i:0;s:10:\"parent_ext\";i:0;s:13:\"fields_format\";i:0;s:8:\"user_ext\";i:0;s:4:\"user\";b:0;s:12:\"userlist_ext\";i:0;s:6:\"in_sub\";i:0;s:10:\"in_project\";i:0;s:7:\"in_cate\";i:0;s:8:\"title_id\";b:0;}');
INSERT INTO `qinggan_phpok` VALUES ('95', '客服', '148', 'arclist', 'kefu', '1', '1', '0', 'a:23:{s:5:\"psize\";s:2:\"50\";s:6:\"offset\";i:0;s:7:\"is_list\";s:1:\"1\";s:7:\"in_text\";s:1:\"1\";s:4:\"attr\";b:0;s:11:\"fields_need\";s:8:\"ext.code\";s:3:\"tag\";b:0;s:8:\"keywords\";b:0;s:7:\"orderby\";b:0;s:4:\"cate\";b:0;s:8:\"cate_ext\";i:0;s:12:\"catelist_ext\";i:0;s:11:\"project_ext\";i:0;s:11:\"sublist_ext\";i:0;s:10:\"parent_ext\";i:0;s:13:\"fields_format\";i:0;s:8:\"user_ext\";i:0;s:4:\"user\";b:0;s:12:\"userlist_ext\";i:0;s:6:\"in_sub\";i:0;s:10:\"in_project\";s:1:\"2\";s:7:\"in_cate\";i:0;s:8:\"title_id\";b:0;}');
INSERT INTO `qinggan_phpok` VALUES ('100', '导航菜单', '42', 'arclist', 'menu_mobile', '1', '1', '0', 'a:23:{s:5:\"psize\";s:1:\"4\";s:6:\"offset\";i:0;s:7:\"is_list\";s:1:\"1\";s:7:\"in_text\";s:1:\"1\";s:4:\"attr\";s:6:\"mobile\";s:11:\"fields_need\";b:0;s:3:\"tag\";b:0;s:8:\"keywords\";b:0;s:7:\"orderby\";b:0;s:4:\"cate\";b:0;s:8:\"cate_ext\";i:0;s:12:\"catelist_ext\";i:0;s:11:\"project_ext\";i:0;s:11:\"sublist_ext\";i:0;s:10:\"parent_ext\";i:0;s:13:\"fields_format\";i:0;s:8:\"user_ext\";i:0;s:4:\"user\";b:0;s:12:\"userlist_ext\";i:0;s:6:\"in_sub\";i:0;s:10:\"in_project\";i:0;s:7:\"in_cate\";i:0;s:8:\"title_id\";b:0;}');
INSERT INTO `qinggan_phpok` VALUES ('104', '资讯中心', '43', 'arclist', 'titlelist', '1', '1', '7', 'a:13:{s:5:\"psize\";s:2:\"10\";s:6:\"offset\";i:0;s:7:\"is_list\";s:1:\"1\";s:4:\"attr\";s:0:\"\";s:11:\"fields_need\";s:0:\"\";s:3:\"tag\";s:0:\"\";s:8:\"keywords\";s:0:\"\";s:7:\"orderby\";s:0:\"\";s:4:\"cate\";s:0:\"\";s:13:\"fields_format\";i:0;s:4:\"user\";s:0:\"\";s:6:\"in_sub\";i:0;s:8:\"title_id\";s:0:\"\";}');
INSERT INTO `qinggan_phpok` VALUES ('105', '资讯中心', '43', 'catelist', 'news_catelist', '1', '1', '7', 'a:13:{s:5:\"psize\";i:0;s:6:\"offset\";i:0;s:7:\"is_list\";s:1:\"1\";s:4:\"attr\";s:0:\"\";s:11:\"fields_need\";s:0:\"\";s:3:\"tag\";s:0:\"\";s:8:\"keywords\";s:0:\"\";s:7:\"orderby\";s:0:\"\";s:4:\"cate\";s:0:\"\";s:13:\"fields_format\";i:0;s:4:\"user\";s:0:\"\";s:6:\"in_sub\";i:0;s:8:\"title_id\";s:0:\"\";}');
INSERT INTO `qinggan_phpok` VALUES ('109', '校园公告', '167', 'arclist', 'xygg', '1', '1', '0', 'a:13:{s:5:\"psize\";s:1:\"5\";s:6:\"offset\";i:0;s:7:\"is_list\";s:1:\"1\";s:4:\"attr\";s:0:\"\";s:11:\"fields_need\";s:0:\"\";s:3:\"tag\";s:0:\"\";s:8:\"keywords\";s:0:\"\";s:7:\"orderby\";s:0:\"\";s:4:\"cate\";s:0:\"\";s:13:\"fields_format\";i:0;s:4:\"user\";s:0:\"\";s:6:\"in_sub\";i:0;s:8:\"title_id\";s:0:\"\";}');
INSERT INTO `qinggan_phpok` VALUES ('114', '热点新闻', '171', 'arclist', 'redianxinwen', '1', '1', '0', 'a:13:{s:5:\"psize\";s:1:\"5\";s:6:\"offset\";i:0;s:7:\"is_list\";s:1:\"1\";s:4:\"attr\";s:0:\"\";s:11:\"fields_need\";s:0:\"\";s:3:\"tag\";s:0:\"\";s:8:\"keywords\";s:0:\"\";s:7:\"orderby\";s:9:\"l.id DESC\";s:4:\"cate\";s:0:\"\";s:13:\"fields_format\";i:0;s:4:\"user\";s:0:\"\";s:6:\"in_sub\";i:0;s:8:\"title_id\";s:0:\"\";}');
INSERT INTO `qinggan_phpok` VALUES ('118', '学校新闻图片', '174', 'arclist', 'xxxw', '1', '1', '0', 'a:13:{s:5:\"psize\";s:1:\"5\";s:6:\"offset\";i:0;s:7:\"is_list\";s:1:\"1\";s:4:\"attr\";s:0:\"\";s:11:\"fields_need\";s:0:\"\";s:3:\"tag\";s:0:\"\";s:8:\"keywords\";s:0:\"\";s:7:\"orderby\";s:9:\"l.id DESC\";s:4:\"cate\";s:0:\"\";s:13:\"fields_format\";i:0;s:4:\"user\";s:0:\"\";s:6:\"in_sub\";i:0;s:8:\"title_id\";s:0:\"\";}');

-- ----------------------------
-- Table structure for `qinggan_plugins`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_plugins`;
CREATE TABLE `qinggan_plugins` (
  `id` varchar(100) NOT NULL COMMENT '插件ID，仅限字母，数字及下划线',
  `title` varchar(255) NOT NULL COMMENT '插件名称',
  `author` varchar(255) NOT NULL COMMENT '开发者',
  `version` varchar(50) NOT NULL COMMENT '插件版本号',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0禁用1使用',
  `taxis` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '值越小越往前靠',
  `note` varchar(255) NOT NULL COMMENT '摘要说明',
  `param` text NOT NULL COMMENT '参数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='插件管理器';

-- ----------------------------
-- Records of qinggan_plugins
-- ----------------------------
INSERT INTO `qinggan_plugins` VALUES ('identifier', '标识串自动生成工具', 'phpok.com', '1.0', '1', '255', '实现名称转拼音，英语的功能', 'a:5:{s:9:\"is_youdao\";i:0;s:7:\"keyfrom\";s:0:\"\";s:5:\"keyid\";s:0:\"\";s:10:\"is_pingyin\";i:1;s:5:\"is_py\";i:1;}');

-- ----------------------------
-- Table structure for `qinggan_plugin_duanxincm`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_plugin_duanxincm`;
CREATE TABLE `qinggan_plugin_duanxincm` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `code` varchar(255) NOT NULL COMMENT '验证码',
  `mobile` varchar(255) NOT NULL COMMENT '手机号',
  `ctime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码创建时间',
  `etime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码失效时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态0未被使用1被使用',
  `utype` varchar(50) NOT NULL COMMENT '应用模块ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='插件莫名短信验证码';

-- ----------------------------
-- Records of qinggan_plugin_duanxincm
-- ----------------------------
INSERT INTO `qinggan_plugin_duanxincm` VALUES ('6', '5528', '15818533971', '1429694134', '1429694434', '1', 'register');
INSERT INTO `qinggan_plugin_duanxincm` VALUES ('7', '8859', '15818533971', '1433422761', '1433423061', '1', 'register');

-- ----------------------------
-- Table structure for `qinggan_plugin_yuntongxun`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_plugin_yuntongxun`;
CREATE TABLE `qinggan_plugin_yuntongxun` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `code` varchar(255) NOT NULL COMMENT '验证码',
  `mobile` varchar(255) NOT NULL COMMENT '手机号',
  `ctime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码创建时间',
  `etime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码失效时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态0未被使用1被使用',
  `utype` varchar(50) NOT NULL COMMENT '应用模块ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='插件云通讯验证码';

-- ----------------------------
-- Records of qinggan_plugin_yuntongxun
-- ----------------------------
INSERT INTO `qinggan_plugin_yuntongxun` VALUES ('4', '8442', '15818533971', '1429691444', '1429691744', '1', 'register');

-- ----------------------------
-- Table structure for `qinggan_popedom`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_popedom`;
CREATE TABLE `qinggan_popedom` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '权限ID，即自增ID',
  `gid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '所属组ID，对应sysmenu表中的ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '项目ID，仅在list中有效',
  `title` varchar(255) NOT NULL COMMENT '名称，如：添加，修改等',
  `identifier` varchar(255) NOT NULL COMMENT '字符串，如add，modify等',
  `taxis` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `gid` (`gid`)
) ENGINE=MyISAM AUTO_INCREMENT=826 DEFAULT CHARSET=utf8 COMMENT='权限明细';

-- ----------------------------
-- Records of qinggan_popedom
-- ----------------------------
INSERT INTO `qinggan_popedom` VALUES ('2', '19', '0', '配置全局', 'gset', '10');
INSERT INTO `qinggan_popedom` VALUES ('3', '19', '0', '内容', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('4', '29', '0', '添加', 'add', '10');
INSERT INTO `qinggan_popedom` VALUES ('5', '29', '0', '修改', 'modify', '20');
INSERT INTO `qinggan_popedom` VALUES ('6', '29', '0', '删除', 'delete', '30');
INSERT INTO `qinggan_popedom` VALUES ('7', '18', '0', '添加', 'add', '10');
INSERT INTO `qinggan_popedom` VALUES ('8', '18', '0', '编辑', 'modify', '20');
INSERT INTO `qinggan_popedom` VALUES ('9', '18', '0', '删除', 'delete', '30');
INSERT INTO `qinggan_popedom` VALUES ('10', '23', '0', '添加', 'add', '10');
INSERT INTO `qinggan_popedom` VALUES ('11', '23', '0', '编辑', 'modify', '20');
INSERT INTO `qinggan_popedom` VALUES ('12', '23', '0', '删除', 'delete', '30');
INSERT INTO `qinggan_popedom` VALUES ('14', '22', '0', 'GD配置', 'gd', '10');
INSERT INTO `qinggan_popedom` VALUES ('15', '22', '0', '附件分类维护', 'cate', '20');
INSERT INTO `qinggan_popedom` VALUES ('16', '22', '0', '批处理', 'pl', '30');
INSERT INTO `qinggan_popedom` VALUES ('17', '16', '0', '配置', 'config', '10');
INSERT INTO `qinggan_popedom` VALUES ('18', '16', '0', '安装', 'install', '20');
INSERT INTO `qinggan_popedom` VALUES ('19', '16', '0', '卸载', 'uninstall', '30');
INSERT INTO `qinggan_popedom` VALUES ('20', '16', '0', '删除', 'delete', '40');
INSERT INTO `qinggan_popedom` VALUES ('21', '17', '0', '添加', 'add', '20');
INSERT INTO `qinggan_popedom` VALUES ('22', '13', '0', '添加', 'add', '10');
INSERT INTO `qinggan_popedom` VALUES ('23', '13', '0', '修改', 'modify', '20');
INSERT INTO `qinggan_popedom` VALUES ('24', '13', '0', '删除', 'delete', '30');
INSERT INTO `qinggan_popedom` VALUES ('25', '13', '0', '查看', 'list', '5');
INSERT INTO `qinggan_popedom` VALUES ('26', '19', '0', '查看', 'list', '5');
INSERT INTO `qinggan_popedom` VALUES ('27', '20', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('28', '20', '0', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('29', '20', '0', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('30', '20', '0', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('31', '20', '0', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('32', '20', '0', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('33', '21', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('34', '21', '0', '添加', 'add', '20');
INSERT INTO `qinggan_popedom` VALUES ('35', '21', '0', '编辑', 'modify', '30');
INSERT INTO `qinggan_popedom` VALUES ('36', '21', '0', '删除', 'delete', '40');
INSERT INTO `qinggan_popedom` VALUES ('37', '18', '0', '查看', 'list', '5');
INSERT INTO `qinggan_popedom` VALUES ('38', '23', '0', '查看', 'list', '5');
INSERT INTO `qinggan_popedom` VALUES ('83', '16', '0', '启用/禁用', 'status', '50');
INSERT INTO `qinggan_popedom` VALUES ('40', '16', '0', '查看', 'list', '5');
INSERT INTO `qinggan_popedom` VALUES ('41', '17', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('42', '18', '0', '扩展', 'ext', '40');
INSERT INTO `qinggan_popedom` VALUES ('43', '19', '0', '扩展', 'ext', '30');
INSERT INTO `qinggan_popedom` VALUES ('44', '14', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('45', '14', '0', '添加', 'add', '20');
INSERT INTO `qinggan_popedom` VALUES ('46', '14', '0', '修改', 'modify', '30');
INSERT INTO `qinggan_popedom` VALUES ('47', '14', '0', '删除', 'delete', '40');
INSERT INTO `qinggan_popedom` VALUES ('48', '25', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('49', '25', '0', '配置', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('80', '14', '0', '启用/禁用', 'status', '50');
INSERT INTO `qinggan_popedom` VALUES ('52', '29', '0', '查看', 'list', '5');
INSERT INTO `qinggan_popedom` VALUES ('53', '27', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('54', '27', '0', '配置', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('81', '19', '0', '网站', 'site', '40');
INSERT INTO `qinggan_popedom` VALUES ('82', '19', '0', '域名', 'domain', '50');
INSERT INTO `qinggan_popedom` VALUES ('58', '8', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('59', '8', '0', '维护', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('84', '20', '1', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('85', '20', '1', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('63', '6', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('64', '6', '0', '维护', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('86', '20', '22', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('67', '7', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('68', '7', '0', '添加', 'add', '20');
INSERT INTO `qinggan_popedom` VALUES ('69', '7', '0', '修改', 'modify', '30');
INSERT INTO `qinggan_popedom` VALUES ('70', '7', '0', '删除', 'delete', '40');
INSERT INTO `qinggan_popedom` VALUES ('71', '28', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('72', '28', '0', '添加', 'add', '20');
INSERT INTO `qinggan_popedom` VALUES ('73', '28', '0', '修改', 'modify', '30');
INSERT INTO `qinggan_popedom` VALUES ('74', '28', '0', '删除', 'delete', '40');
INSERT INTO `qinggan_popedom` VALUES ('75', '9', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('76', '9', '0', '添加', 'add', '20');
INSERT INTO `qinggan_popedom` VALUES ('77', '9', '0', '修改', 'modify', '30');
INSERT INTO `qinggan_popedom` VALUES ('78', '9', '0', '启用/禁用', 'status', '40');
INSERT INTO `qinggan_popedom` VALUES ('79', '29', '0', '启用/禁用', 'status', '40');
INSERT INTO `qinggan_popedom` VALUES ('87', '20', '22', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('88', '20', '22', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('89', '20', '22', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('90', '20', '22', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('91', '20', '24', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('92', '20', '24', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('93', '20', '24', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('94', '20', '24', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('95', '20', '24', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('96', '20', '26', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('97', '20', '26', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('98', '20', '26', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('99', '20', '26', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('100', '20', '26', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('101', '20', '25', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('102', '20', '25', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('103', '20', '25', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('104', '20', '25', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('105', '20', '25', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('106', '20', '25', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('107', '20', '33', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('108', '20', '33', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('109', '20', '34', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('110', '20', '34', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('111', '20', '34', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('112', '20', '34', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('113', '20', '34', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('114', '20', '35', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('115', '20', '35', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('116', '20', '36', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('117', '20', '36', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('118', '20', '37', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('119', '20', '37', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('120', '20', '37', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('121', '20', '37', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('122', '20', '37', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('123', '20', '38', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('124', '20', '38', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('125', '20', '38', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('126', '20', '38', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('127', '20', '38', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('128', '20', '39', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('129', '20', '39', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('130', '20', '39', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('131', '20', '39', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('132', '20', '39', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('133', '30', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('134', '30', '0', '设置', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('135', '30', '0', '文件管理', 'filelist', '30');
INSERT INTO `qinggan_popedom` VALUES ('136', '30', '0', '删除', 'delete', '40');
INSERT INTO `qinggan_popedom` VALUES ('137', '20', '40', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('138', '20', '40', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('139', '20', '40', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('140', '20', '40', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('141', '20', '40', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('142', '13', '0', '审核', 'status', '40');
INSERT INTO `qinggan_popedom` VALUES ('143', '20', '41', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('144', '20', '41', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('145', '20', '41', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('146', '20', '41', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('147', '20', '41', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('148', '20', '42', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('149', '20', '42', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('150', '20', '42', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('151', '20', '42', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('152', '20', '42', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('153', '20', '43', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('154', '20', '43', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('155', '20', '43', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('156', '20', '43', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('157', '20', '43', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('162', '31', '0', '添加站点', 'add', '40');
INSERT INTO `qinggan_popedom` VALUES ('159', '31', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('160', '31', '0', '删除', 'delete', '20');
INSERT INTO `qinggan_popedom` VALUES ('161', '31', '0', '设为默认', 'default', '30');
INSERT INTO `qinggan_popedom` VALUES ('163', '20', '44', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('164', '20', '44', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('170', '19', '0', '添加站点', 'add', '60');
INSERT INTO `qinggan_popedom` VALUES ('171', '20', '46', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('172', '20', '46', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('173', '20', '46', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('174', '20', '46', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('175', '20', '46', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('176', '20', '47', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('177', '20', '47', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('178', '20', '47', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('179', '20', '47', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('180', '20', '47', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('181', '20', '48', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('182', '20', '48', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('183', '20', '48', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('184', '20', '48', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('185', '20', '48', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('186', '20', '49', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('187', '20', '49', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('188', '20', '49', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('189', '20', '49', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('190', '20', '49', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('191', '20', '50', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('192', '20', '50', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('193', '20', '50', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('194', '20', '50', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('195', '20', '50', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('196', '20', '51', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('197', '20', '51', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('198', '20', '51', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('199', '20', '51', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('200', '20', '51', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('201', '20', '51', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('202', '20', '52', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('203', '20', '52', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('204', '20', '53', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('205', '20', '53', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('206', '20', '54', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('207', '20', '54', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('208', '20', '54', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('209', '20', '54', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('210', '20', '54', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('211', '20', '55', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('212', '20', '55', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('213', '20', '55', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('214', '20', '55', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('215', '20', '55', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('216', '20', '56', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('217', '20', '56', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('218', '20', '57', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('219', '20', '57', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('220', '20', '57', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('221', '20', '57', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('222', '20', '57', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('223', '20', '58', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('224', '20', '58', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('225', '20', '58', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('226', '20', '58', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('227', '20', '58', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('228', '20', '59', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('229', '20', '59', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('230', '20', '59', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('231', '20', '59', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('232', '20', '59', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('233', '20', '60', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('234', '20', '60', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('235', '20', '60', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('236', '20', '60', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('237', '20', '60', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('238', '20', '61', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('239', '20', '61', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('240', '20', '61', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('241', '20', '61', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('242', '20', '61', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('243', '20', '62', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('244', '20', '62', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('245', '20', '62', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('246', '20', '62', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('247', '20', '62', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('248', '20', '62', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('249', '20', '63', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('250', '20', '63', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('251', '20', '64', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('252', '20', '64', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('253', '20', '65', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('254', '20', '65', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('255', '20', '65', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('256', '20', '65', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('257', '20', '65', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('258', '20', '66', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('259', '20', '66', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('260', '20', '66', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('261', '20', '66', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('262', '20', '66', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('263', '20', '67', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('264', '20', '67', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('265', '20', '68', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('266', '20', '68', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('267', '20', '68', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('268', '20', '68', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('269', '20', '68', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('270', '20', '69', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('271', '20', '69', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('272', '20', '69', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('273', '20', '69', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('274', '20', '69', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('275', '20', '70', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('276', '20', '70', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('277', '20', '70', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('278', '20', '70', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('279', '20', '70', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('280', '20', '71', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('281', '20', '71', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('282', '20', '72', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('283', '20', '72', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('284', '20', '73', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('285', '20', '73', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('286', '20', '74', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('287', '20', '74', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('288', '20', '75', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('289', '20', '75', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('290', '20', '76', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('291', '20', '76', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('292', '20', '77', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('293', '20', '77', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('294', '20', '77', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('295', '20', '77', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('296', '20', '77', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('297', '20', '77', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('298', '20', '78', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('299', '20', '78', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('300', '20', '78', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('301', '20', '78', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('302', '20', '78', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('303', '20', '79', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('304', '20', '79', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('305', '20', '79', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('306', '20', '79', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('307', '20', '79', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('308', '20', '80', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('309', '20', '80', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('310', '20', '81', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('311', '20', '81', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('312', '20', '81', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('313', '20', '81', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('314', '20', '81', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('315', '20', '82', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('316', '20', '82', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('317', '20', '82', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('318', '20', '82', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('319', '20', '82', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('320', '20', '83', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('321', '20', '83', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('322', '20', '83', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('323', '20', '83', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('324', '20', '83', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('325', '20', '83', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('326', '20', '84', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('327', '20', '84', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('328', '20', '84', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('329', '20', '84', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('330', '20', '84', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('331', '20', '84', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('332', '20', '85', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('333', '20', '85', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('334', '20', '85', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('335', '20', '85', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('336', '20', '85', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('337', '20', '85', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('338', '20', '86', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('339', '20', '86', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('340', '20', '86', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('341', '20', '86', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('342', '20', '86', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('343', '20', '86', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('344', '32', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('345', '32', '0', '启用/禁用', 'status', '20');
INSERT INTO `qinggan_popedom` VALUES ('346', '32', '0', '删除', 'delete', '30');
INSERT INTO `qinggan_popedom` VALUES ('347', '32', '0', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('348', '32', '0', '回复', 'reply', '50');
INSERT INTO `qinggan_popedom` VALUES ('349', '20', '87', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('350', '20', '87', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('351', '20', '87', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('352', '20', '87', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('353', '20', '87', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('354', '20', '88', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('355', '20', '88', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('356', '20', '88', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('357', '20', '88', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('358', '20', '88', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('359', '20', '89', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('360', '20', '89', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('361', '20', '89', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('362', '20', '89', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('363', '20', '89', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('364', '20', '90', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('365', '20', '90', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('366', '20', '91', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('367', '20', '91', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('368', '20', '91', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('369', '20', '91', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('370', '20', '91', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('371', '20', '92', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('372', '20', '92', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('373', '20', '93', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('378', '20', '94', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('379', '20', '94', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('380', '20', '94', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('381', '20', '94', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('382', '20', '94', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('383', '20', '95', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('384', '20', '95', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('385', '20', '95', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('386', '20', '95', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('387', '20', '95', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('393', '20', '97', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('394', '20', '97', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('395', '20', '97', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('396', '20', '97', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('397', '20', '97', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('398', '20', '98', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('399', '20', '98', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('400', '20', '98', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('401', '20', '98', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('402', '20', '98', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('403', '20', '99', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('404', '20', '99', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('405', '20', '99', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('406', '20', '99', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('407', '20', '99', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('408', '20', '100', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('409', '20', '100', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('410', '20', '100', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('411', '20', '100', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('412', '20', '100', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('413', '20', '101', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('414', '20', '101', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('415', '20', '101', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('416', '20', '101', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('417', '20', '101', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('418', '20', '102', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('419', '20', '102', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('420', '20', '102', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('421', '20', '102', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('422', '20', '102', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('423', '20', '103', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('424', '20', '103', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('425', '20', '103', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('426', '20', '103', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('427', '20', '103', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('428', '20', '104', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('429', '20', '104', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('430', '20', '104', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('431', '20', '104', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('432', '20', '104', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('433', '20', '105', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('434', '20', '105', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('435', '20', '105', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('436', '20', '105', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('437', '20', '105', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('438', '20', '106', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('439', '20', '106', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('440', '20', '106', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('441', '20', '106', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('442', '20', '106', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('443', '20', '107', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('444', '20', '107', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('445', '20', '107', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('446', '20', '107', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('447', '20', '107', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('448', '20', '108', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('449', '20', '108', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('450', '20', '108', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('451', '20', '108', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('452', '20', '108', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('453', '20', '109', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('454', '20', '109', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('455', '20', '109', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('456', '20', '109', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('457', '20', '109', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('458', '20', '110', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('459', '20', '110', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('460', '20', '111', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('461', '20', '111', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('462', '20', '112', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('463', '20', '112', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('464', '20', '113', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('465', '20', '113', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('466', '20', '114', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('467', '20', '114', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('468', '20', '114', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('469', '20', '114', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('470', '20', '114', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('471', '20', '115', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('472', '20', '115', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('473', '20', '115', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('474', '20', '115', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('475', '20', '115', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('476', '33', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('477', '33', '0', '添加', 'add', '20');
INSERT INTO `qinggan_popedom` VALUES ('478', '33', '0', '修改', 'modify', '30');
INSERT INTO `qinggan_popedom` VALUES ('479', '33', '0', '删除', 'delete', '40');
INSERT INTO `qinggan_popedom` VALUES ('480', '33', '0', '启用/禁用', 'status', '50');
INSERT INTO `qinggan_popedom` VALUES ('481', '20', '116', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('482', '20', '116', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('483', '20', '116', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('484', '20', '116', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('485', '20', '116', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('486', '20', '117', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('487', '20', '117', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('488', '20', '117', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('489', '20', '117', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('490', '20', '117', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('491', '20', '118', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('492', '20', '118', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('493', '20', '118', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('494', '20', '118', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('495', '20', '118', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('496', '20', '119', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('497', '20', '119', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('498', '20', '119', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('499', '20', '119', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('500', '20', '119', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('501', '20', '120', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('502', '20', '120', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('503', '20', '120', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('504', '20', '120', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('505', '20', '120', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('506', '20', '121', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('507', '20', '121', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('508', '20', '121', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('509', '20', '121', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('510', '20', '121', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('511', '20', '122', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('512', '20', '122', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('513', '20', '122', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('514', '20', '122', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('515', '20', '122', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('516', '20', '123', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('517', '20', '123', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('518', '20', '123', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('519', '20', '123', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('520', '20', '123', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('521', '20', '124', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('522', '20', '124', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('523', '20', '124', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('524', '20', '124', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('525', '20', '124', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('526', '20', '125', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('527', '20', '125', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('528', '20', '125', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('529', '20', '125', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('530', '20', '125', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('531', '20', '126', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('532', '20', '126', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('533', '20', '126', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('534', '20', '126', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('535', '20', '126', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('536', '20', '128', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('537', '20', '128', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('538', '20', '128', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('539', '20', '128', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('540', '20', '128', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('541', '20', '129', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('542', '20', '129', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('543', '20', '129', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('544', '20', '129', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('545', '20', '129', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('546', '20', '130', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('547', '20', '130', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('548', '20', '130', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('549', '20', '130', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('550', '20', '130', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('551', '20', '131', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('552', '20', '131', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('553', '20', '131', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('554', '20', '131', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('555', '20', '131', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('556', '20', '132', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('557', '20', '132', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('558', '20', '132', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('559', '20', '132', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('560', '20', '132', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('561', '20', '133', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('562', '20', '133', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('563', '20', '133', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('564', '20', '133', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('565', '20', '133', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('566', '20', '134', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('567', '20', '134', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('568', '20', '134', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('569', '20', '134', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('570', '20', '134', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('571', '20', '135', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('572', '20', '135', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('573', '20', '135', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('574', '20', '135', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('575', '20', '135', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('576', '20', '136', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('577', '20', '136', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('578', '20', '136', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('579', '20', '136', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('580', '20', '136', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('581', '20', '137', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('582', '20', '137', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('583', '20', '137', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('584', '20', '137', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('585', '20', '137', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('586', '20', '138', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('587', '20', '138', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('588', '20', '138', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('589', '20', '138', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('590', '20', '138', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('591', '20', '139', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('592', '20', '139', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('593', '20', '139', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('594', '20', '139', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('595', '20', '139', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('596', '20', '140', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('597', '20', '140', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('598', '20', '141', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('599', '20', '141', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('600', '20', '93', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('601', '34', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('602', '34', '0', '添加', 'add', '20');
INSERT INTO `qinggan_popedom` VALUES ('603', '34', '0', '修改', 'modify', '30');
INSERT INTO `qinggan_popedom` VALUES ('604', '34', '0', '审核', 'status', '40');
INSERT INTO `qinggan_popedom` VALUES ('605', '34', '0', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('606', '20', '142', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('607', '20', '142', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('608', '20', '142', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('609', '20', '142', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('610', '20', '142', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('611', '20', '142', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('816', '20', '173', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('815', '20', '173', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('814', '20', '173', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('813', '20', '173', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('617', '42', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('618', '42', '0', '执行', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('619', '43', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('620', '44', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('621', '45', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('622', '45', '0', '升级', 'update', '20');
INSERT INTO `qinggan_popedom` VALUES ('623', '45', '0', '配置升级服务器', 'set', '30');
INSERT INTO `qinggan_popedom` VALUES ('624', '46', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('625', '9', '0', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('626', '52', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('627', '52', '0', '添加组', 'groupadd', '20');
INSERT INTO `qinggan_popedom` VALUES ('628', '52', '0', '修改组', 'groupedit', '30');
INSERT INTO `qinggan_popedom` VALUES ('629', '52', '0', '删除组', 'groupdelete', '40');
INSERT INTO `qinggan_popedom` VALUES ('630', '52', '0', '添加', 'add', '50');
INSERT INTO `qinggan_popedom` VALUES ('631', '52', '0', '修改', 'edit', '60');
INSERT INTO `qinggan_popedom` VALUES ('632', '52', '0', '删除', 'delete', '70');
INSERT INTO `qinggan_popedom` VALUES ('633', '52', '0', '启用/禁用', 'status', '80');
INSERT INTO `qinggan_popedom` VALUES ('634', '52', '0', '组启用/禁用', 'groupstatus', '35');
INSERT INTO `qinggan_popedom` VALUES ('635', '54', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('636', '54', '0', '添加', 'add', '20');
INSERT INTO `qinggan_popedom` VALUES ('637', '54', '0', '修改', 'modify', '30');
INSERT INTO `qinggan_popedom` VALUES ('638', '54', '0', '删除', 'delete', '40');
INSERT INTO `qinggan_popedom` VALUES ('639', '54', '0', '审核', 'status', '50');
INSERT INTO `qinggan_popedom` VALUES ('640', '54', '0', '排序', 'taxis', '60');
INSERT INTO `qinggan_popedom` VALUES ('641', '20', '145', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('642', '20', '145', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('643', '20', '145', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('644', '20', '145', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('645', '20', '145', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('646', '20', '145', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('647', '55', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('648', '55', '0', '更新HTML', 'create', '20');
INSERT INTO `qinggan_popedom` VALUES ('649', '20', '146', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('650', '20', '146', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('651', '20', '147', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('652', '20', '147', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('653', '20', '147', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('654', '20', '147', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('655', '20', '147', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('656', '20', '147', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('663', '20', '149', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('664', '20', '149', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('683', '20', '153', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('684', '20', '153', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('685', '20', '153', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('686', '20', '153', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('687', '20', '153', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('688', '20', '153', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('812', '20', '173', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('690', '57', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('691', '57', '0', '创建备份', 'create', '20');
INSERT INTO `qinggan_popedom` VALUES ('692', '57', '0', '删除备份', 'delete', '30');
INSERT INTO `qinggan_popedom` VALUES ('693', '57', '0', '恢复备份', 'recover', '40');
INSERT INTO `qinggan_popedom` VALUES ('694', '57', '0', '优化', 'optimize', '50');
INSERT INTO `qinggan_popedom` VALUES ('695', '57', '0', '修复', 'repair', '60');
INSERT INTO `qinggan_popedom` VALUES ('696', '58', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('697', '58', '0', '添加', 'add', '20');
INSERT INTO `qinggan_popedom` VALUES ('698', '58', '0', '修改', 'modify', '30');
INSERT INTO `qinggan_popedom` VALUES ('699', '58', '0', '删除', 'delete', '40');
INSERT INTO `qinggan_popedom` VALUES ('700', '18', '0', '状态', 'status', '50');
INSERT INTO `qinggan_popedom` VALUES ('701', '59', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('702', '59', '0', '设置', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('703', '59', '0', '删除', 'delete', '30');
INSERT INTO `qinggan_popedom` VALUES ('704', '27', '0', '扩展', 'ext', '30');
INSERT INTO `qinggan_popedom` VALUES ('705', '20', '0', '扩展', 'ext', '70');
INSERT INTO `qinggan_popedom` VALUES ('706', '20', '157', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('707', '20', '157', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('708', '20', '157', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('709', '20', '157', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('710', '20', '157', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('711', '20', '157', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('712', '20', '157', '扩展', 'ext', '70');
INSERT INTO `qinggan_popedom` VALUES ('713', '20', '158', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('714', '20', '158', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('715', '20', '158', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('716', '20', '158', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('717', '20', '158', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('718', '20', '158', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('719', '20', '158', '扩展', 'ext', '70');
INSERT INTO `qinggan_popedom` VALUES ('720', '20', '160', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('721', '20', '160', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('722', '20', '160', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('723', '20', '160', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('724', '20', '160', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('725', '20', '160', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('726', '20', '160', '扩展', 'ext', '70');
INSERT INTO `qinggan_popedom` VALUES ('727', '20', '161', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('728', '20', '161', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('729', '20', '161', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('730', '20', '161', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('731', '20', '161', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('732', '20', '161', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('733', '20', '161', '扩展', 'ext', '70');
INSERT INTO `qinggan_popedom` VALUES ('754', '63', '0', '修改', 'modify', '30');
INSERT INTO `qinggan_popedom` VALUES ('753', '63', '0', '添加', 'add', '20');
INSERT INTO `qinggan_popedom` VALUES ('752', '63', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('751', '62', '0', '删除', 'delete', '40');
INSERT INTO `qinggan_popedom` VALUES ('750', '62', '0', '编辑', 'modify', '30');
INSERT INTO `qinggan_popedom` VALUES ('749', '62', '0', '添加', 'add', '20');
INSERT INTO `qinggan_popedom` VALUES ('748', '62', '0', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('755', '63', '0', '删除', 'delete', '40');
INSERT INTO `qinggan_popedom` VALUES ('789', '20', '169', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('788', '20', '169', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('787', '20', '169', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('786', '20', '169', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('785', '20', '169', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('775', '20', '167', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('774', '20', '167', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('773', '20', '167', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('772', '20', '167', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('771', '20', '167', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('770', '20', '167', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('776', '20', '167', '扩展', 'ext', '70');
INSERT INTO `qinggan_popedom` VALUES ('790', '20', '169', '扩展', 'ext', '70');
INSERT INTO `qinggan_popedom` VALUES ('784', '20', '169', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('810', '20', '172', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('809', '20', '172', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('808', '20', '172', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('807', '20', '172', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('806', '20', '172', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('805', '20', '172', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('798', '20', '171', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('799', '20', '171', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('800', '20', '171', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('801', '20', '171', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('802', '20', '171', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('803', '20', '171', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('804', '20', '171', '扩展', 'ext', '70');
INSERT INTO `qinggan_popedom` VALUES ('811', '20', '172', '扩展', 'ext', '70');
INSERT INTO `qinggan_popedom` VALUES ('817', '20', '173', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('818', '20', '173', '扩展', 'ext', '70');
INSERT INTO `qinggan_popedom` VALUES ('819', '20', '174', '查看', 'list', '10');
INSERT INTO `qinggan_popedom` VALUES ('820', '20', '174', '编辑', 'set', '20');
INSERT INTO `qinggan_popedom` VALUES ('821', '20', '174', '添加', 'add', '30');
INSERT INTO `qinggan_popedom` VALUES ('822', '20', '174', '修改', 'modify', '40');
INSERT INTO `qinggan_popedom` VALUES ('823', '20', '174', '删除', 'delete', '50');
INSERT INTO `qinggan_popedom` VALUES ('824', '20', '174', '启用/禁用', 'status', '60');
INSERT INTO `qinggan_popedom` VALUES ('825', '20', '174', '扩展', 'ext', '70');

-- ----------------------------
-- Table structure for `qinggan_project`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_project`;
CREATE TABLE `qinggan_project` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID，也是应用ID',
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '上一级ID',
  `site_id` mediumint(8) unsigned NOT NULL COMMENT '网站ID',
  `module` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '指定模型ID，为0表页面空白',
  `cate` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '绑定根分类ID',
  `title` varchar(255) NOT NULL COMMENT '名称',
  `nick_title` varchar(255) NOT NULL COMMENT '后台别称',
  `taxis` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序，值越小越往前靠',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0不使用1使用',
  `tpl_index` varchar(255) NOT NULL COMMENT '封面页',
  `tpl_list` varchar(255) NOT NULL COMMENT '列表页',
  `tpl_content` varchar(255) NOT NULL COMMENT '详细页',
  `is_identifier` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否自定义标识',
  `ico` varchar(255) NOT NULL COMMENT '图标',
  `orderby` text NOT NULL COMMENT '排序',
  `alias_title` varchar(255) NOT NULL COMMENT '主题别名',
  `alias_note` varchar(255) NOT NULL COMMENT '主题备注',
  `psize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '0表示不限制，每页显示数量',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID号，为0表示管理员维护',
  `identifier` varchar(255) NOT NULL COMMENT '标识',
  `seo_title` varchar(255) NOT NULL COMMENT 'SEO标题',
  `seo_keywords` varchar(255) NOT NULL COMMENT 'SEO关键字',
  `seo_desc` varchar(255) NOT NULL COMMENT 'SEO描述',
  `subtopics` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否启用子主题功能',
  `is_search` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否支持搜索',
  `is_tag` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '必填Tag',
  `is_biz` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0不启用电商，1启用电商',
  `is_userid` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否绑定会员',
  `is_tpl_content` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否自定义内容模板',
  `is_seo` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否默认使用seo',
  `currency_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '默认货币ID',
  `admin_note` text NOT NULL COMMENT '管理员备注，给编辑人员使用的',
  `hidden` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0显示1隐藏',
  `post_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '发布模式，0不启用1启用',
  `comment_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '启用评论功能',
  `post_tpl` varchar(255) NOT NULL COMMENT '发布页模板',
  `etpl_admin` varchar(255) NOT NULL COMMENT '通知管理员邮件模板',
  `etpl_user` varchar(255) NOT NULL COMMENT '发布邮件通知会员模板',
  `etpl_comment_admin` varchar(255) NOT NULL COMMENT '评论邮件通知管理员模板',
  `etpl_comment_user` varchar(255) NOT NULL COMMENT '评论邮件通知会员',
  `is_attr` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1启用主题属性0不启用',
  `tag` varchar(255) NOT NULL COMMENT '自身Tag设置',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `site_id` (`site_id`,`status`)
) ENGINE=MyISAM AUTO_INCREMENT=175 DEFAULT CHARSET=utf8 COMMENT='项目管理器';

-- ----------------------------
-- Records of qinggan_project
-- ----------------------------
INSERT INTO `qinggan_project` VALUES ('41', '0', '1', '21', '0', '图片播放器', '', '20', '1', '', '', '', '0', 'images/ico/picplayer.png', 'l.sort ASC,l.dateline DESC,l.id DESC', '', '', '30', '0', 'picture-player', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '', '', '', '', '', '0', '');
INSERT INTO `qinggan_project` VALUES ('42', '0', '1', '23', '0', '导航菜单', '', '30', '1', '', '', '', '0', 'images/ico/menu.png', 'l.sort ASC,l.dateline DESC,l.id DESC', '导航名称', '', '30', '0', 'menu', '', '', '', '1', '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '', '', '', '', '', '1', '');
INSERT INTO `qinggan_project` VALUES ('43', '0', '1', '22', '7', '学校新闻', '', '12', '1', '', '', '', '1', 'images/ico/article.png', 'l.sort DESC,l.dateline DESC,l.id DESC', '新闻主题', '', '10', '0', 'news', '', '', '', '0', '1', '0', '0', '0', '0', '1', '0', '', '0', '0', '1', '', '', '', '', '', '1', '');
INSERT INTO `qinggan_project` VALUES ('87', '0', '1', '0', '0', '关于我们', '', '15', '1', '', '', '', '0', 'images/ico/about.png', 'l.sort ASC,l.dateline DESC,l.id DESC', '', '', '30', '0', 'about', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '', '', '', '', '', '0', '');
INSERT INTO `qinggan_project` VALUES ('90', '87', '1', '0', '0', '学校简介', '', '10', '1', '', '', '', '0', 'images/ico/company.png', '', '', '', '30', '0', 'about-us', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '', '', '', '', '', '0', '企业 phpok企业');
INSERT INTO `qinggan_project` VALUES ('146', '87', '1', '0', '0', '发展历程', '', '20', '1', '', '', '', '0', 'images/ico/time.png', 'l.sort DESC,l.dateline DESC,l.id DESC', '', '', '30', '0', 'development-course', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '', '', '', '', '', '0', '');
INSERT INTO `qinggan_project` VALUES ('92', '87', '1', '0', '0', '联系我们', '', '30', '1', '', '', '', '0', 'images/ico/email.png', '', '', '', '30', '0', 'contact-us', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '', '', '', '', '', '0', '');
INSERT INTO `qinggan_project` VALUES ('93', '87', '1', '0', '0', '工作环境', '', '40', '1', '', '', '', '0', 'images/ico/extension.png', 'l.sort DESC,l.dateline DESC,l.id DESC', '', '', '30', '0', 'work', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '', '', '', '', '', '0', '');
INSERT INTO `qinggan_project` VALUES ('142', '0', '1', '61', '0', '友情链接', '', '120', '1', '', '', '', '0', 'images/ico/link.png', 'l.sort ASC,l.dateline DESC,l.id DESC', '网站名称', '', '30', '0', 'link', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '1', '0', 'post_link', 'project_save', '', '', '', '0', '');
INSERT INTO `qinggan_project` VALUES ('147', '0', '1', '23', '0', '页脚导航', '', '35', '1', '', '', '', '0', 'images/ico/menu.png', 'l.sort ASC,l.dateline DESC,l.id DESC', '', '', '30', '0', 'yejiaodaohang', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '', '', '', '', '', '0', '');
INSERT INTO `qinggan_project` VALUES ('149', '0', '1', '0', '0', '首页自定义', '', '10', '1', '', '', '', '0', 'images/ico/home.png', 'l.sort DESC,l.dateline DESC,l.id DESC', '', '', '30', '0', 'index', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '', '', '', '', '', '0', '');
INSERT INTO `qinggan_project` VALUES ('167', '0', '1', '22', '0', '校园公告', '校园公告', '255', '1', '', '', '', '0', '', 'l.sort ASC,l.dateline DESC,l.id DESC', '', '', '30', '0', 'xygg', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '', '', '', '', '', '0', '');
INSERT INTO `qinggan_project` VALUES ('169', '0', '1', '74', '0', '首页新闻图片', '', '20', '1', '', 'picture-player_list', 'picture-player_content', '0', 'images/ico/picplayer.png', 'l.sort ASC,l.dateline DESC,l.id DESC', '', '', '30', '0', 'xwtp', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '', '', '', '', '', '0', '');
INSERT INTO `qinggan_project` VALUES ('172', '0', '1', '22', '0', '最新动态', '最新动态', '13', '1', '', 'news_list', 'news_content', '0', 'images/ico/article.png', 'l.sort DESC,l.dateline DESC,l.id DESC', '新闻主题', '', '10', '0', 'zuixindongtai', '', '', '', '0', '1', '0', '0', '0', '0', '0', '0', '', '0', '0', '1', '', '', '', '', '', '1', '');
INSERT INTO `qinggan_project` VALUES ('171', '0', '1', '22', '0', '热点新闻', '热点新闻', '13', '1', '', 'news_list', 'news_content', '0', 'images/ico/article.png', 'l.sort DESC,l.dateline DESC,l.id DESC', '新闻主题', '', '10', '0', 'redianxinwen', '', '', '', '0', '1', '0', '0', '0', '0', '0', '0', '', '0', '0', '1', '', '', '', '', '', '1', '');
INSERT INTO `qinggan_project` VALUES ('173', '0', '1', '68', '0', '校园风貌', '校园风貌', '255', '1', '', 'photo_list', 'photo_content', '0', '', 'l.sort ASC,l.dateline DESC,l.id DESC', '', '', '30', '0', 'xyfm', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '', '', '', '', '', '0', '');
INSERT INTO `qinggan_project` VALUES ('174', '0', '1', '74', '0', '学校新闻图片', '', '20', '1', '', 'picture-player_list', 'picture-player_content', '0', 'images/ico/picplayer.png', 'l.sort ASC,l.dateline DESC,l.id DESC', '', '', '30', '0', 'xxxw', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '', '', '', '', '', '0', '');

-- ----------------------------
-- Table structure for `qinggan_reply`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_reply`;
CREATE TABLE `qinggan_reply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主题ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父回复ID',
  `vouch` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '推荐评论',
  `star` tinyint(1) NOT NULL DEFAULT '3' COMMENT '星级',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `ip` varchar(255) NOT NULL COMMENT '回复人IP',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0未审核1审核',
  `session_id` varchar(255) NOT NULL COMMENT '游客标识',
  `content` text NOT NULL COMMENT '评论内容',
  `admin_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `adm_content` longtext NOT NULL COMMENT '管理员回复内容',
  `adm_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回复时间',
  PRIMARY KEY (`id`),
  KEY `tid` (`tid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='主题评论表';

-- ----------------------------
-- Records of qinggan_reply
-- ----------------------------

-- ----------------------------
-- Table structure for `qinggan_res`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_res`;
CREATE TABLE `qinggan_res` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '资源ID',
  `cate_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `folder` varchar(255) NOT NULL COMMENT '存储目录',
  `name` varchar(255) NOT NULL COMMENT '资源文件名',
  `ext` varchar(30) NOT NULL COMMENT '资源后缀，如jpg等',
  `filename` varchar(255) NOT NULL COMMENT '文件名带路径',
  `ico` varchar(255) NOT NULL COMMENT 'ICO图标文件',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `title` varchar(255) NOT NULL COMMENT '内容',
  `attr` text NOT NULL COMMENT '附件属性',
  `note` text NOT NULL COMMENT '备注',
  `session_id` varchar(100) NOT NULL COMMENT '操作者 ID，即会员ID用于检测是否有权限删除 ',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID，当该ID为时检则sesson_id，如不相同则不能删除 ',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  PRIMARY KEY (`id`),
  KEY `ext` (`ext`)
) ENGINE=MyISAM AUTO_INCREMENT=891 DEFAULT CHARSET=utf8 COMMENT='资源ID';

-- ----------------------------
-- Records of qinggan_res
-- ----------------------------
INSERT INTO `qinggan_res` VALUES ('827', '13', 'res/picplayer/', 'b13b0cfacb8567c2.jpg', 'jpg', 'res/picplayer/b13b0cfacb8567c2.jpg', 'images/filetype-large/jpg.jpg', '1430375027', '01', 'a:2:{s:5:\"width\";i:980;s:6:\"height\";i:180;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('828', '13', 'res/picplayer/', '21a7421bf229f2ff.jpg', 'jpg', 'res/picplayer/21a7421bf229f2ff.jpg', 'images/filetype-large/jpg.jpg', '1430375108', '02', 'a:2:{s:5:\"width\";i:980;s:6:\"height\";i:180;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('829', '13', 'res/picplayer/', '51d03925fffb2e14.jpg', 'jpg', 'res/picplayer/51d03925fffb2e14.jpg', 'images/filetype-large/jpg.jpg', '1430375118', '03', 'a:2:{s:5:\"width\";i:980;s:6:\"height\";i:180;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('630', '1', 'res/201409/03/', '5b0086d14de1bbf2.jpg', 'jpg', 'res/201409/03/5b0086d14de1bbf2.jpg', 'res/201409/03/_630.jpg', '1409749616', 'about-img', 'a:2:{s:5:\"width\";i:129;s:6:\"height\";i:133;}', '', '', '0', '0', '0');
INSERT INTO `qinggan_res` VALUES ('888', '1', 'res/201506/17/', 'a0a6614e7b0c749f.png', 'png', 'res/201506/17/a0a6614e7b0c749f.png', 'res/201506/17/_888.png', '1434523354', '育人标志100px', 'a:2:{s:5:\"width\";i:100;s:6:\"height\";i:102;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('889', '1', 'res/201506/17/', '969c9356661de6c5.png', 'png', 'res/201506/17/969c9356661de6c5.png', 'res/201506/17/_889.png', '1434525824', '育人标志100apx', 'a:2:{s:5:\"width\";i:546;s:6:\"height\";i:102;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('635', '1', 'res/201409/11/', 'e77fa09c0a487b0f.jpg', 'jpg', 'res/201409/11/e77fa09c0a487b0f.jpg', 'res/201409/11/_635.jpg', '1410443978', '01', 'a:2:{s:5:\"width\";i:490;s:6:\"height\";i:490;}', '正面图', '', '0', '0', '0');
INSERT INTO `qinggan_res` VALUES ('636', '1', 'res/201409/11/', '785bf4c3d697cdce.jpg', 'jpg', 'res/201409/11/785bf4c3d697cdce.jpg', 'res/201409/11/_636.jpg', '1410443978', '02', 'a:2:{s:5:\"width\";i:440;s:6:\"height\";i:440;}', '测试2', '', '0', '0', '0');
INSERT INTO `qinggan_res` VALUES ('700', '1', 'res/201411/06/', 'a50b479341925654', 'jpg', 'res/201411/06/a50b479341925654.jpg', 'res/201411/06/_700.jpg', '1415255292', 'logo200', 'a:2:{s:5:\"width\";i:200;s:6:\"height\";i:200;}', '', '3ua49d1mc854trcn2b205tbhf1', '3', '0', '0');
INSERT INTO `qinggan_res` VALUES ('721', '1', 'res/201502/04/', '2e03d8cbd4bd052f_38_0.jpg', 'jpg', 'res/201502/04/2e03d8cbd4bd052f_38_0.jpg', 'res/201502/04/_721.jpg', '1423013135', '1422928796557', 'a:2:{s:5:\"width\";i:447;s:6:\"height\";i:335;}', '', '5erev8s0fdqqpnekg0ih95i480', '0', '0', '0');
INSERT INTO `qinggan_res` VALUES ('723', '1', 'res/201502/17/', 'ec965d3da64edb9c', 'png', 'res/201502/17/ec965d3da64edb9c.png', 'res/201502/17/_723.png', '1424155994', '300', 'a:2:{s:5:\"width\";i:300;s:6:\"height\";i:300;}', '', '8jrbteoquq65qblrp1vi68sc27', '12', '0', '0');
INSERT INTO `qinggan_res` VALUES ('724', '1', 'res/201502/26/', '107e320208ae1e0f.jpg', 'jpg', 'res/201502/26/107e320208ae1e0f.jpg', 'res/201502/26/_724.jpg', '1424917423', 'everedit', 'a:2:{s:5:\"width\";i:700;s:6:\"height\";i:522;}', '', '', '0', '0', '0');
INSERT INTO `qinggan_res` VALUES ('725', '1', 'res/201502/26/', '68e015c42394c56f.jpg', 'jpg', 'res/201502/26/68e015c42394c56f.jpg', 'res/201502/26/_725.jpg', '1424917803', 'wps', 'a:2:{s:5:\"width\";i:700;s:6:\"height\";i:478;}', '', '', '0', '0', '0');
INSERT INTO `qinggan_res` VALUES ('726', '1', 'res/201502/26/', 'bfc3513c24ba7355_94_0.jpg', 'jpg', 'res/201502/26/bfc3513c24ba7355_94_0.jpg', 'res/201502/26/_726.jpg', '1424920067', '1423019734597', 'a:2:{s:5:\"width\";i:368;s:6:\"height\";i:233;}', '', '78u1j5s4ef2jfbnu93uetuif67', '0', '0', '0');
INSERT INTO `qinggan_res` VALUES ('730', '1', 'res/201503/13/', '5bb3971514719131.jpg', 'jpg', 'res/201503/13/5bb3971514719131.jpg', 'res/201503/13/_730.jpg', '1426256922', '180', 'a:2:{s:5:\"width\";i:180;s:6:\"height\";i:180;}', '', '', '0', '0', '0');
INSERT INTO `qinggan_res` VALUES ('731', '1', 'res/201503/22/', '4d191f2f96f43766.jpg', 'jpg', 'res/201503/22/4d191f2f96f43766.jpg', 'res/201503/22/_731.jpg', '1426979029', '农村老家', 'a:2:{s:5:\"width\";i:816;s:6:\"height\";i:594;}', '', '', '0', '0', '0');
INSERT INTO `qinggan_res` VALUES ('733', '1', 'res/201504/09/', '6626a6d2992e767d.rar', 'rar', 'res/201504/09/6626a6d2992e767d.rar', 'images/filetype-large/rar.jpg', '1428562186', 'dtree', '', '', '', '0', '6', '0');
INSERT INTO `qinggan_res` VALUES ('734', '1', 'res/201504/10/', '788f2d92eae6a3cd_48_0.jpg', 'jpg', 'res/201504/10/788f2d92eae6a3cd_48_0.jpg', 'res/201504/10/_734.jpg', '1428676025', '测试的噢999', 'a:2:{s:5:\"width\";i:500;s:6:\"height\";i:333;}', '<p>测试附件可视化摘要！</p>', 'b6709c7259d2248815ece56da062ea61', '0', '0', '0');
INSERT INTO `qinggan_res` VALUES ('735', '1', 'res/201504/10/', '8540dc15d85b44a9_63_1.jpg', 'jpg', 'res/201504/10/8540dc15d85b44a9_63_1.jpg', 'res/201504/10/_735.jpg', '1428676025', '55261f8b40096', 'a:2:{s:5:\"width\";i:500;s:6:\"height\";i:280;}', '', 'b6709c7259d2248815ece56da062ea61', '0', '0', '0');
INSERT INTO `qinggan_res` VALUES ('736', '1', 'res/201504/10/', 'fc51638e37cb2124_74_0.png', 'png', 'res/201504/10/fc51638e37cb2124_74_0.png', 'res/201504/10/_736.png', '1428676255', '1428649014185', 'a:2:{s:5:\"width\";i:714;s:6:\"height\";i:464;}', '', 'b6709c7259d2248815ece56da062ea61', '0', '0', '0');
INSERT INTO `qinggan_res` VALUES ('737', '1', 'res/201504/10/', 'ceb201b133367168_53_0.jpg', 'jpg', 'res/201504/10/ceb201b133367168_53_0.jpg', 'res/201504/10/_737.jpg', '1428676292', '1428648643514', 'a:2:{s:5:\"width\";i:738;s:6:\"height\";i:345;}', '', 'b6709c7259d2248815ece56da062ea61', '0', '0', '0');
INSERT INTO `qinggan_res` VALUES ('738', '1', 'res/201504/10/', 'ba24fe9563df6ddd_45_1.png', 'png', 'res/201504/10/ba24fe9563df6ddd_45_1.png', 'res/201504/10/_738.png', '1428676292', '1428648643875', 'a:2:{s:5:\"width\";i:675;s:6:\"height\";i:457;}', '', 'b6709c7259d2248815ece56da062ea61', '0', '0', '0');
INSERT INTO `qinggan_res` VALUES ('739', '1', 'res/201504/10/', '3e38a8cfd460b1c5_53_2.jpg', 'jpg', 'res/201504/10/3e38a8cfd460b1c5_53_2.jpg', 'res/201504/10/_739.jpg', '1428676292', '1428648643761', 'a:2:{s:5:\"width\";i:738;s:6:\"height\";i:452;}', '<p>dfasfa</p>', 'b6709c7259d2248815ece56da062ea61', '0', '0', '0');
INSERT INTO `qinggan_res` VALUES ('861', '12', 'res/thumb/201505/02/', 'd1084b94031b7e59.jpg', 'jpg', 'res/thumb/201505/02/d1084b94031b7e59.jpg', 'res/thumb/201505/02/_861.jpg', '1430577602', '老君岩小图', 'a:2:{s:5:\"width\";i:200;s:6:\"height\";i:240;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('855', '15', 'res/pictures/201505/02/', '42615936340458ec.jpg', 'jpg', 'res/pictures/201505/02/42615936340458ec.jpg', 'res/pictures/201505/02/_855.jpg', '1430561353', '开元寺实景图01', 'a:2:{s:5:\"width\";i:800;s:6:\"height\";i:557;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('853', '15', 'res/pictures/201505/02/', '67b2ad9d33910a08.jpg', 'jpg', 'res/pictures/201505/02/67b2ad9d33910a08.jpg', 'res/pictures/201505/02/_853.jpg', '1430559466', '开元寺实景图07', 'a:2:{s:5:\"width\";i:800;s:6:\"height\";i:600;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('830', '12', 'res/thumb/201505/02/', 'e7eb33702234fc5e.jpg', 'jpg', 'res/thumb/201505/02/e7eb33702234fc5e.jpg', 'res/thumb/201505/02/_830.jpg', '1430549177', '开元寺-小图', 'a:2:{s:5:\"width\";i:140;s:6:\"height\";i:160;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('856', '15', 'res/pictures/201505/02/', 'bd9803497279bd33.jpg', 'jpg', 'res/pictures/201505/02/bd9803497279bd33.jpg', 'res/pictures/201505/02/_856.jpg', '1430561353', '开元寺实景图02', 'a:2:{s:5:\"width\";i:800;s:6:\"height\";i:593;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('857', '15', 'res/pictures/201505/02/', '52a903c095758cf8.jpg', 'jpg', 'res/pictures/201505/02/52a903c095758cf8.jpg', 'res/pictures/201505/02/_857.jpg', '1430561353', '开元寺实景图03', 'a:2:{s:5:\"width\";i:800;s:6:\"height\";i:593;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('858', '15', 'res/pictures/201505/02/', '8f616f15da194998.jpg', 'jpg', 'res/pictures/201505/02/8f616f15da194998.jpg', 'res/pictures/201505/02/_858.jpg', '1430561355', '开元寺实景图04', 'a:2:{s:5:\"width\";i:800;s:6:\"height\";i:533;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('859', '15', 'res/pictures/201505/02/', '59d32d46223b1c2d.jpg', 'jpg', 'res/pictures/201505/02/59d32d46223b1c2d.jpg', 'res/pictures/201505/02/_859.jpg', '1430561355', '开元寺实景图05', 'a:2:{s:5:\"width\";i:800;s:6:\"height\";i:533;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('860', '15', 'res/pictures/201505/02/', '47227da5cf88bc48.jpg', 'jpg', 'res/pictures/201505/02/47227da5cf88bc48.jpg', 'res/pictures/201505/02/_860.jpg', '1430561355', '开元寺实景图06', 'a:2:{s:5:\"width\";i:800;s:6:\"height\";i:533;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('862', '15', 'res/pictures/201505/02/', '11b32f2adf42be51.jpg', 'jpg', 'res/pictures/201505/02/11b32f2adf42be51.jpg', 'res/pictures/201505/02/_862.jpg', '1430577615', '老君岩01', 'a:2:{s:5:\"width\";i:960;s:6:\"height\";i:640;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('863', '15', 'res/pictures/201505/02/', 'c7cc3a1075cddcf3.jpg', 'jpg', 'res/pictures/201505/02/c7cc3a1075cddcf3.jpg', 'res/pictures/201505/02/_863.jpg', '1430577615', '老君岩02', 'a:2:{s:5:\"width\";i:864;s:6:\"height\";i:1300;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('864', '15', 'res/pictures/201505/02/', '8812cd8b7dc94ea2.jpg', 'jpg', 'res/pictures/201505/02/8812cd8b7dc94ea2.jpg', 'res/pictures/201505/02/_864.jpg', '1430577615', '老君岩03', 'a:2:{s:5:\"width\";i:1300;s:6:\"height\";i:863;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('865', '15', 'res/pictures/201505/02/', '9e39f409f540579f.jpg', 'jpg', 'res/pictures/201505/02/9e39f409f540579f.jpg', 'res/pictures/201505/02/_865.jpg', '1430577618', '老君岩04', 'a:2:{s:5:\"width\";i:1300;s:6:\"height\";i:864;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('866', '15', 'res/pictures/201505/02/', '83486793a8ce6a21.jpg', 'jpg', 'res/pictures/201505/02/83486793a8ce6a21.jpg', 'res/pictures/201505/02/_866.jpg', '1430577618', '老君岩05', 'a:2:{s:5:\"width\";i:1300;s:6:\"height\";i:864;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('867', '15', 'res/pictures/201505/02/', '828bdaf176820f9d.jpg', 'jpg', 'res/pictures/201505/02/828bdaf176820f9d.jpg', 'res/pictures/201505/02/_867.jpg', '1430577618', '老君岩06', 'a:2:{s:5:\"width\";i:864;s:6:\"height\";i:1300;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('868', '12', 'res/thumb/201505/02/', 'fa27a7164eb857fc.jpg', 'jpg', 'res/thumb/201505/02/fa27a7164eb857fc.jpg', 'res/thumb/201505/02/_868.jpg', '1430578718', '牛姆林小图', 'a:2:{s:5:\"width\";i:200;s:6:\"height\";i:240;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('869', '15', 'res/pictures/201505/02/', 'b53cf8920ff5dc66.jpg', 'jpg', 'res/pictures/201505/02/b53cf8920ff5dc66.jpg', 'res/pictures/201505/02/_869.jpg', '1430578727', '牛姆林01', 'a:2:{s:5:\"width\";i:640;s:6:\"height\";i:428;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('870', '15', 'res/pictures/201505/02/', '77270a098f4cc6d5.jpg', 'jpg', 'res/pictures/201505/02/77270a098f4cc6d5.jpg', 'res/pictures/201505/02/_870.jpg', '1430578727', '牛姆林02', 'a:2:{s:5:\"width\";i:402;s:6:\"height\";i:600;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('871', '15', 'res/pictures/201505/02/', '9d902716b08721b1.jpg', 'jpg', 'res/pictures/201505/02/9d902716b08721b1.jpg', 'res/pictures/201505/02/_871.jpg', '1430578727', '牛姆林03', 'a:2:{s:5:\"width\";i:767;s:6:\"height\";i:416;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('872', '15', 'res/pictures/201505/02/', '2f29ccf2413bb97e.jpg', 'jpg', 'res/pictures/201505/02/2f29ccf2413bb97e.jpg', 'res/pictures/201505/02/_872.jpg', '1430578729', '牛姆林04', 'a:2:{s:5:\"width\";i:760;s:6:\"height\";i:423;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('873', '15', 'res/pictures/201505/02/', '6682b10e5bc200a9.jpg', 'jpg', 'res/pictures/201505/02/6682b10e5bc200a9.jpg', 'res/pictures/201505/02/_873.jpg', '1430578729', '牛姆林05', 'a:2:{s:5:\"width\";i:774;s:6:\"height\";i:478;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('874', '15', 'res/pictures/201505/02/', '14418e0c6a346fb6.jpg', 'jpg', 'res/pictures/201505/02/14418e0c6a346fb6.jpg', 'res/pictures/201505/02/_874.jpg', '1430578729', '牛姆林06', 'a:2:{s:5:\"width\";i:768;s:6:\"height\";i:422;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('875', '12', 'res/thumb/201505/02/', '8b25dd8fd55c7831.jpg', 'jpg', 'res/thumb/201505/02/8b25dd8fd55c7831.jpg', 'res/thumb/201505/02/_875.jpg', '1430579475', '清水岩小图', 'a:2:{s:5:\"width\";i:200;s:6:\"height\";i:240;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('876', '15', 'res/pictures/201505/02/', '165a4e7240412c1f.jpg', 'jpg', 'res/pictures/201505/02/165a4e7240412c1f.jpg', 'res/pictures/201505/02/_876.jpg', '1430579481', '清水岩01', 'a:2:{s:5:\"width\";i:1280;s:6:\"height\";i:960;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('887', '1', 'res/201506/17/', '0f73070f1f0ca8dc.jpg', 'jpg', 'res/201506/17/0f73070f1f0ca8dc.jpg', 'res/201506/17/_887.jpg', '1434513745', '育人标志100x', 'a:2:{s:5:\"width\";i:100;s:6:\"height\";i:102;}', '', '', '0', '0', '1');
INSERT INTO `qinggan_res` VALUES ('885', '1', 'res/201506/17/', 'd4ee2167f68ecc93.jpg', 'jpg', 'res/201506/17/d4ee2167f68ecc93.jpg', 'res/201506/17/_885.jpg', '1434511111', '育人标志', 'a:2:{s:5:\"width\";i:3915;s:6:\"height\";i:4001;}', '', '', '0', '0', '1');

-- ----------------------------
-- Table structure for `qinggan_res_cate`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_res_cate`;
CREATE TABLE `qinggan_res_cate` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '资源分类ID',
  `title` varchar(255) NOT NULL COMMENT '分类名称',
  `root` varchar(255) NOT NULL DEFAULT '/' COMMENT '存储目录',
  `folder` varchar(255) NOT NULL DEFAULT 'Ym/d/' COMMENT '存储目录格式',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1默认0非默认',
  `filetypes` varchar(255) NOT NULL COMMENT '附件类型',
  `typeinfo` varchar(200) NOT NULL COMMENT '类型说明',
  `gdtypes` varchar(255) NOT NULL COMMENT '支持的GD方案，多个GD方案用英文ID分开',
  `gdall` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1支持全部GD方案0仅支持指定的GD方案',
  `ico` tinyint(1) NOT NULL DEFAULT '0' COMMENT '后台缩略图',
  `filemax` int(10) unsigned NOT NULL DEFAULT '2' COMMENT '上传文件大小限制',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='资源分类存储';

-- ----------------------------
-- Records of qinggan_res_cate
-- ----------------------------
INSERT INTO `qinggan_res_cate` VALUES ('1', '图片', 'res/', 'Ym/d/', '1', 'png,jpg,gif', '图片', '12,2', '0', '1', '200');
INSERT INTO `qinggan_res_cate` VALUES ('9', '项目图标库', 'res/project/', '', '0', 'png', 'PNG透明图片', '', '0', '0', '200');
INSERT INTO `qinggan_res_cate` VALUES ('11', '压缩软件', 'res/soft/', 'Y/', '0', 'rar,zip', '压缩包', '', '0', '0', '2000');
INSERT INTO `qinggan_res_cate` VALUES ('12', '缩略图', 'res/thumb/', 'Ym/d/', '0', 'png,jpg,gif', '图片', '2', '0', '1', '100');
INSERT INTO `qinggan_res_cate` VALUES ('13', '图片播放器', 'res/picplayer/', '', '0', 'jpg,png,gif', '图片', '', '0', '0', '500');
INSERT INTO `qinggan_res_cate` VALUES ('14', '产品图片', 'res/', 'Ym/d/', '0', 'png,jpg,gif', '图片', '28,25,12', '0', '1', '500');
INSERT INTO `qinggan_res_cate` VALUES ('15', '图集相册', 'res/pictures/', 'Ym/d/', '0', 'jpg,png,gif', '图片', '29,12', '0', '1', '500');

-- ----------------------------
-- Table structure for `qinggan_res_ext`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_res_ext`;
CREATE TABLE `qinggan_res_ext` (
  `res_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '附件ID',
  `gd_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'GD库方案ID',
  `filename` varchar(255) NOT NULL COMMENT '文件地址（含路径）',
  `filetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后',
  PRIMARY KEY (`res_id`,`gd_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='生成扩展图片';

-- ----------------------------
-- Records of qinggan_res_ext
-- ----------------------------
INSERT INTO `qinggan_res_ext` VALUES ('636', '12', 'res/201409/11/auto_636.jpg', '1430225431');
INSERT INTO `qinggan_res_ext` VALUES ('636', '2', 'res/201409/11/thumb_636.jpg', '1430225431');
INSERT INTO `qinggan_res_ext` VALUES ('635', '12', 'res/201409/11/auto_635.jpg', '1430225433');
INSERT INTO `qinggan_res_ext` VALUES ('635', '2', 'res/201409/11/thumb_635.jpg', '1430225433');
INSERT INTO `qinggan_res_ext` VALUES ('630', '12', 'res/201409/03/auto_630.jpg', '1430225439');
INSERT INTO `qinggan_res_ext` VALUES ('630', '2', 'res/201409/03/thumb_630.jpg', '1430225439');
INSERT INTO `qinggan_res_ext` VALUES ('853', '12', 'res/pictures/201505/02/auto_853.jpg', '1430560999');
INSERT INTO `qinggan_res_ext` VALUES ('861', '2', 'res/thumb/201505/02/thumb_861.jpg', '1430577602');
INSERT INTO `qinggan_res_ext` VALUES ('830', '2', 'res/thumb/201505/02/thumb_830.jpg', '1430563473');
INSERT INTO `qinggan_res_ext` VALUES ('700', '12', 'res/201411/06/auto_700.jpg', '1430225430');
INSERT INTO `qinggan_res_ext` VALUES ('700', '2', 'res/201411/06/thumb_700.jpg', '1430225430');
INSERT INTO `qinggan_res_ext` VALUES ('721', '12', 'res/201502/04/auto_721.jpg', '1430225428');
INSERT INTO `qinggan_res_ext` VALUES ('721', '2', 'res/201502/04/thumb_721.jpg', '1430225428');
INSERT INTO `qinggan_res_ext` VALUES ('723', '12', 'res/201502/17/auto_723.png', '1430225426');
INSERT INTO `qinggan_res_ext` VALUES ('723', '2', 'res/201502/17/thumb_723.png', '1430225426');
INSERT INTO `qinggan_res_ext` VALUES ('724', '12', 'res/201502/26/auto_724.jpg', '1430225424');
INSERT INTO `qinggan_res_ext` VALUES ('724', '2', 'res/201502/26/thumb_724.jpg', '1430225424');
INSERT INTO `qinggan_res_ext` VALUES ('725', '12', 'res/201502/26/auto_725.jpg', '1430225422');
INSERT INTO `qinggan_res_ext` VALUES ('725', '2', 'res/201502/26/thumb_725.jpg', '1430225422');
INSERT INTO `qinggan_res_ext` VALUES ('726', '12', 'res/201502/26/auto_726.jpg', '1430225421');
INSERT INTO `qinggan_res_ext` VALUES ('726', '2', 'res/201502/26/thumb_726.jpg', '1430225421');
INSERT INTO `qinggan_res_ext` VALUES ('730', '12', 'res/201503/13/auto_730.jpg', '1430225417');
INSERT INTO `qinggan_res_ext` VALUES ('730', '2', 'res/201503/13/thumb_730.jpg', '1430225417');
INSERT INTO `qinggan_res_ext` VALUES ('731', '12', 'res/201503/22/auto_731.jpg', '1430225415');
INSERT INTO `qinggan_res_ext` VALUES ('731', '2', 'res/201503/22/thumb_731.jpg', '1430225415');
INSERT INTO `qinggan_res_ext` VALUES ('887', '2', 'res/201506/17/thumb_887.jpg', '1434513745');
INSERT INTO `qinggan_res_ext` VALUES ('888', '12', 'res/201506/17/auto_888.png', '1434523354');
INSERT INTO `qinggan_res_ext` VALUES ('734', '12', 'res/201504/10/auto_734.jpg', '1430225410');
INSERT INTO `qinggan_res_ext` VALUES ('734', '2', 'res/201504/10/thumb_734.jpg', '1430225410');
INSERT INTO `qinggan_res_ext` VALUES ('735', '12', 'res/201504/10/auto_735.jpg', '1430225408');
INSERT INTO `qinggan_res_ext` VALUES ('735', '2', 'res/201504/10/thumb_735.jpg', '1430225408');
INSERT INTO `qinggan_res_ext` VALUES ('736', '12', 'res/201504/10/auto_736.png', '1430225406');
INSERT INTO `qinggan_res_ext` VALUES ('736', '2', 'res/201504/10/thumb_736.png', '1430225406');
INSERT INTO `qinggan_res_ext` VALUES ('737', '12', 'res/201504/10/auto_737.jpg', '1430225404');
INSERT INTO `qinggan_res_ext` VALUES ('737', '2', 'res/201504/10/thumb_737.jpg', '1430225404');
INSERT INTO `qinggan_res_ext` VALUES ('738', '12', 'res/201504/10/auto_738.png', '1430225402');
INSERT INTO `qinggan_res_ext` VALUES ('738', '2', 'res/201504/10/thumb_738.png', '1430225402');
INSERT INTO `qinggan_res_ext` VALUES ('739', '12', 'res/201504/10/auto_739.jpg', '1430225400');
INSERT INTO `qinggan_res_ext` VALUES ('739', '2', 'res/201504/10/thumb_739.jpg', '1430225400');
INSERT INTO `qinggan_res_ext` VALUES ('853', '29', 'res/pictures/201505/02/photo_853.jpg', '1430560999');
INSERT INTO `qinggan_res_ext` VALUES ('855', '29', 'res/pictures/201505/02/photo_855.jpg', '1430561353');
INSERT INTO `qinggan_res_ext` VALUES ('630', '22', 'res/201409/03/mobile_630.jpg', '1430221693');
INSERT INTO `qinggan_res_ext` VALUES ('889', '12', 'res/201506/17/auto_889.png', '1434525824');
INSERT INTO `qinggan_res_ext` VALUES ('889', '2', 'res/201506/17/thumb_889.png', '1434525824');
INSERT INTO `qinggan_res_ext` VALUES ('635', '22', 'res/201409/11/mobile_635.jpg', '1430221687');
INSERT INTO `qinggan_res_ext` VALUES ('636', '22', 'res/201409/11/mobile_636.jpg', '1430221685');
INSERT INTO `qinggan_res_ext` VALUES ('700', '22', 'res/201411/06/mobile_700.jpg', '1430221683');
INSERT INTO `qinggan_res_ext` VALUES ('721', '22', 'res/201502/04/mobile_721.jpg', '1430221681');
INSERT INTO `qinggan_res_ext` VALUES ('723', '22', 'res/201502/17/mobile_723.png', '1430221679');
INSERT INTO `qinggan_res_ext` VALUES ('724', '22', 'res/201502/26/mobile_724.jpg', '1430221677');
INSERT INTO `qinggan_res_ext` VALUES ('725', '22', 'res/201502/26/mobile_725.jpg', '1430221675');
INSERT INTO `qinggan_res_ext` VALUES ('726', '22', 'res/201502/26/mobile_726.jpg', '1430221673');
INSERT INTO `qinggan_res_ext` VALUES ('887', '12', 'res/201506/17/auto_887.jpg', '1434513745');
INSERT INTO `qinggan_res_ext` VALUES ('731', '22', 'res/201503/22/mobile_731.jpg', '1430221668');
INSERT INTO `qinggan_res_ext` VALUES ('730', '22', 'res/201503/13/mobile_730.jpg', '1430221670');
INSERT INTO `qinggan_res_ext` VALUES ('736', '22', 'res/201504/10/mobile_736.png', '1430221658');
INSERT INTO `qinggan_res_ext` VALUES ('735', '22', 'res/201504/10/mobile_735.jpg', '1430221660');
INSERT INTO `qinggan_res_ext` VALUES ('734', '22', 'res/201504/10/mobile_734.jpg', '1430221662');
INSERT INTO `qinggan_res_ext` VALUES ('739', '22', 'res/201504/10/mobile_739.jpg', '1430221652');
INSERT INTO `qinggan_res_ext` VALUES ('738', '22', 'res/201504/10/mobile_738.png', '1430221654');
INSERT INTO `qinggan_res_ext` VALUES ('737', '22', 'res/201504/10/mobile_737.jpg', '1430221656');
INSERT INTO `qinggan_res_ext` VALUES ('855', '12', 'res/pictures/201505/02/auto_855.jpg', '1430561353');
INSERT INTO `qinggan_res_ext` VALUES ('856', '29', 'res/pictures/201505/02/photo_856.jpg', '1430561353');
INSERT INTO `qinggan_res_ext` VALUES ('856', '12', 'res/pictures/201505/02/auto_856.jpg', '1430561353');
INSERT INTO `qinggan_res_ext` VALUES ('857', '29', 'res/pictures/201505/02/photo_857.jpg', '1430561353');
INSERT INTO `qinggan_res_ext` VALUES ('857', '12', 'res/pictures/201505/02/auto_857.jpg', '1430561353');
INSERT INTO `qinggan_res_ext` VALUES ('858', '29', 'res/pictures/201505/02/photo_858.jpg', '1430561355');
INSERT INTO `qinggan_res_ext` VALUES ('858', '12', 'res/pictures/201505/02/auto_858.jpg', '1430561355');
INSERT INTO `qinggan_res_ext` VALUES ('859', '29', 'res/pictures/201505/02/photo_859.jpg', '1430561355');
INSERT INTO `qinggan_res_ext` VALUES ('859', '12', 'res/pictures/201505/02/auto_859.jpg', '1430561355');
INSERT INTO `qinggan_res_ext` VALUES ('860', '29', 'res/pictures/201505/02/photo_860.jpg', '1430561355');
INSERT INTO `qinggan_res_ext` VALUES ('860', '12', 'res/pictures/201505/02/auto_860.jpg', '1430561355');
INSERT INTO `qinggan_res_ext` VALUES ('862', '29', 'res/pictures/201505/02/photo_862.jpg', '1430577615');
INSERT INTO `qinggan_res_ext` VALUES ('862', '12', 'res/pictures/201505/02/auto_862.jpg', '1430577615');
INSERT INTO `qinggan_res_ext` VALUES ('863', '29', 'res/pictures/201505/02/photo_863.jpg', '1430577615');
INSERT INTO `qinggan_res_ext` VALUES ('863', '12', 'res/pictures/201505/02/auto_863.jpg', '1430577615');
INSERT INTO `qinggan_res_ext` VALUES ('864', '29', 'res/pictures/201505/02/photo_864.jpg', '1430577615');
INSERT INTO `qinggan_res_ext` VALUES ('864', '12', 'res/pictures/201505/02/auto_864.jpg', '1430577615');
INSERT INTO `qinggan_res_ext` VALUES ('865', '29', 'res/pictures/201505/02/photo_865.jpg', '1430577618');
INSERT INTO `qinggan_res_ext` VALUES ('865', '12', 'res/pictures/201505/02/auto_865.jpg', '1430577618');
INSERT INTO `qinggan_res_ext` VALUES ('866', '29', 'res/pictures/201505/02/photo_866.jpg', '1430577618');
INSERT INTO `qinggan_res_ext` VALUES ('866', '12', 'res/pictures/201505/02/auto_866.jpg', '1430577618');
INSERT INTO `qinggan_res_ext` VALUES ('867', '29', 'res/pictures/201505/02/photo_867.jpg', '1430577618');
INSERT INTO `qinggan_res_ext` VALUES ('867', '12', 'res/pictures/201505/02/auto_867.jpg', '1430577618');
INSERT INTO `qinggan_res_ext` VALUES ('868', '2', 'res/thumb/201505/02/thumb_868.jpg', '1430578718');
INSERT INTO `qinggan_res_ext` VALUES ('869', '29', 'res/pictures/201505/02/photo_869.jpg', '1430578727');
INSERT INTO `qinggan_res_ext` VALUES ('869', '12', 'res/pictures/201505/02/auto_869.jpg', '1430578727');
INSERT INTO `qinggan_res_ext` VALUES ('870', '29', 'res/pictures/201505/02/photo_870.jpg', '1430578727');
INSERT INTO `qinggan_res_ext` VALUES ('870', '12', 'res/pictures/201505/02/auto_870.jpg', '1430578727');
INSERT INTO `qinggan_res_ext` VALUES ('871', '29', 'res/pictures/201505/02/photo_871.jpg', '1430578727');
INSERT INTO `qinggan_res_ext` VALUES ('871', '12', 'res/pictures/201505/02/auto_871.jpg', '1430578727');
INSERT INTO `qinggan_res_ext` VALUES ('872', '29', 'res/pictures/201505/02/photo_872.jpg', '1430578729');
INSERT INTO `qinggan_res_ext` VALUES ('872', '12', 'res/pictures/201505/02/auto_872.jpg', '1430578729');
INSERT INTO `qinggan_res_ext` VALUES ('873', '29', 'res/pictures/201505/02/photo_873.jpg', '1430578729');
INSERT INTO `qinggan_res_ext` VALUES ('873', '12', 'res/pictures/201505/02/auto_873.jpg', '1430578729');
INSERT INTO `qinggan_res_ext` VALUES ('874', '29', 'res/pictures/201505/02/photo_874.jpg', '1430578729');
INSERT INTO `qinggan_res_ext` VALUES ('874', '12', 'res/pictures/201505/02/auto_874.jpg', '1430578729');
INSERT INTO `qinggan_res_ext` VALUES ('875', '2', 'res/thumb/201505/02/thumb_875.jpg', '1430579475');
INSERT INTO `qinggan_res_ext` VALUES ('876', '29', 'res/pictures/201505/02/photo_876.jpg', '1430579481');
INSERT INTO `qinggan_res_ext` VALUES ('876', '12', 'res/pictures/201505/02/auto_876.jpg', '1430579481');
INSERT INTO `qinggan_res_ext` VALUES ('888', '2', 'res/201506/17/thumb_888.png', '1434523354');
INSERT INTO `qinggan_res_ext` VALUES ('885', '12', 'res/201506/17/auto_885.jpg', '1434512246');
INSERT INTO `qinggan_res_ext` VALUES ('885', '2', 'res/201506/17/thumb_885.jpg', '1434512246');

-- ----------------------------
-- Table structure for `qinggan_rewrite`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_rewrite`;
CREATE TABLE `qinggan_rewrite` (
  `id` varchar(100) NOT NULL COMMENT '规则ID',
  `site_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '站点ID',
  `urltype` varchar(255) NOT NULL COMMENT '网址规则',
  PRIMARY KEY (`id`,`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='网址规范，用于伪静态页';

-- ----------------------------
-- Records of qinggan_rewrite
-- ----------------------------

-- ----------------------------
-- Table structure for `qinggan_session`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_session`;
CREATE TABLE `qinggan_session` (
  `id` varchar(32) NOT NULL COMMENT 'session_id',
  `data` text NOT NULL COMMENT 'session 内容',
  `lasttime` int(10) unsigned NOT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='SESSION操作';

-- ----------------------------
-- Records of qinggan_session
-- ----------------------------

-- ----------------------------
-- Table structure for `qinggan_site`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_site`;
CREATE TABLE `qinggan_site` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `domain_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '默认域名ID',
  `title` varchar(255) NOT NULL COMMENT '网站名称',
  `dir` varchar(255) NOT NULL DEFAULT '/' COMMENT '安装目录，以/结尾',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `content` text NOT NULL COMMENT '网站关闭原因',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1默认站点',
  `tpl_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '模板ID',
  `url_type` enum('default','rewrite','html') NOT NULL DEFAULT 'default' COMMENT '默认，即带?等能数，rewrite是伪静态页，html为生成的静态页',
  `logo` varchar(255) NOT NULL COMMENT '网站 LOGO ',
  `meta` text NOT NULL COMMENT '扩展配置',
  `currency_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '默认货币ID',
  `register_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0关闭注册1开启注册',
  `register_close` varchar(255) NOT NULL COMMENT '关闭注册说明',
  `login_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0关闭登录1开启',
  `login_close` varchar(255) NOT NULL COMMENT '关闭登录说明',
  `adm_logo29` varchar(255) NOT NULL COMMENT '在后台左侧LOGO地址',
  `adm_logo180` varchar(255) NOT NULL COMMENT '登录LOGO地址',
  `lang` varchar(255) NOT NULL COMMENT '语言包',
  `api` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '0不走接口',
  `api_code` varchar(255) NOT NULL COMMENT 'API验证串',
  `email_charset` enum('gbk','utf-8') NOT NULL DEFAULT 'utf-8' COMMENT '邮箱模式',
  `email_server` varchar(100) NOT NULL COMMENT '邮件服务器',
  `email_port` varchar(10) NOT NULL COMMENT '端口',
  `email_ssl` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'SSL模式',
  `email_account` varchar(100) NOT NULL COMMENT '邮箱账号',
  `email_pass` varchar(100) NOT NULL COMMENT '邮箱密码',
  `email_name` varchar(100) NOT NULL COMMENT '发件人名称',
  `email` varchar(100) NOT NULL COMMENT '邮箱',
  `seo_title` varchar(255) NOT NULL COMMENT 'SEO主题',
  `seo_keywords` varchar(255) NOT NULL COMMENT 'SEO关键字',
  `seo_desc` text NOT NULL COMMENT 'SEO摘要',
  `biz_sn` varchar(255) NOT NULL COMMENT '订单号生成规则',
  `biz_payment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '默认支付方式',
  `biz_billing` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '0未绑定',
  `upload_guest` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '游客上传权限',
  `upload_user` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '会员上传权限',
  `html_root_dir` varchar(255) NOT NULL DEFAULT 'html/' COMMENT 'HTML根目录',
  `html_content_type` varchar(255) NOT NULL DEFAULT 'empty' COMMENT 'HTML生成规则',
  `biz_etpl` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='网站管理';

-- ----------------------------
-- Records of qinggan_site
-- ----------------------------
INSERT INTO `qinggan_site` VALUES ('1', '1', '郑州育人国际学校', '/', '1', '网站建设中', '1', '1', 'default', 'res/201506/17/969c9356661de6c5.png', '', '1', '0', '暂停注册', '0', '暂停登录', 'res/201506/17/a0a6614e7b0c749f.png', '', 'cn', '0', '', 'utf-8', '', '25', '0', '', '', '', '', '', '', '', 'prefix[P]-year-month-date-number', '0', '0', '0', '0', 'html/', 'empty', '');

-- ----------------------------
-- Table structure for `qinggan_site_domain`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_site_domain`;
CREATE TABLE `qinggan_site_domain` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `site_id` mediumint(8) unsigned NOT NULL COMMENT '网站ID',
  `domain` varchar(255) NOT NULL COMMENT '域名信息',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='网站指定的域名';

-- ----------------------------
-- Records of qinggan_site_domain
-- ----------------------------
INSERT INTO `qinggan_site_domain` VALUES ('1', '1', 'www.yuren.com');

-- ----------------------------
-- Table structure for `qinggan_stock`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_stock`;
CREATE TABLE `qinggan_stock` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '仓库ID，自增ID',
  `title` varchar(255) NOT NULL COMMENT '仓库名称',
  `address` varchar(255) NOT NULL COMMENT '仓库地址',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0不使用1使用',
  `taxis` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='产品仓库';

-- ----------------------------
-- Records of qinggan_stock
-- ----------------------------

-- ----------------------------
-- Table structure for `qinggan_sysmenu`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_sysmenu`;
CREATE TABLE `qinggan_sysmenu` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '父级ID，0为根菜单',
  `title` varchar(100) NOT NULL COMMENT '分类名称',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态0禁用1正常',
  `appfile` varchar(100) NOT NULL COMMENT '应用文件名，放在phpok/admin/目录下，记录不带.php',
  `taxis` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序，值越小越往前靠，可选0-255',
  `func` varchar(100) NOT NULL COMMENT '应用函数，为空使用index',
  `identifier` varchar(100) NOT NULL COMMENT '标识串，用于区分同一应用文件的不同内容',
  `ext` varchar(255) NOT NULL COMMENT '表单扩展',
  `if_system` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0常规项目，1系统项目',
  `site_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '0表示全局网站',
  `icon` varchar(255) NOT NULL COMMENT '图标路径',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='PHPOK后台系统菜单';

-- ----------------------------
-- Records of qinggan_sysmenu
-- ----------------------------
INSERT INTO `qinggan_sysmenu` VALUES ('1', '0', '设置', '1', 'setting', '50', '', '', '', '1', '0', '');
INSERT INTO `qinggan_sysmenu` VALUES ('3', '0', '会员', '1', 'user', '30', '', '', '', '0', '0', '');
INSERT INTO `qinggan_sysmenu` VALUES ('5', '0', '内容', '1', 'index', '10', '', '', '', '0', '0', '');
INSERT INTO `qinggan_sysmenu` VALUES ('6', '1', '表单选项', '1', 'opt', '30', '', '', '', '0', '0', '');
INSERT INTO `qinggan_sysmenu` VALUES ('7', '4', '字段维护', '1', 'fields', '20', '', '', '', '0', '0', '');
INSERT INTO `qinggan_sysmenu` VALUES ('8', '1', '模块管理', '1', 'module', '20', '', '', '', '0', '0', 'settings');
INSERT INTO `qinggan_sysmenu` VALUES ('9', '1', '核心配置', '1', 'system', '50', '', '', '', '1', '0', '');
INSERT INTO `qinggan_sysmenu` VALUES ('16', '4', '插件', '1', 'plugin', '30', '', '', '', '0', '0', '');
INSERT INTO `qinggan_sysmenu` VALUES ('18', '5', '分类管理', '1', 'cate', '30', '', '', '', '0', '0', 'stack');
INSERT INTO `qinggan_sysmenu` VALUES ('19', '5', '全局内容', '1', 'all', '10', '', '', '', '0', '0', '');
INSERT INTO `qinggan_sysmenu` VALUES ('20', '5', '内容管理', '1', 'list', '20', '', '', '', '0', '0', 'office');
INSERT INTO `qinggan_sysmenu` VALUES ('22', '5', '资源管理', '1', 'res', '60', '', '', '', '0', '0', 'download');
INSERT INTO `qinggan_sysmenu` VALUES ('23', '5', '数据调用', '1', 'call', '40', '', '', '', '0', '0', 'rocket');
INSERT INTO `qinggan_sysmenu` VALUES ('27', '1', '项目管理', '1', 'project', '10', '', '', '', '0', '0', 'finder');
INSERT INTO `qinggan_sysmenu` VALUES ('28', '1', '邮件通知模板', '1', 'email', '40', '', '', '', '0', '0', '');
INSERT INTO `qinggan_sysmenu` VALUES ('29', '1', '管理员维护', '1', 'admin', '80', '', '', '', '0', '0', 'user3');
INSERT INTO `qinggan_sysmenu` VALUES ('30', '1', '风格管理', '1', 'tpl', '60', '', '', '', '0', '0', '');
INSERT INTO `qinggan_sysmenu` VALUES ('31', '1', '站点管理', '1', 'site', '90', '', '', '', '0', '0', '');
INSERT INTO `qinggan_sysmenu` VALUES ('32', '5', '评论管理', '1', 'reply', '50', '', '', '', '0', '1', 'bubbles');
INSERT INTO `qinggan_sysmenu` VALUES ('4', '0', '工具', '1', 'tool', '40', '', '', '', '0', '0', '');
INSERT INTO `qinggan_sysmenu` VALUES ('2', '0', '订单', '0', 'order', '20', '', '', '', '0', '0', '');
INSERT INTO `qinggan_sysmenu` VALUES ('57', '1', '数据库管理', '1', 'sql', '100', '', '', '', '0', '1', '');
INSERT INTO `qinggan_sysmenu` VALUES ('58', '5', 'Tag标签管理', '1', 'tag', '70', '', '', '', '0', '1', 'tags');
INSERT INTO `qinggan_sysmenu` VALUES ('59', '1', '伪静态页规则', '1', 'rewrite', '70', '', '', '', '0', '1', '');
INSERT INTO `qinggan_sysmenu` VALUES ('60', '5', '数据库比较', '1', 'plugin', '80', 'exec', '', 'id=sqldiff&exec=manage', '0', '1', '');
INSERT INTO `qinggan_sysmenu` VALUES ('62', '1', '附件分类管理', '1', 'rescate', '120', '', '', '', '0', '1', 'cogs');
INSERT INTO `qinggan_sysmenu` VALUES ('63', '1', 'GD图片方案', '1', 'gd', '130', '', '', '', '0', '1', 'image');

-- ----------------------------
-- Table structure for `qinggan_tag`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_tag`;
CREATE TABLE `qinggan_tag` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `site_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '站点ID',
  `title` varchar(255) NOT NULL COMMENT '名称',
  `url` varchar(255) NOT NULL COMMENT '关键字网址',
  `target` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0原窗口打开，1新窗口打开',
  `hits` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点击次数',
  `alt` varchar(255) NOT NULL COMMENT '链接里的提示',
  `is_global` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否全局状态1是0否',
  `replace_count` tinyint(4) NOT NULL DEFAULT '3' COMMENT '替换次数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='关键字管理器';

-- ----------------------------
-- Records of qinggan_tag
-- ----------------------------
INSERT INTO `qinggan_tag` VALUES ('1', '1', '企业', '', '0', '1', '', '0', '3');
INSERT INTO `qinggan_tag` VALUES ('2', '1', 'php', '', '0', '0', '', '0', '3');
INSERT INTO `qinggan_tag` VALUES ('3', '1', '公司', '', '0', '0', '', '0', '3');
INSERT INTO `qinggan_tag` VALUES ('4', '1', '新闻', '', '0', '0', '', '0', '3');

-- ----------------------------
-- Table structure for `qinggan_tag_stat`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_tag_stat`;
CREATE TABLE `qinggan_tag_stat` (
  `title_id` varchar(200) NOT NULL COMMENT '主题ID，以p开头的表示项目ID，以c开头的表示分类ID',
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'TAG标签ID',
  PRIMARY KEY (`title_id`,`tag_id`),
  KEY `title_id` (`title_id`),
  KEY `tag_id` (`tag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Tag主题统计';

-- ----------------------------
-- Records of qinggan_tag_stat
-- ----------------------------
INSERT INTO `qinggan_tag_stat` VALUES ('1373', '6');
INSERT INTO `qinggan_tag_stat` VALUES ('1373', '7');
INSERT INTO `qinggan_tag_stat` VALUES ('1381', '10');
INSERT INTO `qinggan_tag_stat` VALUES ('1381', '11');
INSERT INTO `qinggan_tag_stat` VALUES ('1382', '6');
INSERT INTO `qinggan_tag_stat` VALUES ('c8', '3');
INSERT INTO `qinggan_tag_stat` VALUES ('c8', '4');
INSERT INTO `qinggan_tag_stat` VALUES ('p90', '1');
INSERT INTO `qinggan_tag_stat` VALUES ('p90', '2');

-- ----------------------------
-- Table structure for `qinggan_temp`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_temp`;
CREATE TABLE `qinggan_temp` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `tbl` varchar(100) NOT NULL COMMENT '表',
  `admin_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `content` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl` (`tbl`,`admin_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='临时表单存储器';

-- ----------------------------
-- Records of qinggan_temp
-- ----------------------------
INSERT INTO `qinggan_temp` VALUES ('7', 'project-43', '1', 'a:5:{s:2:\"id\";s:2:\"43\";s:5:\"title\";s:12:\"学校新闻\";s:7:\"entitle\";s:0:\"\";s:5:\"thumb\";s:0:\"\";s:6:\"banner\";s:0:\"\";}');

-- ----------------------------
-- Table structure for `qinggan_tpl`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_tpl`;
CREATE TABLE `qinggan_tpl` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(100) NOT NULL COMMENT '模板名称',
  `author` varchar(100) NOT NULL COMMENT '开发者名称',
  `folder` varchar(100) NOT NULL DEFAULT 'www' COMMENT '模板目录',
  `refresh_auto` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1自动判断更新刷新0不刷新',
  `refresh` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1强制刷新0普通刷新',
  `ext` varchar(20) NOT NULL DEFAULT 'html' COMMENT '后缀',
  `folder_change` varchar(255) NOT NULL COMMENT '更改目录',
  `phpfolder` varchar(200) NOT NULL COMMENT 'PHP执行文件目录',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='模板管理';

-- ----------------------------
-- Records of qinggan_tpl
-- ----------------------------
INSERT INTO `qinggan_tpl` VALUES ('1', '默认风格', 'phpok.com', 'www', '1', '0', 'html', 'css,images,js', 'phpinc');

-- ----------------------------
-- Table structure for `qinggan_user`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_user`;
CREATE TABLE `qinggan_user` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID，即会员ID',
  `group_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '主要会员组',
  `user` varchar(100) NOT NULL COMMENT '会员账号',
  `pass` varchar(100) NOT NULL COMMENT '会员密码',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态ID，0未审核1正常2锁定',
  `regtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `email` varchar(200) NOT NULL COMMENT '邮箱，可用于取回密码',
  `mobile` varchar(50) NOT NULL COMMENT '手机或电话',
  `code` varchar(255) NOT NULL COMMENT '验证串，可用于取回密码',
  `avatar` varchar(255) NOT NULL COMMENT '会员头像',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='会员管理';

-- ----------------------------
-- Records of qinggan_user
-- ----------------------------
INSERT INTO `qinggan_user` VALUES ('12', '2', 'demo', '81e7876a76f7ed1553f73973760d8714:e2', '1', '1424154886', 'suxiangkun@126.com', '123456789', 'QCUkfp4oPN1428046065', 'res/201502/17/ec965d3da64edb9c.png');
INSERT INTO `qinggan_user` VALUES ('18', '2', 'admin', '767bb352046d8df71041d1083c34b04b:7a', '1', '1429694309', 'admin@phpok.com', '15818533971', '', '');
INSERT INTO `qinggan_user` VALUES ('19', '2', 'demo999', 'bbf8b998986f2d0ddf0a28fb3bc78a1c:9a', '1', '1433422800', 'demo@9999.com', '15818533971', '', '');

-- ----------------------------
-- Table structure for `qinggan_user_ext`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_user_ext`;
CREATE TABLE `qinggan_user_ext` (
  `id` int(10) unsigned NOT NULL COMMENT '会员ID',
  `fullname` varchar(255) NOT NULL DEFAULT '' COMMENT '姓名',
  `gender` varchar(255) NOT NULL DEFAULT '' COMMENT '性别',
  `content` longtext NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='会员扩展字段';

-- ----------------------------
-- Records of qinggan_user_ext
-- ----------------------------
INSERT INTO `qinggan_user_ext` VALUES ('12', 'demo', '', '');
INSERT INTO `qinggan_user_ext` VALUES ('18', '', '', '');
INSERT INTO `qinggan_user_ext` VALUES ('19', '', '', '');

-- ----------------------------
-- Table structure for `qinggan_user_fields`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_user_fields`;
CREATE TABLE `qinggan_user_fields` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '字段ID，自增',
  `title` varchar(255) NOT NULL COMMENT '字段名称',
  `identifier` varchar(50) NOT NULL COMMENT '字段标识串',
  `field_type` varchar(255) NOT NULL DEFAULT '200' COMMENT '字段存储类型',
  `note` varchar(255) NOT NULL COMMENT '字段内容备注',
  `form_type` varchar(100) NOT NULL COMMENT '表单类型',
  `form_style` varchar(255) NOT NULL COMMENT '表单CSS',
  `format` varchar(100) NOT NULL COMMENT '格式化方式',
  `content` varchar(255) NOT NULL COMMENT '默认值',
  `taxis` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  `ext` text NOT NULL COMMENT '扩展内容',
  `is_edit` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0不可编辑1可编辑',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='字段管理器';

-- ----------------------------
-- Records of qinggan_user_fields
-- ----------------------------
INSERT INTO `qinggan_user_fields` VALUES ('21', '姓名', 'fullname', 'varchar', '', 'text', '', 'safe', '', '10', 'a:2:{s:8:\"form_btn\";b:0;s:5:\"width\";s:3:\"300\";}', '1');
INSERT INTO `qinggan_user_fields` VALUES ('22', '性别', 'gender', 'varchar', '', 'radio', '', 'safe', '', '120', 'a:3:{s:11:\"option_list\";s:5:\"opt:1\";s:9:\"put_order\";s:1:\"0\";s:10:\"ext_select\";b:0;}', '1');
INSERT INTO `qinggan_user_fields` VALUES ('23', '内容', 'content', 'longtext', '', 'editor', '', 'html', '', '255', 'a:12:{s:5:\"width\";s:3:\"900\";s:6:\"height\";s:3:\"360\";s:7:\"is_code\";s:0:\"\";s:9:\"btn_image\";s:1:\"1\";s:9:\"btn_video\";s:1:\"1\";s:8:\"btn_file\";s:1:\"1\";s:8:\"btn_page\";s:0:\"\";s:8:\"btn_info\";s:0:\"\";s:7:\"is_read\";s:0:\"\";s:5:\"etype\";s:4:\"full\";s:7:\"btn_map\";s:0:\"\";s:7:\"inc_tag\";s:0:\"\";}', '0');

-- ----------------------------
-- Table structure for `qinggan_user_group`
-- ----------------------------
DROP TABLE IF EXISTS `qinggan_user_group`;
CREATE TABLE `qinggan_user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '会员组ID',
  `title` varchar(255) NOT NULL COMMENT '会员组名称',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0不使用1使用',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1为会员注册默认组',
  `is_guest` tinyint(1) NOT NULL DEFAULT '0' COMMENT '游客组',
  `is_open` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1开放供用户选择，0不开放',
  `taxis` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  `register_status` varchar(100) NOT NULL COMMENT '1通过0审核email邮件code邀请码mobile手机',
  `tbl_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '关联验证串项目',
  `fields` text NOT NULL COMMENT '会员字段，多个字段用英文逗号隔开',
  `popedom` longtext NOT NULL COMMENT '权限，包括读写及评论审核',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='会员组信息管理';

-- ----------------------------
-- Records of qinggan_user_group
-- ----------------------------
INSERT INTO `qinggan_user_group` VALUES ('2', '普通会员', '1', '1', '0', '0', '10', '1', '0', '', 'a:1:{i:1;s:682:\"read:149,read:43,read:87,read:90,read:146,read:92,read:93,read:41,read:42,read:147,read:45,read:156,read:150,read:96,post:96,read:144,read:151,read:152,post:152,read:142,read:148,read:159,read:160,post:160,reply:160,post1:160,reply1:160,read:161,post:161,reply:161,post1:161,reply1:161,read:162,post:162,reply:162,post1:162,reply1:162,read:163,read:164,post:164,reply:164,post1:164,reply1:164,read:165,read:166,read:167,read:168,read:169,post:169,reply:169,post1:169,reply1:169,read:170,post:170,reply:170,post1:170,reply1:170,read:171,post:171,reply:171,post1:171,reply1:171,read:172,post:172,reply:172,post1:172,reply1:172,read:173,read:174,post:174,reply:174,post1:174,reply1:174\";}');
INSERT INTO `qinggan_user_group` VALUES ('3', '游客组', '1', '0', '1', '0', '200', '0', '0', '', 'a:1:{i:1;s:728:\"read:149,read:87,read:90,read:146,read:92,read:93,read:43,read:41,read:42,read:147,read:45,read:150,read:96,post:96,read:144,read:151,read:152,read:142,post:142,read:148,read:153,read:156,read:157,read:158,post:158,post1:158,read:159,read:160,post:160,reply:160,post1:160,reply1:160,read:161,post:161,reply:161,post1:161,reply1:161,read:162,post:162,reply:162,post1:162,reply1:162,read:163,read:164,post:164,reply:164,post1:164,reply1:164,read:165,read:166,read:167,read:168,read:169,post:169,reply:169,post1:169,reply1:169,read:170,post:170,reply:170,post1:170,reply1:170,read:171,post:171,reply:171,post1:171,reply1:171,read:172,post:172,reply:172,post1:172,reply1:172,read:173,read:174,post:174,reply:174,post1:174,reply1:174\";}');
