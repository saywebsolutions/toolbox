<?php

$data = json_encode(['Email' => $email, 'ListId' => '']);

$ch = curl_init();

$options = array(
    CURLOPT_URL            => "https://api.emailoversight.com/api/EmailValidation",
    CURLOPT_POST           => true,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_HEADER         => true,
    CURLOPT_FOLLOWLOCATION => true,
    CURLOPT_ENCODING       => "",
    CURLOPT_AUTOREFERER    => true,
    CURLOPT_CONNECTTIMEOUT => 12,
    CURLOPT_TIMEOUT        => 12,
    CURLOPT_MAXREDIRS      => 3,
    CURLOPT_USERAGENT      => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0) Gecko/20100101 Firefox/45.0',
    CURLOPT_POSTFIELDS     => $data,
    CURLOPT_HTTPHEADER     => [
        'Content-Type: application/json',                                                                                
        'Content-Length: '.strlen($data),
        'ApiKey: ',
    ],
);

curl_setopt_array( $ch, $options );
$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

if ( $httpCode != 200 ){
    echo "Return code is {$httpCode} \n".curl_error($ch);
} else {
    echo "<pre>".htmlspecialchars($response)."</pre>";
}

curl_close($ch);

