$(document).ready(function() {
    $.ajax({
        url: "http://" + window.location.hostname + "/api/examples/exception_test.php",
        dataType: "json",
        success: function(data) {
            console.log(data);
        },
        error: function(xhr, ajaxOptions, thrownError) {
            var serverErrorInfo = JSON.parse(unescape(xhr.responseText));
            for (var key in serverErrorInfo) {
                console.error('Ajax Error: ' + serverErrorInfo[key]['errorDescription']);
                showError(serverErrorInfo[key]['userErrorText']);
            }
        }
    });
});

function showError(text) {
    $('#error').append(text);
}