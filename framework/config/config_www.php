<?php
/***********************************************************
	Filename: phpok/config/config_admin.php
	Note	: 后台控制器
***********************************************************/
if(!defined("PHPOK_SET")){exit("<h1>Access Denied</h1>");}

//前台自动加载的JS，此处的JS对应的CSS，HTML及图片路径是相对于网站根目录
$config["autoload_js"] .= ",global.www.js";
//jQUery插件Superslide
$config["autoload_js"] .= ",jquery.superslide.js";

$config["autoload_func"] = "";


$config["is_vcode"] = true;

$config["gzip"] = true;//启用压缩

