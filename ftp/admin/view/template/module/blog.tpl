<?php echo $header; ?>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>

  <div style="border-bottom: 1px solid #DDD; background-color: #EFEFEF; height: 40px; min-width: 900px; overflow: hidden;">
    <div style="float:left; margin-top: 10px;" >
    <img src="view/image/blog-icon.png" style="height: 21px; margin-left: 10px; " >
    </div>

<div style="margin-left: 10px; float:left; font-size: 16px; margin-top: 10px;">
<ins style="color: green; padding-top: 17px; text-shadow: 0 2px 1px #FFFFFF; padding-left: 3px; font-size: 17px; font-weight: bold;  text-decoration: none; ">
<?php echo strip_tags($heading_title); ?>
</ins> ver.: <?php echo $blog_version; ?>
</div>

    <div style=" height: 40px; float:right; background:#aceead;">
   <div style="margin-top: 2px; line-height: 18px; margin-left: 40px; margin-right: 40px; font-size: 13px; overflow: hidden;"><?php echo $this->language->get('heading_dev'); ?></div>
    </div>


</div>

<div id="content" style="border: none;">

<!--
<div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo strip_tags($breadcrumb['text']); ?></a>
  <?php } ?>
</div>
-->
<div style="clear: both; line-height: 1px; font-size: 1px;"></div>


<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>

<?php if (isset($this->session->data['success'])) {unset($this->session->data['success']);
?>
<div class="success"><?php echo $this->language->get('text_success'); ?></div>
<?php } ?>


<div class="box1">

<div class="content">

<div style="margin:5px; float:left;">
<a href="<?php echo $url_blog; ?>" class="markbutton"><div style="float: left;"><img src="view/image/blog-icon-m.png" style="" ></div><div style="float: left; margin-left: 7px; margin-top: 3px; "><?php echo $url_blog_text; ?></div></a>
<a href="<?php echo $url_record; ?>" class="markbutton"><div style="float: left;"><img src="view/image/blog-rec-m.png"  style="" ></div><div style="float: left; margin-left: 7px; margin-top: 3px; "><?php echo $url_record_text; ?></div></a>
<a href="<?php echo $url_comment; ?>" class="markbutton"><div style="float: left;"><img src="view/image/blog-com-m.png"  style="" ></div><div style="float: left; margin-left: 7px; margin-top: 3px; "><?php echo $url_comment_text; ?></div></a>
<a href="<?php echo $url_modules; ?>" class="markbutton"><div style="float: left;"><img src="view/image/blog-back-m.png"  style="" ></div><div style="float: left; margin-left: 7px; margin-top: 3px; "><?php echo $url_modules_text; ?></div></a>
</div>

<div style="margin:5px; float:right;">
   <a href="#" class="mbutton blog_save"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="mbutton"><?php echo $button_cancel; ?></a>
</div>

<div style="clear: both; line-height: 1px; font-size: 1px;"></div>

<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">

<script type="text/javascript">
function delayer(){
    window.location = 'index.php?route=module/blog&token=<?php echo $token; ?>';
}
</script>

<div id="widgets_loading" style="width: 100%; height: 24px; line-height: 24px;  background-color: #EEE; margin-bottom: 5px;">&nbsp;</div>

 <div id="tabs" class="htabs"><a href="#tab-options"><?php echo $this->language->get('tab_options'); ?></a><a href="#tab-general"><?php echo $tab_general; ?></a><a href="#tab-list"><?php echo $tab_list; ?></a></div>

  <div id="tab-options">
   <div id="create_tables" style="color: green; font-weight: bold;"></div>
    <a href="#" onclick="
		$.ajax({
			url: '<?php echo $url_create; ?>',
			dataType: 'html',
			success: function(json) {
				$('#create_tables').html(json);
				setTimeout('delayer()', 2000);
			},
			error: function(json) {
			$('#create_tables').html('error');
			}
		}); return false;" class="markbuttono" style=""><?php echo $url_create_text; ?></a>

<?php if (isset($text_update) && $text_update!='' ) { ?>
<div style="font-size: 18px; color: red;"><?php echo $text_update; ?></div>
<?php } ?>

   <table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">

    <tr>
     <td class="left"><?php echo $entry_small_dim; ?></td>
     <td class="left">
      <input type="text" name="blog_small[width]" value="<?php if (isset($blog_small['width'])) echo $blog_small['width']; ?>" size="3" />x
      <input type="text" name="blog_small[height]" value="<?php if (isset($blog_small['height'])) echo $blog_small['height']; ?>" size="3" />
     </td>
    </tr>

    <tr>
     <td class="left"><?php echo $entry_big_dim; ?></td>
     <td class="left">
      <input type="text" name="blog_big[width]" value="<?php  if (isset($blog_big['width'])) echo $blog_big['width']; ?>" size="3" />x
      <input type="text" name="blog_big[height]" value="<?php if (isset($blog_big['height'])) echo $blog_big['height']; ?>" size="3" />
     </td>
    </tr>

    <tr>
     <td class="left"><?php echo $entry_blog_num_records; ?></td>
     <td class="left">
      <input type="text" name="blog_num_records" value="<?php  if (isset($blog_num_records)) echo $blog_num_records; ?>" size="3" />
     </td>
    </tr>

    <tr>
     <td class="left"><?php echo $entry_blog_num_comments; ?></td>
     <td class="left">
      <input type="text" name="blog_num_comments" value="<?php  if (isset($blog_num_comments)) echo $blog_num_comments; ?>" size="3" />
     </td>
    </tr>

    <tr>
     <td class="left"><?php echo $entry_blog_num_desc; ?></td>
     <td class="left">
      <input type="text" name="blog_num_desc" value="<?php  if (isset($blog_num_comments)) echo $blog_num_desc; ?>" size="3" />
     </td>
    </tr>

    <tr>
     <td class="left"><?php echo $entry_blog_num_desc_words; ?></td>
     <td class="left">
      <input type="text" name="blog_num_desc_words" value="<?php  if (isset($blog_num_desc_words)) echo $blog_num_desc_words; ?>" size="3" />
     </td>
    </tr>

    <tr>
     <td class="left"><?php echo $entry_blog_num_desc_pred; ?></td>
     <td class="left">
      <input type="text" name="blog_num_desc_pred" value="<?php  if (isset($blog_num_desc_pred)) echo $blog_num_desc_pred; ?>" size="3" />
     </td>
    </tr>

 	<!--
 	<tr>
 		<td>
			<?php echo $this->language->get('entry_order_records'); ?>
		</td>
		<td>
         <select id="generallist_order"  name="generallist[order]">
           <option value="sort"  <?php if (isset($generallist['order']) &&  $generallist['order']=='sort')  { echo 'selected="selected"'; } ?>><?php echo $this->language->get('text_what_sort'); ?></option>
           <option value="latest"  <?php if (isset( $generallist['order']) &&  $generallist['order']=='latest')  { echo 'selected="selected"'; } ?>><?php echo $this->language->get('text_what_latest'); ?></option>
           <option value="popular" <?php if (isset( $generallist['order']) &&  $generallist['order']=='popular') { echo 'selected="selected"'; } ?>><?php echo $this->language->get('text_what_popular'); ?></option>
           <option value="rating" <?php if (isset( $generallist['order']) &&  $generallist['order']=='rating') { echo 'selected="selected"'; } ?>><?php echo $this->language->get('text_what_rating'); ?></option>
           <option value="comments" <?php if (isset( $generallist['order']) &&  $generallist['order']=='comments') { echo 'selected="selected"'; } ?>><?php echo $this->language->get('text_what_comments'); ?></option>
           <option value="reviews" <?php if (isset( $generallist['order']) &&  $generallist['order']=='reviews') { echo 'selected="selected"'; } ?>><?php echo $this->language->get('text_what_reviews'); ?></option>

         </select>
		</td>
	</tr>

 	<tr>
 		<td>
			<?php echo $this->language->get('entry_order_ad'); ?>
		</td>
		<td>
         <select id="generallist_order_ad"  name="generallist[order_ad]">
           <option value="desc"  <?php if (isset( $generallist['order_ad']) &&  $generallist['order_ad']=='desc') { echo 'selected="selected"'; } ?>><?php echo $this->language->get('text_what_desc'); ?></option>
           <option value="asc"   <?php if (isset( $generallist['order_ad']) &&  $generallist['order_ad']=='asc')  { echo 'selected="selected"'; } ?>><?php echo $this->language->get('text_what_asc'); ?></option>
        </select>
		</td>
	</tr>
         -->
          <tr>
              <td><?php echo $this->language->get('entry_category_status'); ?></td>
              <td><select name="generallist[category_status]">
                  <?php if ($generallist['category_status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>

          <tr>
              <td><?php echo $this->language->get('entry_cache_widgets'); ?></td>
              <td><select name="generallist[cache_widgets]">
                  <?php if ($generallist['cache_widgets']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>


            <td><?php echo $this->language->get('entry_colorbox_theme'); ?></td>
              <td>
               <select name="generallist[colorbox_theme]">
           	<?php
				foreach ($colorbox_theme as $num =>$list) {
		    ?>
                <?php if (isset($generallist['colorbox_theme']) && $generallist['colorbox_theme']==$list) { ?>
                <option value="<?php echo $list; ?>" selected="selected"><?php echo $list; ?></option>
                <?php } else { ?>
                <option value="<?php echo $list; ?>"><?php echo $list; ?></option>
                <?php } ?>

              <?php
              }
              ?>
              </select>
              </td>




    <tr>
     <td></td>
     <td></td>
    </tr>
   </table>
  </div>

  <div id="tab-general">

          <?php

      // print_r("<PRE>");
     //  print_r($modules);
       // print_r($mylist);
     //   print_r("</PRE>");

        ?>

   <table class="mytable" id="module" style="width: 100%; ">
     <thead>
      <tr>
       <td class="left"><?php echo $entry_layout; ?></td>
       <td class="left"><?php echo $entry_position; ?></td>
       <td class="left"><?php echo $entry_status; ?></td>
       <td class="right"> <?php echo $this->language->get('type_list'); ?></td>
       <td class="right"><?php echo $entry_sort_order; ?></td>
       <td style="width: 200px;"><?php echo $this->language->get('text_action'); ?></td>
      </tr>
     </thead>
        <?php
          $module_row = 0;
        ?>
        <?php foreach ($modules as $module)
        {
         while (!isset($modules[$module_row])) {          $module_row++;
         }
        ?>

          <tr id="module-row<?php echo $module_row; ?>">
            <td class="left"><?php echo $module_row; ?>&nbsp;<select name="blog_module[<?php echo $module_row; ?>][layout_id]">

                <?php foreach ($layouts as $layout) { ?>
                <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            <td class="left"><select name="blog_module[<?php echo $module_row; ?>][position]">
                <?php if ($module['position'] == 'content_top') { ?>
                <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                <?php } else { ?>
                <option value="content_top"><?php echo $text_content_top; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'content_bottom') { ?>
                <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                <?php } else { ?>
                <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_left') { ?>
                <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                <?php } else { ?>
                <option value="column_left"><?php echo $text_column_left; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_right') { ?>
                <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                <?php } else { ?>
                <option value="column_right"><?php echo $text_column_right; ?></option>
                <?php } ?>
              </select></td>
            <td class="left"><select name="blog_module[<?php echo $module_row; ?>][status]">
                <?php if ($module['status']) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>

              <td class="left">
               <select name="blog_module[<?php echo $module_row; ?>][what]">
           	<?php
				foreach ($mylist as $num =>$list) {
                   // echo $module['what']."->".$list['type']."<br>";
					if (isset($list['title_list_latest'][ $this->config->get('config_language_id')]) &&  $list['title_list_latest'][ $this->config->get('config_language_id')]!='')
					{
				     $title=$list['title_list_latest'][ $this->config->get('config_language_id')];
					}
					else
					{
					 $title="List-".$num;
					}


		    ?>
                <?php if ($module['what']==$num) { ?>
                <option value="<?php echo $num; ?>" selected="selected"><?php echo $title; ?></option>
                <?php } else { ?>
                <option value="<?php echo $num; ?>"><?php echo $title; ?></option>
                <?php } ?>

              <?php
              }
              ?>

               <?php if ($module['what']=='what_hook') { ?>
                <option value="what_hook" selected="selected"><?php echo $text_what_hook; ?></option>
                <?php } else { ?>
                <option value="what_hook"><?php echo $text_what_hook; ?></option>
                <?php } ?>
              </select>
              </td>


            <td class="right"><input type="text" name="blog_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            <td class="left">
            <?php if ($module['what']!='what_hook' ) {
            $button_class ='mbuttonr';
			}
            else
            {           	 $button_class ='markbuttono';
           	}             ?>
           <div style="float:left; width: 100px;">
             <a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="<?php echo $button_class; ?>"><?php echo $button_remove; ?></a>
           </div>

             <?php if ($button_class =='markbuttono') {

             ?>
             <div style="float:left;  width: 50%;">
             <?php
             //echo $this->language->get('hook_not_delete');
             ?>
             </div>
             <?php
            }
            ?>


          </td>
         </tr>
        <?php
         $module_row++;
        }
        ?>
        <tfoot>
          <tr>
            <td colspan="5"></td>
            <td class="left"><a onclick="addModule();" class="markbutton"><?php echo $button_add_module; ?></a></td>
          </tr>
        </tfoot>
      </table>

    </div>

<?php
if (count($mylist)<1) {	$msql                = "INSERT INTO `" . DB_PREFIX . "setting` ( `store_id`, `group`, `key`, `value`, `serialized`) VALUES
	(0, 'blog', 'mylist', 'a:1:{i:2;a:5:{s:4:\"type\";s:5:\"blogs\";s:17:\"title_list_latest\";a:3:{i:1;s:4:\"Blog\";i:2;s:0:\"\";i:3;s:0:\"\";}s:6:\"avatar\";a:2:{s:5:\"width\";s:2:\"50\";s:6:\"height\";s:2:\"50\";}s:8:\"template\";s:0:\"\";s:5:\"blogs\";a:1:{i:0;s:1:\"1\";}}}', 1);
	";
	$query               = $this->db->query($msql);
}
?>

<div id="tab-list">
	<div id="lists">
		<div id="mytabs" class="vtabs"><a href="#mytabs_add" style="color: #FFF; background: green; "><img src="view/image/madd.png" style="height: 16px; margin-right: 7px;" ><?php echo $this->language->get('text_add'); ?></a></div>


<div id="mytabs_add" style="">

<div style="float: left;">
 <?php
	             echo $this->language->get('type_list');
	       ?>


         <select id="mylist-what"  name="mylist-what">
                <option value="blogs"><?php echo $text_what_blog; ?></option>
                <option value="blogsall"><?php echo $this->language->get('text_what_blogsall'); ?></option>
                <option value="latest"><?php echo $this->language->get('text_widget_latest'); ?></option>
                <option value="records"><?php echo $this->language->get('text_widget_records'); ?></option>
                <option value="html"><?php echo $this->language->get('text_what_html'); ?></option>
                <option value="treecomments"><?php echo $this->language->get('text_widget_treecomments'); ?></option>
                <option value="reviews"><?php echo $this->language->get('text_widget_reviews'); ?></option>
                <option value="related"><?php echo $this->language->get('text_widget_related'); ?></option>
                <option value="loader"><?php echo $this->language->get('text_widget_loader'); ?></option>

         </select>
         </div>
      <div class="buttons" style="margin-left: 10px; float: left;"><a onclick="
      mylist_num++;
      type_what = $('#mylist-what :selected').val();
 		$.ajax({
					url: 'index.php?route=module/blog/ajax_list&token=<?php echo $token; ?>',
					type: 'post',
					data: { type: type_what, num: mylist_num },
					dataType: 'html',
					beforeSend: function()
					{

					},
					success: function(html) {
						if (html) {
							$('#mytabs').append('<a href=\'#mytabs' + mylist_num + '\' id=\'amytabs'+mylist_num+'\'>List-' + mylist_num + '<\/a>');
							$('#lists').append('<div id=\'mytabs'+mylist_num+'\'>'+html+'<\/div>');
							$('#mytabs a').tabs();
							$('#amytabs' + mylist_num).click();
						}
						$('.mbutton').removeClss();


					}
				});


      return false; " class="markbutton"><?php echo $this->language->get('button_add_list'); ?></a>
      </div>
   </div>

	</div>


	<?php

	if (count($mylist)>0)
	{
	reset($mylist);
	$first_key = key($mylist);

	$ki=0;
	foreach ($mylist as $num =>$list) {
	$ki++;
	$slist = serialize($list);

	if (isset($list['title_list_latest'][ $this->config->get('config_language_id')]) &&  $list['title_list_latest'][ $this->config->get('config_language_id')]!='')
	{
     $title=$list['title_list_latest'][ $this->config->get('config_language_id')];
	}
	else
	{	 $title="List-".$num;
	}


	?>
	<script type="text/javascript">

	 form_submit = function() {		$('#form').submit();
		return false;
	}

	var mylist_num=<?php echo $num; ?>;
		$('#mytabs').append('<a href=\"#mytabs<?php echo $num; ?>\" id=\"amytabs<?php echo $num; ?>\"><?php echo $title; ?><\/a>');
    var progress_num = 0;
    var allcount = <?php echo (count($mylist)); ?>;
		$.ajax({
					url: 'index.php?route=module/blog/ajax_list&token=<?php echo $token; ?>',
					type: 'post',
					async: true,
					data: { list: '<?php echo base64_encode($slist); ?>', num: '<?php echo $num; ?>' },
					dataType: 'html',
					beforeSend: function() {
					 $('a.mbutton').addClass('loader');
					 $('.blog_save').unbind('click');

					},
					success: function(html) {
						if (html) {							$('#lists').append('<div id=\"mytabs<?php echo $num; ?>\">'+html+'<\/div>');
							$('#mytabs a').tabs();
							$('#amytabs<?php echo $first_key; ?>').click();
						}
						<?php if (count($mylist)<=$ki) {  ?>
						$('a.mbutton').removeClass('loader');
						$('.blog_save').bind('click', form_submit);
						$('#widgets_loading').hide();
						<?php } ?>

						<?php
						$loading_recent = round((100*$num)/count($mylist));
						?>
						progress_num++;
						loading_recent = Math.round((100*progress_num)/allcount);

                        $('#widgets_loading').html('<div style=\"height: 24px; line-height: 24px; text-align: center; width:'+loading_recent+'%; color: white;background-color: orange;\">'+loading_recent+'%<\/div>');

					}
				});

		</script>
	<?php

	 }



	}
	else
	{     ?>
     	<script type="text/javascript">
	var mylist_num=0;
        </script>
     <?php
	} ?>

</div>
</div>

    </form>
     <div style="clear: both; line-height: 1px; font-size: 1px;"></div>
      <div class="buttons right" style="margin-top: 20px;float: right;"><a href="#" class="mbutton blog_save"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="mbutton"><?php echo $button_cancel; ?></a></div>

  </div>

  </div>
</div>


<script type="text/javascript">
$('#tabs a').tabs();
</script>

<script type="text/javascript">
var amodule_row = Array();

<?php
 foreach ($modules as $indx => $module) {
?>
amodule_row.push(<?php echo $indx; ?>);
<?php
}
?>
var module_row = <?php echo $module_row; ?>;

function addModule() {	var aindex = -1;
	for(i=0; i<amodule_row.length; i++) {	 flg = jQuery.inArray(i, amodule_row);
	 if (flg == -1) {	  aindex = i;
	 }
	}
	if (aindex == -1) {
	  aindex = amodule_row.length;
	}
	module_row = aindex;
	amodule_row.push(aindex);

	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="left">'+module_row+'&nbsp;<select name="blog_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><select name="blog_module[' + module_row + '][position]">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    <td class="left"><select name="blog_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';


	html += '    <td class="left"><select name="blog_module[' + module_row + '][what]">';

    <?php
	if (count($mylist)>0) {
  	 foreach ($mylist as $num =>$list) {
					if (isset($list['title_list_latest'][ $this->config->get('config_language_id')]) &&  $list['title_list_latest'][ $this->config->get('config_language_id')]!='')
					{
				     $title=$list['title_list_latest'][ $this->config->get('config_language_id')];
					}
					else
					{
					 $title="List-".$num;
					}

		    ?>
	html += '        <option value="<?php echo $num; ?>"><?php echo $title; ?></option>';
	<?php
	 }
	}
	 ?>

	html += '      <option value="what_hook"><?php echo $text_what_hook; ?></option>';
	html += '    </select></td>';





	html += '    <td class="right"><input type="text" name="blog_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="mbuttonr"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';

	$('#module tfoot').before(html);

	module_row++;
}
</script>

<script type="text/javascript">
$('input[name=\'record\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/record/autocomplete&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.record_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name=\'record\']').val(ui.item.label);
		$('input[name=\'record_id\']').val(ui.item.value);

		return false;
	}
});
 </script>


</div>

<?php echo $footer; ?>