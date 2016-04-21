$(document).ready(function() {
});

function registerUser() {
	var username = $('input:text[name=username]').val();
	var password = $('input:password[name=password]').val();
    var password2 = $('input:password[name=password2]').val();
	var email = $('#email1').val();
	var name = $('input:text[name=nam]').val();
	var phone_number = $('input:text[name=phone_number]').val();
    var age = $('#age1').val();
    var gender = $('input:text[name=gender]').val();
    var annual_income = $('#annualincome1').val();

    if(password != password2) {
        displayGeneralUserError("Passwords must match!");
    }
    else{
        var sendData = {username: username, password: password, email: email, name: name, phone_number: phone_number, age: age, gender: gender, annual_income, annual_income};

        console.log(sendData);

        $.ajax({
            url: PROTOCOL + ROOT_DIRECTORY + '/api/RegisterUser.php',
            dataType: 'json',
            data: sendData,
            method: 'POST',
            success: function(data) {
                if (data) {
                    window.location = 'login.html';
                }
                else {
                    displayGeneralUserError('Unable to register user.  Please try again later');
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
}

function displayGeneralUserError(textToDisplay) {
    var divText = '<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + textToDisplay + '</div>';
    $('#error-view').append(divText);
}