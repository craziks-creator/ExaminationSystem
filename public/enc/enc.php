<?php
$information = "my some secret information";
$cipher = "AES-128-ECB";
$secret = "123456789e123456";
$encryptedString = openssl_encrypt($information, $cipher, $secret);
echo $encryptedString . "<br>";
echo openssl_decrypt($encryptedString, $cipher, $secret);
?>
