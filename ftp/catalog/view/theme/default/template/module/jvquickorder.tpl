<script type="text/javascript">
	var 
		main_stylesheet, 
		stylesheet_ie6,
		stylesheet_ie7;
		
	$(document).ready(function(){	
		$('#myModal').on('hide', function () {
			//$('#myModal').addClass('fade');	
		})
		
		//Это событие срабатывает после скрытия всплывающего элемента и окончания анимации.
		$('#myModal').on('hidden', function () {
			<?php if ( $del_system_css_on_show =='1' ) { ?>
				main_stylesheet.appendTo('head');
				stylesheet_ie6.appendTo('head');
				stylesheet_ie7.appendTo('head');
			<?php } ?>
			
			$("link[href$='bootstrap-min.css']").remove();
			$('#myModal').remove();
		});
		
		$('#myModal').on('show', function () {
			<?php if ( $del_system_css_on_show =='1' ) { ?>
				main_stylesheet = $("link[href$='stylesheet.css']").detach();
				stylesheet_ie6 = $("link[href$='ie6.css']").detach();
				stylesheet_ie7 = $("link[href$='ie7.css']").detach();
			<?php } ?>	
		});
	});
</script>

<div id="myModal" class="bt_modal" style="top: 45%; width: 535px;" >
	<div class="bt_modal-header">
	  <button class="close" data-dismiss="bt_modal">&times;</button>
	  <div class="bt_h3">
		<?php echo $heading_title; ?>
	  </div>
	</div>
	
	<div class="bt_modal-body" style="max-height: 430px;"> 	  
	  <div class="row">
		  <div class="span4">
			<?php if ($show_product_name_price == '1') { ?>
				<div class="bt_h3">
					<a href="<?php echo $product['href']; ?>" style="font-size: inherit; line-height: inherit; color: #0088CC;"><?php echo $product['name']; ?></a> - <?php echo $product['price']; ?>
				</div>
			<?php } ?>
			
			<?php if ($show_product_desc == '1') { ?>
				<div class="bt_p" rel="popover" data-content="<?php echo $product['description']; ?>" data-original-title="<?php echo $hint_description_heading_text; ?>">
					<?php echo $product['shortdescription']; ?> 
				</div>		
			<?php } ?>	
		  </div>
			
		  <?php if ($product['thumb']) { ?>	
			  <div class="span2">
				<?php if ($show_product_images == '1') { ?>
					
					<?php if ($type_product_images == 'type_product_images_carousel') { ?>
						<div id="myCarousel" class="carousel slide">
							<!-- Картинки в карусельке -->
							<div class="carousel-inner">
								<div class="active item">
									<img alt="<?php echo $product['name']; ?>" src="<?php echo $product['thumb']; ?>">
								</div>			
								<?php if ($images) { ?>
									<?php foreach ($images as $result) { ?>
										<div class="item">
											<img alt="<?php echo $product['name']; ?>" src="<?php echo $result['thumb']; ?>">
										</div>
									<?php } ?>
								<?php } ?>
							</div>
						</div>
					<?php } ?>
					
					
					<?php if ($type_product_images == 'type_product_images_oneimage') { ?>
						<div class="thumbnail">
							<img alt="<?php echo $product['name']; ?>" src="<?php echo $product['thumb']; ?>">
						</div>
					<?php } ?>

				<?php } ?>
			  </div>
		  <?php } ?>	  
	  </div>	  
	
	  <div class="bt_h4"><?php echo $title_before_form; ?></div>
	  <div class="bt_p"><?php echo $text_before_form; ?></div>
	  <!--
	  <?php if ($options) { ?>
		<div class="options">
			<h2><?php echo $text_option; ?></h2>
			<br />
			
			<?php foreach ($options as $option) { ?>
			
				<?php if ($option['type'] == 'select') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <select name="option[<?php echo $option['product_option_id']; ?>]">
						<option value=""><?php echo $text_select; ?></option>
						<?php foreach ($option['option_value'] as $option_value) { ?>
						<option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
						<?php if ($option_value['price']) { ?>
						(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
						<?php } ?>
						</option>
						<?php } ?>
					  </select>
					</div>
					<br />
				<?php } ?>
			
				<?php if ($option['type'] == 'radio') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <?php foreach ($option['option_value'] as $option_value) { ?>
					  <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
					  <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
						<?php if ($option_value['price']) { ?>
						(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
						<?php } ?>
					  </label>
					  <br />
					  <?php } ?>
					</div>
					<br />
				<?php } ?>
				
				<?php if ($option['type'] == 'checkbox') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <?php foreach ($option['option_value'] as $option_value) { ?>
					  <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
					  <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
						<?php if ($option_value['price']) { ?>
						(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
						<?php } ?>
					  </label>
					  <br />
					  <?php } ?>
					</div>
					<br />
				<?php } ?>
				
				<?php if ($option['type'] == 'image') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <table class="option-image">
						<?php foreach ($option['option_value'] as $option_value) { ?>
						<tr>
						  <td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
						  <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
						  <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
							  <?php if ($option_value['price']) { ?>
							  (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
							  <?php } ?>
							</label></td>
						</tr>
						<?php } ?>
					  </table>
					</div>
					<br />
				<?php } ?>
				
				<?php if ($option['type'] == 'text') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
					</div>
					<br />
				<?php } ?>
				
				<?php if ($option['type'] == 'textarea') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
					</div>
					<br />
				<?php } ?>
				
				<?php if ($option['type'] == 'file') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>" class="button">
					  <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
					</div>
					<br />
				<?php } ?>
				
				<?php if ($option['type'] == 'date') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
					</div>
					<br />
				<?php } ?>
				
				<?php if ($option['type'] == 'datetime') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
					</div>
					<br />
				<?php } ?>
				
				<?php if ($option['type'] == 'time') { ?>
				<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
				  <?php if ($option['required']) { ?>
				  <span class="required">*</span>
				  <?php } ?>
				  <b><?php echo $option['name']; ?>:</b><br />
				  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
				</div>
				<br />
			<?php } ?>
			
			<?php } ?>
		</div>
      <?php } ?>
	  -->
	  
		<form class="form-horizontal" id="jv_quickorder" method='post'>
			<fieldset>
				<legend><?php echo $legend_text; ?></legend>
					
					<?php if ( $field_user_name_show =='1' ) { ?>
						<div class="control-group input-prepend">
							<label class="control-label" for="user_name" style="cursor: inherit;"><h4><?php echo $label_name_text; ?></h4></label>
							<div class="controls">
								<span class="add-on">
									<i class="icon-user"></i>
								</span><input type="text" value="<?php echo $FullName; ?>" class="input-xlarge" id="user_name" rel="popover" name="user_name" placeholder="<?php echo $hint_name_descr_text; ?>" data-content="<?php echo $hint_name_descr_text; ?>" data-original-title="<?php echo $hint_name_heading_text; ?>" />
							</div>
						</div>
					<?php } ?>
					
					<?php if ( $field_user_phone_show =='1' ) { ?>
						<div class="control-group input-prepend">
							<label class="control-label" for="user_phone" style="cursor: inherit;"><h4><?php echo $label_phone_text; ?></h4></label>
							<div class="controls">
								<span class="add-on">
									<i class="icon-pencil"></i>			
								</span><input type="text" class="input-xlarge" id="user_phone" rel="popover" name="user_phone" placeholder="<?php echo $placeholder_phone_text; ?>"  data-content="<?php echo $hint_phone_descr_text; ?>" data-original-title="<?php echo $hint_phone_heading_text; ?>" />
							</div>
						</div>
					<?php } ?>
					
					<?php if ( $field_email_show =='1' ) { ?>
						<div class="control-group input-prepend">
							<label class="control-label" for="user_email" style="cursor: inherit;"><h4><?php echo $label_email_text; ?></h4></label>
							<div class="controls">
							<span class="add-on">
								<i class="icon-envelope"></i>
							</span><input type="text" value="<?php echo $Email; ?>" class="input-xlarge" id="user_email" rel="popover" name="user_email" placeholder="<?php echo $placeholder_email_text; ?>" data-content="<?php echo $hint_email_descr_text; ?>" data-original-title="<?php echo $hint_email_heading_text; ?>" />
							</div>
						</div>
					<?php } ?>
					
					<?php if ( $field_comment_show =='1' ) { ?>
						<div class="control-group input-prepend">
							<label class="control-label" for="user_comment" style="cursor: inherit;"><h4><?php echo $label_comment_text; ?></h4></label>
							<div class="controls">
								<span class="add-on">
									<i class="icon-comment"></i>			
								</span><textarea rows="1" class="input-xlarge" id="user_comment" rel="popover" name="user_comment" placeholder="<?php echo $placeholder_comment_text; ?>"  data-content="<?php echo $hint_comment_descr_text; ?>" data-original-title="<?php echo $hint_comment_heading_text; ?>"></textarea>
							</div>
						</div>
					<?php } ?>
					
					<?php if ( $field_product_quantity_show =='1' ) { ?>
						<div class="control-group input-prepend">
							<label class="control-label" for="order_product_quantity" style="cursor: inherit;">
								<h4><?php echo $label_product_quantity_text; ?></h4>
							</label>
							<div class="controls">
								<span class="add-on">
									<i class="icon-shopping-cart"></i>
								</span><input type="text" value="<?php echo $product['minimum']; ?>" class="input-xlarge" id="order_product_quantity" rel="popover" name="order_product_quantity" placeholder="<?php echo $placeholder_product_quantity_text; ?>" data-content="<?php echo $hint_product_quantity_descr_text; ?>" data-original-title="<?php echo $hint_product_quantity_heading_text; ?>" />
							</div>
						</div>
					<?php } ?>
					
					<input type="hidden" name="version" value="<?php echo $version; ?>" />				
			</fieldset>			
		</form>		
	</div>
	
	<div class="bt_modal-footer">
	  <?php $myrandom = rand(); ?>
	  <button id="button_order<?php echo $myrandom; ?>"  class="btn btn-large <?php echo $type_colour_button_quickorder; ?>" rel="tooltip"><?php echo $button_order_text; ?></button>
	</div>
</div>

<script type="text/javascript">
	function is_undefined(val){
	  if(typeof(val)  === 'undefined') {
		return ''
		}
	  else
	    return val;
	}

	var myvalidator;
	
	<?php if ( $show_popover =='1' ) { ?>
	$(document).ready(function(){
		$('input').hover(function(){
			$(this).popover('show')
		});
		
		$('.bt_p').hover(function(){
			$(this).popover({
				placement: 'left',
				animation: true
			});
			$(this).popover('show')
		});
	});
	<?php } ?>

	<?php if ( ($show_product_images == '1') && ($type_product_images == 'type_product_images_carousel') ) { ?>
		$(document).ready(function(){	
			$('.carousel').carousel({
				interval: 2000,
				pause: "hover"
			})
		});
	<?php } ?>
	
	
	$(document).ready(function(){	
		$("#jv_quickorder #user_phone").mask('<?php echo $field_user_phone_maskedinput; ?>');	
	});
	
	$(document).ready(function(){	
		myvalidator = $('#jv_quickorder').validate({		
			focusInvalid: true,
			errorClass: "help-inline",
			errorElement: "span",
			//errorClass: "error",
			//validClass: "success", 
			highlight:function(element, errorClass, validClass) {
				$(element).parents('.control-group').removeClass('bt_success');
				$(element).parents('.control-group').addClass('bt_error');
			},
			unhighlight: function(element, errorClass, validClass) {
				$(element).parents('.control-group').removeClass('bt_error');
				$(element).parents('.control-group').addClass('bt_success');
			}
		});
		
		<?php if ( ($field_user_name_show =='1') && ($field_user_name_required == '1') ) { ?>
			$("#jv_quickorder #user_name").rules("add", {
				required: true,
				
				messages: {
					required: "<?php echo $error_name_descr_text; ?>"
				}
			});
		<?php } ?>

		<?php if ( $field_user_phone_show =='1' ) { ?>
			$("#jv_quickorder #user_phone").rules("add", {
				rangelength: [5, 25],
				//digits: true,
				
				messages: {
					rangelength:"<?php echo $error_rangelengthphone_descr_text; ?>",
					digits: "<?php echo $error_digitsphone_descr_text; ?>"
				}
			});
		<?php } ?>
		
		<?php if ( ($field_user_phone_show =='1') && ($field_user_phone_required == '1') ) { ?>
			$("#jv_quickorder #user_phone").rules("add", {
				required: true,
				rangelength: [5, 25],
				//digits: true,
			
				messages: {
					required:"<?php echo $error_phone_descr_text; ?>",
					rangelength:"<?php echo $error_rangelengthphone_descr_text; ?>",
					digits: "<?php echo $error_digitsphone_descr_text; ?>"
				}
			});
		<?php } ?>

		
		<?php if ( ($field_email_show =='1') && ($field_email_required == '1') ) { ?>
			$("#jv_quickorder #user_email").rules("add", {
				required: true,
				email: true,
				
				messages: {
					required: "<?php echo $error_email_descr_text; ?>",
					email:"<?php echo $error_validemail_descr_text; ?>"
				}
			});
		<?php } ?>
		
		<?php if ( ($field_comment_show =='1') && ($field_comment_required == '1') ) { ?>
			$("#jv_quickorder #user_comment").rules("add", {
				required: true,
				rangelength: [5, 400],
			
				messages: {
					required:"<?php echo $error_comment_descr_text; ?>",
					rangelength:"<?php echo $error_rangelengthcomment_descr_text; ?>"
				}
			});
		<?php } ?>
		
		<?php if ( $field_product_quantity_show =='1' ) { ?>
			$("#jv_quickorder #order_product_quantity").rules("add", {
				min: <?php echo $product['minimum']; ?>,
				<?php if ($consider_in_stock) { ?>
					<?php if (!$config_stock_checkout) { ?>
						max: <?php echo $product['quantity']; ?>,
					<?php } ?>
				<?php } ?>	
				digits: true,
				
				messages: {
					min:"<?php echo $error_min_prod_quantity_descr_text; ?>",
					<?php if ($consider_in_stock) { ?>
						<?php if (!$config_stock_checkout) { ?>
							max:"<?php echo $error_max_prod_quantity_descr_text; ?>",
						<?php } ?>
					<?php } ?>	
					digits: "<?php echo $error_digits_prod_quantity_descr_text; ?>"
				}
			});
		<?php } ?>
		
		<?php if ( ($field_product_quantity_show =='1') && ($field_product_quantity_required == '1') ) { ?>
			$("#jv_quickorder #order_product_quantity").rules("add", {
				required: true,
				min: <?php echo $product['minimum']; ?>,
				<?php if ($consider_in_stock) { ?>
					<?php if (!$config_stock_checkout) { ?>
						max: <?php echo $product['quantity']; ?>,
					<?php } ?>
				<?php } ?>	
				digits: true,
			
				messages: {
					required:"<?php echo $error_product_quantity_descr_text; ?>",
					min:"<?php echo $error_min_prod_quantity_descr_text; ?>",
					<?php if ($consider_in_stock) { ?>
						<?php if (!$config_stock_checkout) { ?>
							max:"<?php echo $error_max_prod_quantity_descr_text; ?>",
						<?php } ?>
					<?php } ?>	
					digits: "<?php echo $error_digits_prod_quantity_descr_text; ?>"
				}
			});
		<?php } ?>
	});
	
	function successmessage_in_full_body(heading_text, body_text){
		$('.bt_modal-body').empty();
		$('.bt_modal-footer').remove();
		
		$('.alert').alert();
		$('.bt_modal-body').html('<div class="alert alert-success alert-block fade in">' + 
									'<a class="close" data-dismiss="alert" href="#">×</a>' +
									'<div class="alert-heading bt_h3">' + heading_text + '<br /><br />' + 
									'<strong>' + body_text + '</strong><div>');	
		setTimeout(
			function(){
						$('#myModal').bt_modal('hide')
			}, 
			5000
		);
		
	    return false;
	}
	
	function errormessage_in_full_body(heading_text, body_text){
		$('.bt_modal-body').empty();
		$('.bt_modal-footer').remove();
		$('.alert').remove();

		$('.alert').alert();
		$('.bt_modal-body').prepend('<div class="alert  alert-block fade in">' + 
									'<a class="close" data-dismiss="alert" href="#">×</a>' +
									'<div class="alert-heading bt_h3">' + heading_text + '</div><br /><br />' + 
									'<strong>' + body_text + '</strong><div>');	
		setTimeout(
			function(){
				$('#myModal').bt_modal('hide')
			}, 
			5000
		);
	
	    return false;
	}
	
	function errormessage_in_body(heading_text, body_text){
		$('.alert').remove();

		$('.alert').alert();
		$('.bt_modal-body').prepend('<div class="alert alert-error alert-block fade in">' + 
									'<a class="close" data-dismiss="alert" href="#">×</a>' +
									'<div class="alert-heading bt_h3">' + heading_text + '<br /><br />' + 
									'<strong>' + body_text + '</strong><div>');	
		setTimeout(
			function(){
				$(".alert").alert('close');
				$('#button_order').removeAttr('disabled')
			}, 
			5000
		);
	    return false;
	}
	
	$('#button_order' + <?php echo $myrandom; ?>).live('click', function() {
		if ( myvalidator.form() ) {
			//Sending E-Mail
			var issuccess = true;
			
			<?php if ( $send_email_status == '1' ) { ?>	
				$.ajax({
					<?php if ( $type_email == 'type_email_text' ) { ?>
						url: 'index.php?route=module/jvquickorder/SendTextMail',
					<?php } else { ?>
						url: 'index.php?route=module/jvquickorder/SendHTMLMail',
					<?php } ?>
					type: 'post',
					timeout : 6000,
					async: false,
					data: 'product_id=' + <?php echo $product['product_id']; ?> + '&customer_name=' + is_undefined($('#jv_quickorder #user_name').val()) + '&customer_phone=' + is_undefined($('#jv_quickorder #user_phone').val()) + '&customer_email=' + is_undefined($('#jv_quickorder #user_email').val()) + '&customer_comment=' + is_undefined($('#jv_quickorder #user_comment').val()) + '&order_product_quantity=' +is_undefined($('#jv_quickorder #order_product_quantity').val()),
					dataType: 'json',
					beforeSend: function() {
						$('#button_order').attr('disabled', 'disabled');
					},
					success: function(json) {
						issuccess = true;
					},
					error: function(data) {
						issuccess = false;
						errormessage_in_body('<?php echo $error_message_heading_text; ?>', '<?php echo $error_message_body_text; ?>');					
					}
				});	
			<?php } ?>
			//Sending E-Mail
			
			//Checkout order
			var order_offon = <?php echo $order_offon ?>;
			
			if ( ( order_offon == '1'  ) && issuccess ) {
				$.ajax({
					url: 'index.php?route=module/jvquickorder/addorder',
					type: 'post',
					timeout : 6000,
					async: false,
					data: 'product_id=' + <?php echo $product['product_id']; ?> + '&customer_name=' + is_undefined($('#jv_quickorder #user_name').val()) + '&customer_phone=' + is_undefined($('#jv_quickorder #user_phone').val()) + '&customer_email=' + is_undefined($('#jv_quickorder #user_email').val()) + '&customer_comment=' + is_undefined($('#jv_quickorder #user_comment').val()) + '&order_product_quantity=' +is_undefined($('#jv_quickorder #order_product_quantity').val()),
					dataType: 'json',
					beforeSend: function() {
						$('#button_order').attr('disabled', 'disabled');
					},
					success: function(json) {
						issuccess = true;
					},
					
					error: function(data) {
						issuccess = false;
						errormessage_in_body('<?php echo $error_message_heading_text; ?>', '<?php echo $error_message_ordererror_body_text; ?>');					
					}
				});	
			}
			//Checkout order
			if ( issuccess ) {
				successmessage_in_full_body('<?php echo $success_message_heading_text; ?>', '<?php echo $success_message_body_text; ?>');
			}
		};
	});
	
	$(document).ready(function(){
		<?php if (!$show_in_category) { ?>
			errormessage_in_full_body('<?php echo $error_message_heading_text; ?>', '<?php echo $error_message_not_work_in_categories_body_text; ?>');	
		<?php } ?>
	});	
		
	$(document).ready(function(){
		<?php if ($consider_in_stock) { ?>
			<?php if (!$config_stock_checkout) { ?>
				<?php if (!$instock) { ?>
					errormessage_in_full_body('<?php echo $error_message_heading_text; ?>', '<?php echo $error_message_nostock_body_text; ?>');	
				<?php } ?>
			<?php } ?>
		<?php } ?>
	});		
</script>	


<?php if ($options) { ?>
	<!--
	<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
	-->
	<?php foreach ($options as $option) { ?>
		<?php if ($option['type'] == 'file') { ?>
			<script type="text/javascript"><!--
			/*
			new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
				action: 'index.php?route=product/product/upload',
				name: 'file',
				autoSubmit: true,
				responseType: 'json',
				onSubmit: function(file, extension) {
					$('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
					$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
				},
				onComplete: function(file, json) {
					$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);
					
					$('.error').remove();
					
					if (json['success']) {
						alert(json['success']);
						
						$('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
					}
					
					if (json['error']) {
						$('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
					}
					
					$('.loading').remove();	
				}
			});
			*/
			//--></script>
		<?php } ?>
	<?php } ?>
<?php } ?>

<script type="text/javascript"><!--
/*
if (!$("script").is("script[src$='jquery-ui-timepicker-addon.js']")) {
		$("head").append('<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script>');
	}	

$('.date').datepicker({dateFormat: 'yy-mm-dd'});
$('.datetime').datetimepicker({
	dateFormat: 'yy-mm-dd',
	timeFormat: 'h:m'
});
$('.time').timepicker({timeFormat: 'h:m'});
*/
//--></script> 