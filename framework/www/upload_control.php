<?php
/***********************************************************
	Filename: {phpok}/admin/upload_control.php
	Note	: 附件上传操作
***********************************************************/
if(!defined("PHPOK_SET")){exit("<h1>Access Denied</h1>");}
class upload_control extends phpok_control
{
	public function __construct()
	{
		parent::control();
	}

	//附件上传
	public function save_f()
	{
		$this->popedom();
		$cateid = $this->get('cateid','int');
		$rs = $this->upload_base('upfile',$cateid);
		if(!$rs || $rs['status'] != 'ok'){
			$this->json($rs['error']);
		}
		unset($rs['status']);
		$rs['uploadtime'] = date("Y-m-d H:i:s",$rs['addtime']); 
		$this->json($rs,true);
	}

	//设置权限，防止非法人员上传
	private function popedom()
	{
		if(!$this->site['upload_guest'] && !$_SESSION['user_id']){
			$this->json(P_Lang('系统已禁止游客上传，请联系管理员'));
		}
		if(!$this->site['upload_user'] && $_SESSION['user_id']){
			$this->json(P_Lang('系统已禁止会员上传，请联系管理员'));
		}
		return true;
	}


	//基础上传
	function upload_base($input_name='upfile',$cateid=0)
	{
		if($cateid){
			$cate_rs = $this->model('rescate')->get_one($cateid);
		}
		if(!$cate_rs){
			$cate_rs = $this->model('rescate')->get_default();
		}
		if(!$cate_rs){
			return array('status'=>'error','error'=>P_Lang('未指定分类或附件分类不存在'));
		}
		if(!$cate_rs['filetypes']){
			$cate_rs['filetypes'] = 'jpg,png,gif,rar,zip';
		}
		$this->lib('upload')->set_type($cate_rs['filetypes']);
		$rs = $this->lib('upload')->upload($input_name);
		if($rs["status"] != "ok"){
			return $rs;
		}
		$folder = $cate_rs["root"];
		if($cate_rs["folder"] && $cate_rs["folder"] != "/"){
			$folder .= date($cate_rs["folder"],$this->time);
		}
		if(!file_exists($folder)){
			$this->lib('file')->make($folder);
		}
		if(!file_exists($folder)){
			$folder = $cate_rs['root'];
		}
		$basename = basename($rs["filename"]);
		$save_folder = $this->dir_root.$folder;
		if($save_folder.$basename != $rs["filename"]){
			$this->lib('file')->mv($rs["filename"],$save_folder.$basename);
		}
		if(!file_exists($save_folder.$basename)){
			$this->lib('file')->rm($rs["filename"]);
			return array('status'=>'error','error'=>P_Lang('图片迁移失败'));
		}
		$rs['title'] = $this->lib('string')->to_utf8($rs['title']);
		$array = array();
		$array["cate_id"] = $cateid;
		$array["folder"] = $folder;
		$array["name"] = $basename;
		$array["ext"] = $rs["ext"];
		$array["filename"] = $folder.$basename;
		$array["addtime"] = $this->time;
		$array["title"] = $rs['title'];
		$array["title"] = str_replace(".".$rs["ext"],"",$array["title"]);
		if($_SESSION['user_id']){
			$array['user_id'] = $_SESSION['user_id'];
		}
		$array['session_id'] = $this->session->sessid();
		$arraylist = array("jpg","gif","png","jpeg");
		if(in_array($rs["ext"],$arraylist)){
			$img_ext = getimagesize($save_folder.$basename);
			$my_ext = array("width"=>$img_ext[0],"height"=>$img_ext[1]);
			$array["attr"] = serialize($my_ext);
		}
		$id = $this->model('res')->save($array);
		if(!$id){
			$this->lib('file')->rm($save_folder.$basename);
			return array('status'=>'error','error'=>P_Lang('图片存储失败'));
		}
		$this->model('res')->gd_update($id);
		$rs = $this->model('res')->get_one($id);
		$rs["status"] = "ok";
		return $rs;
	}

	//附件上传替换
	public function replace_f()
	{
		$this->popedom();
		$id = $this->get("oldid",'int');
		if(!$id)
		{
			$this->json(P_Lang('没有指定要替换的附件'));
		}
		$old_rs = $this->model('res')->get_one($id);
		if(!$old_rs){
			$this->json(P_Lang('资源不存在'));
		}
		$rs = $this->lib('upload')->upload('upfile');
		if($rs["status"] != "ok")
		{
			$this->json(P_Lang('附件上传失败'));
		}
		$arraylist = array("jpg","gif","png","jpeg");
		$my_ext = array();
		if(in_array($rs["ext"],$arraylist))
		{
			$img_ext = getimagesize($rs["filename"]);
			$my_ext["width"] = $img_ext[0];
			$my_ext["height"] = $img_ext[1];
		}
		//替换资源
		$this->lib('file')->mv($rs["filename"],$old_rs["filename"]);
		$tmp = array("addtime"=>$this->time);
		$tmp["attr"] = serialize($my_ext);
		$this->model('res')->save($tmp,$id);
		//更新附件扩展信息
		$this->model('res')->gd_update($id);
		$rs = $this->model('res')->get_one($id);
		$this->json($rs,true);
	}

	public function thumbshow_f()
	{
		$id = $this->get('id');
		if(!$id){
			$this->json(P_Lang('未指定ID'));
		}
		$list = explode(",",$id);
		$newlist = array();
		foreach($list AS $key=>$value){
			$value = intval($value);
			if($value){
				$newlist[] = $value;
			}
		}
		$id = implode(",",$newlist);
		if(!$id){
			$this->json(P_Lang('请传递正确的附件ID'));
		}
		$rslist = $this->model("res")->get_list_from_id($id);
		if($rslist){
			$reslist = array();
			foreach($newlist as $key=>$value){
				if($rslist[$value]){
					$reslist[] = $rslist[$value];
				}
			}
			$this->json($reslist,true);
		}
		$this->json(P_Lang('附件信息获取失败，可能已经删除'));
	}

	public function editopen_f()
	{
		$id = $this->get('id','int');
		if(!$id){
			error(P_Lang('未指定ID'));
		}
		$rs = $this->model('res')->get_one($id);
		if(!$rs){
			error(P_Lang('数据不存在'));
		}
		$this->popedom_action($rs['session_id'],$rs['user_id']);
		$note = form_edit('note',$rs['note'],'editor','width=650&height=250&etype=simple');
		$this->assign('rs',$rs);
		$this->assign('note',$note);
		$this->view($this->dir_phpok."open/res_editopen.html",'abs-file',false);
	}

	public function editopen_save_f()
	{
		$id = $this->get('id','int');
		if(!$id){
			$this->json(P_Lang('未指定ID'));
		}
		$rs = $this->model('res')->get_one($id);
		if(!$rs){
			$this->json(P_Lang('数据不存在'));
		}
		$this->popedom_action($rs['session_id'],$rs['user_id']);
		$title = $this->get('title');
		if(!$title){
			$this->json(P_Lang('附件标题不能为空'));
		}
		$note = $this->get('note','html');
		$this->model('res')->save(array('title'=>$title,'note'=>$note),$id);
		$this->json(true);
	}

	public function preview_f()
	{
		$id = $this->get('id','int');
		if(!$id){
			error(P_Lang('未指定ID'));
		}
		$rs = $this->model('res')->get_one($id);
		if(!$rs){
			error(P_Lang('数据不存在'));
		}
		if($_SESSION['user_id']){
			if($_SESSION['user_id'] != $rs['user_id'] && $rs['session_id'] != $this->session->sessid()){
				error(P_Lang('您没有权限查看此附件信息'));
			}
		}else{
			if(!$rs['session_id']){
				error(P_Lang('您没有权限查看此附件信息'));
			}
			if($rs['session_id'] != $this->session->sessid()){
				error(P_Lang('您没有权限查看此附件信息'));
			}
		}
		$arraylist = array('jpg','png','gif','jpeg');
		if($rs['ext'] && in_array($rs['ext'],$arraylist)){
			$this->assign('ispic',true);
		}
		$this->assign('rs',$rs);
		$this->view($this->dir_phpok."open/res_openview.html",'abs-file',false);
	}

	public function delete_f()
	{
		$id = $this->get('id','int');
		if(!$id){
			$this->json(P_Lang('未指定ID'));
		}
		$rs = $this->model('res')->get_one($id);
		if(!$rs){
			$this->json(P_Lang('附件信息不存在'));
		}
		$this->popedom_action($rs['session_id'],$rs['user_id']);
		$this->model('res')->delete($id);
		$this->json(true);
	}

	private function popedom_action($sessid='',$uid=0)
	{
		if($_SESSION['user_id']){
			if($uid && $uid == $_SESSION['user_id']){
				return true;
			}
			if($sessid && $sessid == $this->session->sessid()){
				return true;
			}
		}else{
			if($sessid && $sessid == $this->session->sessid()){
				return true;
			}
		}
		$info = P_Lang('没有权限操作');
		$this->json($info);
	}
}
?>