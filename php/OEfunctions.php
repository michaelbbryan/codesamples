<?php

  /* this file contains PHP functions shared across the site   ini_set('error_reporting', E_ERROR);  */

  function OEmail($toemail,$toname,$fromemail,$fromname,$subject,$message) {
    /* NOTE: toname is erquired but not used in the PHP function. */
    /* write the mail to file rather than over smtp in development environ */
    $welcomefile = fopen($toemail, "w") or die("Unable to open file!"); 
    fwrite($welcomefile, $message); fclose($welcomefile); 
    }

    /*
    $headers =
        'Return-Path: ' . $fromemail . "\r\n" .
        'From: ' . $fromname . ' <' . $fromemail . '>' . "\r\n" .
        'X-Priority: 3' . "\r\n" .
        'X-Mailer: PHP ' . phpversion() .  "\r\n" .
        'Reply-To: ' . $fromname . ' <' . $fromemail . '>' . "\r\n" .
        'MIME-Version: 1.0' . "\r\n" .
        'Content-Transfer-Encoding: 8bit' . "\r\n" .
        'Content-Type: text/plain; charset=UTF-8' . "\r\n";
    $params = '-f ' . $fromemail;
    $try = mail($toemail, $subject, $message, $headers, $params);
    if ( $try ) {echo "Succeeded";}  else  {echo "Failed";} ;
    } 
    */
    
  function OEalert($subject,$message) {
    $toemail = "admin@openenvironmets.com";
    $toname = "Admin";
    $fromemail = "admin@openenvironmets.com";
    $fromname = "Admin";
    $headers =
        'Return-Path: ' . $fromemail . "\r\n" .
        'From: ' . $fromname . ' <' . $fromemail . '>' . "\r\n" .
        'X-Priority: 3' . "\r\n" .
        'X-Mailer: PHP ' . phpversion() .  "\r\n" .
        'Reply-To: ' . $fromname . ' <' . $fromemail . '>' . "\r\n" .
        'MIME-Version: 1.0' . "\r\n" .
        'Content-Transfer-Encoding: 8bit' . "\r\n" .
        'Content-Type: text/plain; charset=UTF-8' . "\r\n";
    $params = '-f ' . $fromemail;
    $try = mail($toemail, $subject, $message, $headers, $params);
    if ( $try ) {echo "Succeeded";}  else  {echo "Failed";} ;
    }
?>