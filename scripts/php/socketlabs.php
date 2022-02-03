<?php

                $listId = '83945';
                $optInDateAndTime = date("Y-m-d H:i:s");
                $curl = curl_init();

                curl_setopt_array($curl, array(
                        CURLOPT_URL => "https://api.socketlabs.com/marketing/v1/lists/".$listId."/contacts",
                        CURLOPT_RETURNTRANSFER => true,
                        CURLOPT_ENCODING => "",
                        CURLOPT_MAXREDIRS => 10,
                        CURLOPT_TIMEOUT => 30,  
                        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                        CURLOPT_CUSTOMREQUEST => "PUT",
                        CURLOPT_POSTFIELDS => "{\"emailAddress\":\"$user->user_email\",\"customFields\":[{\"name\":\"Opt-in Date\",\"value\":\"$optInDateAndTime\"},{\"name\":\"ip\",\"value\":\"$user->user_ip\"},{\"name\":\"Address\",\"value\":\"$user->address\"},{\"name\":\"City\",\"value\":\"$user->city\"},{\"name\":\"FirstName\",\"value\":\"$user->first_name\"},{\"name\":\"LastName\",\"value\":\"$user->last_name\"},{\"name\":\"Mobile Phone\",\"value\":\"\"},{\"name\":\"State\",\"value\":\"$user->state\"},{\"name\":\"Zip Code\",\"value\":\"$user->zip\"},{\"name\":\"User Id\",\"value\":\"$user->ID\"}]}",
                        CURLOPT_HTTPHEADER => array(
                                "Authorization: Basic ".base64_encode("33311:d2GSg36LmTf8j9BZb47N"),
                                "content-type: application/json"
                        ),      
                ));
                                
                $response = curl_exec($curl);
                $err = curl_error($curl);

                curl_close($curl);

                if ($err) {             
                    error_log(__FUNCTION__.' failed: (USER ID: ' . $user->ID . ' USER EMAIL: ' . $user->user_email . ') = '.$err);
                } else {
                    error_log(__FUNCTION__.' debug: (USER ID: ' . $user->ID . ' USER EMAIL: ' . $user->user_email . ') = '.$response);
                }