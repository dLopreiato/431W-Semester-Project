<?php
require_once('config.php');
require_once('http_headers.php');

// function to use when returning a simple error
function SendSingleError($httpStatus, $errorDescription, $userErrorText) {
    header($httpStatus);
    header(API_RESPONSE_CONTENT);
    echo json_encode(array(array('errorDescription' => $errorDescription,
        'userErrorText' => $userErrorText)));
    exit;
}

function SendArrayOfErrors($httpStatus, $errorArray) {
    header($httpStatus);
    header(API_RESPONSE_CONTENT);
    echo json_encode($errorArray);
    exit;
}

function TopLevelExceptionHandler($exception) {
    SendSingleError(HTTP_INTERNAL_ERROR, $exception->getMessage(), 'Uh oh! Something went terribly wrong. 😢');
}

if (OVERRIDE_EXCEPTION_HANDLING) {
    set_exception_handler('TopLevelExceptionHandler');
}

?>
