<?php
/*****************************************************************************************
	文件： {phpok}/model/admin/payment_model.php
	备注： 管理付款信息方案
*****************************************************************************************/
if(!defined("PHPOK_SET")){exit("<h1>Access Denied</h1>");}
class payment_model extends payment_model_base
{
	function __construct()
	{
		parent::__construct();
	}

	public function __destruct()
	{
		parent::__destruct();
		unset($this);
	}

	//取得所支持的付款组
	function group_all($site_id=0,$status=0)
	{
		$condition = $site_id ? "site_id IN(0,".$site_id.")" : "site_id=0";
		$sql = "SELECT * FROM ".$this->db->prefix."payment_group WHERE ".$condition." ";
		if($status)
		{
			$sql .= " AND status=1 ";
		}
		$sql.= "ORDER BY taxis ASC,id DESC";
		return $this->db->get_all($sql,'id');		
	}

	function get_all($condition="")
	{
		$sql = "SELECT * FROM ".$this->db->prefix."payment ";
		if($condition)
		{
			$sql .= "WHERE ".$condition;
		}
		$sql.= ' ORDER BY taxis ASC,id DESC';
		return $this->db->get_all($sql);
	}

	//付款方案option
	function opt_all($site_id=0)
	{
		$condition = $site_id ? "site_id IN(0,".$site_id.")" : "site_id=0";
		$sql = "SELECT * FROM ".$this->db->prefix."payment_group WHERE ".$condition." ";
		$sql.= " ORDER BY is_default DESC,taxis ASC,id DESC";
		$rslist = $this->db->get_all($sql,"id");
		if(!$rslist)
		{
			return false;
		}
		$ids = array_keys($rslist);
		$condition = " gid IN(".implode(",",$ids).")";
		$sql = "SELECT id,title,status,gid,currency FROM ".$this->db->prefix."payment WHERE ".$condition." ORDER BY taxis ASC,id DESC";
		$tmplist = $this->db->get_all($sql);
		if(!$tmplist)
		{
			return false;
		}
		foreach($tmplist AS $key=>$value)
		{
			$rslist[$value['gid']]['paylist'][$value['id']] = $value;
		}
		return $rslist;
	}

	//获取本站系统中存储的所有支付引挈
	function code_all()
	{
		//读取目录下的
		$handle = opendir($this->dir_root.'payment');
		$list = array();
		while(false !== ($myfile = readdir($handle)))
		{
			if(substr($myfile,0,1) != '.' && is_dir($this->dir_root.'payment/'.$myfile))
			{
				$list[$myfile] = array('id'=>$myfile,'dir'=>$this->dir_root.'payment/'.$myfile);
				$tmpfile = $this->dir_root.'payment/'.$myfile.'/config.xml';
				if(is_file($tmpfile))
				{
					$tmp = xml_to_array(file_get_contents($tmpfile));
				}
				else
				{
					$tmp = array('title'=>$myfile,'code'=>'');
				}
				$list[$myfile]['title'] = $tmp['title'];
				$list[$myfile]['code'] = $tmp['code'];
			}
		}
		closedir($handle);
		return $list;
	}

	//取得当前Code信息
	function code_one($id)
	{
		$rs = array('id'=>$id,'dir'=>$this->dir_root.'payment/'.$id);
		$xmlfile = $this->dir_root.'payment/'.$id.'/config.xml';
		if(is_file($xmlfile))
		{
			$tmp = xml_to_array(file_get_contents($xmlfile));
		}
		else
		{
			$tmp = array('title'=>$myfile,'code'=>'');
		}
		$rs['code'] = $tmp['code'];
		$rs['title'] = $tmp['title'];
		return $rs;		
	}

	//存储组信息
	function groupsave($data,$id=0)
	{
		if(!$data || !is_array($data))
		{
			return false;
		}
		if($id)
		{
			return $this->db->update_array($data,'payment_group',array('id'=>$id));
		}
		return $this->db->insert_array($data,'payment_group');
		
	}

	function group_set_default($id,$site_id=0)
	{
		if(!$id)
		{
			return false;
		}
		$condition = $site_id ? 'site_id IN(0,'.$site_id.')' : 'site_id=0';
		$sql = "UPDATE ".$this->db->prefix."payment_group SET is_default=0 WHERE ".$condition;
		$this->db->query($sql);
		$sql = "UPDATE ".$this->db->prefix."payment_group SET is_default=1 WHERE id=".intval($id);
		return $this->db->query($sql);
	}

	//取得单个支付组
	function group_one($id)
	{
		$sql = "SELECT * FROM ".$this->db->prefix."payment_group WHERE id=".intval($id);
		return $this->db->get_one($sql);
	}

	//删除支付组
	function group_delete($id)
	{
		$sql = "DELETE FROM ".$this->db->prefix."payment_group WHERE id=".intval($id);
		return $this->db->query($sql);
	}
	//取得单个支付方式
	function get_one($id)
	{
		$sql = "SELECT * FROM ".$this->db->prefix."payment WHERE id=".intval($id);
		return $this->db->get_one($sql);
	}

	//存储表单信息
	function save($data,$id=0)
	{
		if(!$data || !is_array($data))
		{
			return false;
		}
		if($id)
		{
			return $this->db->update_array($data,'payment',array('id'=>$id));
		}
		else
		{
			return $this->db->insert_array($data,'payment');
		}
	}

	function delete($id)
	{
		$sql = "DELETE FROM ".$this->db->prefix."payment WHERE id='".$id."'";
		return $this->db->query($sql);
	}
}

?>