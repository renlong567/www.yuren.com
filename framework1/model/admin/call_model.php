<?php
/*****************************************************************************************
	文件： {phpok}/model/admin/call_model.php
	备注： 调用中心后台管理中涉及到的函数
*****************************************************************************************/
if(!defined("PHPOK_SET")){exit("<h1>Access Denied</h1>");}
class call_model extends call_model_base
{
	public function __construct()
	{
		parent::__construct();
	}

	public function __destruct()
	{
		parent::__destruct();
		unset($this);
	}

	public function del($id)
	{
		$sql = "DELETE FROM ".$this->db->prefix."phpok WHERE id='".$id."'";
		return $this->db->query($sql);
	}

	public function set_status($id,$status=0)
	{
		$sql = "UPDATE ".$this->db->prefix."phpok SET status='".$status."' WHERE id='".$id."'";
		return $this->db->query($sql);
	}

	public function save($data,$id=0)
	{
		if(!$data || !is_array($data)) return false;
		if($id)
		{
			return $this->db->update_array($data,"phpok",array("id"=>$id));
		}
		else
		{
			return $this->db->insert_array($data,"phpok");
		}
	}
}

?>