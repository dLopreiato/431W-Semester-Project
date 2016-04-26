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
                window.location.href = PROTOCOL + ROOT_DIRECTORY + '/account.html';
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
	var divText = '<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + textToDisplay + '</div>';
    $('#error-view').append(divText);
}