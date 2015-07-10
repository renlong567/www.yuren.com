<?php
/*****************************************************************************************
	文件： {phpok}/model/admin/site_model.php
	备注： 站点信息管理
*****************************************************************************************/
if(!defined("PHPOK_SET")){exit("<h1>Access Denied</h1>");}
class site_model extends site_model_base
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

	public function save($data,$id=0)
	{
		if(!$data || !is_array($data)){
			return false;
		}
		if($id){
			return $this->db->update_array($data,"site",array("id"=>$id));
		}else{
			return $this->db->insert_array($data,"site");
		}
	}

	public function domain_update($domain,$id)
	{
		if(!$domain || !$id){
			return false;
		}
		$sql = "UPDATE ".$this->db->prefix."site_domain SET domain='".$domain."' WHERE id='".$id."'";
		return $this->db->query($sql);
	}

	public function domain_add($domain,$site_id)
	{
		if(!$domain || !$site_id){
			return false;
		}
		$sql = "INSERT INTO ".$this->db->prefix."site_domain(site_id,domain) VALUES('".$site_id."','".$domain."')";
		return $this->db->insert($sql);
	}

	public function domain_delete($id)
	{
		$sql = "DELETE FROM ".$this->db->prefix."site_domain WHERE id='".$id."'";
		return $this->db->query($sql);
	}

	public function all_save($data,$id=0)
	{
		if(!$data || !is_array($data)){
			return false;
		}		
		if($id){
			return $this->db->update_array($data,"all",array("id"=>$id));
		}else{
			return $this->db->insert_array($data,"all");
		}
	}

	public function ext_delete($id)
	{
		if(!$id) {
			return false;
		}
		$sql = "DELETE FROM ".$this->db->prefix."all WHERE id='".$id."'";
		$this->db->query($sql);
		$sql = "SELECT id FROM ".$this->db->prefix."ext WHERE module='all-".$id."'";
		$rslist = $this->db->get_all($sql,"id");
		if($rslist)	{
			$id_array = array_keys($rslist);
			$ids = implode(",",$id_array);
			$sql = "DELETE FROM ".$this->db->prefix."ext_c WHERE id IN(".$ids.")";
			$this->db->query($sql);
			$sql = "DELETE FROM ".$this->db->prefix."ext WHERE id IN(".$ids.")";
			$this->db->query($sql);
		}
		return true;
	}

	public function site_delete($id)
	{
		//读取所有的表
		$rslist = $this->db->list_tables();
		if($rslist){
			foreach($rslist AS $key=>$value){
				$flist = $this->db->list_fields($value);
				if($flist && in_array("site_id",$flist)){
					$sql = "DELETE FROM ".$value." WHERE site_id='".$id."'";
					$this->db->query($sql);
				}
			}
		}
		$sql = "DELETE FROM ".$this->db->prefix."site WHERE id='".$id."'";
		$this->db->query($sql);
		return true;
	}

	public function set_default($id)
	{
		if(!$id) return false;
		$sql = "UPDATE ".$this->db->prefix."site SET is_default=0";
		$this->db->query($sql);
		$sql = "UPDATE ".$this->db->prefix."site SET is_default=1 WHERE id=".intval($id);
		$this->db->query($sql);
		return true;
	}
}

?>