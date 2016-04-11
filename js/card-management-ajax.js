$(document).ready(function() {
    populateExistingCards();
});

function populateExistingCards() {
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetCards.php',
        dataType: 'json',
        success: function(data) {
			$.each(data, function (i, item) {
				addCardToTable(item.card_number, item.card_type, item.exp_date);
			});
        },
        error: function(xhr, ajaxOptions, thrownError) {
            var serverErrorInfo = JSON.parse(unescape(xhr.responseText));
            for (var key in serverErrorInfo) {
                console.error('AJAX Error: ' + serverErrorInfo[key]['errorDescription'] + "\n" + thrownError);
            }
        }
    });
}

function addCardToTable(cardNumber, cardType, expDate) {
	var appendString = '<tr id="' + cardNumber + '"><td>' + cardNumber + '</td><td>' + cardType + '</td><td>' + expDate + '</td><td><button type="button" class="btn btn-danger" onclick="removeCard(' + cardNumber  + ');">Remove Card</button></td></tr>';
	$('#existing-cards tbody').append(appendString);
}

function removeCard(cardNumber) {
	
	var sendData = {card_number: cardNumber};
	
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/DeleteCard.php',
        dataType: 'json',
        data: sendData,
        method: 'GET',
        success: function(data) {
            if (data) {
				document.getElementById(cardNumber).remove();
            }
            else {
                displayGeneralUserError('Unable to delete this card.  Please try again later. ');
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
	
	console.log("deleting card number: " + cardNumber);
}

function addNewCard() {
	var cardNumber = $('input:text[name=cardNumber]').val();
	var cardType = $('input:text[name=cardType]').val();
	var expDate = $('input:text[name=expDate]').val();
	
    var sendData = {card_number: cardNumber, card_type: cardType, exp_date: expDate};

    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/AddCard.php',
        dataType: 'json',
        data: sendData,
        method: 'GET',
        success: function(data) {
            if (data) {
				addCardToTable(cardNumber, cardType, expDate);
				document.getElementById('cardNumber1').value = "";
				document.getElementById('cardType1').value = "";
				document.getElementById('expirationDate1').value = "";
            }
            else {
                displayGeneralUserError('Unable to add this card.  Please try again later');
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