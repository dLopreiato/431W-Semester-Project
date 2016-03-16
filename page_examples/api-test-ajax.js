$(document).ready(function() {
    $.ajax({
        /*url: "http://" + window.location.hostname + "/api/examples/example_api.php",*/ // default
        url: "http://" + window.location.hostname + "/431/431W-Semester-Project/api/examples/example_api.php", //Chuck

        dataType: "json",
        success: function(data) {
            console.log(data);
            for (var key in data) {
                $('#test-table tbody').append('<tr><td>' + data[key]['test_key'] + '</td><td>' + data[key]['test_attribute'] + '</td></tr>\n');
            }
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