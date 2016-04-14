$(document).ready(function() {
    populateTables();
});

function populateTables() {
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetTransactions.php',
        dataType: 'json',
        success: function(data) {
			var purchaseData = data.purchases;
			var rentalData = data.rentals;
			$.each(purchaseData, function (i, item) {
				addPurchaseToTable(item.item_id, item.description, item.amount, item.sale_id, item.time, item.card_number, item.sent, item.received);
			});
			$.each(rentalData, function (i, item) {
				addRentalToTable(item.item_id, item.description, item.rental_id, item.serial_number, item.sent, item.received, item.due_date, item.was_returned, item.card_number);
			});
        },
        error: function(xhr, ajaxOptions, thrownError) {
            var serverErrorInfo = JSON.parse(unescape(xhr.responseText));
            for (var key in serverErrorInfo) {
				displayGeneralUserError(serverErrorInfo[key]['userErrorText']);
                console.error('AJAX Error: ' + serverErrorInfo[key]['errorDescription'] + "\n" + thrownError);
            }
        }
    });
}

function addPurchaseToTable(itemID, description, amount, saleID, time, cardNumber, sent, received){
	
	var appendString = '<tr id="' + saleID + '"><td><a href="product.html?id=' + itemID +  '">' + description + '</a></td><td>' + amount +  '</td><td>' + time + '</td><td>' + disguiseNumber(cardNumber) + '</td>';

	if (sent != null){
		appendString += '<td><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></td>';
	}
	else{
		appendString += '<td><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></td>';
	}
	
	if (received != null){
		appendString += '<td><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></td>';
	}
	else{
		appendString += '<td><button type="button" class="btn btn-warning" onclick="markPurchaseReceived(\'' + saleID + "\', \'" + itemID + "\', \'" + description + "\', \'" + amount + "\', \'" + time + "\', \'" + cardNumber + "\', \'" + sent + "\', \'" + received  + '\');">Mark Received</button></td>';
	}
	
	appendString += '</tr>';
	
	$('#purchased-items tbody').append(appendString);
}

function disguiseNumber(cardNumber){
	var disguisedNum = cardNumber;
	
	if (disguisedNum != null){
		for (var i = 0; i < disguisedNum.length - 4; i++){
			disguisedNum = disguisedNum.substr(0, i) + 'x' + disguisedNum.substr(i + 1);
		}
	}
	return disguisedNum;
}

function markPurchaseReceived(saleID, itemID, description, amount, time, cardNumber, sent, received) {
	
	var sendData = {sale_id: saleID};
	
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/MarkReceived.php',
        dataType: 'json',
        data: sendData,
        method: 'GET',
        success: function(data) {
            if (data) {
				$('#' + saleID).remove();
				addPurchaseToTable(itemID, description, amount, saleID, time, cardNumber, sent, 1);
            }
            else {
                displayGeneralUserError('Unable to mark this purchase as received.  Please try again later. ');
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

function addRentalToTable(itemID, description, rentalID, serialNumber, sent, received, dueDate, wasReturned, cardNumber){

	var appendString = '<tr id="' + rentalID + '"><td><a href="product.html?id=' + itemID +  '">' + description + '</a></td><td>' + serialNumber +  '</td><td>' + dueDate + '</td><td>' + disguiseNumber(cardNumber) + '</td>';

	if (sent == 1){
		appendString += '<td><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></td>';
	}
	else{
		appendString += '<td><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></td>';
	}
	
	if (received == 1){
		appendString += '<td><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></td>';
	}
	else{
		appendString += '<td><button type="button" class="btn btn-warning" onclick="markRentalReceived(\'' + itemID + "\', \'" + description + "\', \'" + rentalID + "\', \'" + serialNumber  + "\', \'" + sent + "\', \'" + received  + "\', \'" + dueDate + "\', \'" + wasReturned + + "\', \'" + cardNumber  + '\');">Mark Received</button></td>';
	}
	
	if (wasReturned == 1){
		appendString += '<td><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></td>';
	}
	else{
		appendString += '<td><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></td>';
	}
	
	appendString += '</tr>';
	
	$('#rented-items tbody').append(appendString);
}

function markRentalReceived(itemID, description, rentalID, serialNumber, sent, received, dueDate, wasReturned, cardNumber) {
	
	var sendData = {rental_id: rentalID};
	
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/MarkReceived.php',
        dataType: 'json',
        data: sendData,
        method: 'GET',
        success: function(data) {
            if (data) {
				$('#' + rentalID).remove();
				addRentalToTable(itemID, description, rentalID, serialNumber, sent, 1, dueDate, wasReturned, cardNumber)
            }
            else {
                displayGeneralUserError('Unable to mark this rental as received.  Please try again later. ');
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