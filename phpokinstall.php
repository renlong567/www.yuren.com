<?php
/*****************************************************************************************
	文件： phpokinstall.php
	备注： 文件安装包
*****************************************************************************************/
error_reporting(E_ALL ^ E_NOTICE);
define('PHPOK_SET',true);
define("ROOT",str_replace("\\","/",dirname(__FILE__))."/");
//定义JQuery的文件地址
define('JQUERY','http://libs.phpok.cn/jquery/1.7.1/jquery.js');
//PHPOK下载地址
define('PHPOKFILE','http://www.phpok.com/index.php?c=download&id=6985');
function error($tips="",$url="",$time=2)
{
	echo '<!DOCTYPE html>'."\n";
	echo '<html>'."\n";
	echo '<head>'."\n";
	echo '<meta charset="utf-8" />'."\n";
	echo '<meta http-equiv="expires" content="wed, 26 feb 1997 08:21:57 gmt">'."\n";
	echo '<title>友情提示</title>'."\n";
	echo '<style type="text/css">body{font-size:12px;font-family:"Microsoft Yahei","宋体","Tahoma","Arial"}.body{margin:100px auto auto auto;width:550px;border:1px solid #8F8F8F;}.red{color:red;}.body .tips{height:70px;}.body .tips .title{margin-left:70px;font-weight:bold;height:20px;padding-top:15px;}.body .tips .note{margin-left:70px;height:30px;}.body .tips .txt{margin-left:70px;padding-top:10px;line-height:50px;font-weight:bold;}</style>'."\n";
	echo '</head>'."\n";
	echo '<body>'."\n";
	echo '<div class="body"><div class="tips">';
	if($url){
		echo '<div class="title">'.$tips.'</div>';
		echo '<div class="note"><a href="'.$url.'">系统将在 <span class="red">'.$time.'秒</span> 后跳转，手动跳转请点这里</div>';
	}else{
		echo '<div class="txt">'.$tips.'</div>';
	}
	echo '</div></div>';
	if($url){
		echo '<script type="text/javascript>"'."\n";
		echo 'function refresh()'."\n";
		echo '{'."\n\t";
		echo 'window.location.href = "'.$url.'";'."\n";
		echo '}'."\n";
		echo 'window.setTimeout("refresh()",'.($time*1000).');'."\n";
		echo '</script>'."\n";
	}
	echo '</body>'."\n</html>";
	exit;
}

function root_url()
{
	$http_type = ((isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') || (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')) ? 'https://' : 'http://';
	$port = $_SERVER["SERVER_PORT"];
	//$myurl = $http_type.$_SERVER["SERVER_NAME"];
	$myurl = $_SERVER["SERVER_NAME"];
	if($port != "80" && $port != "443")
	{
		$myurl .= ":".$port;
	}
	$site = array("domain"=>$myurl);
	$docu = $_SERVER["PHP_SELF"];
	$array = explode("/",$docu);
	$count = count($array);
	$dir = "";
	if($count>1)
	{
		foreach($array AS $key=>$value)
		{
			$value = trim($value);
			if($value)
			{
				if(($key+1) < $count)
				{
					$dir .= "/".$value;
				}
			}
		}
	}
	$dir .= "/";
	$dir = str_replace(array("//","install/"),array("/",""),$dir);
	$site["dir"] = $dir;
	return $site;
}

function format_sql($sql)
{
	global $db;
	$sql = str_replace("\r","\n",$sql);
	$ret = array();
	$num = 0;
	foreach(explode(";\n", trim($sql)) as $query) {
		$queries = explode("\n", trim($query));
		foreach($queries as $query) {
			$ret[$num] .= $query[0] == '#' || $query[0].$query[1] == '--' ? '' : $query;
		}
		$num++;
	}
	unset($sql);

	foreach($ret as $query) {
		$query = trim($query);
		if($query) {
			$db->query($query);
		}
	}
}



class db_mysql
{
	public $error_id = 0;
	public $error = '';
	public $prefix = 'qinggan_';
	public $conn;
	public $debug = false;
	public $config_db = array('host'=>'localhost','user'=>'root','pass'=>'','data'=>'','port'=>3306);
	private $type = MYSQL_ASSOC;
	private $query; //执行对象
	private $time_use = 0;
	private $time_tmp = 0;
	private $count = 0;

	public function __construct($config=array())
	{
		$this->debug = $config["debug"] ? $config["debug"] : false;
		$this->prefix = $config['prefix'] ? $config['prefix'] : 'qinggan_';
		$this->_config_db($config);
	}

	//连接数据库
	public function connect_db($data='')
	{
		if(!$data){
			$data = $this->config_db['data'];
		}
		$linkhost = $this->config_db['host'].":".($this->config_db['port'] ? $this->config_db['port'] : '3306');
		if($this->config_db['socket']){
			$linkhost .= ":".$this->config_db['socket'];
		}
		$this->conn = @mysql_connect($linkhost,$this->config_db['user'],$this->config_db['pass'],true,MYSQL_CLIENT_COMPRESS);
		if(!$this->conn || !is_resource($this->conn)){
			return $this->debug(mysql_error(),mysql_errno());
		}
		$this->debug();
		mysql_query("SET NAMES 'utf8'",$this->conn);
		mysql_query("SET sql_mode=''",$this->conn);
		$this->select_db($data);
		return true;
	}

	//更换数据库选择
	public function select_db($data="")
	{
		$this->check_connect();
		@mysql_select_db($data,$this->conn);
		if(mysql_error() || mysql_errno()){
			return $this->debug(mysql_error(),mysql_errno());
		}
		$this->debug();
		return true;
	}

	private function check_connect()
	{
		if(!$this->conn || !is_resource($this->conn)){
			$this->connect_db();
		}else{
			if(!mysql_ping($this->conn)){
				mysql_close($this->conn);
				$this->connect_db();
			}
		}
	}

	//关闭数据库连接
	public function __destruct()
	{
		@mysql_close($this->conn);
		unset($this);
	}

	//定义基本的变量信息
	public function set($name,$value)
	{
		if($name == "rs_type" || $name == 'type'){
			$value = strtolower($value) == "num" ? MYSQL_NUM : MYSQL_ASSOC;
			$this->type = $value;
		}else{
			$this->$name = $value;
		}
	}

	public function query($sql)
	{
		if(!$sql || !trim($sql)){
			return false;
		}
		$sql = trim($sql);
		$this->check_connect();
		$this->query = mysql_query($sql,$this->conn);
		if(!$this->query){
			return false;
		}
		return $this->query;
	}

	public function get_all($sql,$primary="")
	{
		if(!$sql || !trim($sql)){
			return false;
		}
		$sql = trim($sql);
		$this->query($sql);
		$rs = false;
		while($rows = mysql_fetch_array($this->query,$this->type)){
			$rs[$rows[$primary]] = $rows;
		}
		mysql_free_result($this->query);
		return $rs;
	}

	//取得单独数据
	public function get_one($sql="")
	{
		if(!$sql || !trim($sql)){
			return false;
		}
		$sql = trim($sql);
		$this->query($sql);
		$rs = mysql_fetch_array($this->query,$this->type);
		mysql_free_result($this->query);
		return $rs;
	}

	public function insert_id()
	{
		return mysql_insert_id($this->conn);
	}

	public function insert($sql)
	{
		$this->query($sql);
		return $this->insert_id();
	}

	public function count($sql="")
	{
		if($sql){
			$this->set('type','num');
			$rs = $this->get_one($sql);
			$this->set('type','assoc');
			return $rs[0];
		}else{
			return mysql_num_rows($this->query);
		}
	}

	public function escape_string($char)
	{
		if(!$char){
			return false;
		}
		return mysql_real_escape_string($char,$this->conn);
	}

	private function _config_db($config)
	{
		$this->config_db['host'] = $config['host'] ? $config['host'] : 'localhost';
		$this->config_db['port'] = $config['port'] ? $config['port'] : '3306';
		$this->config_db['user'] = $config['user'] ? $config['user'] : 'root';
		$this->config_db['pass'] = $config['pass'] ? $config['pass'] : '';
		$this->config_db['data'] = $config['data'] ? $config['data'] : '';
		$this->config_db['socket'] = isset($config['socket']) ? $config['socket'] : '';
		if($this->config_db['data']){
			$this->connect_db($this->config_db['data']);
		}
	}

	public function debug($info='',$id=0)
	{
		$this->error_id = $id;
		$this->error = $info;
	}

	public function insert_array($data,$table,$insert_type="insert")
	{
		$table = $this->prefix.$table;
		if($insert_type == "insert"){
			$sql = "INSERT INTO ".$table;
		}else{
			$sql = "REPLACE INTO ".$table;
		}
		$sql_fields = array();
		$sql_val = array();
		foreach($data AS $key=>$value){
			$sql_fields[] = "`".$key."`";
			$sql_val[] = "'".$value."'";
		}
		$sql.= "(".(implode(",",$sql_fields)).") VALUES(".(implode(",",$sql_val)).")";
		return $this->insert($sql);
	}

}

class db_mysqli
{
	public $prefix = 'qinggan_';
	public $conn;
	public $debug = false;
	public $config_db = array('host'=>'localhost','user'=>'root','pass'=>'','data'=>'','port'=>3306);
	private $type = MYSQLI_ASSOC;
	private $query;
	private $time_use = 0;
	private $time_tmp = 0;
	private $count = 0;

	public $error_id = 0;
	public $error = '';

	public function __construct($config=array())
	{
		$this->debug = $config["debug"] ? $config["debug"] : false;
		$this->prefix = $config['prefix'] ? $config['prefix'] : 'qinggan_';
		$this->_config_db($config);
	}

	//连接数据库
	public function connect_db($data='')
	{
		if(!$data){
			$data = $this->config_db['data'];
		}
		$this->conn = @new mysqli($this->config_db['host'],$this->config_db['user'],$this->config_db['pass'],'',$this->config_db['port'],$this->config_db['socket']);
		if(!$this->conn){
			return $this->error('数据库连接失败');
		}
		if($this->conn->connect_error){
			return $this->debug($this->conn->connect_error,$this->conn->connect_errno);
		}
		if($this->conn->error){
			return $this->debug($this->conn->error,$this->conn->errno);
		}
		if(!$this->conn || !is_object($this->conn)){
			return $this->debug('数据库连接请求失败');
		}
		$this->debug();
		$this->conn->query("SET NAMES 'utf8'");
		$this->conn->query("SET sql_mode=''");
		$this->select_db($data);
		return true;
	}

	//更换数据库选择
	public function select_db($data="")
	{
		$this->check_connect();
		$this->conn->select_db($data);
		if($this->conn->error){
			return $this->debug($this->conn->error,$this->conn->errno);
		}
		$this->debug();
		return true;
	}

	private function check_connect()
	{
		if(!$this->conn || !is_object($this->conn)){
			$this->connect_db();
		}else{
			if(!$this->conn->ping()){
				$this->conn->close();
				$this->connect_db();
			}
		}
	}

	//关闭数据库连接
	public function __destruct()
	{
		@$this->conn->close();
		unset($this);
	}

	//定义基本的变量信息
	public function set($name,$value)
	{
		if($name == "rs_type" || $name == 'type'){
			$value = strtolower($value) == "num" ? MYSQLI_NUM : MYSQLI_ASSOC;
			$this->type = $value;
		}else{
			$this->$name = $value;
		}
	}

	public function query($sql)
	{
		if(!$sql || !trim($sql)){
			return false;
		}
		$sql = trim($sql);
		$this->check_connect();
		$this->query = $this->conn->query($sql);
		return $this->query;
	}

	public function get_all($sql,$primary="")
	{
		if(!$sql || !trim($sql)){
			return false;
		}
		$sql = trim($sql);
		$this->query($sql);
		if(!$this->query || !is_object($this->query)){
			return false;
		}
		$rs = false;
		while($rows = $this->query->fetch_array($this->type)){
			$rs[$rows[$primary]] = $rows;
		}
		return $rs;
	}

	public function get_one($sql="")
	{
		if(!$sql || !trim($sql)){
			return false;
		}
		$sql = trim($sql);
		$this->query($sql);
		if(!$this->query || !is_object($this->query)){
			return false;
		}
		$this->_time();
		$rs = $this->query->fetch_array($this->type);
		$this->query->free_result();
		return $rs;
	}

	//返回最后插入的ID
	public function insert_id()
	{
		return $this->conn->insert_id;
	}

	//执行写入SQL
	public function insert($sql)
	{
		$this->query($sql);
		return $this->insert_id();
	}

	public function count($sql="")
	{
		if($sql){
			$this->set('type','num');
			$rs = $this->get_one($sql);
			$this->set('type','assoc');
			return $rs[0];
		}else{
			return $this->query->num_rows;
		}
	}

	public function escape_string($char)
	{
		if(!$char){
			return false;
		}
		return $this->conn->escape_string($char);
	}

	//初始化数据库
	private function _config_db($config)
	{
		$this->config_db['host'] = $config['host'] ? $config['host'] : 'localhost';
		$this->config_db['port'] = $config['port'] ? $config['port'] : '3306';
		$this->config_db['user'] = $config['user'] ? $config['user'] : 'root';
		$this->config_db['pass'] = $config['pass'] ? $config['pass'] : '';
		$this->config_db['data'] = $config['data'] ? $config['data'] : '';
		$this->config_db['socket'] = isset($config['socket']) ? $config['socket'] : '';
		if($this->config_db['data']){
			$this->connect_db($this->config_db['data']);
		}
	}

	public function debug($info='',$id='')
	{
		$this->error_id = $id;
		$this->error = $info;
	}

	public function insert_array($data,$table,$insert_type="insert")
	{
		$table = $this->prefix.$table;
		if($insert_type == "insert"){
			$sql = "INSERT INTO ".$table;
		}else{
			$sql = "REPLACE INTO ".$table;
		}
		$sql_fields = array();
		$sql_val = array();
		foreach($data AS $key=>$value){
			$sql_fields[] = "`".$key."`";
			$sql_val[] = "'".$value."'";
		}
		$sql.= "(".(implode(",",$sql_fields)).") VALUES(".(implode(",",$sql_val)).")";
		return $this->insert($sql);
	}
}


class phpzip_lib
{
	private $total_files = 0;
	private $total_folders = 0;
	public $file_count = 0 ;
	public $datastr_len   = 0;
	public $dirstr_len = 0;
	public $gzfilename;
	public $fp;
	public $dirstr='';

	public function __construct()
	{
		$this->total_files = 0;
		$this->total_folders = 0;
	}

	public function unzip($file,$to='',$index= array(-1))
	{
		return $this->Extract($file,$to,$index);
	}

	public function Extract( $zn, $to, $index = array(-1) )
	{
		$ok = 0;
		$zip = @fopen($zn,'rb');
		if(!$zip) return(-1);
		$cdir = $this->ReadCentralDir($zip,$zn);
		$pos_entry = $cdir['offset'];

		if(!is_array($index))
		{
			$index = array($index);
		}
		for($i=0; $index[$i];$i++)
		{
			if(intval($index[$i])!=$index[$i]||$index[$i]>$cdir['entries'])
			{
				return(-1);
			}
		}
		for ($i=0; $i<$cdir['entries']; $i++)
		{
			@fseek($zip, $pos_entry);
			$header = $this->ReadCentralFileHeaders($zip);
			$header['index'] = $i; $pos_entry = ftell($zip);
			@rewind($zip);
			fseek($zip, $header['offset']);
			if(in_array("-1",$index)||in_array($i,$index))
			{
				$stat[$header['filename']]=$this->ExtractFile($header, $to, $zip);
			}
		}
		fclose($zip);
		return $stat;
	}

	function ReadFileHeader($zip)
	{
		$binary_data = fread($zip, 30);
		$data = unpack('vchk/vid/vversion/vflag/vcompression/vmtime/vmdate/Vcrc/Vcompressed_size/Vsize/vfilename_len/vextra_len',$binary_data);

		$header['filename'] = fread($zip, $data['filename_len']);
		if ($data['extra_len'] != 0)
		{
			$header['extra'] = fread($zip, $data['extra_len']);
		}
		else
		{
			$header['extra'] = '';
		}
		$header['compression'] = $data['compression'];
		$header['size'] = $data['size'];
		$header['compressed_size'] = $data['compressed_size'];
		$header['crc'] = $data['crc'];
		$header['flag'] = $data['flag'];
		$header['mdate'] = $data['mdate'];
		$header['mtime'] = $data['mtime'];

		if ($header['mdate'] && $header['mtime'])
		{
			$hour=($header['mtime']&0xF800)>>11;$minute=($header['mtime']&0x07E0)>>5;
			$seconde=($header['mtime']&0x001F)*2;$year=(($header['mdate']&0xFE00)>>9)+1980;
			$month=($header['mdate']&0x01E0)>>5;$day=$header['mdate']&0x001F;
			$header['mtime'] = mktime($hour, $minute, $seconde, $month, $day, $year);
		}
		else
		{
			$header['mtime'] = time();
		}
		$header['stored_filename'] = $header['filename'];
		$header['status'] = "ok";
		return $header;
	}

	function ReadCentralFileHeaders($zip)
	{
    	$binary_data = fread($zip, 46);
    	$header = unpack('vchkid/vid/vversion/vversion_extracted/vflag/vcompression/vmtime/vmdate/Vcrc/Vcompressed_size/Vsize/vfilename_len/vextra_len/vcomment_len/vdisk/vinternal/Vexternal/Voffset', $binary_data);

    	if ($header['filename_len'] != 0)
    	{
	    	$header['filename'] = fread($zip,$header['filename_len']);
    	}
    	else
    	{
	    	$header['filename'] = '';
    	}
    	if ($header['extra_len'] != 0)
    	{
	    	$header['extra'] = fread($zip, $header['extra_len']);
    	}
    	else
    	{
	    	$header['extra'] = '';
    	}
    	if ($header['comment_len'] != 0)
    	{
	    	$header['comment'] = fread($zip, $header['comment_len']);
    	}
    	else
    	{
	    	$header['comment'] = '';
    	}

		if ($header['mdate'] && $header['mtime'])
		{
			$hour = ($header['mtime'] & 0xF800) >> 11;
			$minute = ($header['mtime'] & 0x07E0) >> 5;
			$seconde = ($header['mtime'] & 0x001F)*2;
			$year = (($header['mdate'] & 0xFE00) >> 9) + 1980;
			$month = ($header['mdate'] & 0x01E0) >> 5;
			$day = $header['mdate'] & 0x001F;
			$header['mtime'] = mktime($hour, $minute, $seconde, $month, $day, $year);
		}
		else
		{
			$header['mtime'] = time();
		}
		$header['stored_filename'] = $header['filename'];
		$header['status'] = 'ok';
		if (substr($header['filename'], -1) == '/')
		{
			$header['external'] = 0x41FF0010;
		}
		return $header;
	}

	function ReadCentralDir($zip,$zip_name)
	{
		$size = filesize($zip_name);
		if ($size < 277)
		{
			$maximum_size = $size;
		}
		else
		{
			$maximum_size=277;
		}
		@fseek($zip, $size-$maximum_size);
		$pos = ftell($zip); $bytes = 0x00000000;
		while ($pos < $size)
		{
			$byte = @fread($zip, 1);
			$bytes=($bytes << 8) | ord($byte);
			if ($bytes == 0x504b0506 or $bytes == 0x2e706870504b0506)
			{
				$pos++;
				break;
			}
			$pos++;
		}
		$fdata=fread($zip,18);
		$data=@unpack('vdisk/vdisk_start/vdisk_entries/ventries/Vsize/Voffset/vcomment_size',$fdata);
		if ($data['comment_size'] != 0)
		{
			$centd['comment'] = fread($zip, $data['comment_size']);
		}
		else
		{
			$centd['comment'] = '';
		}
		$centd['entries'] = $data['entries'];
		$centd['disk_entries'] = $data['disk_entries'];
		$centd['offset'] = $data['offset'];$centd['disk_start'] = $data['disk_start'];
		$centd['size'] = $data['size'];  $centd['disk'] = $data['disk'];
		return $centd;
	}

	function ExtractFile($header,$to,$zip)
	{
		$header = $this->readfileheader($zip);
		if(substr($to,-1)!="/")
		{
			$to.="/";
		}
		if($to=='./')
		{
			$to = '';
		}
		$pth = explode("/",$to.$header['filename']);
		$mydir = '';
		for($i=0;$i<count($pth)-1;$i++)
		{
			if(!$pth[$i])
			{
				continue;
			}
			$mydir .= $pth[$i]."/";
			if((!is_dir($mydir) && @mkdir($mydir,0777)) || (($mydir==$to.$header['filename'] || ($mydir==$to && $this->total_folders==0)) && is_dir($mydir)) )
			{
				@chmod($mydir,0777);
				$this->total_folders ++;
				//echo "<input name='dfile[]' type='checkbox' value='$mydir' checked> <a href='$mydir' target='_blank'>目录: $mydir</a><br>";
			}
		}
	
		if(strrchr($header['filename'],'/')=='/')
		{
			return;
		}

		if (!($header['external']==0x41FF0010)&&!($header['external']==16))
		{
			if ($header['compression']==0)
			{
				$fp = @fopen($to.$header['filename'], 'wb');
				if(!$fp)
				{
					return(-1);
				}
				$size = $header['compressed_size'];
			
				while ($size != 0)
				{
					$read_size = ($size < 2048 ? $size : 2048);
					$buffer = fread($zip, $read_size);
					$binary_data = pack('a'.$read_size, $buffer);
					@fwrite($fp, $binary_data, $read_size);
					$size -= $read_size;
				}
				fclose($fp);
				touch($to.$header['filename'], $header['mtime']);
			}
			else
			{
				$fp = @fopen($to.$header['filename'].'.gz','wb');
				if(!$fp)
				{
					return(-1);
				}
				$binary_data = pack('va1a1Va1a1', 0x8b1f, chr($header['compression']),chr(0x00), time(), chr(0x00), chr(3));
				
				fwrite($fp, $binary_data, 10);
				$size = $header['compressed_size'];
				while ($size != 0)
				{
					$read_size = ($size < 1024 ? $size : 1024);
					$buffer = fread($zip, $read_size);
					$binary_data = pack('a'.$read_size, $buffer);
					@fwrite($fp, $binary_data, $read_size);
					$size -= $read_size;
				}
			
				$binary_data = pack('VV', $header['crc'], $header['size']);
				fwrite($fp, $binary_data,8); fclose($fp);
		
				$gzp = @gzopen($to.$header['filename'].'.gz','rb') or die("Cette archive gzcompress error");
				if(!$gzp)
				{
					return(-2);
				}
				$fp = @fopen($to.$header['filename'],'wb');
				if(!$fp)
				{
					return(-1);
				}
				$size = $header['size'];
				while ($size != 0)
				{
					$read_size = ($size < 2048 ? $size : 2048);
					$buffer = gzread($gzp, $read_size);
					$binary_data = pack('a'.$read_size, $buffer);
					@fwrite($fp, $binary_data, $read_size);
					$size -= $read_size;
				}
				fclose($fp); gzclose($gzp);
				touch($to.$header['filename'], $header['mtime']);
				@unlink($to.$header['filename'].'.gz');
			}
		}
		$this->total_files ++;
		//echo "<input name='dfile[]' type='checkbox' value='$to$header[filename]' checked> <a href='$to$header[filename]' target='_blank'>文件: $to$header[filename]</a><br>";
		return true;
 	}

 	//返回文件的修改时间格式
 	//只为本类内部函数调用.
	function unix2DosTime($unixtime = 0)
	{
		$timearray = ($unixtime == 0) ? getdate() : getdate($unixtime);
		if ($timearray['year'] < 1980) 
		{
			$timearray['year']    = 1980;
			$timearray['mon']     = 1;
			$timearray['mday']    = 1;
			$timearray['hours']   = 0;
			$timearray['minutes'] = 0;
			$timearray['seconds'] = 0;
		}

		return (($timearray['year'] - 1980) << 25) | ($timearray['mon'] << 21) | ($timearray['mday'] << 16) | ($timearray['hours'] << 11) | ($timearray['minutes'] << 5) | ($timearray['seconds'] >> 1);
	}

	/*
	初始化文件,建立文件目录,
	并返回文件的写入权限.
	*/
	function startfile($path = 'tmp.zip')
	{
		$this->gzfilename=$path;
		$mypathdir=array();
		do
		{
			$mypathdir[] = $path = dirname($path);
		}while($path != '.');
		@end($mypathdir);
		do
		{
			$path = @current($mypathdir);
			@mkdir($path);
		}while(@prev($mypathdir));

		if($this->fp=@fopen($this->gzfilename,"wb"))
		{
			return true;
		}
		return false;
	}

	/*
	添加一个文件到 zip 压缩包中.
	*/
    function addfile($data, $name)
    {
        $name     = str_replace('\\', '/', $name);
		
		if(strrchr($name,'/')=='/')
		{
			return $this->adddir($name);
		}
		
        $dtime    = dechex($this->unix2DosTime());
        $hexdtime = '\x' . $dtime[6] . $dtime[7]
                  . '\x' . $dtime[4] . $dtime[5]
                  . '\x' . $dtime[2] . $dtime[3]
                  . '\x' . $dtime[0] . $dtime[1];
        eval('$hexdtime = "' . $hexdtime . '";');

        $unc_len = strlen($data);
        $crc     = crc32($data);
        $zdata   = gzcompress($data);
        $c_len   = strlen($zdata);
        $zdata   = substr(substr($zdata, 0, strlen($zdata) - 4), 2);
		
		//新添文件内容格式化:
        $datastr  = "\x50\x4b\x03\x04";
        $datastr .= "\x14\x00";            // ver needed to extract
        $datastr .= "\x00\x00";            // gen purpose bit flag
        $datastr .= "\x08\x00";            // compression method
        $datastr .= $hexdtime;             // last mod time and date
        $datastr .= pack('V', $crc);             // crc32
        $datastr .= pack('V', $c_len);           // compressed filesize
        $datastr .= pack('V', $unc_len);         // uncompressed filesize
        $datastr .= pack('v', strlen($name));    // length of filename
        $datastr .= pack('v', 0);                // extra field length
        $datastr .= $name;
        $datastr .= $zdata;
        $datastr .= pack('V', $crc);                 // crc32
        $datastr .= pack('V', $c_len);               // compressed filesize
        $datastr .= pack('V', $unc_len);             // uncompressed filesize


		fwrite($this->fp,$datastr);	//写入新的文件内容
		$my_datastr_len = strlen($datastr);
		unset($datastr);
		
		//新添文件目录信息
        $dirstr  = "\x50\x4b\x01\x02";
        $dirstr .= "\x00\x00";                	// version made by
        $dirstr .= "\x14\x00";                	// version needed to extract
        $dirstr .= "\x00\x00";                	// gen purpose bit flag
        $dirstr .= "\x08\x00";                	// compression method
        $dirstr .= $hexdtime;                 	// last mod time & date
        $dirstr .= pack('V', $crc);           	// crc32
        $dirstr .= pack('V', $c_len);         	// compressed filesize
        $dirstr .= pack('V', $unc_len);       	// uncompressed filesize
        $dirstr .= pack('v', strlen($name) ); 	// length of filename
        $dirstr .= pack('v', 0 );             	// extra field length
        $dirstr .= pack('v', 0 );             	// file comment length
        $dirstr .= pack('v', 0 );             	// disk number start
        $dirstr .= pack('v', 0 );             	// internal file attributes
        $dirstr .= pack('V', 32 );            	// external file attributes - 'archive' bit set
        $dirstr .= pack('V',$this->datastr_len ); // relative offset of local header
        $dirstr .= $name;
		
		$this->dirstr .= $dirstr;	//目录信息
		
		$this -> file_count ++;
		$this -> dirstr_len += strlen($dirstr);
		$this -> datastr_len += $my_datastr_len;	
    }

	//添加一个目录
	function adddir($name)
	{ 
		$name = str_replace("\\", "/", $name); 
		$datastr = "\x50\x4b\x03\x04\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00"; 
		
		$datastr .= pack("V",0).pack("V",0).pack("V",0).pack("v", strlen($name) ); 
		$datastr .= pack("v", 0 ).$name.pack("V", 0).pack("V", 0).pack("V", 0); 

		fwrite($this->fp,$datastr);	//写入新的文件内容
		$my_datastr_len = strlen($datastr);
		unset($datastr);
		
		$dirstr = "\x50\x4b\x01\x02\x00\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00"; 
		$dirstr .= pack("V",0).pack("V",0).pack("V",0).pack("v", strlen($name) ); 
		$dirstr .= pack("v", 0 ).pack("v", 0 ).pack("v", 0 ).pack("v", 0 ); 
		$dirstr .= pack("V", 16 ).pack("V",$this->datastr_len).$name; 
		
		$this->dirstr .= $dirstr;	//目录信息

		$this -> file_count ++;
		$this -> dirstr_len += strlen($dirstr);
		$this -> datastr_len += $my_datastr_len;	
	}


	function createfile()
	{
		//压缩包结束信息,包括文件总数,目录信息读取指针位置等信息
		$endstr = "\x50\x4b\x05\x06\x00\x00\x00\x00" .
					pack('v', $this -> file_count) .
					pack('v', $this -> file_count) .
					pack('V', $this -> dirstr_len) .
					pack('V', $this -> datastr_len) .
					"\x00\x00";

		fwrite($this->fp,$this->dirstr.$endstr);
		fclose($this->fp);
	}
}

class install
{
	public function head($num=1)
	{
		echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'."\n";
		echo '<html xmlns="http://www.w3.org/1999/xhtml">'."\n";
		echo '<head>'."\n";
		echo '<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />'."\n";
		echo '<title>PHPOK企业站系统安装</title>'."\n";
		$this->cssinfo();
		$this->jsinfo();
		echo '</head>'."\n";
		echo '<body>'."\n";
		echo '<div class="header">';
		echo '<div class="logo"><img src="'.$this->logo().'" width="266" height="63" /></div>';
		echo '<div class="step"><div class="line"></div><ul class="step_num">';
		$current = array('1'=>'','2'=>'','3'=>'','4'=>'','5'=>'','6'=>'');
		if($num){
			$current[$num] = 'current';
		}
		echo '<li class="'.$current[1].'"><span class="num">1</span><p class="name">检测安装环境</p></li>';
		echo '<li class="'.$current[2].'"><span class="num">2</span><p class="name">获取安装包</p></li>';
		echo '<li class="'.$current[3].'"><span class="num">3</span><p class="name">可写检测</p></li>';
		echo '<li class="'.$current[4].'"><span class="num">4</span><p class="name">阅读安装协议</p></li>';
		echo '<li class="'.$current[5].'"><span class="num">5</span><p class="name">开始安装</p></li>';
		echo '<li class="'.$current[6].'"><span class="num">6</span><p class="name">完成安装</p></li>';
		echo '</ul></div></div>';
	}

	public function foot()
	{
		echo '<div class="footer">Powered By phpok.com 版权所有 &copy; 2005-2015, All right reserved.</div>'."\n";
		echo '</body>'."\n";
		echo '</html>';
		exit;
	}

	public function env_check()
	{
		echo '<div class="tips_box"><div class="tips_title">提示消息</div>';
		echo '<div class="tips_txt">';
		echo '<p>本系统采用PHP+MySQL编写，这里对系统环境进行简单测试，请保证下列文件或目录可读写(Unix和Linux服务器请设置以下文件夹的属性为777，文件属性为666）：星号 <span style="color:red">*</span> 表示任意值</p></div></div>';
		$status = true;
		if(!function_exists('mysql_connect') && !function_exists('mysqli_connect')){
			$mysql_status = '<span class="red">不支持</span>';
			$status = false;
		}else{
			$mysql_status = '<span class="darkblue">支持</span>';
		}
		echo '<table width="980" border="0" cellspacing="0" cellpadding="0" class="tablebox">';
		echo '<tr class="head_bg"><td>&nbsp;</td><td>PHPOK最低要求</td><td>PHPOK最佳配置</td><td>当前环境检测</td></tr>';
		echo '<tr><td class="lft">PHP版本</td><td>5.0.x</td><td>5.3.x</td><td>'.PHP_VERSION.'</td></tr>';
		echo '<tr><td class="lft">附件上传</td><td>2M+</td><td>10M+</td><td>'.get_cfg_var('upload_max_filesize').'</td></tr>';
		echo '<tr><td class="lft">MYSQL支持</td><td>5.0.x</td><td>5.5.x</td><td>'.$mysql_status.'</td></tr>';
		$space = disk_free_space(ROOT) > (80 * 1024 * 1024) ? '<span class="darkblue">80M+</span>' : '通过';
		echo '<tr><td class="lft">磁盘空间</td><td>20M+</td><td>80M+</td><td>'.$space.'</td></tr>';
		$curl = $this->func_check('curl_close');
		if(!$curl['status']){
			$status = false;
		}
		echo '<tr><td class="lft">PHP组件：Curl库</td><td>支持</td><td>支持</td><td>'.$curl['info'].'</td></tr>';
		$session = $this->func_check('session_start');
		if(!$session['status']){
			$status = false;
		}
		echo '<tr><td class="lft">PHP组件：Session</td><td>支持</td><td>支持</td><td>'.$session['info'].'</td></tr>';
		$xml = $this->func_check('simplexml_load_file');
		if(!$xml['status']){
			$status = false;
		}
		echo '<tr><td class="lft">PHP组件：SimpleXML</td><td>支持</td><td>支持</td><td>'.$xml['info'].'</td></tr>';
		$json = $this->func_check('json_encode');
		if(!$json['status']){
			$status = false;
		}
		echo '<tr><td class="lft">PHP组件：JSON</td><td>支持</td><td>支持</td><td>'.$json['info'].'</td></tr>';
		$gd = $this->func_check('gd_info');
		if(!$gd['status']){
			$status = false;
		}
		echo '<tr><td class="lft">PHP组件：GD库</td><td>支持</td><td>支持</td><td>'.$gd['info'].'</td></tr>';
		$zlib = $this->func_check('gzclose');
		if(!$zlib['status']){
			$status = false;
		}
		echo '<tr><td class="lft">PHP组件：Zlib压缩</td><td>支持</td><td>支持</td><td>'.$zlib['info'].'</td></tr>';
		//检测根目录是否可写
		$tmpfile = time().".txt";
		touch(ROOT.$tmpfile);
		$dir_info = '<span class="darkblue">可读写</span>';
		if(!file_exists(ROOT.$tmpfile)){
			$dir_info = '<span class="red">不可写</span>';
			$status = false;
		}else{
			unlink(ROOT.$tmpfile);
		}
		echo '<tr><td class="lft">网站根目录</td><td>可读写</td><td>可读写</td><td>'.$dir_info.'</td></tr>';
		echo '</table>';
		echo '<div class="btn_wrap">';
		if(!$status){
			echo '<div style="line-height:33px;color:red;text-align:center;">检测不通过，不能执行安装</div>';
		}else{
			echo '<input name="" type="button" class="next_btn" value="下一步" onclick="window.location.href=\'?step=getzip\'" />';
		}
		echo '<div class="cl"></div></div>';
	}

	public function load_zip()
	{
		echo "\n";
		echo '<script type="text/javascript">'."\n";
		echo 'function action()'."\n";
		echo '{'."\n\t";
		echo '$.ajax({'."\n\t\t";
		echo '"url":"?step=getzip2",'."\n\t\t";
		echo '"dataType":"json",'."\n\t\t";
		echo '"cache":false,'."\n\t\t";
		echo '"async":true,'."\n\t\t";
		echo '"beforeSend": function (XMLHttpRequest){'."\n\t\t\t";
		echo 'XMLHttpRequest.setRequestHeader("request_type","ajax");'."\n\t\t\t";
		echo '$(".btn_wrap").html(\'正在获取数据……<img src="data:image/gif;base64,R0lGODlhEAAQAPeQANHR0fX19aampvDw8O/v7+zs7CgoKGBgYPf395iYmMPDw4CAgDMzM8LCwtbW1vv7+4SEhIWFhbe3t6Ojo25ubltbW+vr6+fn51paWjs7O0VFRXx8fKKiopubm7m5uUNDQ97e3pKSkqqqqvHx8W1tbc3NzTk5OYyMjEtLS4+PjzAwMKSkpO3t7ebm5ri4uG9vb5qamlhYWAkJCcjIyMzMzBgYGAUFBUpKStPT0zExMWRkZLq6ur6+vq+vr09PTzY2NgEBAfr6+vT09BkZGR0dHUdHR1ZWVmdnZ8/Pz9nZ2RYWFlNTU7a2tpmZma2trZGRkUZGRsTExOPj4729vaioqAICAk1NTeDg4KmpqaGhoenp6SkpKcXFxR4eHtzc3EhISKCgoO7u7rKysl5eXp6eni8vL7W1tSMjI1JSUsfHx3p6eioqKiEhIeHh4T09PVBQUOXl5bOzs0lJSc7OzsrKymZmZvPz88vLy2hoaEFBQT8/P3t7e9/f3z4+PpeXlx8fHxAQEAgICMbGxqysrOrq6jo6OvLy8tvb20BAQFVVVdTU1OLi4qurq8HBwf39/QAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH/C05FVFNDQVBFMi4wAwEAAAAh+QQJAACQACwAAAAAEAAQAAAIfgAhCRzogYGJBgMTQoqy4A4kA48eZVAoUFCZR3kOqYioAZKjAY4GRogoI4GCDyhKQAoggMBABz6GjGlBMUDIgYR6FKCoEEGHCQ94KkwRkYNQSAAaQRr5KMHRpJAKnAgx4qjVq44CCLWZkIAArQpZuhz48SYAAALLHm2k9OrVgAAh+QQJAACQACwAAAAAEAAQAAAIfgAhCRzoAMMBEAMTKqzw6BGFIGCWCAgyMA0FGoZINNzwRMkjJVgGxnj0RsKFBRAsGGj46MBAMVDMWEiYZQ2QLRIGXsBSQCEkEVZ2+BzqsxEAogIBNBJoFCkkpU6jShXoKADRAI4SEhBgVWEAAQQSOhqQ9elRSGPLDm20dCrSgAAh+QQJAACQACwAAAAAEAAQAAAIfQAhCRyIoMOEBwMTKkzx6BEHSA0WzEnoaIAjSBEaJqDz41EhRQMJCAgAqcCJECP2VGkIY6Ajkgq9GKmBgY/Cm5C09GCBE6cHBiYaQGoEoCckAw0zDC3aU0VDDUYHKviAokTUni97BrgYcuTNAAIIULQoEADTilxxNmp0tW1AACH5BAkAAJAALAAAAAAQABAAAAh+ACEJHEiwoEGBjRodFOhogCOBAABAYqHgBRKCBAQEKLiizyM8BB1tLCiFSpEpCwu2EFEgZUEHGA6AgNRI4sIKjx5RoGnzIImcG1wKv';
		echo 'LAAggWhMHKsCDmS4BM2j7qIGJixqUADOR8dGNjwIaSIkLIQeXRGwsKEAgcdceFVKMGAACH5BAkAAJAALAAAAAAQABAAAAh9ACEJHEiwoEGBjRodFOhogCOBAAAwdEiQgIAABgMIIEDQEcaDAR4uHElSIIIOEx5AaiRxYYpHjzisbHkwAswEJSEVOBFiRMkoL3B0/Ehwhp5AiIQKtIjRAwMTDdRUgdlkYMOHBmBmuILGRqJFB1XA1ADpihM4CxV8QFHCYEAAIfkECQAAkAAsAAAAABAAEAAACHsAIQkcSLCgQYGNGh0U6GiAI4EAADB0SJCAgAAGAwggQNARxoMBHi4cSfJgI4kjASiEdJKkypILE+RYYdDODiEDYQx5ZEAAwTA8YtAYeOORUSgOMBwAMcHNozoDBdR4tEVCBaMUWsTRoWDgA0ZHJEAiYXQDzAsLIFgwGBAAIfkECQAAkAAsAAAAABAAEAAACH0AIQkcSLCgQYGNGh0U6GiAI4EAADB0SJCAgAAGAwggQNARxoMBHi4c6YGBiQYjBxp49CjDSAAKVbDU8FKhgg8oSqQkOOMFkp2QuPyQ8SVJRpGQILCU4QdBhwkPIGnkKDCJHBsVtKRgyQFSQ6SQ2jiRAikCywRAC5wIMcJgQAAh+QQFAACQACwAAAAAEAAQAAAIfAAhCRxIsKBABGSWUHEEqVEjgwKbAHpERAAkAAAEOhrAUOCNRyCLFAwggMBAAX+AMHBhMEBHgSKsMIFI0AGGAyBoEqwAkoJOAA9JgNzw8+GFBRAs6Cw4wAWCpQMbGZkhpOVLSDEe+ZhJkKTJgVN08GBxMSOkjVcLOoTKNiAAOw==" width="16px" height="16px" /><div class="cl"></div>\');'."\n\t\t";
		echo '},'."\n\t\t";
		echo '"success":function(rs){'."\n\t\t\t";
		echo 'if(rs.status == "ok"){'."\n\t\t\t\t";
		echo 'alert("成功执行，请点下一步进行安装");'."\n\t\t\t\t";
		echo 'window.location.href = "?step=checkdir";'."\n\t\t\t";
		echo '}else{'."\n\t\t\t\t";
		echo 'alert(rs.content);'."\n\t\t\t\t";
		echo 'window.location.reload();'."\n\t\t\t\t";
		echo 'return false;'."\n\t\t\t";
		echo '}'."\n\t\t";
		echo '}'."\n\t";
		echo '});'."\n";
		echo '}'."\n";
		echo '</script>'."\n";
		if(file_exists(ROOT.'phpok.zip')){
			echo '<div class="tips_box"><div class="tips_title">提示消息</div>';
			echo '<div class="tips_txt">';
			echo '<p>检测到根目录存在phpok.zip安装包，点击“执行解压”进行解压操作</p></div></div>';
			echo '<div class="btn_wrap">';
			echo '<input name="" type="button" class="next_btn" value="执行解压" onclick="action()" />';
			echo '<div class="cl"></div></div>';
		}else{
			echo '<div class="tips_box"><div class="tips_title">提示消息</div>';
			echo '<div class="tips_txt">';
			echo '<p>点击“远程获取”，系统将偿试从远程获取PHPOK.ZIP最新安装包，如获取失败，请手动下载<br />下载地址：<a href="http://www.phpok.com/phpok.html" target="_blank">http://www.phpok.com/phpok.html</a></p></div></div>';
			echo '<div class="btn_wrap">';
			echo '<input name="" type="button" class="next_btn" value="远程获取" onclick="action()" />';
			echo '<input name="" type="button" class="prev_btn" value="上一步" onclick="go_prev()" />';
			echo '<div class="cl"></div></div>';
		}
	}

	public function check_dir()
	{
		$status = true;
		echo '<div class="tips_box"><div class="tips_title">提示消息</div>';
		echo '<div class="tips_txt">';
		echo '<p>检测环境目录是否可写<br />已存在安装包将跳过第二步操作</p></div></div>';
		echo '<table width="980" border="0" cellspacing="0" cellpadding="0" class="tablebox">';
		echo '<tr class="head_bg"><td>目录或文件</td><td>要求</td><td>当前环境检测</td></tr>';
		$tmpfile = time().".txt";
		touch(ROOT.$tmpfile);
		$dir_info = '<span class="darkblue">读写</span>';
		if(!file_exists(ROOT.$tmpfile)){
			$dir_info = '<span class="red">不可写</span>';
			$status = false;
		}else{
			if(!is_readable(ROOT.$tmpfile)){
				$dir_info = '<span class="red">不可读</span>';
				$status = false;
			}
			unlink(ROOT.$tmpfile);
		}
		echo '<tr><td class="lft">网站根目录</td><td>读写</td><td>'.$dir_info.'</td></tr>';
		if(is_writable($ROOT.'config.php')){
			$info = '<span class="darkblue">正常</span>';
			if(!is_readable(ROOT.'config.php')){
				$info = '<span class="red">不可读</span>';
				$status = false;
			}
		}else{
			$info = '<span class="red">异常，无法写入</span>';
			$status = false;
		}
		echo '<tr><td class="lft">文件：config.php</td><td>写入</td><td>'.$info.'</td></tr>';
		//data/
		touch(ROOT.'data/'.$tmpfile);
		$dir_info = '<span class="darkblue">读写</span>';
		if(!file_exists(ROOT.'data/'.$tmpfile)){
			$dir_info = '<span class="red">不可写</span>';
			$status = false;
		}else{
			if(!is_readable(ROOT.'data/'.$tmpfile)){
				$dir_info = '<span class="red">不可读</span>';
				$status = false;
			}
			unlink(ROOT.'data/'.$tmpfile);
		}
		echo '<tr><td class="lft">目录：data/</td><td>读写</td><td>'.$dir_info.'</td></tr>';
		//data/cache/
		touch(ROOT.'data/cache/'.$tmpfile);
		$dir_info = '<span class="darkblue">读写</span>';
		if(!file_exists(ROOT.'data/cache/'.$tmpfile)){
			$dir_info = '<span class="red">不可写</span>';
			$status = false;
		}else{
			if(!is_readable(ROOT.'data/cache/'.$tmpfile)){
				$dir_info = '<span class="red">不可读</span>';
				$status = false;
			}
			unlink(ROOT.'data/cache/'.$tmpfile);
		}
		echo '<tr><td class="lft">目录：data/cache/</td><td>读写</td><td>'.$dir_info.'</td></tr>';
		//data/session/
		touch(ROOT.'data/session/'.$tmpfile);
		$dir_info = '<span class="darkblue">读写</span>';
		if(!file_exists(ROOT.'data/session/'.$tmpfile)){
			$dir_info = '<span class="red">不可写</span>';
			$status = false;
		}else{
			if(!is_readable(ROOT.'data/session/'.$tmpfile)){
				$dir_info = '<span class="red">不可读</span>';
				$status = false;
			}
			unlink(ROOT.'data/session/'.$tmpfile);
		}
		echo '<tr><td class="lft">目录：data/session/</td><td>读写</td><td>'.$dir_info.'</td></tr>';
		//data/tpl_admin/
		touch(ROOT.'data/tpl_admin/'.$tmpfile);
		$dir_info = '<span class="darkblue">读写</span>';
		if(!file_exists(ROOT.'data/tpl_admin/'.$tmpfile)){
			$dir_info = '<span class="red">不可写</span>';
			$status = false;
		}else{
			if(!is_readable(ROOT.'data/tpl_admin/'.$tmpfile)){
				$dir_info = '<span class="red">不可读</span>';
				$status = false;
			}
			unlink(ROOT.'data/tpl_admin/'.$tmpfile);
		}
		echo '<tr><td class="lft">目录：data/tpl_admin/</td><td>读写</td><td>'.$dir_info.'</td></tr>';
		//data/tpl_html/
		touch(ROOT.'data/tpl_html/'.$tmpfile);
		$dir_info = '<span class="darkblue">读写</span>';
		if(!file_exists(ROOT.'data/tpl_html/'.$tmpfile)){
			$dir_info = '<span class="red">不可写</span>';
			$status = false;
		}else{
			if(!is_readable(ROOT.'data/tpl_html/'.$tmpfile)){
				$dir_info = '<span class="red">不可读</span>';
				$status = false;
			}
			unlink(ROOT.'data/tpl_html/'.$tmpfile);
		}
		echo '<tr><td class="lft">目录：data/tpl_html/</td><td>读写</td><td>'.$dir_info.'</td></tr>';
		//data/tpl_www/
		touch(ROOT.'data/tpl_www/'.$tmpfile);
		$dir_info = '<span class="darkblue">读写</span>';
		if(!file_exists(ROOT.'data/tpl_www/'.$tmpfile)){
			$dir_info = '<span class="red">不可写</span>';
			$status = false;
		}else{
			if(!is_readable(ROOT.'data/tpl_www/'.$tmpfile)){
				$dir_info = '<span class="red">不可读</span>';
				$status = false;
			}
			unlink(ROOT.'data/tpl_www/'.$tmpfile);
		}
		echo '<tr><td class="lft">目录：data/tpl_www/</td><td>读写</td><td>'.$dir_info.'</td></tr>';
		//data/update/
		touch(ROOT.'data/update/'.$tmpfile);
		$dir_info = '<span class="darkblue">读写</span>';
		if(!file_exists(ROOT.'data/update/'.$tmpfile)){
			$dir_info = '<span class="red">不可写</span>';
			$status = false;
		}else{
			if(!is_readable(ROOT.'data/update/'.$tmpfile)){
				$dir_info = '<span class="red">不可读</span>';
				$status = false;
			}
			unlink(ROOT.'data/update/'.$tmpfile);
		}
		echo '<tr><td class="lft">目录：data/update/</td><td>读写</td><td>'.$dir_info.'</td></tr>';
		touch(ROOT.'res/'.$tmpfile);
		$dir_info = '<span class="darkblue">读写</span>';
		if(!file_exists(ROOT.'res/'.$tmpfile)){
			$dir_info = '<span class="red">不可写</span>';
			$status = false;
		}else{
			if(!is_readable(ROOT.'res/'.$tmpfile)){
				$dir_info = '<span class="red">不可读</span>';
				$status = false;
			}
			unlink(ROOT.'res/'.$tmpfile);
		}
		echo '<tr><td class="lft">目录：res/</td><td>读写</td><td>'.$dir_info.'</td></tr>';
		echo '</table>';
		if($status){
			echo '<div class="btn_wrap">';
			echo '<input name="" type="button" class="next_btn" value="下一步" onclick="window.location.href=\'?step=readme\'" />';
			echo '<input name="" type="button" class="prev_btn" value="上一步" onclick="window.location.href=\'?\'" />';
			echo '<div class="cl"></div></div>';
		}else{
			echo '<div style="line-height:33px;color:red;text-align:center;height:50px;">检测不通过，不能执行安装</div>';
		}
	}

	public function readme()
	{
		echo '<div class="agreement">';
		echo '<div class="txt_box">';
		echo '<p class="fz_16">GNU 较宽松公共许可证 (简体中文翻译版)</p>';
		echo '<p class="fz_14">声明!</p>';
		echo '<p>这是一份 GNU 较宽松公共许可证非正式的中文翻译。它不是自由软体基金会所发布，并且不能适用于使用 GNU LGPL 的软体 —— 只有 GNU LGPL 英文原文的版本才行。然而，我们希望这份翻译能帮助中文的使用者更了解 GNU LGPL。</p>';
		echo '<p>This is an unofficial translation of the GNU Lesser General Public License into Chinese. It was not published by the Free Software Foundation, and does not legally state the distribution terms for software that uses the GNU LGPL--only the original English text of the GNU LGPL does that. However, we hope that this translation will help Chinese speakers understand the GNU LGPL better.</p>';
		echo '<p>GNU 较宽松公共许可证</p>';
		echo '<p>1999.2, 第 2.1 版</p>';
		echo '<p>版权所有 (C) 1991, 1999 Free Software Foundation, Inc.</p>';
		echo '<p>59 Temple Place, Suite 330, Boston, MA 02111-1307 USA</p>';
		echo '<p class="fz_16 col_red">允许每个人复制和发布本授权文件的完整副本，但不允许对它进行任何修改。</p>';
		echo '<p>[这是第一次发表的较宽松公共许可证 (Lesser GPL) 版本。它同时也可视为 GNU 函数库公共许可证 (GNU Library Public License) 第 2 版的后继者，故称为 2.1 版]</p>';
		echo '<p class="fz_14">导言</p>';
		echo '<p>大多数软体许可证决意剥夺您共享和修改软体的自由。相反的，GNU 通用公共许可证力图保证您共享和修改自由软体的自由 —— 保证自由软体对所有使用者都是自由的。</p>';
		echo '<p>这个许可证，较宽松公共许可证，适用于一些由自由软体基金会与其他决定使用此许可证的软体作者，所特殊设计的软体套件 —— 象是函数库。您也可以使用它，但我们建议您事先仔细考虑，基于以下的说明是否此许可证或原来的通用公共许可证在任何特殊情况下均为较好的方案。</p>';
		echo '<p>当我们谈到自由软体时，我们所指的是自由，而不是价格。我们的 GNU 通用公共许可证是设计用以确保使您有发布自由软体备份的自由（如果您愿意，您可以对此项服务收取一定的费用）；确保您能收到程式原始码或者在您需要时能得到它；确保您能修改软体或将它的一部分用于新的自由软体；而且还确保您知道您可以做上述的这些事情。</p>';
		echo '<p>为了保护您的权利，我们需要作出限制：禁止任何人否认您上述的权利，或者要求您放弃这些权利。如果您发布软件的副本，或者对之加以修改，这些规定就转化为您的责任。</p>';
		echo '<p>例如，如果您发布此函数库的副本，不管是免费还是收取费用，您必须将您享有的一切权利给予接受者；您必须确保他们也能收到或得到原始程式码；如果您将此函数库与其他的程式码连结，您必须提供完整的目的对象文件和程序(object file)给接受者，则当他们修改此函数库并重新编译过后，可以重新与目的档连结。您并且要将这些条款给他们看，使他们知道他们有这样的权利。</p>';
		echo '<p>我们采取两项措施来保护您的权利: （1）用版权来保护函数库。并且，（2）我们提供您这份许可证，赋予您复制，发布和（或）修改这些函数库的法律许可。</p>';
		echo '<p>为了保护每个发布者，我们需要非常清楚地让每个人明白，自由函数库是没有担保责任的。如果由于某人修改了函数库，并继续加以传播，我们需要它的接受者明白：他们所得到的并不是原始的版本。故由其他人引入的任何问题，对原作者的声誉将不会有任何的影响。</p>';
		echo '</div>';
		echo '</div>';
		echo '<script type="text/javascript">'."\n";
		echo 'function submit_next()'."\n";
		echo '{'."\n\t";
		echo 'if(!$("#agree").is(":checked")){'."\n\t\t";
		echo 'alert("请勾选同意本站安装协议");'."\n\t\t";
		echo 'return false;'."\n\t\t";
		echo '}'."\n\t";
		echo 'window.location.href = "?step=install";'."\n";
		echo '}'."\n";
		echo '</script>';
		echo '<div class="btn_wrap">';
		echo '<label class="choose_check"><input id="agree" type="checkbox" />我已阅读并接受该服务条款</label>';
		echo '<input name="" type="button" class="next_btn" value="下一步" onclick="submit_next()" />';
		echo '<input name="" type="button" class="prev_btn" value="上一步" onclick="window.location.href=\'?step=checkdir\'" />';
		echo '<div class="cl"></div></div>';
		
	}

	public function config()
	{
		include(ROOT."config.php");
		$dbconfig = $config['db'];
		unset($config);
		$site = root_url();
		$site['title'] = "PHPOK企业站";
		$optlist = '<select name="file" id="file">';
		if(function_exists("mysql_close")){
			$optlist .= '<option value="mysql">使用MySQL连接数据库</option>';
		}
		if(function_exists("mysqli_close")){
			$optlist .= '<option value="mysqli" selected>使用MySQLi连接数据库</option>';
		}
		$optlist .= '</select>';
		echo <<<EOT
<div class="tips_box">
	<div class="tips_title">提示消息</div>
	<div class="tips_txt">
   	  <p>填写网站安装要用到的配置，如数据库信息等，请仔细填写</p>
    </div>    
</div>
<script type="text/javascript">
function submit_next()
{
	var chk = check_connect(true);
	if(!chk){
		return false;
	}
	var sitename = jQuery("#title").val();
	if(!sitename){
		alert('网站名称不能为空');
		return false;
	}
	var domain = jQuery("#domain").val();
	if(!domain){
		alert('域名不能为空');
		return false;
	}
	var user = jQuery('#admin_user').val();
	if(!user){
		alert('管理员账号不能为空');
		return false;
	}
	var email = jQuery('#admin_email').val();
	if(!email){
		alert('管理员邮箱不能为空');
		return false;
	}
	var newpass = jQuery('#admin_newpass').val();
	if(!newpass){
		alert('管理员密码不能为空');
		return false;
	}
	var chkpass = jQuery('#admin_chkpass').val();
	if(!chkpass){
		alert('管理员确认密码不能为空');
		return false;
	}
	if(newpass != chkpass){
		alert('两次输入的管理员密码不一致');
		return false;
	}
	return true;
}
function check_connect(isin)
{
	var url = "?step=checkdb";
	var file = jQuery("#file").val();
	url += "&file="+file;
	var host = jQuery("#host").val();
	if(!host){
		jQuery("#host").val('127.0.0.1');
		host = '127.0.0.1';
	}
	url += "&host="+encodeURIComponent(host);
	var port = jQuery("#port").val();
	if(!port){
		jQuery("#port").val('3306');
	}
	url += "&port="+encodeURIComponent(port);
	var user = jQuery("#user").val();
	if(!user){
		alert("请填写数据库账号！");
		return false;
	}
	url += "&user="+encodeURIComponent(user);
	var pass = $("#pass").val();
	var chkpass = $("#chkpass").val();
	if(pass){
		if(!chkpass){
			alert('请再次输入数据库密码');
			return false;
		}
		if(pass != chkpass){
			alert('两次输入的数据库密码不一致');
			return false;
		}
	}else{
		var q = confirm("请填写数据库密码，如果您确定为空，请按确定");
		if(q == '0'){
			return false;
		}
	}
	url += "&pass="+encodeURIComponent(pass)+"&chkpass="+encodeURIComponent(chkpass);
	var data = jQuery("#data").val();
	if(!data){
		alert("请填写您的数据库名称，不能为空");
		return false;
	}
	url += "&data="+encodeURIComponent(data);
	var info = $.ajax({'url':url,'dataType':'html','cache':false,'async':false}).responseText;
	var rs = $.parseJSON(info);
	if(rs.status != 'ok'){
		alert(rs.content);
		return false;
	}
	if(!isin || isin == 'undefined'){
		alert('测试连接数据库通过');
	}
	return true;
}
</script>
<div class="tips_box">
	<div class="tips_title">配置数据库连接</div>
	<form method="post" action="?step=save" onsubmit="return submit_next()">
	<div class="input_box">
		<ul>
			<li><span class="l_name">数据库引挈：</span>
				$optlist
			</li>
    		<li>
	    		<span class="l_name">数据库服务器：</span>
	    		<input  name="host" id="host" type="text" class="infor_input col_red" value="{$dbconfig['host']}" />
	    		<p class="tips_p">MySQL数据库服务器地址，一般为127.0.0.1</p>
	    	</li>
        	<li><span class="l_name">数据库端口：</span>
				<input type="text" class="infor_input col_red" name="port" id="port" value="{$dbconfig['port']}" />
				<p class="tips_p">MySQL默认端口为3306，请根据您实际情况调整</p>
			</li>
        	<li><span class="l_name">数据库用户名：</span>
				<input type="text" class="infor_input" name="user" id="user" value="{$dbconfig['user']}" />
				<p class="tips_p">MySQL数据库用户名</p>
			</li>
			<li><span class="l_name">数据库密码：</span>
				<input type="password" class="infor_input" name="pass" id="pass" value="" />
				<p class="tips_p">MySQL数据库密码</p>
			</li>
			<li><span class="l_name">数据库确认密码：</span>
				<input type="password" class="infor_input" name="chkpass" id="chkpass" value="" />
				<p class="tips_p">请再填写一次数据库密码</p>
			</li>
			<li><span class="l_name">数据库名：</span>
				<input type="text" class="infor_input" name="data" id="data" value="{$dbconfig['data']}" />
				<p class="tips_p">数据库名称<span class="col_red">（数据库必须存在，不存在请先创建！）</span></p>
			</li>
			<li><span class="l_name">表名前缀：</span>
				<input type="text" class="infor_input" name="prefix" id="prefix" value="{$dbconfig['prefix']}" />
				<p class="tips_p">同一数据库安装多个应用时可改变前缀</p>
			</li>
			<li><span class="l_name">&nbsp;</span>
				<input name="" type="button" class="next_btn" value="检测数据库配置是否正确" onclick="check_connect()" style="float:none;" />
			</li>
        </ul>
    </div>   
</div>
<div class="tips_box">
	<div class="tips_title">站点信息设置</div>
	<div class="input_box">
		<ul>
			<li><span class="l_name">网站名称：</span>
				<input type="text" class="infor_input" name="title" id="title" value="{$site['title']}" />
				<p class="tips_p">设置网站的名称</p>
			</li>
			
			<li><span class="l_name">网站域名：</span>
				<input type="text" class="infor_input" name="domain" id="domain" value="{$site['domain']}" />
				<p class="tips_p">设置网站绑定的域名，不能有/和http://</p>
			</li>
			<li><span class="l_name">安装目录：</span>
				<input type="text" class="infor_input" name="dir" id="dir" value="{$site['dir']}" />
				<p class="tips_p">根目录请设为/</p>
			</li>
        </ul>
    </div>   
</div>
<div class="tips_box">
	<div class="tips_title">管理员设置</div>
	<div class="input_box">
		<ul>
			<li><span class="l_name">管理员账号：</span>
				<input type="text" class="infor_input" name="admin_user" id="admin_user" value="admin" />
				<p class="tips_p">中、英文均可使用</p>
			</li>
			<li><span class="l_name">管理员Email地址：</span>
				<input type="text" class="infor_input" name="admin_email" id="admin_email" />
				<p class="tips_p">E-mail请一定填写正确有效的地址</p>
			</li>
			<li><span class="l_name">管理员密码：</span>
				<input type="password" class="infor_input" name="admin_newpass" id="admin_newpass" />
				<p class="tips_p">密码长度不能小于6位，且区分大小写</p>
			</li>
			<li><span class="l_name">确认密码：</span>
				<input type="password" class="infor_input" name="admin_chkpass" id="admin_chkpass" />
				<p class="tips_p">请重复输入一次密码，确认</p>
			</li>
        </ul>
    </div>   
</div>
		
EOT;
		echo '<div class="btn_wrap">';
		echo '<input name="" type="submit" class="next_btn" value="下一步" />';
		echo '<input name="" type="button" class="prev_btn" value="上一步" onclick="window.location.href=\'?step=readme\'" />';
		echo '<div class="cl"></div></div>';
		echo '</form>';
	}

	public function import_info()
	{
		echo <<<EOT
<script type="text/javascript">
function waiting(id)
{
	var val = jQuery("#"+id).attr("status");
	if(val == 'wait'){
		jQuery("#"+id).html('<img src="{$this->loading()}" width="16" height="16" />');
		jQuery("#"+id).attr("status","installing");
		jQuery("#"+id+"_status").html('...');
	}
	jQuery("#"+id+"_status").append('.');
	if(val != "ok" && val != 'error')
	{
		window.setTimeout(function(){waiting(id);},230);
	}
}
function to_admin()
{
	var d = jQuery("#installing").attr('installok');
	if(d == 'false'){
		alert('正在安装中，不能点击');
		return false;
	}
	window.location.href = 'admin.php';
}
function starting_install(id)
{
	var url = "?step=ajax_"+id;
	jQuery.ajax({
		'url':url,
		'cache':false,
		'async':true,
		'dataType':'html',
		'success':function(info){
			if(info){
				if(info == 'ok'){
					jQuery("#"+id).attr("status","ok");
					jQuery("#"+id).html('完成');
					if(id == 'endok'){
						jQuery("#installing").val("进入后台").attr('installok','true');
						jQuery(".step_num li").removeClass("current");
						jQuery(".step_num li").last().addClass("current");
						alert("PHPOK安装完成，您可以点击《进入后台》按钮可以进入后台设置");
					}else{
						var _i = 0;
						jQuery("span[name=install]").each(function(i){
							var tmp = jQuery(this).attr('status');
							if(tmp == "wait" && _i<1){
								_i++;
								var tmpid = jQuery(this).attr("id");
								waiting(tmpid);
								window.setTimeout(function(){starting_install(tmpid)},1500);
								return false;
							}
						});
					}
				}else{
					jQuery("#"+id).attr("status","error");
					jQuery("#"+id).html('<i class="col_red">'+info+'</i>');
				}
			}
		}
	});
}
</script>
<div class="tips_box">
	<div class="tips_title">提示消息</div>
	<div class="tips_txt">
		<p>数据库信息已保存，正在安装其他项目，请耐心等待</p>
    </div>    
</div>

<div class="tips_box">
	<div class="tips_title">安装进度</div>
	<div class="install">
		<ul>
		<li>数据库文件导入<span id="importsql_status"></span><span name="install" id="importsql" status="wait"></span></li>
		<li class="grey_bg">初始化数据<span id="initdata_status"></span><span name="install" id="initdata" status="wait"></span></li>
		<li>安装管理员信息<span id="iadmin_status"></span><span name="install" id="iadmin" status="wait"></span></li>
		<li class="grey_bg">清空缓存<span id="clearcache_status"></span><span name="install" id="clearcache" status="wait"></span></li>
		<li>完成安装<span id="endok_status"></span><span name="install" id="endok" status="wait"></span></li>
		</ul>
	</div>
</div>

<div class="btn_wrap">
	<input name="" type="button" class="next_btn" id="installing" value="安装中…" installok='false' onclick="to_admin()" />
	<div class="cl"></div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	waiting('importsql');
	window.setTimeout(function(){starting_install('importsql')},1500);
});
</script>
EOT;
	}
	
	private function func_check($funName = '',$id='')
	{
		$status =  function_exists($funName) ? true : false;
		if($status){
			$info = '<span class="darkblue">支持</span>';
		}else{
			$info = '<span class="red">不支持</span>';
		}
		return array('status'=>$status,'info'=>$info);
	}

	private function loading()
	{
		$info = 'data:image/gif;base64,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';
		return $info;
	}
	
	private function logo()
	{
		$info = "data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAABLAAD/4QNvaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjMtYzAxMSA2Ni4xNDU2NjEsIDIwMTIvMDIvMDYtMTQ6NTY6MjcgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6QTY4ODUwN0FENDNFRTQxMTkxNEVGOUJDNUEzRjZGNjMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6MzA5MUFDQTEzRjlFMTFFNDgzNDc5NkEzNUYwQTc0NkQiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6MzA5MUFDQTAzRjlFMTFFNDgzNDc5NkEzNUYwQTc0NkQiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDpFRDA5OTQ1MUU4M0VFNDExQjZEQkM5MzdCOTYxRDgyMCIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDpBNjg4NTA3QUQ0M0VFNDExOTE0RUY5QkM1QTNGNkY2MyIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6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";
		return $info;
	}

	private function cssinfo()
	{
		echo '<style type="text/css">'."\n";
		echo 'body,h1,h2,h3,h4,h5,h6,p,th,td,dl,dd,form,fieldset,legend,input,textarea,select{margin:0;padding:0}'."\n";
		echo 'body{font:12px "微软雅黑","Arial Narrow",HELVETICA;background:#fff;-webkit-text-size-adjust:100%}'."\n";
		echo 'a{color:#172c45;text-decoration:none}'."\n";
		echo 'a:hover{color:#cd0200;text-decoration:underline}'."\n";
		echo 'em{font-style:normal}'."\n";
		echo 'img{border:0;vertical-align:middle}'."\n";
		echo 'table{border-collapse:collapse;border-spacing:0}'."\n";
		echo 'p{word-wrap:break-word}'."\n";
		echo 'input{font-family:"微软雅黑"}'."\n";
		echo '.cl{clear:both}'."\n";
		echo '.fl{float:left}'."\n";
		echo '.fr{float:right}'."\n";
		echo '.fz_16{font-size:16px}'."\n";
		echo '.fz_14{font-size:14px}'."\n";
		echo '.col_red{color:#ff0000}'."\n";
		echo '.red{color:#ff0000}'."\n";
		echo '.darkblue{color:darkblue}'."\n";
		echo '.lft{text-align:left}'."\n";
		echo '.header{height:63px;width:980px;margin:0 auto;padding:40px 0 30px}'."\n";
		echo '.logo{float:left;width:266px;height:63px}'."\n";
		echo '.step{width:650px;float:right;height:50px;position:relative;margin-top:15px}'."\n";
		echo '.step .line{width:650px;height:3px;background:#dde6ed;position:absolute;left:0;top:13px;z-index:9}'."\n";
		echo '.step .step_num{width:650px;height:50px;position:absolute;left:0;top:0;z-index:10;margin:0;padding:0;list-style:none}'."\n";
		echo '.step .step_num li{width:100px;float:left;list-style:none}'."\n";
		echo '.step .step_num li .num{height:28px;width:28px;background:#DBE6EC;border-radius:14px;text-align:center;line-height:28px;color:#333;margin:0 auto;display:block}'."\n";
		echo '.step .step_num li .name{display:block;text-align:center;padding:5px 0 0;font-size:12px;color:#333}'."\n";
		echo '.step .step_num .current .num{background:#2C91D9;color:#fff}'."\n";
		echo '.step .step_num .current .name{color:#5496dd}'."\n";
		echo '.agreement{width:938px;border:1px solid #e6e6e6;background:#fdfdfd;margin:0 auto;height:400px;overflow-x:hidden;overflow-y:scroll;padding:20px}'."\n";
		echo '.agreement .txt_box{width:100%;font-size:12px;line-height:22px}'."\n";
		echo '.agreement .txt_box p{margin-bottom:20px}'."\n";
		echo '.btn_wrap{width:980px;margin:15px auto ;height:32px;overflow:hidden}'."\n";
		echo '.btn_wrap .choose_check{float:left;line-height:32px}'."\n";
		echo '.btn_wrap .choose_check input{float:left;margin:9px 5px 0 0}'."\n";
		echo '.next_btn{background:#4995E0;border:1px solid #4388CD;padding:5px 10px;color:#fff;text-align:center;font-size:14px;cursor:pointer;float:right;margin-left:15px}'."\n";
		echo '.prev_btn{background:#959595;border:1px solid #858585;padding:5px 10px;color:#fff;text-align:center;font-size:14px;cursor:pointer;float:right;margin-left:15px}'."\n";
		echo '.footer{width:980px;padding:20px 0 30px;border-top:1px solid #c7c7c7;text-align:center;font-size:14px;margin:0 auto}'."\n";
		echo '.tips_box{width:978px;border:1px solid #e6e6e6;margin:0 auto 15px}'."\n";
		echo '.tips_box .tips_title{background:#F5F5F5;height:39px;border-bottom:1px solid #e6e6e6;padding:0 20px;line-height:39px;font-size:16px;color:#03C}'."\n";
		echo '.tips_box .tips_txt{padding:20px;line-height:22px;font-size:14px}'."\n";
		echo '.tips_box .tips_txt p{margin-bottom:15px}'."\n";
		echo '.tablebox{border-collapse:collapse;width:980px;margin:0 auto 15px;text-align:center}'."\n";
		echo '.tablebox td{border:#e6e6e6 solid 1px;padding:5px;height:30px}'."\n";
		echo '.tablebox .head_bg{background:#F5F5F5;height:38px}'."\n";
		echo '.input_box{padding:20px;overflow:hidden}'."\n";
		echo '.input_box ul{list-style:none}'."\n";
		echo '.input_box li{line-height:30px;margin-bottom:10px;overflow:hidden}'."\n";
		echo '.input_box select{padding:3px}'."\n";
		echo '.input_box .l_name{width:150px;float:left;text-align:right;font-size:14px;margin-right:5px}'."\n";
		echo '.input_box .infor_input{width:350px;height:22px;border:1px solid #cacaca;padding:3px;float:left;margin-right:10px}'."\n";
		echo '.input_box .tips_p{float:left;line-height:30px}'."\n";
		echo '.install{overflow:hidden}'."\n";
		echo '.install ul{list-style:none;margin:0;padding:0}'."\n";
		echo '.install li{height:30px;line-height:30px;padding:0 30px}'."\n";
		echo '.install .grey_bg{background:#fcfcfc}'."\n";
		echo '.install li span{color:#03C}'."\n";
		echo '</style>'."\n";
	}

	private function jsinfo()
	{
		echo '<script type="text/javascript" src="'.JQUERY.'"></script>';
	}

	public function curl($url,$post="")
	{
		$curl = curl_init();
		curl_setopt($curl, CURLOPT_FORBID_REUSE, true); // 处理完后，关闭连接，释放资源
		curl_setopt($curl, CURLOPT_HEADER, true);//结果中包含头部信息
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);//把结果返回，而非直接输出
		if($post){
			curl_setopt($curl,CURLOPT_POST,true);
			curl_setopt($curl,CURLOPT_POSTFIELDS,$post);
		}else{
			curl_setopt($curl, CURLOPT_HTTPGET,true);//使用GET传输数据
		}
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT,10);//等待时间，超时退出
		curl_setopt($curl,CURLOPT_ENCODING ,'gzip');//GZIP压缩
		curl_setopt($curl, CURLOPT_TIMEOUT, 1800);
		$purl = $this->format_url($url);
		$header = array();
		$header[] = "Host: ".$purl["host"];
		$header[] = "Referer: ".$purl['protocol'].$purl["host"];
		if($post){
			$length = strlen($post);
			$header[] = 'Content-length: '.$length;
		}
		curl_setopt($curl, CURLOPT_URL, $url);
		curl_setopt($curl, CURLOPT_HTTPHEADER, $header);
		curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);

        $content = curl_exec($curl);
        if (curl_errno($curl) != 0){
            return false;
        }
        $separator = '/\r\n\r\n|\n\n|\r\r/';
        list($http_header, $http_body) = preg_split($separator, $content, 2);
        $http_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		$last_url = curl_getinfo($curl, CURLINFO_EFFECTIVE_URL);
        curl_close($curl);
        //判断是否是301或302跳转
        if ($http_code == 301 || $http_code == 302){
			$matches = array();
			preg_match('/Location:(.*?)\n/', $http_header, $matches);
			$url = @parse_url(trim(array_pop($matches)));
			if (!$url) return $data;
			$new_url = $url['scheme'] . '://' . $url['host'] . $url['path']
			. (isset($url['query']) ? '?' . $url['query'] : '');
			$new_url = stripslashes($new_url);
			return $this->curl($new_url, $post);
		}
        if($http_code != '200'){
	        return false;
        }
		return $http_body;
    }

	public function format_url($url)
	{
		$array = parse_url($url);
		if (!isset($array['host'])){
			if(isset($_SERVER["HTTP_HOST"])){
				$array['host'] = $_SERVER["HTTP_HOST"];
			}elseif(isset($_SERVER["SERVER_NAME"])){
				$array['host'] = $_SERVER["SERVER_NAME"];
			}else{
				$array['host'] = "localhost";
			}
		}
		if(!isset($_SERVER["HTTPS"]) || $_SERVER["HTTPS"] == "off" || $_SERVER["HTTPS"] == ""){
			$array['scheme'] = "http";
		}else{
			$array['scheme'] = "https";
		}
		$array['port'] = $_SERVER["SERVER_PORT"] ? $_SERVER["SERVER_PORT"] : 80;
        if(!isset($array['path'])){
			$array['path'] = "/";
		}elseif(($array['path']{0} != '/') && ($_SERVER["PHP_SELF"]{0} == '/')){
			$array['path'] = substr($_SERVER["PHP_SELF"], 0, strrpos($_SERVER["PHP_SELF"], '/') + 1) . $array['path'];
		}
		return $array;
	}

	public function get($id,$system=false)
	{
		$msg = isset($_POST[$id]) ? $_POST[$id] : (isset($_GET[$id]) ? $_GET[$id] : "");
		if($msg == ''){
			return false;
		}
		if($system){
			if(!preg_match('/^[a-zA-Z][a-zA-Z0-9\_\-]+$/u',$msg)){
				return false;
			}
			return $msg;
		}else{
			$msg = stripslashes($msg);
			$msg = str_replace(array("\\","'",'"',"<",">"),array("&#92;","&#39;","&quot;","&lt;","&gt;"),$msg);
			return addslashes($msg);
		}
	}

}

if(file_exists(ROOT.'data/install.lock')){
	error('已安装过，不能重复安装');
}

$install = new install();
$step = $install->get('step',true);
if(!$step){
	$install->head(1);
	$install->env_check();
	$install->foot();
}
if($step == 'getzip'){
	if(file_exists(ROOT.'config.php')){
		header("Location:?step=checkdir");
		exit;
	}
	$install->head(2);
	$install->load_zip();
	$install->foot();
}
if($step == 'checkdir'){
	$install->head(3);
	$install->check_dir();
	$install->foot();
}
if($step == 'readme'){
	$install->head(4);
	$install->readme();
	$install->foot();
}
if($step == 'install'){
	$install->head(5);
	$install->config();
	$install->foot();
}
if($step == 'checkdb'){
	$array = array('status'=>'error','content'=>'正在执行中');
	$file = $install->get('file',false);
	if(!$file){
		$file = 'mysql';
	}
	$host = $install->get('host',false);
	if(!$host){
		$array['content'] = '数据库服务器不能为空';
		exit(json_encode($array));
	}
	$port = $install->get('port',false);
	if(!$port){
		$port  = '3306';
	}
	$user = $install->get('user',false);
	$pass = $install->get('pass',false);
	$chkpass = $install->get('chkpass',false);
	$data = $install->get('data',false);
	if(!$user){
		$array['content'] = '数据库用户不能为空';
		exit(json_encode($array));
	}
	if($pass && $chkpass){
		if($pass != $chkpass){
			$array['content'] = '两次密码输入不一致';
			exit(json_encode($array));
		}
	}
	$config = array('host'=>$host,'user'=>$user,'pass'=>$pass,'port'=>$port,'data'=>$data);
	$dbname = 'db_'.$file;
	$db = new $dbname($config);
	if($db->error || $db->error_id){
		$array['content'] = '错误ID:'.$db->error_id.',错误信息:'.$db->error;
		exit(json_encode($array));
	}
	$array['status'] = 'ok';
	$array['content'] = '成功';
	exit(json_encode($array));
}
if($step == 'save'){
	$file = $install->get("file",false);
	if(!$file){
		$file = "mysql";
	}
	$dbconfig = array("file"=>$file);
	$dbconfig['host'] = $install->get("host",false);
	$dbconfig['port'] = $install->get("port",false);
	$dbconfig['user'] = $install->get("user",false);
	$dbconfig['pass'] = $install->get("pass",false);
	$dbconfig['data'] = $install->get("data",false);
	$dbconfig['prefix'] = $install->get("prefix",false);
	$content = file_get_contents(ROOT."config.php");
	$content = preg_replace('/\$config\["db"\]\["file"\]\s*=\s*[\'|"][a-zA-Z0-9\-\_]*[\'|"];/isU','$config["db"]["file"] = "'.$dbconfig['file'].'";',$content);
	$content = preg_replace('/\$config\["db"\]\["host"\]\s*=\s*[\'|"][a-zA-Z0-9\-\_]*[\'|"];/isU','$config["db"]["host"] = "'.$dbconfig['host'].'";',$content);
	$content = preg_replace('/\$config\["db"\]\["port"\]\s*=\s*[\'|"][a-zA-Z0-9\-\_]*[\'|"];/isU','$config["db"]["port"] = "'.$dbconfig['port'].'";',$content);
	$content = preg_replace('/\$config\["db"\]\["user"\]\s*=\s*[\'|"][a-zA-Z0-9\-\_]*[\'|"];/isU','$config["db"]["user"] = "'.$dbconfig['user'].'";',$content);
	$content = preg_replace('/\$config\["db"\]\["pass"\]\s*=\s*[\'|"][a-zA-Z0-9\-\_]*[\'|"];/isU','$config["db"]["pass"] = "'.$dbconfig['pass'].'";',$content);
	$content = preg_replace('/\$config\["db"\]\["data"\]\s*=\s*[\'|"][a-zA-Z0-9\-\_]*[\'|"];/isU','$config["db"]["data"] = "'.$dbconfig['data'].'";',$content);
	$content = preg_replace('/\$config\["db"\]\["prefix"\]\s*=\s*[\'|"][a-zA-Z0-9\-\_]*[\'|"];/isU','$config["db"]["prefix"] = "'.$dbconfig['prefix'].'";',$content);
	file_put_contents(ROOT."config.php",$content);
	$info = array('title'=>$install->get('title',false));
	$info['domain'] = $install->get('domain',false);
	$info['dir'] = $install->get('dir',false);
	$info['user'] = $install->get('admin_user',false);
	$info['email'] = $install->get('admin_email',false);
	$info['pass'] = $install->get('admin_newpass',false);
	$info['test'] = $install->get('test',false);
	$handle = fopen(ROOT.'data/install.lock.php','wb');
	fwrite($handle,'<?php'."\n");
	foreach($info as $key=>$value){
		$value = str_replace('"','',$value);
		fwrite($handle,'$adminer["'.$key.'"] = "'.$value.'";'."\n");
	}
	fwrite($handle,'?>');
	$install->head(6);
	$install->import_info();
	$install->foot();
}
if($step == 'ajax_importsql'){
	include(ROOT.'config.php');
	$file = $config['db']['file'];
	$dbname = 'db_'.$file;
	$db = new $dbname($config['db']);
	$sql = file_get_contents(ROOT."install/phpok.sql");
	if($db->prefix != "qinggan_"){
		$sql = str_replace("qinggan_",$db->prefix,$sql);
	}
	$sql = str_replace("\r","\n",$sql);
	$ret = array();
	$num = 0;
	foreach(explode(";\n", trim($sql)) as $query) {
		$queries = explode("\n", trim($query));
		foreach($queries as $query) {
			$ret[$num] .= $query[0] == '#' || $query[0].$query[1] == '--' ? '' : $query;
		}
		$num++;
	}
	unset($sql);
	foreach($ret as $query) {
		$query = trim($query);
		if($query) {
			$db->query($query);
		}
	}
	exit('ok');
}
if($step == 'ajax_initdata'){
	include(ROOT.'config.php');
	$file = $config['db']['file'];
	$dbname = 'db_'.$file;
	$db = new $dbname($config['db']);
	$truncate_array = array('address','adm','adm_popedom','cart','cart_product','log','order','order_product');
	$truncate_array[] = 'order_address';
	$truncate_array[] = 'payment';
	$truncate_array[] = 'plugins';
	$truncate_array[] = 'reply';
	$truncate_array[] = 'session';
	$truncate_array[] = 'tag';
	$truncate_array[] = 'tag_list';
	$truncate_array[] = 'temp';
	$truncate_array[] = 'site';
	$truncate_array[] = 'site_domain';
	foreach($truncate_array as $key=>$value){
		$sql = "TRUNCATE ".$db->prefix.$value;
		$db->query($sql);
	}
	$sql = "UPDATE ".$db->prefix."list SET replydate=0";
	$db->query($sql);
	//添加插件
	$data = array('id'=>'identifier','title'=>'标识串自动生成工具','author'=>'phpok.com','version'=>'1.0');
	$data['status'] = 1;
	$data['note'] = '实现名称转拼音，英语的功能';
	$tmp = array('is_youdao'=>0,'keyfrom'=>'','keyid'=>'','is_pingyin'=>1,'is_py'=>1);
	$data['param'] = serialize($tmp);
	$db->insert_array($data,'plugins');
	//安装数据信息
	$tmpfile = ROOT."data/install.lock.php";
	if(file_exists($tmpfile)){
		include($tmpfile);
		$sql = "INSERT INTO ".$db->prefix."site_domain(id,site_id,domain) VALUES(1,1,'".$adminer['domain']."')";
		$db->query($sql);
		$data = array('domain_id'=>1,'title'=>$adminer['title'],'dir'=>$adminer['dir']);
		$data['status'] = 1;
		$data['content'] = '网站建设中';
		$data['is_default'] = 1;
		$data['tpl_id'] = 1;
		$data['url_type'] = 'default';
		$data['logo'] = 'res/201409/01/27a6e141c3d265ae.jpg';
		$data['register_status'] = 1;
		$data['login_status'] = 1;
		$data['register_close'] = '暂停注册';
		$data['login_close'] = '暂停登录';
		$data['email_charset'] = 'utf-8';
		$data['seo_title'] = '';
		$data['seo_keywords'] = '';
		$data['seo_desc'] = '';
		$data['biz_sn'] = 'prefix[P]-year-month-date-number';
		$data['currency_id'] = 1;
		$data['upload_guest'] = 0;
		$data['upload_user'] = 1;
		$db->insert_array($data,'site');
	}
	exit('ok');
}
if($step == 'ajax_iadmin'){
	include(ROOT.'config.php');
	$file = $config['db']['file'];
	$dbname = 'db_'.$file;
	$db = new $dbname($config['db']);
	$file = ROOT."data/install.lock.php";
	if(file_exists($file)){
		include($file);
		$pass_sub = rand(11,99);
		$pass = md5($adminer['pass'].$pass_sub).":".$pass_sub;
		$data = array('account'=>$adminer['user'],'pass'=>$pass,'email'=>$adminer['email']);
		$data['status'] = 1;
		$data['if_system'] = 1;
		$db->insert_array($data,'adm');
	}
	exit('ok');
}
if($step == 'ajax_clearcache'){
	unlink(ROOT."data/install.lock.php");
	exit('ok');
}
if($step == 'ajax_endok'){
	touch(ROOT."data/install.lock");
	exit('ok');
}
if($step == 'getzip2'){
	$array = array('status'=>'error','content'=>'正在执行中');
	if(!file_exists(ROOT.'phpok.zip')){
		$info = $install->curl(PHPOKFILE);
		file_put_contents(ROOT.'phpok.zip',$info);
		unset($info);
	}
	if(file_exists(ROOT.'phpok.zip') && !file_exists(ROOT.'config.php')){
		$zip = new phpzip_lib();
		$zip->unzip(ROOT.'phpok.zip',ROOT);
	}
	if(!file_exists('config.php')){
		$array['content'] = '执行操作失败，请检查';
		exit(json_encode($array));
	}
	chmod(ROOT.'config.php',0666);
	chmod(ROOT.'data/tpl_www',0777);
	chmod(ROOT.'data/tpl_admin',0777);
	chmod(ROOT.'data/tpl_html',0777);
	chmod(ROOT.'res',0777);
	$array['status'] = 'ok';
	$array['content'] = '文件获取成功';
	exit(json_encode($array));
}
?>