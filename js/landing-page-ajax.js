$(document).ready(function() {
    setActiveUserInfo();
});

function setActiveUserInfo() {
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetActiveUserInfo.php',
        dataType: 'json',
        success: function(data) {
            if (data != false) {
                $('#greeting').html('');
                $('#greeting').append('Hello, ' + data['name'] + '!');
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            var serverErrorInfo = JSON.parse(unescape(xhr.responseText));
            for (var key in serverErrorInfo) {
                console.error('AJAX Error: ' + serverErrorInfo[key]['errorDescription'] + "\n" + thrownError);
            }
        }
    });
}