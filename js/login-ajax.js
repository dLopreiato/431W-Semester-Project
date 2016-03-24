function submitLoginCredentials() {
    var sendData = {username:$('input:text[name=username]').val(),
        password: $('input:password[name=password]').val()};

    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/LoginUser.php',
        dataType: 'json',
        data: sendData,
        method: 'GET',
        success: function(data) {
            if (data) {
                window.location.href = PROTOCOL + ROOT_DIRECTORY;
            }
            else {
                displayGeneralUserError('This username/password is not correct.');
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            var serverErrorInfo = JSON.parse(unescape(xhr.responseText));
            for (var key in serverErrorInfo) {
                console.error('AJAX Error: ' + serverErrorInfo[key]['errorDescription'] + '\n' + thrownError);
                displayGeneralUserError(serverErrorInfo[key]['userErrorText']);
            }
        }
    });
}

function displayGeneralUserError(textToDisplay) {
    $('#error-view').append(textToDisplay);
}