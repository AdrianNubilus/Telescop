<!-- // for the lazy. no need to thanks. no offense, i wanted to help them :) -->
<?php if ($captcha_status) { ?>
<div class="captcha_title"><?php echo $entry_captcha_title; ?>&nbsp;&darr;</div>
<div class="entry_captcha"><?php echo $entry_captcha; ?></div>

<div class="height30">
<img src="<?php echo $captcha_filename; ?>" alt="captcha" id="imgcaptcha" class="captcha_img">
<input type="text" name="captcha" value="" id="captcha_fun" class="captcha captchainput captcha_img" maxlength="5" size="5">
</div>

<div>
	<div class="floatleft align_center">
	 <a href="" class="captcha_update"><?php echo $entry_captcha_update; ?></a>
	</div>

	<div class="captcha_left">
	<?php
 	for ($i=0; $i<strlen($captcha_keys); $i++) { ?><input type="button" class="bkey width24" value='<?php echo $captcha_keys[$i];?>'><?php }  ?>
 	</div>
</div>


<script type="text/javascript">
$(document).ready(function(){
	$('.bkey').bind('click', subcaptcha);

$('#imgcaptcha').attr('src', '<?php if (isset($captcha_filename)) echo $captcha_filename; ?>').load(function() {
       $.ajax({
			type: 'POST',
			url: 'index.php?route=record/record/captchadel',
			dataType: 'html',
		   	success: function(data)
		    {
		    }
	  });
});



     	// wait for the image captcha, for, because may not see captcha image
     	//var pic = new Image();
		//pic.src = '<?php if (isset($captcha_filename)) echo $captcha_filename; ?>' ;
		//$(pic).load(function()	{
        //    $.ajax({
		//	type: 'POST',
		//	url: 'index.php?route=record/record/captchadel',
		//	dataType: 'html',
		//   	success: function(data)
		//    {
		//    }
	 // });
	//});

$('.captcha_update').click(function() {
 captcha_fun();
 return false;
});

});
</script>
<?php } ?>