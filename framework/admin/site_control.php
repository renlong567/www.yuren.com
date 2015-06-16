<?php
/***********************************************************
	Filename: {phpok}/admin/site_control.php
	Note	: 站点管理器
	Version : 4.0
	Web		: www.phpok.com
	Author  : qinggan <qinggan@188.com>
	Update  : 2013年10月8日
***********************************************************/
if(!defined("PHPOK_SET")){exit("<h1>Access Denied</h1>");}
class site_control extends phpok_control
{
	function __construct()
	{
		parent::control();
		$this->popedom = appfile_popedom("site");
		$this->assign("popedom",$this->popedom);
	}

	function index_f()
	{
		if(!$this->popedom["list"]){
			error(P_Lang('您没有权限执行此操作'),'','error');
		}
		$rslist = $this->model('site')->get_all_site();
		$this->assign("rslist",$rslist);
		$domain_list = $this->model('site')->domain_list();
		if($domain_list)
		{
			$dlist = "";
			foreach($domain_list AS $key=>$value)
			{
				$dlist[$value['site_id']][] = $value['domain'];
			}
			$this->assign("dlist",$dlist);
		}
		$this->view("site_list");
	}

	function delete_f()
	{
		//删除站点操作
		if(!$this->popedom['delete']){
			$this->json(P_Lang('您没有权限执行此操作'));
		}
		$id = $this->get("id","int");
		if(!$id) $this->json(P_Lang('未指定ID'));
		$rs = $this->model('site')->get_one($id);
		if(!$rs) $this->json(P_Lang('站点信息不存在'));
		if($rs['is_default']) $this->json(P_Lang('默认站点不支持删除操作'));
		//删除网站内容
		$this->model("site")->site_delete($id);
		if($id == $_SESSION['admin_site_id'])
		{
			$d_rs = $this->model('site')->get_one_default();
			$_SESSION['admin_site_id'] = $d_rs['id'];
		}
		$this->json(P_Lang('网站删除成功'),true);
	}

	function default_f()
	{
		if(!$this->popedom['default']){
			$this->json(P_Lang('您没有权限执行此操作'));
		}
		$id = $this->get("id","int");
		if(!$id) $this->json(P_Lang('未指定站点信息'));
		$rs = $this->model('site')->get_one($id);
		if(!$rs) $this->json(P_Lang('站点信息不存在'));
		if($rs['is_default']) $this->json(P_Lang('默认站点不支持此操作'));
		$this->model('site')->set_default($id);
		$this->json(P_Lang('默认站点设置成功'),true);
	}
}
?>