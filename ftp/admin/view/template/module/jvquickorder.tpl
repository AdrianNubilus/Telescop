<?php echo $header; ?>
<div id="content">

	<div class="breadcrumb">
	  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
	  <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
	  <?php } ?>
	</div>
	
	<?php if ($error_warning) { ?>
	<div class="warning"><?php echo $error_warning; ?></div>
	<?php } ?>
	
	<div class="box"> 
	
	  <div class="heading">
		<h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
		<div class="buttons">
			<a onclick="sav_con()" class="button"><span><?php echo $button_save_stay; ?></span></a>
			<a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a>
			<a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a>
		</div>
	  </div>
	  
	  <div class="content">		
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">		  						
			<div id="settings" class="htabs">
					<a href="#tab-common">
						<?php echo $tab_text_common; ?>
					</a>
					
					<a href="#tab-appearance">
						<?php echo $tab_text_appearance; ?>
					</a>
					
					<a href="#tab-fields">
						<?php echo $tab_text_fields; ?>
					</a>
					
					<a href="#tab-email">
						<?php echo $tab_text_email; ?>
					</a>
					
					<a href="#tab-order">
						<?php echo $tab_text_order; ?>
					</a>
					
					<a href="#tab-system-settings">
						<?php echo $tab_text_system_settings; ?>
					</a>
					
			</div>
			
			<div id="tab-common">
				<table class="form">
				  <tr>
					<td>
						<h3><?php echo $entry_offon; ?></h3>
					</td>
					
					<td class="left">
						<select name="jvquickorder_status">
						<?php if ($jvquickorder_status == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
				  
				  <tr>
					<td><?php echo $entry_work_in_categories; ?></td>
					<td>
					<div class="scrollbox">
					  <?php $class = 'odd'; ?>
					  <?php foreach ($categories as $category) { ?>				  
						  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
						  <div class="<?php echo $class; ?>"> 					
							<?php if (isset($config_var_category[$category['category_id']]) && ($category['category_id'] == $config_var_category[$category['category_id']])) { ?>						
							<input type="checkbox" name="config_var_category[<?php echo $category['category_id']; ?>]" value="<?php echo $category['category_id']; ?>" checked="checked" />
							
							<a href="<?php echo $category['href']; ?>" target="_blank"><?php echo $category['name']; ?></a>
													
							<?php } else { ?>
							<input type="checkbox" name="config_var_category[<?php echo $category['category_id']; ?>]" value="<?php echo $category['category_id']; ?>" />
							
							<a href="<?php echo $category['href']; ?>" target="_blank"><?php echo $category['name']; ?></a>
							
							<?php } ?>
						  </div>
					  <?php } ?>
					</div>
					<a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
					</td>
				  </tr>
				  
				  <tr>
					<td>
						<?php echo $entry_in_stock; ?>
					</td>
					
					<td class="left">
						<select name="consider_in_stock">
						<?php if ($consider_in_stock == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
  
				</table>
			</div>
			
			<div id="tab-appearance">
				<table class="form">

				  <tr>
					<td>
						<?php echo $entry_show_product_name_price; ?>
					</td>
					
					<td class="left">
						<select name="show_product_name_price">
						<?php if ($show_product_name_price == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
				  
				  <tr>
					<td>
						<?php echo $entry_show_product_desc; ?>
					</td>
					
					<td class="left">
						<select name="show_product_desc">
						<?php if ($show_product_desc == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
				  
				  <tr>
					<td>
						<?php echo $entry_show_product_images; ?>
					</td>
					
					<td class="left">
						<select name="show_product_images">
						<?php if ($show_product_images == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
				  
				  <tr>
					<td>
						<?php echo $entry_type_product_images; ?>
					</td>
					
					<td class="left">						
						<select name="type_product_images" >
							<?php foreach($type_product_images_option as $key => $value) { ?>
								<option value="<?php echo $key;?>" <?php if ($type_product_images == $key) { echo " selected"; }?> >
									<?php echo $value;?>
								</option>
							<?php } ?>
						</select>
					</td>				
				  </tr>  
				  
				  <tr>
					<td><?php echo $entry_title_before_form; ?></td>
					<td>
						<?php foreach ($languages as $language) { ?>
						  <input type="text" name="title_before_form[<?php echo $language['language_id']; ?>]" value="<?php echo isset($title_before_form[$language['language_id']]) ? $title_before_form[$language['language_id']] : ''; ?>"  size="100" />
						  &nbsp;<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br /><br />
						<?php } ?>
					</td>
				  </tr>
				  
				  <tr>
					  <td><?php echo $entry_text_before_form; ?></td>
					  
					  <td>
						  <div id="language" class="htabs">
							<?php foreach ($languages as $language) { ?>
								<a href="#tab-language-<?php echo $language['language_id']; ?>">
									<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> 
									<?php echo $language['name']; ?>
								</a>
							<?php } ?>
						  </div>
						  
						  <?php foreach ($languages as $language) { ?>
						  <div id="tab-language-<?php echo $language['language_id']; ?>">						
								<textarea rows="8" cols="100" name="text_before_form[<?php echo $language['language_id']; ?>]" id="description-<?php echo $language['language_id']; ?>"><?php echo isset($text_before_form[$language['language_id']]) ? $text_before_form[$language['language_id']] : ''; ?>
								</textarea>		  			
						  </div>
						  <?php } ?>	
					  </td>		
				  </tr>
				  
				  <tr >
					<td style="padding-bottom: 20px;">
					</td>
					
					<td>
					</td>
				  </tr>
				  
				  <tr>
					<td>
						<?php echo $entry_show_popover; ?>
					</td>
					
					<td class="left">
						<select name="show_popover">
						<?php if ($show_popover == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
				
				  <tr>
					<td>
						<?php echo $entry_colour_button_quickorder; ?>
					</td>
					
					<td class="left">						
						<select name="type_colour_button_quickorder" >
							<?php foreach($colour_button_quickorder_option as $key => $value) { ?>
								<option value="<?php echo $key;?>" <?php if ($type_colour_button_quickorder == $key) { echo " selected"; }?> >
									<?php echo $value;?>
								</option>
							<?php } ?>
						</select>
					</td>				
				  </tr>
				</table>
			</div>	
			
			<div id="tab-fields">
				<table class="form">

				  <tr>
					<td>
						<h3><?php echo $entry_field_user_name_title; ?></h3>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_user_name_show; ?>
					</td>
					
					<td class="left">
						<select name="field_user_name_show">
						<?php if ($field_user_name_show == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_user_name_required; ?>
					</td>
					
					<td class="left">
						<select name="field_user_name_required">
						<?php if ($field_user_name_required == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>	


				  <tr>
					<td>
						<h3><?php echo $entry_field_user_phone_title; ?></h3>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_user_phone_show; ?>
					</td>
					
					<td class="left">
						<select name="field_user_phone_show">
						<?php if ($field_user_phone_show == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_user_phone_required; ?>
					</td>
					
					<td class="left">
						<select name="field_user_phone_required">
						<?php if ($field_user_phone_required == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>	
				  
				  <tr> 
					<td>
						<?php echo $entry_field_user_phone_maskedinput; ?>
					</td>
					
					<td class="left">
						<input type="text" name="field_user_phone_maskedinput" value="<?php echo $field_user_phone_maskedinput; ?>"  size="30" />
					</td>				
				  </tr>
				  
				  
				  <tr>
					<td>
						<h3><?php echo $entry_field_email_title; ?></h3>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_email_show; ?>
					</td>
					
					<td class="left">
						<select name="field_email_show">
						<?php if ($field_email_show == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_email_required; ?>
					</td>
					
					<td class="left">
						<select name="field_email_required">
						<?php if ($field_email_required == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>				  
				  
				  <tr>
					<td>
						<h3><?php echo $entry_field_comment_title; ?></h3>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_comment_show; ?>
					</td>
					
					<td class="left">
						<select name="field_comment_show">
						<?php if ($field_comment_show == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_comment_required; ?>
					</td>
					
					<td class="left">
						<select name="field_comment_required">
						<?php if ($field_comment_required == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>				  
				  
				  <tr> 
					<td></td>
					<td></td>				
				  </tr>				  
				  
				  <tr>
					<td>
						<h3><?php echo $entry_field_product_quantity_title; ?></h3>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_product_quantity_show; ?>
					</td>
					
					<td class="left">
						<select name="field_product_quantity_show">
						<?php if ($field_product_quantity_show == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_product_quantity_required; ?>
					</td>
					
					<td class="left">
						<select name="field_product_quantity_required">
						<?php if ($field_product_quantity_required == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>	
				  
				</table>
			</div>
			
			<div id="tab-email">
				<table class="form">

				  <tr>
					<td>
						<?php echo $entry_send_email_status; ?>
					</td>
					
					<td class="left">
						<select name="send_email_status">
						<?php if ($send_email_status == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
						</select>
						
					</td>
				  </tr>	
				
				  <tr>
					<td>
						<?php echo $entry_type_email; ?>
					</td>
					
					<td class="left">						
						<select name="type_email" >
							<?php foreach($type_email_option as $key => $value) { ?>
								<option value="<?php echo $key;?>" <?php if ($type_email == $key) { echo " selected"; }?> >
									<?php echo $value;?>
								</option>
							<?php } ?>
						</select>
						
					</td>
				  </tr>
				  
				  <tr>
					<td>
						<?php echo $entry_offon_email_admin; ?>
					</td>
					
					<td class="left">
						<select name="offon_email_admin">
						<?php if ($offon_email_admin == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
						</select>
					</td>
				  </tr>
				  
				  <tr>
					<td>
						<?php echo $entry_offon_email_additional; ?>
					</td>
					
					<td class="left">
						<textarea rows="5" cols="40" name="email_additional"><?php echo $email_additional; ?></textarea>
					</td>
				  </tr>
				  
				  <tr>
					<td>
						<?php echo $entry_offon_email_customer; ?>
					</td>
					
					<td class="left">
						<select name="offon_email_customer">
						<?php if ($offon_email_customer == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
						</select>
					</td>
				  </tr>
				  
				</table>
			</div>	

			<div id="tab-order">
				<table class="form">
				
				  <tr>
					<td>
						<?php echo $entry_order_offon; ?>
					</td>
					
					<td>
						<select name="order_offon">
						<?php if ($order_offon == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
						</select>
					</td>
				  </tr>	
				  
				  <tr>
					<td>
						<?php echo $entry_order_name_in_admin; ?>
					</td>
					
					<td>
						<input type="text" name="order_name_in_admin" value="<?php echo $order_name_in_admin; ?>"  size="30" />
					</td>
				  </tr>

				  <tr>
					<td><?php echo $entry_order_status; ?></td>
					<td><select name="order_order_status_id">
						<?php foreach ($order_statuses as $order_status) { ?>
						<?php if ($order_status['order_status_id'] == $order_order_status_id) { ?>
						<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
						<?php } ?>
						<?php } ?>
					  </select></td>
				  </tr>		
				
				</table>
			</div>
			
			<div id="tab-system-settings">	
				<table class="form">
				  <tr>
					<td>
						<?php echo $entry_del_system_css_on_show; ?>
					</td>
					
					<td class="left">
						<select name="del_system_css_on_show">
						<?php if ($del_system_css_on_show == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
						</select>
					</td>
				  </tr>			  
				</table>					
			</div>
		</form>
	  </div>
	</div>
</div>


<script type="text/javascript"><!--
$(document).ready(function(){
		$('#settings a').tabs();
		$('#language a').tabs();
	});
//--></script>

<script type="text/javascript"><!--
function sav_con(){
	$('#form').append('<input type="hidden" id="save_continue" name="save_continue" value="1"  />');
	$('#form').submit();
}
//--></script>

<?php echo $footer; ?>