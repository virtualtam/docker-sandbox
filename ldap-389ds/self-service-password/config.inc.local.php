<?php
$ldap_url = "ldap://ldap:389";
$ldap_binddn = "cn=Directory Manager";
$ldap_bindpw = "password";
$ldap_base = "ou=People,dc=domain,dc=tld";
$ldap_login_attribute = "uid";
$ldap_fullname_attribute = "cn";
$ldap_filter = "(&(objectClass=person)($ldap_login_attribute={login}))";

$who_change_password = "user";
$hash = "auto";

$pwd_min_length = 8;
$pwd_max_length = 30;
$pwd_min_lower = 1;
$pwd_min_upper = 1;
$pwd_min_digit = 1;
$pwd_min_special = 1;
$pwd_show_policy = "onerror";

$use_questions = false;
$use_tokens = false;
$use_sms = false;

$keyphrase = "ohnoescleartextsecret";
