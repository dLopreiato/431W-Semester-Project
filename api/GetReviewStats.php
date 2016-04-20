<?php
/*
Input: item_id
Process: Finds all reviews with each number of stars 
Output: Returns an array of number_of_ratings, average rating, and how many of each star ranking (five_star, four_star...)
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
$item_id = (isset($_GET['item_id'])) ? ($_GET['item_id']) : (false);

// Check for Data
if($item_id === false) {
	SendSingleError(HTTP_BAD_REQUEST, "one or more fields not found", ERRTXT_UNSETVARIABLE);
} else {
	
	$query = "SELECT * FROM items WHERE item_id = '$item_id' ";
	$data = $databaseConnection->query($query);
	if ($data->num_rows > 0){
	
		$avg_rating = 0;
		$totalStars = 0;
		$number_of_ratings = 0;
		$five_star = 0;
		$four_star = 0;
		$three_star = 0;
		$two_star = 0;
		$one_star = 0;
		
		$query = "SELECT * FROM ratings WHERE item_id = '$item_id' AND star_ranking = 5";
		$data = $databaseConnection->query($query);
		 if ($data->num_rows > 0) {
			 $totalStars += (5*$data->num_rows);
			 $five_star = $data->num_rows;
			 $number_of_ratings += $data->num_rows;
		 }
		 $query = "SELECT * FROM ratings WHERE item_id = '$item_id' AND star_ranking = 4";
		$data = $databaseConnection->query($query);
		 if ($data->num_rows > 0) {
			 $totalStars += (4*$data->num_rows);
			 $four_star = $data->num_rows;
			 $number_of_ratings += $data->num_rows;
		 }
		$query = "SELECT * FROM ratings WHERE item_id = '$item_id' AND star_ranking = 3";
		$data = $databaseConnection->query($query);
		 if ($data->num_rows > 0) {
			 $totalStars += (3*$data->num_rows);
			 $three_star = $data->num_rows;
			 $number_of_ratings += $data->num_rows;
		 }
		$query = "SELECT * FROM ratings WHERE item_id = '$item_id' AND star_ranking = 2";
		$data = $databaseConnection->query($query);
		 if ($data->num_rows > 0) {
			 $totalStars += (2*$data->num_rows);
			 $two_star = $data->num_rows;
			 $number_of_ratings += $data->num_rows;
		 }
		$query = "SELECT * FROM ratings WHERE item_id = '$item_id' AND star_ranking = 1";
		$data = $databaseConnection->query($query);
		 if ($data->num_rows > 0) {
			 $totalStars += (1*$data->num_rows);
			 $one_star = $data->num_rows;
			 $number_of_ratings += $data->num_rows;
		 }
		 
		 if ($number_of_ratings > 0){
			$avg_rating = $totalStars / $number_of_ratings;
		 }
		 
		$result = array("number_of_ratings"=>$number_of_ratings, "avg_rating"=>$avg_rating, "five_star"=>$five_star, "four_star"=>$four_star, "three_star"=>$three_star, "two_star"=>$two_star, "one_star"=>$one_star);

		header(HTTP_OK);
		header(API_RESPONSE_CONTENT);
		echo json_encode($result);
		exit;
	
	}else{
			SendSingleError(HTTP_BAD_REQUEST, "there is no item with this ID", ERRTXT_FAILED_QUERY);
	}
	
}

SendSingleError(HTTP_INTERNAL_ERROR, 'php failed', ERRTXT_FAILED);

?>