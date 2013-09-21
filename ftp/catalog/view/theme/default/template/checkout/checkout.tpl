<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
	<div class="breadcrumb">
		<?php foreach($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a
				href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
	<h1><?php echo $heading_title; ?></h1>

	<div class="checkout">
		<div id="checkout">
<!--			<div class="checkout-heading">&nbsp;</div>  -->
			<div class="checkout-content" style="display: block">
				<form id="checkout_form" onsubmit="return false;">
					<div class="left">
						<table class="form">
							<tr>
								<td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
								<td><input type="text" name="firstname" value="<?php echo $firstname?>"
										   class="large-field"/></td>
							</tr>
<!--
							<tr>								
								<td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
								<td><input type="text" name="lastname" value="<?php echo $lastname?>"
										   class="large-field"/></td>-->
							</tr>
<input type="hidden" name="lastname" value="hidden" class="large-field"/>
							<tr>
								<td><span class="required">*</span> <?php echo $entry_address_1; ?></td>
								<td><input type="text" name="address_1" value="<?php echo $address_1?>"
										   class="large-field"/></td>
							</tr>
							<tr>
								<td><span class="required">*</span> <?php echo $entry_email; ?></td>
								<td><input type="text" name="email" value="<?php echo $email?>" class="large-field"/>
								</td>
							</tr>
							<tr>
								<td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
								<td><input type="text" name="telephone" value="<?php echo $telephone?>"
										   class="large-field"/></td>
							</tr>
							<tr>
								<td><?php echo $column_comment; ?>:</td>
								<td><textarea rows="8" style="width: 300px"
											  name="comment"><?php echo $comment?></textarea></td>
							</tr>
						</table>
					</div>
					
					<div class="right">
						<h2>Бесплатная доставка</h2>
						<span class="deliver">По Минску доставляем товары бесплатно. После оформления заказа, мы свяжемся с Вами, для согласования времени доставки.</span>
						<br/><br/><br/>

						<h2>Оплата после получения</h2>
						<span class="paym">Оплата производится наличными в белорусских рублях, при получении товара.</span>
					</div>
					<br style="clear:both;"/>

					<div>

					<?php if ($text_agree) { ?>
					<div class="buttons">
					  <div class="left-but"><?php echo $text_agree; ?>
						<?php if ($agree) { ?>
						<input type="checkbox" name="agree" value="1" checked="checked" />
						<?php } else { ?>
						<input type="checkbox" name="agree" value="1" />
						<?php } ?>
					  </div>
					</div>
						<script type="text/javascript"><!--
							<?php if ((VERSION == '1.5.4') or (VERSION == '1.5.4.1') or (VERSION == '1.5.3.1')) { ?>
								$('.colorbox').colorbox({
									width: 640,
									height: 480
								});
							<?php } else { ?>
								$('.fancybox').fancybox({
									width: 560,
									height: 560,
									autoDimensions: false
								});
							<?php }?>
						//--></script>
					<?php }?>

						<div class="shipping-content" style="display: block">
							<?php if(count($shipping_methods)>1) { ?>
							<p><?php echo $text_shipping_method; ?></p>
							<table class="form">
								<?php foreach($shipping_methods as $shipping_method) { ?>
								<tr>
									<td colspan="3"><b><?php echo $shipping_method['title']; ?></b></td>
								</tr>
								<?php if(!$shipping_method['error']) { ?>
									<?php foreach($shipping_method['quote'] as $quote) { ?>
										<tr>
											<td style="width: 1px;"><?php if($quote['code'] == $code || !$code) { ?>
												<?php $code = $quote['code']; ?>
												<input type="radio" name="shipping_method"
													   value="<?php echo $quote['code']; ?>"
													   id="<?php echo $quote['code']; ?>" checked="checked"/>
												<?php } else { ?>
												<input type="radio" name="shipping_method"
													   value="<?php echo $quote['code']; ?>"
													   id="<?php echo $quote['code']; ?>"/>
												<?php } ?></td>
											<td><label
													for="<?php echo $quote['code']; ?>"><?php echo $quote['title']; ?></label>
											</td>
											<td style="text-align: right;"><label
													for="<?php echo $quote['code']; ?>"><?php echo $quote['text']; ?></label>
											</td>
										</tr>
										<?php } ?>
									<?php } else { ?>
									<tr>
										<td colspan="3">
											<div class="error"><?php echo $shipping_method['error']; ?></div>
										</td>
									</tr>
									<?php } ?>
								<?php } ?>
							</table>
							<?php } ?>
						</div>
						<div class="checkout-product">
							<table>
								<thead>
								<tr>
									<td class="name"><?php echo $column_name; ?></td>
									<td class="model"><?php echo $column_model; ?></td>
									<td class="quantity"><?php echo $column_quantity; ?></td>
									<td class="price"><?php echo $column_price; ?></td>
									<td class="total"><?php echo $column_total; ?></td>
								</tr>
								</thead>
								<tbody>
								<?php foreach($products as $product) { ?>
								<tr>
									<td class="name"><a
											href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
										<?php foreach($product['option'] as $option) { ?>
											<br/>
											&nbsp;
											<small> - <?php echo $option['name']; ?>
												: <?php echo $option['value']; ?></small>
											<?php } ?></td>
									<td class="model"><?php echo $product['model']; ?></td>
									<td class="quantity"><?php echo $product['quantity']; ?></td>
									<td class="price"><?php echo $product['price_text']; ?></td>
									<td class="total"><?php echo $product['total_text']; ?></td>
								</tr>
									<?php } ?>
								<?php foreach($vouchers as $voucher) { ?>
								<tr>
									<td class="name"><?php echo $voucher['description']; ?></td>
									<td class="model"></td>
									<td class="quantity">1</td>
									<td class="price"><?php echo $voucher['amount']; ?></td>
									<td class="total"><?php echo $voucher['amount']; ?><br/>
									</td>
								</tr>
									<?php } ?>
								</tbody>
								<tfoot id="total_data">
									<?php echo $total_data?>									
								</tfoot>
							</table>
						</div>
					</div>
					<div style="float:right;">
						<a id="button-confirm" class="button"><span><?php echo $button_confirm?></span></a>
					</div>
					<br/>
				</form>
			</div>
		</div>
	</div>
</div>
<?php echo $content_bottom; ?>
<script type="text/javascript">

	$('#button-confirm').live('click', function() {
		$.ajax({
			url: 'index.php?route=checkout/checkout',
			type: 'post',
			data: $('#checkout_form').serialize(),
			dataType: 'json',
			beforeSend: function() {
				$('#button-confirm').attr('disabled', true);
				$('#button-confirm').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
			},
			complete: function() {
				$('#button-confirm').attr('disabled', false);
				$('.wait').remove();
			},
			success: function(json) {
				$('.warning').remove();
				$('.error').remove();

				if (json['redirect']) {
					location = json['redirect'];
				}

				if (json.errors) {
					for (var key in json.errors) {
						$('#checkout .checkout-content input[name=\'' + key + '\']').
								after('<span class="error" >' + json.errors[key] + '</span>');
					}
				} else {
					if (json.result = "success") {
						location.url = json.redirect;
					}
				}
			}
		});
	});

	$('input[name=shipping_method]').live('click', function() {
		$.ajax({
			url: 'index.php?route=checkout/checkout/change_shipping',
			type: 'post',
			data: 'shipping_method='+$("input[name=shipping_method]:checked").val(),
			dataType: 'json',
			success: function(json) {
				 $('#total_data').html(json['totals_data']);
			}
		})
	});

	//--></script>
<?php echo $footer; ?>
