<?php
class ControllerCheckoutCheckout extends Controller {
	private $error = array();

	public function index() {
////////redirect block
		if ((!$this->cart->hasProducts() && (!isset($this->session->data['vouchers']) || !$this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$this->redirect($this->url->link('checkout/cart'));
		}

		$products = $this->cart->getProducts();

		foreach($products as $product) {
			$product_total = 0;

			foreach($products as $product_2) {
				if($product_2['product_id'] == $product['product_id']) {
					$product_total += $product_2['quantity'];
				}
			}

			if($product['minimum'] > $product_total) {
				$this->redirect($this->url->link('checkout/cart'));
			}
		}


/////////products data
		$product_data = array();

		if((VERSION == '1.5.4') or (VERSION == '1.5.4.1') or (VERSION == '1.5.3.1')) {
			foreach ($this->cart->getProducts() as $product) {
				$option_data = array();

				foreach ($product['option'] as $option) {
					if ($option['type'] != 'file') {
						$value = $option['option_value'];
					} else {
						$value = $this->encryption->decrypt($option['option_value']);
					}

					$option_data[] = array(
						'product_option_id'       => $option['product_option_id'],
						'product_option_value_id' => $option['product_option_value_id'],
						'option_id'               => $option['option_id'],
						'option_value_id'         => $option['option_value_id'],
						'name'                    => $option['name'],
						'value'                   => $value,
						'type'                    => $option['type']
					);
				}

				$product_data[] = array(
					'product_id' => $product['product_id'],
					'href'       => $this->url->link('product/product', 'product_id=' . $product['product_id']),
					'name'       => $product['name'],
					'model'      => $product['model'],
					'option'     => $option_data,
					'download'   => $product['download'],
					'quantity'   => $product['quantity'],
					'subtract'   => $product['subtract'],
					'price' => $product['price'],
					'total' => $product['total'],
					'price_text' => $this->currency->format($product['price']),
					'total_text' => $this->currency->format($product['total']),
					'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
					'reward'     => $product['reward']
				);
			}


	/////////////// Gift Voucher
			$voucher_data = array();
			$this->data['vouchers'] = array();

			if (!empty($this->session->data['vouchers'])) {
				foreach ($this->session->data['vouchers'] as $voucher) {
					$voucher_data[] = array(
						'description'      => $voucher['description'],
						'code'             => substr(md5(mt_rand()), 0, 10),
						'to_name'          => $voucher['to_name'],
						'to_email'         => $voucher['to_email'],
						'from_name'        => $voucher['from_name'],
						'from_email'       => $voucher['from_email'],
						'voucher_theme_id' => $voucher['voucher_theme_id'],
						'message'          => $voucher['message'],
						'amount'           => $voucher['amount']
					);

					$this->data['vouchers'][] = array(
						'description' => $voucher['description'],
						'amount'      => $this->currency->format($voucher['amount'])
					);
				}
			}
		} else {
			$this->load->library('encryption');

			foreach($this->cart->getProducts() as $product) {
				$option_data = array();

				foreach($product['option'] as $option) {
					if($option['type'] != 'file') {
						$option_data[] = array(
							'product_option_id' => $option['product_option_id'],
							'product_option_value_id' => $option['product_option_value_id'],
							'product_option_id' => $option['product_option_id'],
							'product_option_value_id' => $option['product_option_value_id'],
							'option_id' => $option['option_id'],
							'option_value_id' => $option['option_value_id'],
							'name' => $option['name'],
							'value' => $option['option_value'],
							'type' => $option['type']
						);
					} else {
						$encryption = new Encryption($this->config->get('config_encryption'));

						$option_data[] = array(
							'product_option_id' => $option['product_option_id'],
							'product_option_value_id' => $option['product_option_value_id'],
							'product_option_id' => $option['product_option_id'],
							'product_option_value_id' => $option['product_option_value_id'],
							'option_id' => $option['option_id'],
							'option_value_id' => $option['option_value_id'],
							'name' => $option['name'],
							'value' => $encryption->decrypt($option['option_value']),
							'type' => $option['type']
						);
					}
				}

				$product_data[] = array(
					'product_id' => $product['product_id'],
					'name' => $product['name'],
					'model' => $product['model'],
					'option' => $option_data,
					'download' => $product['download'],
					'quantity' => $product['quantity'],
					'subtract' => $product['subtract'],
					'price' => $product['price'],
					'total' => $product['total'],
					'price_text' => $this->currency->format($product['price']),
					'total_text' => $this->currency->format($product['total']),
					'tax' => $this->tax->getTax($product['total'], $product['tax_class_id']),
					'href' => $this->url->link('product/product', 'product_id=' . $product['product_id']),
				);
			}


			////////Gift Voucher
			$this->data['vouchers'] = array();
			if(isset($this->session->data['vouchers']) && $this->session->data['vouchers']) {
				foreach($this->session->data['vouchers'] as $voucher) {
					$product_data[] = array(
						'product_id' => 0,
						'name' => $voucher['description'],
						'model' => '',
						'option' => array(),
						'download' => array(),
						'quantity' => 1,
						'subtract' => false,
						'price' => $voucher['amount'],
						'total' => $voucher['amount'],
						'price_text' => $this->currency->format($voucher['amount']),
						'total_text' => $this->currency->format($voucher['amount']),
						'tax' => 0
					);

					$this->data['vouchers'][] = array(
						'description' => $voucher['description'],
						'amount' => $this->currency->format($voucher['amount'])
					);
				}
			}
		}

		////////shipping
		$shipping_address = array('country_id' => 0, 'zone_id' => 0);
		if($this->customer->isLogged() && isset($this->session->data['shipping_address_id'])) {
			$this->load->model('account/address');

			$shipping_address = $this->model_account_address->getAddress($this->session->data['shipping_address_id']);
		}

		$this->load->model('setting/extension');

		if(!isset($this->session->data['shipping_methods'])) {
			$quote_data = array();

			$results = $this->model_setting_extension->getExtensions('shipping');

			foreach($results as $result) {
				if($this->config->get($result['code'] . '_status')) {
					$this->load->model('shipping/' . $result['code']);

					$quote = $this->{'model_shipping_' . $result['code']}->getQuote($shipping_address);

					if($quote) {
						$quote_data[$result['code']] = array(
							'title' => $quote['title'],
							'quote' => $quote['quote'],
							'sort_order' => $quote['sort_order'],
							'error' => $quote['error']
						);
					}
				}
			}

			$sort_order = array();

			foreach($quote_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}

			array_multisort($sort_order, SORT_ASC, $quote_data);

			$this->session->data['shipping_methods'] = $quote_data;

		}


		if (isset($this->session->data['shipping_methods']) && count($this->session->data['shipping_methods'])>0) {
			$this->data['shipping_methods'] = $this->session->data['shipping_methods'];
			if (!isset($this->session->data['shipping_method']['code'])) {
				$method_keys = array_keys($this->session->data['shipping_methods']);
				$first_method = array_shift($method_keys);
				$this->session->data['shipping_method'] =$this->session->data['shipping_methods'][$first_method]['quote'][$first_method];
			}
			$this->data['code'] = $this->session->data['shipping_method']['code'];
		} else {
			$this->data['shipping_methods'] = array();
			$this->data['code'] = '';
		}

////////totals data
		$total_data = array();
		$total = 0;
		$taxes = $this->cart->getTaxes();
		$sort_order = array();

		$results = $this->model_setting_extension->getExtensions('total');
		foreach($results as $key => $value) {
			$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
		}
		array_multisort($sort_order, SORT_ASC, $results);

		foreach($results as $result) {
			if($this->config->get($result['code'] . '_status')) {
				$this->load->model('total/' . $result['code']);

				$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
			}
		}
		$sort_order = array();
		foreach($total_data as $key => $value) {
			$sort_order[$key] = $value['sort_order'];
		}
		array_multisort($sort_order, SORT_ASC, $total_data);


		$this->language->load('checkout/checkout');
////////do checkout
		if(($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			if(isset($this->request->post['shipping_method'])) {
				$shipping = explode('.', $this->request->post['shipping_method']);
				$this->session->data['shipping_method'] = $this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]];
			}

			$data = array();

			$data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
			$data['store_id'] = $this->config->get('config_store_id');
			$data['store_name'] = $this->config->get('config_name');

			if($data['store_id']) {
				$data['store_url'] = $this->config->get('config_url');
			} else {
				$data['store_url'] = HTTP_SERVER;
			}
			$data['customer_id'] = 0;
			$data['customer_group_id'] = $this->config->get('config_customer_group_id');

			if($this->customer->isLogged()) {
				$data['customer_id'] = $this->customer->getId();
				$data['customer_group_id'] = $this->customer->getCustomerGroupId();
			}

			$data['firstname'] = $this->request->post['firstname'];
			$data['lastname'] = $this->request->post['lastname'];
			$data['email'] = $this->request->post['email'];
			$data['telephone'] = $this->request->post['telephone'];
			$data['fax'] = "";

			$data['payment_firstname'] = $this->request->post['firstname'];
			$data['payment_lastname'] = $this->request->post['lastname'];
			$data['payment_address_1'] = $this->request->post['address_1'];
			$data['shipping_address_1'] = $this->request->post['address_1'];

			$data['payment_company'] = "";
			$data['shipping_company'] = "";
			$data['payment_address_2'] = "";
			$data['payment_city'] = "";
			$data['payment_postcode'] = "";
			$data['payment_zone'] = "";
			$data['payment_zone_id'] = "";
			$data['payment_country'] = "";
			$data['payment_country_id'] = "";
			$data['payment_address_format'] = "";

			$data['shipping_firstname'] = $this->request->post['firstname'];
			$data['shipping_lastname'] = $this->request->post['lastname'];
			$data['shipping_address_2'] = "";
			$data['shipping_city'] = "";
			$data['shipping_postcode'] = "";
			$data['shipping_zone'] = "";
			$data['shipping_zone_id'] = "";
			$data['shipping_country'] = "";
			$data['shipping_country_id'] = "";

			if ((VERSION == '1.5.4') or (VERSION == '1.5.4.1') or (VERSION == '1.5.3.1')) {
                $data['payment_company_id'] = "";
                $data['payment_tax_id'] = "";
                $data['payment_code'] = "";
                $data['shipping_code'] = "";
                if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
                    $data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
                } elseif(!empty($this->request->server['HTTP_CLIENT_IP'])) {
                    $data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
                } else {
                    $data['forwarded_ip'] = '';
                }

                if (isset($this->request->server['HTTP_USER_AGENT'])) {
                    $data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
                } else {
                    $data['user_agent'] = '';
                }

                if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
                    $data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
                } else {
                    $data['accept_language'] = '';
                }
                $data['vouchers'] = $voucher_data;
			} else{
				$data['reward'] = $this->cart->getTotalRewardPoints();
			}

			if(isset($this->session->data['shipping_method']['title'])) {
				$data['shipping_method'] = $this->session->data['shipping_method']['title'];
			} else {
				$data['shipping_method'] = '';
			}
			$data['payment_method'] = '';

			$data['shipping_address_format'] = '{firstname} {lastname} {address_1}';

			$data['products'] = $product_data;

			$data['totals'] = $total_data;
			$data['comment'] = $this->request->post['comment'];
			$data['total'] = $total;

			if(isset($this->request->cookie['tracking'])) {
				$this->load->model('affiliate/affiliate');

				$affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode($this->request->cookie['tracking']);

				if($affiliate_info) {
					$data['affiliate_id'] = $affiliate_info['affiliate_id'];
					$data['commission'] = ($total / 100) * $affiliate_info['commission'];
				} else {
					$data['affiliate_id'] = 0;
					$data['commission'] = 0;
				}
			} else {
				$data['affiliate_id'] = 0;
				$data['commission'] = 0;
			}

			$data['language_id'] = $this->config->get('config_language_id');
			$data['currency_id'] = $this->currency->getId();
			$data['currency_code'] = $this->currency->getCode();
			$data['currency_value'] = $this->currency->getValue($this->currency->getCode());
			$data['ip'] = $this->request->server['REMOTE_ADDR'];

			$this->load->model('checkout/order');

			if((VERSION == '1.5.4') or (VERSION == '1.5.4.1') or (VERSION == '1.5.3.1')) {
			   	$order_id = $this->model_checkout_order->addOrder($data);
				$this->session->data['order_id'] = $order_id;
			} else {
			    $order_id = $this->model_checkout_order->create($data);
			}
	
	$this->model_checkout_order->confirm($order_id, $this->config->get('config_order_status_id'));

if ((VERSION == '1.5.4') or (VERSION == '1.5.4.1')) {}else{	
	
			 if ( isset($this->session->data['order_id']) && ( ! empty($this->session->data['order_id']))  ) { 
                    $this->session->data['last_order_id'] = $this->session->data['order_id']; 
            } 

			$this->cart->clear();
			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['guest']);
			unset($this->session->data['comment']);
			unset($this->session->data['order_id']);
			unset($this->session->data['coupon']);
			unset($this->session->data['reward']);
			unset($this->session->data['voucher']);
			unset($this->session->data['vouchers']);

       }
			$json["status"] = "success";
			$json["redirect"] = $this->url->link('checkout/success');
			$this->response->setOutput(json_encode($json));
			return;
		}


////////breadcrumbs block

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_cart'),
			'href' => $this->url->link('checkout/cart'),
			'separator' => $this->language->get('text_separator')
		);

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('checkout/checkout', '', 'SSL'),
			'separator' => $this->language->get('text_separator')
		);

////////language block
		$this->document->setTitle($this->language->get('heading_title'));
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['entry_telephone'] = $this->language->get('entry_telephone');
		$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_company'] = $this->language->get('entry_company');
		$this->data['entry_address_1'] = $this->language->get('entry_address_1');

		$this->data['button_confirm'] = $this->language->get('button_confirm');
		$this->data['button_continue'] = $this->language->get('button_continue');

		$this->data['text_shipping_method'] = $this->language->get('text_shipping_method');

		$this->load->model('catalog/information');

		if ($this->config->get('config_checkout_id')) {
			$this->load->model('catalog/information');

			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_checkout_id'));

			if ($information_info) {
				$this->data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information/info', 'information_id=' . $this->config->get('config_checkout_id'), 'SSL'), $information_info['title'], $information_info['title']);
			} else {
				$this->data['text_agree'] = '';
			}
		} else {
			$this->data['text_agree'] = '';
		}

		if (isset($this->session->data['agree'])) {
			$this->data['agree'] = $this->session->data['agree'];
		} else {
			$this->data['agree'] = '';
		}


		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_model'] = $this->language->get('column_model');
		$this->data['column_quantity'] = $this->language->get('column_quantity');
		$this->data['column_price'] = $this->language->get('column_price');
		$this->data['column_total'] = $this->language->get('column_total');

		$this->data['total_data'] = $this->getTotalHtml($total_data);

		$this->data['products'] = $product_data;

		if($this->error) {
			$json['errors'] = $this->error;
			$this->response->setOutput(json_encode($json));
			return;
		}

		$this->data['firstname'] = "";
		$this->data['lastname'] = "";
		$this->data['email'] = "";
		$this->data['telephone'] = "";
		$this->data['company'] = "";
		$this->data['address_1'] = "";


		if($this->customer->isLogged()) {
			$this->data['firstname'] = $this->customer->getFirstName();
			$this->data['lastname'] = $this->customer->getLastName();
			$this->data['email'] = $this->customer->getEmail();
			$this->data['telephone'] = $this->customer->getTelephone();
			$this->data['fax'] = $this->customer->getFax();

			$this->load->model('account/address');
			$address = $this->model_account_address->getAddress($this->customer->getAddressId());
			$this->data['company'] = $address['company'];
			$this->data['address_1'] = $address['address_1'];
		}



		if(isset($this->session->data['firstname'])) {
			$this->data['firstname'] = $this->session->data['firstname'];
		}
		if(isset($this->session->data['lastname'])) {
			$this->data['lastname'] = $this->session->data['lastname'];
		}

		if(isset($this->session->data['email'])) {
			$this->data['email'] = $this->session->data['email'];
		}

		if(isset($this->session->data['telephone'])) {
			$this->data['telephone'] = $this->session->data['telephone'];
		}

		$this->data['comment'] = "";
		if(isset($this->session->data['comment'])) {
			$this->data['comment'] = $this->session->data['comment'];
		}

		$this->data['entry_firstname'] = $this->language->get('entry_firstname');
		$this->data['entry_lastname'] = $this->language->get('entry_lastname');

		if(isset($this->session->data['address_1'])) {
			$this->data['address_1'] = $this->session->data['address_1'];
		}

		$this->language->load('account/order');
		$this->data['column_comment'] = $this->language->get('column_comment');


		if(file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/checkout.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/checkout/checkout.tpl';
		} else {
			$this->template = 'default/template/checkout/checkout.tpl';
		}

		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);

		$this->response->setOutput($this->render());
	}

	public function change_shipping() {
		$json = array();
		if(isset($this->request->post['shipping_method'])) {
			$shipping = explode('.', $this->request->post['shipping_method']);
			$this->session->data['shipping_method'] = $this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]];
		}
		$json['totals_data'] = $this->getTotalHtml();
		$this->response->setOutput(json_encode($json));
	}

	private function getTotalHtml($total_data = array()) {

		if(count($total_data) == 0) {
			$total = 0;
			$taxes = $this->cart->getTaxes();
			$sort_order = array();

			$this->load->model('setting/extension');
			$results = $this->model_setting_extension->getExtensions('total');
			foreach($results as $key => $value) {
				$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
			}
			array_multisort($sort_order, SORT_ASC, $results);

			foreach($results as $result) {
				if($this->config->get($result['code'] . '_status')) {
					$this->load->model('total/' . $result['code']);

					$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
				}
			}
			$sort_order = array();
			foreach($total_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
			array_multisort($sort_order, SORT_ASC, $total_data);
		}

		$total_template = new Template();
		$total_template->data['totals'] = $total_data;
		$template_path = 'default/template/checkout/total_data.tpl';
		if(file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/total_data.tpl')) {
			$template_path = $this->config->get('config_template') . '/template/checkout/total_data.tpl';
		}
		return $total_template->fetch($template_path);
	}

	private function validate() {

		if((utf8_strlen($this->request->post['firstname']) < 1) || (utf8_strlen($this->request->post['firstname']) > 64)) {
			$this->error['firstname'] = $this->language->get('error_firstname');
		}

		if((utf8_strlen($this->request->post['lastname']) < 1) || (utf8_strlen($this->request->post['lastname']) > 64)) {
			$this->error['lastname'] = $this->language->get('error_lastname');
		}

		if((utf8_strlen($this->request->post['address_1']) < 3) || (utf8_strlen($this->request->post['address_1']) > 128)) {
			$this->error['address_1'] = $this->language->get('error_address_1');
		}

		if((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_email');
		}

		if((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
			$this->error['telephone'] = $this->language->get('error_telephone');
		}

		if ($this->config->get('config_checkout_id')) {
			$this->load->model('catalog/information');
			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_checkout_id'));
			if ($information_info && !isset($this->request->post['agree'])) {
				$this->error['agree'] = sprintf($this->language->get('error_agree'), $information_info['title']);
			}
		}

		if(!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}

?>