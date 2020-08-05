<?php

try {

  $list_id = '';
  $api_key = get_option('sendgrid_api_key');

  $curl = curl_init();

  curl_setopt_array($curl, array(
    CURLOPT_URL => "https://api.sendgrid.com/v3/marketing/contacts",
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_ENCODING => "",  
    CURLOPT_MAXREDIRS => 10,
    CURLOPT_TIMEOUT => 30,
    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
    CURLOPT_CUSTOMREQUEST => "PUT",
    CURLOPT_POSTFIELDS => "{\"list_ids\":[\"{$list_id}\"],\"contacts\":[{\"email\":\"{$user->user_email}\",\"first_name\":\"{$user->first_name}\",\"last_name\":\"{$user->last_name}\",\"custom_fields\":{}}]}",
    CURLOPT_HTTPHEADER => array(
      "authorization: Bearer {$api_key}",
      "content-type: application/json"
    ),   
  ));  

  $response = curl_exec($curl);
  $err = curl_error($curl);

  curl_close($curl);

  if ($err) {
      error_log(__METHOD__.' failed: (USER ID: ' . $user->ID . ' USER EMAIL: ' . $user->user_email . ') = '.json_encode($err));
  } else {
      error_log(__METHOD__.' debug: (USER ID: ' . $user->ID . ' USER EMAIL: ' . $user->user_email . ') = '.json_encode($response));
  }    

} catch (Exception $e) {
  error_log(__METHOD__.' failed: (USER ID: ' . $user->ID . ' USER EMAIL: ' . $user->user_email . ') = ' . json_encode($e->getMessage()));
} /*   */

