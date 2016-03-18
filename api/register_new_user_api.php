<?php
/*
Input (8 POST parameters): username, password, email, name, phone_number, age, gender, annual_income
Process: Inserts new user into registered_users table
Output: A boolean variable that is true on success (on failure sends single error)
*/
require_once('../lib/config.php');
require_once('../lib/http_headers.php');
require_once('../lib/api_common_error_text.php');
require_once('../lib/api_error_functions.php');

// Set Up the Database Connection
$databaseConnection = new mysqli(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DBNAME);
if ($databaseConnection->connect_errno != 0) {
    SendSingleError(HTTP_INTERNAL_ERROR, $databaseConnection->connect_error, ERRTXT_DBCONN_FAILED);
}
// Put data in variables
$username = (isset($_POST['username'])) ? ($_POST['username']) : (false);
$password = (isset($_POST['password'])) ? ($_POST['password']) : (false);
$email = (isset($_POST['email'])) ? ($_POST['email']) : (false);
$name = (isset($_POST['name'])) ? ($_POST['name']) : (false);
$phone_number = (isset($_POST['phone_number'])) ? ($_POST['phone_number']) : (false);
$age = (isset($_POST['age'])) ? ($_POST['age']) : (false);
$gender = (isset($_POST['gender'])) ? ($_POST['gender']) : (false);
$annual_income = (isset($_POST['annual_income'])) ? ($_POST['annual_income']) : (false);

// Check for Data
if(!($username && $password && $email && $name && $phone_number && $age && $gender && $annual_income)) {
	SendSingleError(HTTP_INTERNAL_ERROR, "one or more fields not found", ERRTXT_UNSETVARIABLE);
} else {
	
	// Make sure we don't already have someone with that username
	$query = "SELECT username FROM registered_users WHERE username = '$username' ";
	$data = $databaseConnection->query($query);
    if ($data->num_rows > 0) {
		SendSingleError(HTTP_INTERNAL_ERROR, "someone else already has this username", "Sorry, but someone else has already claimed this username.  Please try again with a new username. ");
	}
	else{
		// Write data to database
		$query = "INSERT INTO registered_users VALUES('$username', '$name', '$password', '$email', '$phone_number', '$age', '$annual_income')";
		if($databaseConnection->query($query)) { // If query was successful
			header(HTTP_OK);
			header(API_RESPONSE_CONTENT);
			echo json_encode(TRUE);
			exit;
		}
		else{
			SendSingleError(HTTP_INTERNAL_ERROR, 'failed to insert new user into database', ERRTXT_FAILED_QUERY);
		}
	}
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>