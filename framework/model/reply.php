<?php
/***********************************************************
	Filename: {phpok}/model/reply.php
	Note	: 评论信息维护
***********************************************************/
if(!defined("PHPOK_SET")){exit("<h1>Access Denied</h1>");}
class reply_model_base extends phpok_model
{
	function __construct()
	{
		parent::model();
	}

	public function __destruct()
	{
		parent::__destruct();
		unset($this);
	}

	function get_all($condition="",$offset=0,$psize=30)
	{
		$sql = "SELECT l.* FROM ".$this->db->prefix."list l ";
		if($condition)
		{
			$sql.= " WHERE ".$condition;
		}
		$sql .= " ORDER BY l.replydate DESC,l.id DESC ";
		if($psize && $psize>0)
		{
			$offset = intval($offset);
			$sql.= " LIMIT ".$offset.",".$psize;
		}
		$rslist = $this->db->get_all($sql,"id");
		if(!$rslist) return false;
		$idlist = array_keys($rslist);
		$reply_list = $this->total_status(implode(",",$idlist));
		if($reply_list)
		{
			foreach($reply_list AS $key=>$value)
			{
				$rslist[$key]["checked"] = $value["checked"];
				$rslist[$key]["uncheck"] = $value["uncheck"];
			}
		}
		return $rslist;
	}

	function get_all_total($condition="")
	{
		$sql = "SELECT count(l.id) FROM ".$this->db->prefix."list l ";
		if($condition)
		{
			$sql.= " WHERE ".$condition;
		}
		return $this->db->count($sql);
	}

	//统计回复中的已审核主题信息，未审核信息
	function total_status($id)
	{
		$list = array();
		$sql = "SELECT tid,count(id) total FROM ".$this->db->prefix."reply WHERE status=1 AND tid IN(".$id.") GROUP BY tid";
		$rslist = $this->db->get_all($sql);
		if($rslist)
		{
			foreach($rslist AS $key=>$value)
			{
				$list[$value["tid"]]["checked"] = $value["total"];
				$list[$value["tid"]]["uncheck"] = 0;
			}
		}
		$sql = "SELECT tid,count(id) total FROM ".$this->db->prefix."reply WHERE status=0 AND tid IN(".$id.") GROUP BY tid";
		$tmplist = $this->db->get_all($sql);
		if($tmplist)
		{
			foreach($tmplist AS $key=>$value)
			{
				if(!$list[$value["tid"]])
				{
					$list[$value["tid"]]["checked"] = 0;
				}
				$list[$value["tid"]]["uncheck"] = $value["total"];
			}
		}
		return $list;
	}

	function get_list($condition="",$offset=0,$psize=30,$pri="",$orderby="")
	{
		if(!$orderby) $orderby = 'addtime DESC,id DESC';
		$sql = "SELECT * FROM ".$this->db->prefix."reply WHERE ".$condition." ORDER BY ".$orderby;
		if($psize)
		{
			$offset = intval($offset);
			$sql .= " LIMIT ".$offset.",".$psize;
		}
		//phpok_log($sql);
		return $this->db->get_all($sql,$pri);
	}

	function get_total($condition="")
	{
		$sql = "SELECT count(id) FROM ".$this->db->prefix."reply WHERE ".$condition;
		return $this->db->count($sql);
	}

	function save($data,$id=0)
	{
		if(!$data || !is_array($data) || count($data) < 1) return false;
		if($id)
		{
			return $this->db->update_array($data,"reply",array("id"=>$id));
		}
		else
		{
			return $this->db->insert_array($data,"reply");
		}
	}

	function delete($id)
	{
		if(!$id) return false;
		$rs = $this->get_one($id);
		if($rs)
		{
			$sql = "DELETE FROM ".$this->db->prefix."reply WHERE id='".$id."' OR parent_id='".$id."'";
			$this->db->query($sql);
			$sql = "SELECT id FROM ".$this->db->prefix."reply WHERE tid='".$rs['tid']."'";
			$tmp = $this->db->get_one($sql);
			if(!$tmp)
			{
				$sql = "UPDATE ".$this->db->prefix."list SET replydate=0 WHERE id='".$rs['tid']."'";
				$this->db->query($sql);
			}
		}
		return true;
	}

	//取得一条评论信息
	function get_one($id)
	{
		$sql = "SELECT * FROM ".$this->db->prefix."reply WHERE id='".$id."'";
		return $this->db->get_one($sql);
	}
	
}
?>