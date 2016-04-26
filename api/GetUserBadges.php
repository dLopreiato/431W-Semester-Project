<?php
/*
Input: username
Process: Finds all the badges in badge_progresses that has units_earned of at least one for the given user  
Output: Returns an array of all the badges that user has earned or partially earned
*/
require_once('../lib/config.php');
require_once('../lib/http_headers.php');
require_once('../lib/api_common_error_text.php');
require_once('../lib/api_error_functions.php');

session_start();

// Set Up the Database Connection
$databaseConnection = new mysqli(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DBNAME);
if ($databaseConnection->connect_errno != 0) {
    SendSingleError(HTTP_INTERNAL_ERROR, $databaseConnection->connect_error, ERRTXT_DBCONN_FAILED);
}
$databaseConnection->set_charset(MYSQL_CHARSET);

// Put data in variables
$username = (isset($_GET['username'])) ? ($_GET['username']) : (false);

// Check for Data
if($username === false ) {
	$username = (isset($_SESSION['username'])) ? ($_SESSION['username']) : (false);
}
if ($username === false){
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_UNSETVARIABLE);
} else {
	//badge 1 (Pass 431w)
	$badgeQuery = "INSERT INTO badge_progresses (username, badge_id, units_earned, last_updated) VALUES ('$username', 1, 1, NOW()) ON DUPLICATE KEY UPDATE last_updated=NOW(), units_earned=if(units_earned+1 > 2, 2, units_earned+1)";
	$databaseConnection->query($badgeQuery);

	// get data from database
	$query = "SELECT * FROM badge_progresses P, badges B WHERE P.username = '$username' AND B.badge_id = P.badge_id AND P.units_earned > 0";
	$data = $databaseConnection->query($query);

	if ($data->num_rows > 0) {
		
		$result = array();
		while ($row =$data->fetch_assoc()){
			$result[] = $row;
		}
	} else  {
		$result = array();
	}

	header(HTTP_OK);
	header(API_RESPONSE_CONTENT);
	echo json_encode($result);
	exit;
		
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>